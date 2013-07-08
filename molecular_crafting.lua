function random_dust()
local i = math.random(0,100)
if i > 80 then
local dust = math.random(0,100)
if dust == 0 then
return "technic:mithril_dust"
end
if dust > 0 then
if dust < 4 then
return "technic:gold_dust"
end
end
if dust > 3 then
if dust < 10 then
return "technic:silver_dust"
end
end

if dust > 9 then
if dust < 20  then
return "technic:chromium_dust"
end
end

if dust > 19 then
if dust < 40 then
return "technic:zinc_dust"
end
end

if dust > 39 then
if dust < 60 then
return "technic:tin_dust"
end
end

if dust > 59 then
if dust < 80 then
return "technic:copper_dust"
end
end
if dust > 79 then
if dust < 100 then
return "technic:iron_dust"
end
end
end
if i <= 90 then
return nil
end
end

molecular_crafting_recipes ={}

register_molecular_crafting_recipe = function(metal1, count1, metal2, count2, result, count3, result2, count4)
				   molecular_crafting_recipes[metal1..metal2] = { src1_count = count1, src2_count = count2, dst_name = result, dst_count = count3, dst2_name = result2, dst2_count = count4 }
				end


get_molecular_crafting_recipe = function(metal1, metal2)
			      -- Check for both combinations of metals and for the right amount in both
				if not metal2 == nil then
			      if molecular_crafting_recipes[metal1.name..metal2.name]
				 and metal1.count >= molecular_crafting_recipes[metal1.name..metal2.name].src1_count
				 and metal2.count >= molecular_crafting_recipes[metal1.name..metal2.name].src2_count then
				 return molecular_crafting_recipes[metal1.name..metal2.name]
			      elseif molecular_crafting_recipes[metal2.name..metal1.name]
				 and metal2.count >= molecular_crafting_recipes[metal2.name..metal1.name].src1_count
				 and metal1.count >= molecular_crafting_recipes[metal2.name..metal1.name].src2_count then
				 return molecular_crafting_recipes[metal2.name..metal1.name]
			      end
				 end
				if metal2 ==  nil then
					if molecular_crafting_recipes[metal1.name] then
						if metal1.count >= molecular_crafting_recipes[metal1.name].src1_count then
						return molecular_crafting_recipes[metal1.name]
				end
			   end
			end
		end


minetest.register_alias("molecular_crafting","chemistry:molecular_crafting")
minetest.register_alias("molecular_crafting_active","chemistry:molecular_crafting_active")
minetest.register_craft({
	output = 'chemistry:molecular_crafting',
	recipe = {
		{'technic:mv_cable','chemistry:microprocessor', 'technic:mv_cable'},
		{'technic:copper_coil', 'chemistry:molecular_manipulator', 'technic:copper_coil'},
		{'technic:mv_transformer', 'chemistry:vacuum_chamber', 'chemistry:vacuum_pump'},
	}
})


molecular_crafting_formspec =
	"invsize[8,9;]"..
	"list[current_name;src;3,1;1,1;]"..
	"list[current_name;src2;3,2;1,1;]"..
	"list[current_name;dst;5,1;3,2;]"..
	"list[current_name;tst;4,3;1,1;]"..
	"list[current_player;main;0,5;8,4;]"..
	"label[0,0;Molecular Crafting]"..
	"label[1,3;Power level]"..
	"button[5,4;2,1;turn_on;Turn on]"


minetest.register_node("chemistry:molecular_crafting", {
	description = "Molecular Crafting",
	tiles = {"chemistry_stainless_steel_block.png", "chemistry_stainless_steel_block.png", "chemistry_molecular_crafting_front.png",
		"chemistry_molecular_crafting_front.png", "chemistry_molecular_crafting_front.png", "chemistry_molecular_crafting_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", molecular_crafting_formspec)
		meta:set_string("infotext", "Molecular Crafting")
		meta:set_float("technic_power_machine", 1)
		local inv = meta:get_inventory()
		inv:set_size("src", 1)
		inv:set_size("src2", 1)
		inv:set_size("dst", 6)
		inv:set_size("tst", 1)
		local molecular_crafting_is_working = 0
		air_pressure = 1013
		pump_on = 0
		meta:set_float("air_pressure",1013.25)
		meta:set_int(pump_on,0)
	end,
 can_dig = function(pos,player)
		   local meta = minetest.env:get_meta(pos);
		   local inv = meta:get_inventory()
		   if not inv:is_empty("src") or not inv:is_empty("src2") or not inv:is_empty("dst") or not inv:is_empty("tst") then
		      minetest.chat_send_player(player:get_player_name(), "Machine cannot be removed because it is not empty");
		      return false
		   else
		      return true
		   end
		end,

	on_receive_fields = function(pos,formname,fields,sender)
	local meta = minetest.env:get_meta(pos)
	local pump_on = meta:get_int("pump_on")
	if fields.turn_on then
		if pump_on == 0 then
		return meta:set_int("pump_on",1)
		end
		if pump_on == 1 then
			 return meta:set_int("pump_on",0)
		end
	end
end,
	
})

minetest.register_node("chemistry:molecular_crafting_active", {
	description = "Molecular Crafting",
	tiles = {"chemistry_stainless_steel_block.png", "chemistry_stainless_steel_block.png", "chemistry_molecular_crafting_front.png",
		"chemistry_molecular_crafting_front.png", "chemistry_molecular_crafting_front.png", "chemistry_molecular_crafting_front.png"},	paramtype2 = "facedir",
	light_source = 0,
	drop = "chemistry:molecular_crafting",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
 can_dig = function(pos,player)
		   local meta = minetest.env:get_meta(pos);
		   local inv = meta:get_inventory()
		   if not inv:is_empty("src") or not inv:is_empty("src2") or not inv:is_empty("dst") or not inv:is_empty("tst") then
		      minetest.chat_send_player(player:get_player_name(), "Machine cannot be removed because it is not empty");
		      return false
		   else
		      return true
		   end
		end,
	on_receive_fields = function(pos,formname,fields,sender)
	local meta = minetest.env:get_meta(pos)
	local pump_on = meta:get_int("pump_on")
	if fields.turn_on then
		if pump_on == 0 then
		return meta:set_int("pump_on",1)
		end
		if pump_on == 1 then
			 return meta:set_int("pump_on",0)
		end
	end
end,
})



minetest.register_abm(
   { nodenames = {"chemistry:molecular_crafting","chemistry:molecular_crafting_active"},
     interval = 1,
     chance   = 1,
     action = function(pos, node, active_object_count, active_object_count_wider)
		 local meta         = minetest.env:get_meta(pos)
		 local eu_input     = meta:get_int("MV_EU_input")
		 local state        = meta:get_int("state")
		 local next_state   = state
		 local pump_on      = meta:get_int("pump_on")
		 air_pressure       = meta:get_float("air_pressure")

		 -- Machine information
		 local machine_name         = "Molecular Crafting"
		 local machine_node         = "chemistry:molecular_crafting"
		 local machine_state_demand = { 50, 2000 }

		 -- Setup meta data if it does not exist. state is used as an indicator of this
		 if state == 0 then
		    meta:set_int("state", 1)
		if pump_on == 1 then
			machine_state_demand[1] = 200
		    end
		if pump_on == 0 then
			machine_state_demand[1] = 50
		end
		    meta:set_int("MV_EU_demand", machine_state_demand[1])
		    meta:set_int("MV_EU_input", 0)
		    meta:set_int("tube_time", 0)
		    return
		 end
		 --change air pressure

if pump_on == 0 then
if air_pressure < 1013 then
meta:set_float("air_pressure",air_pressure+1)
end
if air_pressure >= 1013 then 
meta:set_float("air_pressure",1013.25)
end
end

local status = ""
if pump_on == 1 then
status = "Turn off"
end

if pump_on == 0 then
status = "Turn on"
end

meta:set_string("formspec",
"invsize[8,9;]"..
"list[current_name;src;3,1;1,1;]"..
"list[current_name;src2;3,2;1,1;]"..
"list[current_name;dst;5,1;3,2;]"..
"list[current_name;tst;4,3;1,1;]"..
"list[current_player;main;0,5;8,4;]"..
"label[0,0;Molecular Crafting]"..
"label[1,4;Air pressure: "..air_pressure.." hPa]"..
"label[1,3;Power level]"..
"button[5,4;2,1;turn_on;"..status.."]")


		 -- Power off automatically if no longer connected to a switching station
		 technic.switching_station_timeout_count(pos, "MV")

		 -- State machine
		 if eu_input == 0 then
		    -- Unpowered - go idle
		    hacky_swap_node(pos, machine_node)
		    meta:set_string("infotext", machine_name.." Unpowered")
		    next_state = 1
		    meta:set_int("pump_on",0)
		 elseif eu_input == machine_state_demand[state] then
		    -- Powered - do the state specific actions
			if pump_on == 1 then
if air_pressure > 5 then
meta:set_float("air_pressure",air_pressure-5)
end
if air_pressure <= 5 then
meta:set_float("air_pressure",0)
end
end
		if air_pressure < 15 then
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
			if src_item1 then
		       recipe = get_molecular_crafting_recipe(src_item1,src_item2)
			end

		    if recipe then
			
		       result = { name=recipe.dst_name, count=recipe.dst_count}
			if recipe.dst2_count > 0 then
			  result2 = { name=recipe.dst2_name, count=recipe.dst2_count}
			end
			if src_item1.name == "default:cobble" then
				result = {name = random_dust(),count=1}
			end
		    end
		if not src2stack == nil then
		    if recipe then
		       print("recipe "..recipe.dst_name.." : result "..result.name.." : empty "..empty.." : src_item1 "..src_item1.name.." : src_item2 "..src_item2.name)
		    end
		end
		if src2stack == nil then
			  print("recipe "..recipe.dst_name.." : result "..result.name.." : empty "..empty.." : src_item1 "..src_item1.name.."")
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
				if not src2stack == nil then
			     src2stack:take_item(recipe.src2_count)
			     inv:set_stack("src2", 1, src2stack)
				end
			   -- Put result in "dst" list
			     inv:add_item("dst",result)
				if result2 then
				inv:add_item("tst",result2)
				end
			  else
			     next_state = 1
			  end
		       end
		    end
		    -- Change state?
		    if next_state ~= state then
		       meta:set_int("MV_EU_demand", machine_state_demand[next_state])
		       meta:set_int("state", next_state)
		    end
		 end
		end
	      end,
  })




technic.register_MV_machine ("chemistry:molecular_crafting","RE")
technic.register_MV_machine ("chemistry:molecular_crafting_active","RE")