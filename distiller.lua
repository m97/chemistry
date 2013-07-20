-- Register distiller recipes
distiller_recipes = {}

-- Register recipe in a table
register_distiller_recipe = function(metal1, count1, metal2, count2, result, count3, result2, count4)
				   distiller_recipes[metal1..metal2] = { src1_count = count1, src2_count = count2, dst_name = result, dst_count = count3, dst2_name = result2, dst2_count = count4 }
				end

minetest.register_alias("distiller","distiller_active")
minetest.register_craft({
	output = 'chemistry:distiller',
	recipe = {
		{'technic:lv_cable','technic:control_logic_unit', 'technic:lv_cable'},
		{'chemistry:test_tube', 'default:steelblock', 'chemistry:test_tube'},
		{'technic:copper_coil', 'chemistry:test_tube', 'technic:copper_coil'},
	}
})

get_distiller_recipe = function(metal1, metal2)
			      -- Check for both combinations of metals and for the right amount in both
			      if distiller_recipes[metal1.name..metal2.name]
				 and metal1.count >= distiller_recipes[metal1.name..metal2.name].src1_count
				 and metal2.count >= distiller_recipes[metal1.name..metal2.name].src2_count then
				 return distiller_recipes[metal1.name..metal2.name]
			      elseif distiller_recipes[metal2.name..metal1.name]
				 and metal2.count >= distiller_recipes[metal2.name..metal1.name].src1_count
				 and metal1.count >= distiller_recipes[metal2.name..metal1.name].src2_count then
				 return distiller_recipes[metal2.name..metal1.name]
			      else
				 return nil
			      end
			   end

local distiller_formspec =
   "invsize[8,9;]"..
   "list[current_name;src;3,1;1,1;]"..
   "list[current_name;src2;3,2;1,1;]"..
   "list[current_name;dst;5,1;2,2;]"..
   "list[current_player;main;0,5;8,4;]"..
   "label[0,0;Distiller]"

minetest.register_node(
   "chemistry:distiller",
   {
      description = "Distiller",
	tiles = {"chemistry_distiller_top.png", "chemistry_distiller_top.png", "chemistry_distiller_front.png",
		"chemistry_distiller_front.png", "chemistry_distiller_front.png", "chemistry_distiller_front.png"},
      paramtype2 = "facedir",
      groups = {cracky=2},
      legacy_facedir_simple = true,
      sounds = default.node_sound_stone_defaults(),
      on_construct = function(pos)
			local meta = minetest.env:get_meta(pos)
			meta:set_string("infotext", "Distiller")
			meta:set_float("technic_power_machine", 1)
			meta:set_string("formspec", distiller_formspec)
			local inv = meta:get_inventory()
			inv:set_size("src", 1)
			inv:set_size("src2", 1)
			inv:set_size("dst", 4)
		     end,
      can_dig = function(pos,player)
		   local meta = minetest.env:get_meta(pos);
		   local inv = meta:get_inventory()
		   if not inv:is_empty("src") or not inv:is_empty("src2") or not inv:is_empty("dst") then
		      minetest.chat_send_player(player:get_player_name(), "Machine cannot be removed because it is not empty");
		      return false
		   else
		      return true
		   end
		end,
})

minetest.register_node(
   "chemistry:distiller_active",
   {
      description = "Distiller",
	tiles = {"chemistry_distiller_top.png", "chemistry_distiller_top.png", "chemistry_distiller_front.png",
		"chemistry_distiller_front.png", "chemistry_distiller_front.png", "chemistry_distiller_front.png"},
      paramtype2 = "facedir",
      light_source = 8,
      drop = "chemistry:distiller",
      groups = {cracky=2,not_in_creative_inventory=1},
      legacy_facedir_simple = true,
      sounds = default.node_sound_stone_defaults(),
      can_dig = function(pos,player)
		   local meta = minetest.env:get_meta(pos);
		   local inv = meta:get_inventory()
		   if not inv:is_empty("src") or not inv:is_empty("src2") or not inv:is_empty("dst") then
		      minetest.chat_send_player(player:get_player_name(), "Machine cannot be removed because it is not empty");
		      return false
		   else
		      return true
		   end
		end,
   })

minetest.register_abm(
   { nodenames = {"chemistry:distiller","chemistry:distiller_active"},
     interval = 1,
     chance   = 1,
     action = function(pos, node, active_object_count, active_object_count_wider)
		 local meta         = minetest.env:get_meta(pos)
		 local eu_input     = meta:get_int("LV_EU_input")
		 local state        = meta:get_int("state")
		 local next_state   = state

		 -- Machine information
		 local machine_name         = "Distiller"
		 local machine_node         = "chemistry:distiller"
		 local machine_state_demand = { 50, 400 }

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
		    local recipe = nil
		    local result = nil
		    local result2 = nil

		    -- Get what to cook if anything
		    local srcstack  = inv:get_stack("src", 1)
		    local src2stack = inv:get_stack("src2", 1)
		    local src_item1 = nil
		    local src_item2 = nil
		    if srcstack and src2stack then
		       src_item1 = srcstack:to_table()
		       src_item2 = src2stack:to_table()
		       empty     = 0
		    end

		    if src_item1 and src_item2 then
		       recipe = get_distiller_recipe(src_item1,src_item2)
		    end
		    if not recipe == nil then
		       result = { name=recipe.dst_name, count=recipe.dst_count}
			if recipe.dst2_count > 0 then
			  result2 = { name=recipe.dst2_name, count=recipe.dst2_count}
			end
		    end

		    if not recipe == nil then
		       print("recipe "..recipe.dst_name.." : result "..result.name.." : empty "..empty.." : src_item1 "..src_item1.name.." : src_item2 "..src_item2.name)
		    end

		    if state == 1 then
		       hacky_swap_node(pos, machine_node)
		       meta:set_string("infotext", machine_name.." Idle")

		       if empty == 0 and recipe and inv:room_for_item("dst", result) then
			  meta:set_string("infotext", machine_name.." Active")
			  meta:set_string("src_time", 0)
			  next_state = 2
		       end

		    elseif state == 2 then
		       hacky_swap_node(pos, machine_node.."_active")
		       meta:set_int("src_time", meta:get_int("src_time") + 1)
		       if meta:get_int("src_time") == 4 then -- 4 ticks per output
			  meta:set_string("src_time", 0)
			  -- check if there's room for output in "dst" list and that we have the materials
			  if recipe and inv:room_for_item("dst", result) then
			     -- Take stuff from "src" list
			     srcstack:take_item(recipe.src1_count)
			     inv:set_stack("src", 1, srcstack)
			     src2stack:take_item(recipe.src2_count)
			     inv:set_stack("src2", 1, src2stack)
			   -- Put result in "dst" list
			     inv:add_item("dst",result)
				if result2 then
				inv:add_item("dst",result2)
				end
			  else
			     next_state = 1
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

technic.register_LV_machine ("chemistry:distiller","RE")
technic.register_LV_machine ("chemistry:distiller_active","RE")