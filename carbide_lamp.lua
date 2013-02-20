minetest.register_alias("carbide_lamp","chemistry:carbide_lamp")
minetest.register_alias("carbide_lamp_active","chemistry:carbide_lamp_active")

minetest.register_craft({
	output = 'chemistry:carbide_lamp',
	recipe = {
		{'technic:stainless_steel_ingot', 'default:glass', 'technic:stainless_steel_ingot'},
		{'default:glass', 'chemistry:calcium_carbide', 'default:glass'},
		{'moreores:copper_ingot', 'chemistry:test_tube_water', 'moreores:copper_ingot'},
	}
})

carbide_lamp_formspec =
	"invsize[8,9;]"..
	"image[1,1;1,2;chemistry_water_level_empty.png]"..
	"list[current_name;src2;3,2;1,1;]"..
	"list[current_player;main;0,5;8,4;]"..
	"label[0,0;Carbide Lamp]"..
	"label[1,3;Water level]"..
	"list[current_name;src;1,4;1,1;]"

minetest.register_node("chemistry:carbide_lamp", {
	description = "Carbide Lamp",
	tiles = {"chemistry_carbide_lamp_top.png", "chemistry_carbide_lamp_top.png", "chemistry_carbide_lamp_front.png",
		"chemistry_carbide_lamp_front.png", "chemistry_carbide_lamp_front.png", "chemistry_carbide_lamp_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
		water_capacity = 40;
		water_level = 0;
		burn_time = 0;
		is_on = 0;
		on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", carbide_lamp_formspec)
		meta:set_string("infotext", "Carbide Lamp")
		local inv = meta:get_inventory()
		inv:set_size("src", 1)
		inv:set_size("src2", 1)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("src") then
			return false end
		if not inv:is_empty("src2") then
			return false end
		return true
	end,
})

minetest.register_node("chemistry:carbide_lamp_active", {
	description = "Carbide Lamp",
	tiles = {"chemistry_carbide_lamp_top.png", "chemistry_carbide_lamp_top.png", "chemistry_carbide_lamp_front_active.png",
		"chemistry_carbide_lamp_front_active.png", "chemistry_carbide_lamp_front_active.png", "chemistry_carbide_lamp_front_active.png"},
	paramtype2 = "facedir",
	light_source = 35,
	drop = "chemistry:carbide_lamp",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
		water_capacity = 40;
		water_level = 0;
		burn_time = 0;
		is_on = 0;
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("src") then
			return false
		end
		return true
	end,
})



minetest.register_abm({
	nodenames = {"chemistry:carbide_lamp","chemistry:carbide_lamp_active"},
	interval = 1,
	chance = 1,

	action = function(pos, node, active_object_count, active_object_count_wider)

		local meta = minetest.env:get_meta(pos)
	water_capacity = meta:get_float("water_capacity")
	water_level= meta:get_float("water_level")
	burn_time = meta:get_float("burn_time")
	is_on = meta:get_float("is_on")
		local load = math.floor(water_level/40 * 100)
		meta:set_string("formspec",
				"invsize[8,9;]"..
				"image[1,1;1,2;chemistry_water_level_empty.png^[lowpart:"..
				(load)..":chemistry_carbide_lamp_full.png]"..
				"list[current_name;src2;3,2;1,1;]"..
				"list[current_player;main;0,5;8,4;]"..
				"label[0,0;Carbide Lamp]"..
				"label[1,3;Water level]"..
				"list[current_name;src;1,4;1,1;]")

		local inv = meta:get_inventory()



		if inv:is_empty("src")==false  then 
		local srcstack = inv:get_stack("src", 1)
		fuel_item=srcstack:to_table()
		if fuel_item["name"]== "chemistry:test_tube_water" or fuel_item["name"] == "chemistry:test_tube_distilated_water" then
		if water_level < 40 then
		srcstack:take_item()
		inv:set_stack("src", 1, srcstack)
		meta:set_float("water_level",meta:get_float("water_level")+1)
		end
		end
		end
		
		if burn_time == 0 then
		if inv:is_empty("src2")==false  then 
		local srcstack2 = inv:get_stack("src2", 1)
		fuel_item=srcstack2:to_table()
		if fuel_item["name"]== "chemistry:calcium_carbide" then
		if water_level > 0 then
		srcstack2:take_item()
		inv:set_stack("src2", 1, srcstack2)
		meta:set_float("burn_time",180)
		burn_time = 180;
		meta:set_float("water_level",meta:get_float("water_level")-1)
		hacky_swap_node(pos,"chemistry:carbide_lamp_active")
		meta:set_float("is_on",1)
		end
		end
		end
		end
		
		if burn_time > 0 then
			meta:set_float("burn_time",meta:get_float("burn_time")-1)	
			end
		if is_on == 1 then
		if burn_time == 0 then
		hacky_swap_node(pos,"chemistry:carbide_lamp")
		meta:set_float("is_on",0)
		end
		end
		end,

	
})
