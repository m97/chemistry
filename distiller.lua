distiller_recipes ={}

registered_recipes_count=1

function register_distiller_recipe (string1,count1, string2,count2, string3,count3,string4,count4)
distiller_recipes[registered_recipes_count]={}
distiller_recipes[registered_recipes_count].src1_name=string1
distiller_recipes[registered_recipes_count].src1_count=count1
distiller_recipes[registered_recipes_count].src2_name=string2
distiller_recipes[registered_recipes_count].src2_count=count2
distiller_recipes[registered_recipes_count].dst_name=string3
distiller_recipes[registered_recipes_count].dst_count=count3
distiller_recipes[registered_recipes_count].dst2_name=string4
distiller_recipes[registered_recipes_count].dst2_count=count4
registered_recipes_count=registered_recipes_count+1
distiller_recipes[registered_recipes_count]={}
distiller_recipes[registered_recipes_count].src1_name=string2
distiller_recipes[registered_recipes_count].src1_count=count2
distiller_recipes[registered_recipes_count].src2_name=string1
distiller_recipes[registered_recipes_count].src2_count=count1
distiller_recipes[registered_recipes_count].dst_name=string3
distiller_recipes[registered_recipes_count].dst_count=count3
distiller_recipes[registered_recipes_count].dst2_name=string4
distiller_recipes[registered_recipes_count].dst2_count=count4
registered_recipes_count=registered_recipes_count+1
end

register_distiller_recipe ("chemistry:test_tube",8, "bucket:bucket_water",1, "chemistry:test_tube_water",8)
register_distiller_recipe ("chemistry:test_tube",2, "default:tree",1, "chemistry:celuose",2)

minetest.register_alias("distiller","distiller_active")
minetest.register_craft({
	output = 'chemistry:distiller',
	recipe = {
		{'technic:copper_lv_copper_cable', 'technic:logic_unit', 'technic:copper_lv_copper_cable'},
		{'chemistry:test_tube', 'default:steelblock', 'chemistry:test_tube'},
		{'technic:copper_coil', 'chemistry:test_tube', 'technic:copper_coil'},
	}
})


distiller_formspec =
	"invsize[8,9;]"..
	"image[1,1;1,2;technic_power_meter_bg.png]"..
	"list[current_name;src;3,1;1,1;]"..
	"list[current_name;src2;3,2;1,1;]"..
	"list[current_name;dst;5,1;2,2;]"..
	"list[current_player;main;0,5;8,4;]"..
	"label[0,0;Distiller]"..
	"label[1,3;Power level]"

minetest.register_node("chemistry:distiller", {
	description = "Distiller",
	tiles = {"chemistry_distiller_top.png", "chemistry_distiller_top.png", "chemistry_distiller_front.png",
		"chemistry_distiller_front.png", "chemistry_distiller_front.png", "chemistry_distiller_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	technic_power_machine=1,
	internal_EU_buffer=0;
	interal_EU_buffer_size=2000;
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_float("technic_power_machine", 1)
		meta:set_string("formspec", distiller_formspec)
		meta:set_string("infotext", "Distiller")
		local inv = meta:get_inventory()
		inv:set_size("src", 1)
		inv:set_size("src2", 1)
		inv:set_size("dst", 4)
		local EU_used  = 0
		local furnace_is_cookin = 0
		local cooked = nil
		meta:set_float("internal_EU_buffer",0)
		meta:set_float("internal_EU_buffer_size",2000)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("dst") then
			return false end
		if not inv:is_empty("src") then
			return false end
		if not inv:is_empty("src2") then
			return false end
		return true
	end,
})

minetest.register_node("chemistry:distiller_active", {
	description = "Distiller",
	tiles = {"chemistry_distiller_top.png", "chemistry_distiller_top.png", "chemistry_distiller_front.png",
		"chemistry_distiller_front.png", "chemistry_distiller_front.png", "chemistry_distiller_front.png"},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "chemistry:distiller",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	internal_EU_buffer=0;
	interal_EU_buffer_size=2000;
	technic_power_machine=1,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
})

minetest.register_abm({
	nodenames = {"chemistry:distiller","chemistry:distiller_active"},
	interval = 1,
	chance = 1,

	action = function(pos, node, active_object_count, active_object_count_wider)

		local meta = minetest.env:get_meta(pos)
	internal_EU_buffer= meta:get_float("internal_EU_buffer")
	internal_EU_buffer_size= meta:get_float("interal_EU_buffer")
		local load = math.floor(internal_EU_buffer/2000 * 100)
		meta:set_string("formspec",
				"invsize[8,9;]"..
				"image[1,1;1,2;technic_power_meter_bg.png^[lowpart:"..
						(load)..":technic_power_meter_fg.png]"..
				"list[current_name;src;3,1;1,1;]"..
				"list[current_name;src2;3,2;1,1;]"..
				"list[current_name;dst;5,1;2,2;]"..
				"list[current_player;main;0,5;8,4;]"..
				"label[0,0;Distiller]"..
				"label[1,3;Power level]")

		local inv = meta:get_inventory()

		local furnace_is_cookin = meta:get_int("furnace_is_cookin")


		local srclist = inv:get_list("src")
		local srclist2 = inv:get_list("src2")

		srcstack = inv:get_stack("src", 1)
		if srcstack then src_item1=srcstack:to_table() end
		srcstack = inv:get_stack("src2", 1)
		if srcstack then src_item2=srcstack:to_table() end
		dst_index=nil

		if src_item1 and src_item2 then 
				dst_index=get_cook_result(src_item1,src_item2) 
				end


		if (furnace_is_cookin == 1) then
			if internal_EU_buffer>=150 then
			internal_EU_buffer=internal_EU_buffer-150;
			meta:set_float("internal_EU_buffer",internal_EU_buffer)
			meta:set_float("src_time", meta:get_float("src_time") + 1)
			if dst_index and meta:get_float("src_time") >= 4 then
				-- check if there's room for output in "dst" list
				dst_stack={}
				dst_stack2={}
				dst_stack["name"]=distiller_recipes[dst_index].dst_name
				dst_stack["count"]=distiller_recipes[dst_index].dst_count
				dst_stack2["name"]=distiller_recipes[dst_index].dst2_name
				dst_stack2["count"]=distiller_recipes[dst_index].dst2_count
				if inv:room_for_item("dst",dst_stack) then
					-- Put result in "dst" list
					inv:add_item("dst",dst_stack)
					inv:add_item("dst",dst_stack2)
					-- take stuff from "src" list
					for i=1,distiller_recipes[dst_index].src1_count,1 do
						srcstack = inv:get_stack("src", 1)
						srcstack:take_item()
						inv:set_stack("src", 1, srcstack)
						end
					for i=1,distiller_recipes[dst_index].src2_count,1 do
						srcstack = inv:get_stack("src2", 1)
						srcstack:take_item()
						inv:set_stack("src2", 1, srcstack)
						end


				else
					print("Furnace inventory full!")
				end
				meta:set_string("src_time", 0)
			end
			end		
		end




		if dst_index and meta:get_int("furnace_is_cookin")==0 then
			hacky_swap_node(pos,"chemistry:distiller_active")
			meta:set_string("infotext","Distiller active")
			meta:set_int("furnace_is_cookin",1)
			meta:set_string("src_time", 0)
			return
			end


		if meta:get_int("furnace_is_cookin")==0 or dst_index==nil then
			hacky_swap_node(pos,"chemistry:distiller")
			meta:set_string("infotext","Distiller inactive")
			meta:set_int("furnace_is_cookin",0)
			meta:set_string("src_time", 0)
		end

end,		
})

function get_cook_result(src_item1, src_item2)
local counter=registered_recipes_count-1
for i=1, counter,1 do
if	distiller_recipes[i].src1_name==src_item1["name"] and
	distiller_recipes[i].src2_name==src_item2["name"] and
	distiller_recipes[i].src1_count<=src_item1["count"] and
	distiller_recipes[i].src2_count<=src_item2["count"] 
	then return i end
end
return nil
end

register_LV_machine ("chemistry:distiller","RE")
register_LV_machine ("chemistry:distiller_active","RE")