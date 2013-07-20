get_efficiency = function(pos)
pos.x = pos.x+1
local ef = 0
local node=minetest.env:get_node(pos)
if node.name == "default:leaves" then
ef = 30+ef
end
if node.name == "default:junglegrass" then
ef = 40+ef
end

pos.x = pos.x-2
local node=minetest.env:get_node(pos)
if node.name == "default:leaves" then
ef = 30+ef
end
if node.name == "default:junglegrass" then
ef = 40+ef
end
pos.x = pos.x+1
return ef
end


minetest.register_alias("air_collector","air_collector_active")
minetest.register_craft({
	output = 'chemistry:air_collector',
	recipe = {
		{'default:steel_ingot','chemistry:test_tube', 'default:steel_ingot'},
		{'pipeworks:tube', 'technic:motor', 'pipeworks:tube'},
		{'default:steel_ingot', 'chemistry:test_tube', 'default:steel_ingot'},
	}
})

local air_collector_formspec =
   "invsize[8,9;]"..
   "list[current_name;src;3,1;1,1;]"..
   "list[current_name;dst;3,3;1,1;]"..
   "list[current_player;main;0,5;8,4;]"..
   "label[0,0;Air Collector]"

minetest.register_node(
   "chemistry:air_collector",
   {
      description = "Air Collector",
	tiles = {"chemistry_distiller_top.png", "chemistry_distiller_top.png", "chemistry_air_collector_front.png",
		"chemistry_air_collector_front.png", "chemistry_air_collector_front.png", "chemistry_air_collector_front.png"},
      paramtype2 = "facedir",
      groups = {cracky=2},
      legacy_facedir_simple = true,
      sounds = default.node_sound_stone_defaults(),
      on_construct = function(pos)
			local meta = minetest.env:get_meta(pos)
			meta:set_string("infotext", "Air Collector")
			meta:set_float("technic_power_machine", 1)
			meta:set_string("formspec", air_collector_formspec)
			local inv = meta:get_inventory()
			inv:set_size("src", 1)
			inv:set_size("dst", 1)
		     end,
      can_dig = function(pos,player)
		   local meta = minetest.env:get_meta(pos);
		   local inv = meta:get_inventory()
		   if not inv:is_empty("src") or not inv:is_empty("dst") then
		      minetest.chat_send_player(player:get_player_name(), "Machine cannot be removed because it is not empty");
		      return false
		   else
		      return true
		   end
		end,
})

minetest.register_node(
   "chemistry:air_collector_active",
   {
      description = "Air Collector",
	tiles = {"chemistry_distiller_top.png", "chemistry_distiller_top.png", "chemistry_air_collector_front.png",
		"chemistry_air_collector_front.png", "chemistry_air_collector_front.png", "chemistry_air_collector_front.png"},
      paramtype2 = "facedir",
      drop = "chemistry:air_collector",
      groups = {cracky=2,not_in_creative_inventory=1},
      legacy_facedir_simple = true,
      sounds = default.node_sound_stone_defaults(),
      can_dig = function(pos,player)
		   local meta = minetest.env:get_meta(pos);
		   local inv = meta:get_inventory()
		   if not inv:is_empty("src") or not inv:is_empty("dst") then
		      minetest.chat_send_player(player:get_player_name(), "Machine cannot be removed because it is not empty");
		      return false
		   else
		      return true
		   end
		end,
   })

minetest.register_abm(
   { nodenames = {"chemistry:air_collector","chemistry:air_collector_active"},
     interval = 1,
     chance   = 1,
     action = function(pos, node, active_object_count, active_object_count_wider)
		 local meta         = minetest.env:get_meta(pos)
		 local eu_input     = meta:get_int("LV_EU_input")
		 local state        = meta:get_int("state")
		 local next_state   = state
		 local efficiency   = get_efficiency(pos)

		 -- Machine information
		 local machine_name         = "Air Collector"
		 local machine_node         = "chemistry:air_collector"
		 local machine_state_demand = { 50, 100 }


			meta:set_string("formspec",
   "invsize[8,9;]"..
   "list[current_name;src;3,1;1,1;]"..
   "list[current_name;dst;3,3;1,1;]"..
   "list[current_player;main;0,5;8,4;]"..
   "label[0,0;Air Collector]"..
   "label[1,4;Efficiency: "..efficiency.." %]")


		 -- Setup meta data if it does not exist. state is used as an indicator of this
		 if state == 0 then
		    meta:set_int("state", 1)
		    meta:set_int("LV_EU_demand", machine_state_demand[1])
		    meta:set_int("LV_EU_input", 0)
		    meta:set_int("tube_time", 0)
		    return
		 end

		 -- Power off automatically if no longer connected to a switching station
		 technic.switching_station_timeout_count(pos, "LV")

		 -- State machine
		 if eu_input == 0 then
		    -- Unpowered - go idle
		    hacky_swap_node(pos, machine_node)
		    meta:set_string("infotext", machine_name.." Unpowered")
		    next_state = 1
		 elseif eu_input == machine_state_demand[state] then
		    -- Powered - do the state specific actions

		    -- Execute always if powered logic
		    local inv    = meta:get_inventory()
		    local empty  = 1
		    local result = nil

		    -- Get what to cook if anything
		    local srcstack  = inv:get_stack("src", 1)
		    local src_item1 = nil
		    if srcstack  then
		       src_item1 = srcstack:to_table()
		       empty     = 0
		    end

		    if src_item1  then
			if src_item1.name == "chemistry:test_tube" then
			  result = { name="chemistry:air", count=1}
		    end
		end
		if src_item1  then
			if not src_item1.name == "chemistry:test_tube" then
				empty = 1
				state = 1
			end
		end

		    if state == 1 then
		       hacky_swap_node(pos, machine_node)
		       meta:set_string("infotext", machine_name.." Idle")

		       if empty == 0 and result and inv:room_for_item("dst", result) and src_item1.name == "chemistry:test_tube" then
			  meta:set_string("infotext", machine_name.." Active")
			  meta:set_string("src_time", 0)
			  next_state = 2
		       end

		    elseif state == 2 then
			  if efficiency > 0 then
		       hacky_swap_node(pos, machine_node.."_active")
		       meta:set_int("src_time", meta:get_int("src_time") + 1)
		       if meta:get_int("src_time") == math.floor(600/efficiency) then -- 10 ticks per output
			  meta:set_string("src_time", 0)
			  -- check if there's room for output in "dst" list and that we have the materials
			  if inv:room_for_item("dst", result) then
			     -- Take stuff from "src" list
			     srcstack:take_item(1)
			     inv:set_stack("src", 1, srcstack)
			   -- Put result in "dst" list
			     inv:add_item("dst",result)
			  else
			     next_state = 1
			  end
		       end
		    end
		end
		    -- Change state?
		    if next_state ~= state then
		       meta:set_int("LV_EU_demand", machine_state_demand[next_state])
		       meta:set_int("state", next_state)
		    end
		 end
	      end,
  })

technic.register_LV_machine ("chemistry:air_collector","RE")
technic.register_LV_machine ("chemistry:air_collector_active","RE")
