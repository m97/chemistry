acetylene_burner_recipes ={}

registered_acetylene_burner_recipes_count=1

function register_acetylene_burner_recipe (string1,count1, string2,count2, string3,count3,string4,count4,string5,count5,string6,count6)
acetylene_burner_recipes[registered_acetylene_burner_recipes_count]={}
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].src1_name=string1
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].src1_count=count1
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].src2_name=string2
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].src2_count=count2
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst_name=string3
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst_count=count3
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst2_name=string4
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst2_count=count4
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst3_name=string5
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst3_count=count5
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst4_name=string6
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst4_count=count6
registered_acetylene_burner_recipes_count=registered_acetylene_burner_recipes_count+1
acetylene_burner_recipes[registered_acetylene_burner_recipes_count]={}
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].src1_name=string2
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].src1_count=count2
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].src2_name=string1
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].src2_count=count1
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst_name=string3
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst_count=count3
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst2_name=string4
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst2_count=count4
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst3_name=string5
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst3_count=count5
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst4_name=string6
acetylene_burner_recipes[registered_acetylene_burner_recipes_count].dst4_count=count6
registered_acetylene_burner_recipes_count=registered_acetylene_burner_recipes_count+1
end

register_acetylene_burner_recipe("chemistry:test_tube_distilated_water",1,"chemistry:test_tube",2,"chemistry:hydrogen",2,"chemistry:oxygen",1)
register_acetylene_burner_recipe("chemistry:celuose",1,"chemistry:test_tube",20,"chemistry:hydrogen",10,"chemistry:oxygen",5,"chemistry:carbon",6)
register_acetylene_burner_recipe("chemistry:calcium_carbonate",1,"chemistry:test_tube",4,"chemistry:calcium",1,"chemistry:oxygen",3,"chemistry:carbon",1)
register_acetylene_burner_recipe("chemistry:carbon_dioxide",1,"chemistry:test_tube",2,"chemistry:carbon",1,"chemistry:oxygen",2)
register_acetylene_burner_recipe("chemistry:calcium_carbide",1,"chemistry:test_tube",2,"chemistry:calcium",1,"chemistry:carbon",2)
register_acetylene_burner_recipe("chemistry:calcium_hydroxide",1,"chemistry:test_tube",4,"chemistry:calcium",1,"chemistry:oxygen",2,"chemistry:hydrogen",2)
register_acetylene_burner_recipe("chemistry:acetylene",1,"chemistry:test_tube",3,"chemistry:carbon",2,"chemistry:hydrogen",2)
register_acetylene_burner_recipe("chemistry:silicon_dioxide",1,"chemistry:test_tube",3,"chemistry:silicon",1,"chemistry:oxygen",2)

minetest.register_alias("acetylene_burner","acetylene_burner_active")
minetest.register_craft({
	output = 'chemistry:acetylene_burner',
	recipe = {
		{'moreores:silver_ingot', 'pipeworks:mese_tube_000000', 'moreores:silver_ingot'},
		{'chemistry:acetylene', 'default:steelblock', 'chemistry:acetylene'},
		{'technic:control_logic_unit', 'moreores:gold_ingot', 'technic:control_logic_unit'},
	}
})


acetylene_burner_formspec =
	"size[8,9]"..
	"label[0,0;Acetylene Burner]"..
	"image[2,2;1,1;default_furnace_fire_bg.png]"..
	"list[current_name;fuel;2,3;1,1;]"..
	"list[current_name;src;2,1;1,1;]"..
	"list[current_name;src2;3,1;1,1;]"..
	"list[current_name;dst;5,1;2,2;]"..
	"list[current_player;main;0,5;8,4;]"
	
minetest.register_node("chemistry:acetylene_burner", {
	description = "Acetylene Burner",
	drawtype = "plantlike",
	tiles = {"chemistry_acetylene_burner_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	visual_scale = 1.1,
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", acetylene_burner_formspec)
		meta:set_string("infotext", "Acetylene Burner")
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("src2", 1)
		inv:set_size("dst", 8)
		local furnace_is_cookin = 0
		local dst_index = nil

	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not (inv:is_empty("fuel") or inv:is_empty("dst") or inv:is_empty("src") or inv:is_empty("src2") )then
			return false
			end
		return true
	end,
})

minetest.register_node("chemistry:acetylene_burner_active", {
	description = "Acetylene Burner",
	drawtype = "plantlike",
	tiles = {name="chemistry_acetylene_burner_active.png"},
	paramtype2 = "facedir",
	paramtype = "light",
	visual_scale = 1.1,
	light_source = 8,
	drop = "chemistry:acetylene_burner",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not (inv:is_empty("fuel") or inv:is_empty("dst") or inv:is_empty("src") or inv:is_empty("src2") )then
			return false
			end
		return true
	end,
})



minetest.register_abm({
	nodenames = {"chemistry:acetylene_burner","chemistry:acetylene_burner_active"},
	interval = 1,
	chance = 1,
	
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		for i, name in ipairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"
		}) do
			if meta:get_string(name) == "" then
				meta:set_float(name, 0.0)
			end
		end

		local inv = meta:get_inventory()

		local srclist = inv:get_list("src")
		local srclist2 = inv:get_list("src2")

		srcstack = inv:get_stack("src", 1)
		if srcstack then src_item1=srcstack:to_table() end
		srcstack = inv:get_stack("src2", 1)
		if srcstack then src_item2=srcstack:to_table() end
		dst_index=nil

		if src_item1 and src_item2 then 
				dst_index=get_burning_result(src_item1,src_item2) 
				end

		
		local was_active = false
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
		meta:set_float("src_time", meta:get_float("src_time") + 1)
			if dst_index and meta:get_float("src_time") >= 4 then
				-- check if there's room for output in "dst" list
				dst_stack={}
				dst_stack2={}
				dst_stack3={}
				dst_stack4={}
				dst_stack["name"]=acetylene_burner_recipes[dst_index].dst_name
				dst_stack["count"]=acetylene_burner_recipes[dst_index].dst_count
				dst_stack2["name"]=acetylene_burner_recipes[dst_index].dst2_name
				dst_stack2["count"]=acetylene_burner_recipes[dst_index].dst2_count
				dst_stack3["name"]=acetylene_burner_recipes[dst_index].dst3_name
				dst_stack3["count"]=acetylene_burner_recipes[dst_index].dst3_count
				dst_stack4["name"]=acetylene_burner_recipes[dst_index].dst4_name
				dst_stack4["count"]=acetylene_burner_recipes[dst_index].dst4_count
				if inv:room_for_item("dst",dst_stack) then
					-- Put result in "dst" list
					inv:add_item("dst",dst_stack)
					inv:add_item("dst",dst_stack2)
 					inv:add_item("dst",dst_stack3)
					inv:add_item("dst",dst_stack4)
					-- take stuff from "src" list
					for i=1,acetylene_burner_recipes[dst_index].src1_count,1 do
						srcstack = inv:get_stack("src", 1)
						srcstack:take_item()
						inv:set_stack("src", 1, srcstack)
						end
					for i=1,acetylene_burner_recipes[dst_index].src2_count,1 do
						srcstack = inv:get_stack("src2", 1)
						srcstack:take_item()
						inv:set_stack("src2", 1, srcstack)
						end


				else
					print("Acetylene Burner inventory full!")
				end
				meta:set_string("src_time", 0)
			end
			end		
	

		
		if meta:get_float("fuel_time") == meta:get_float("fuel_totaltime") then
		local inv = meta:get_inventory()
		if inv:is_empty("fuel")==false  then 
		local srcstack = inv:get_stack("fuel", 1)
		fuel_item=srcstack:to_table()
		if fuel_item["name"]== "chemistry:acetylene" then
		srcstack:take_item()
		inv:set_stack("fuel", 1, srcstack)
		meta:set_float("fuel_time",0)
		meta:set_float("fuel_totaltime",16) 
		end
		end
	end

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
					meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext","Acetylene Burner active: "..percent.."%")
			hacky_swap_node(pos,"chemistry:acetylene_burner_active")
			meta:set_string("formspec",
				"size[8,9]"..
				"label[0,0;Acetylene Burner]"..
				"image[2,2;1,1;default_furnace_fire_bg.png^[lowpart:"..
						(100-percent)..":default_furnace_fire_fg.png]"..
				"list[current_name;fuel;2,3;1,1;]"..
				"list[current_name;src;2,1;1,1;]"..
				"list[current_name;src2;3,1;1,1;]"..
				"list[current_name;dst;5,1;2,2;]"..
				"list[current_player;main;0,5;8,4;]")
			return
		end

		local fuel = nil
		local fuellist = inv:get_list("fuel")
		
		srcstack = inv:get_stack("src", 1)
		if srcstack then src_item1=srcstack:to_table() end
		srcstack = inv:get_stack("src2", 1)
		if srcstack then src_item2=srcstack:to_table() end
		dst_index=nil

		if src_item1 and src_item2 then 
				dst_index=get_burning_result(src_item1,src_item2) 
				end
		
		
		if fuellist then
			fuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if fuel.time <= 0 then
			meta:set_string("infotext","Acetylene Burner out of fuel")
			hacky_swap_node(pos,"chemistry:acetylene_burner")
			meta:set_string("formspec", acetylene_burner_formspec)
			return
		end

		if dst_index==nil then
			if was_active then
				meta:set_string("infotext","Acetylene Burner is empty")
				hacky_swap_node(pos,"chemistry:acetylene_burner")
				meta:set_string("formspec", acetylene_burner_formspec)
			end
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		
	
end,		
})

function get_burning_result(src_item1, src_item2)
local counter=registered_acetylene_burner_recipes_count-1
for i=1, counter,1 do
if	acetylene_burner_recipes[i].src1_name==src_item1["name"] and
	acetylene_burner_recipes[i].src2_name==src_item2["name"] and
	acetylene_burner_recipes[i].src1_count<=src_item1["count"] and
	acetylene_burner_recipes[i].src2_count<=src_item2["count"] 
	then return i end
end
return nil
end