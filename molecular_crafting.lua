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

registered_molecular_recipes_count=1

function register_molecular_crafting_recipe (string1,count1, string2,count2, string3, count3, string4, count4)
molecular_crafting_recipes[registered_molecular_recipes_count]={}
molecular_crafting_recipes[registered_molecular_recipes_count].src1_name=string1
molecular_crafting_recipes[registered_molecular_recipes_count].src1_count=count1
molecular_crafting_recipes[registered_molecular_recipes_count].src2_name=string2
molecular_crafting_recipes[registered_molecular_recipes_count].src2_count=count2
molecular_crafting_recipes[registered_molecular_recipes_count].dst_name=string3
molecular_crafting_recipes[registered_molecular_recipes_count].dst_count=count3
molecular_crafting_recipes[registered_molecular_recipes_count].tst_name=string4
molecular_crafting_recipes[registered_molecular_recipes_count].tst_count=count4

registered_molecular_recipes_count=registered_molecular_recipes_count+1
molecular_crafting_recipes[registered_molecular_recipes_count]={}
molecular_crafting_recipes[registered_molecular_recipes_count].src1_name=string2
molecular_crafting_recipes[registered_molecular_recipes_count].src1_count=count2
molecular_crafting_recipes[registered_molecular_recipes_count].src2_name=string1
molecular_crafting_recipes[registered_molecular_recipes_count].src2_count=count1
molecular_crafting_recipes[registered_molecular_recipes_count].dst_name=string3
molecular_crafting_recipes[registered_molecular_recipes_count].dst_count=count3
molecular_crafting_recipes[registered_molecular_recipes_count].tst_name=string4
molecular_crafting_recipes[registered_molecular_recipes_count].tst_count=count4
registered_molecular_recipes_count=registered_molecular_recipes_count+1
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
	"image[1,1;1,2;technic_power_meter_bg.png]"..
	"list[current_name;src;3,1;1,1;]"..
	"list[current_name;src2;3,2;1,1;]"..
	"list[current_name;dst;5,1;3,2;]"..
	"list[current_name;tst;4,3;1,1;]"..
	"list[current_player;main;0,5;8,4;]"..
	"label[0,0;Molecular Crafting]"..
	"label[1,3;Power level]"..
	"label[1,4;$(air_pressure)]"..
	"button[5,4;2,1;turn_on;Turn on]"
minetest.register_node("chemistry:molecular_crafting", {
	description = "Molecular Crafting",
	tiles = {"chemistry_stainless_steel_block.png", "chemistry_stainless_steel_block.png", "chemistry_molecular_crafting_front.png",
		"chemistry_molecular_crafting_front.png", "chemistry_molecular_crafting_front.png", "chemistry_molecular_crafting_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	technic_power_machine=1,
	internal_EU_buffer=0;
	interal_EU_buffer_size=5000;
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_float("technic_power_machine", 1)
		meta:set_string("formspec", molecular_crafting_formspec)
		meta:set_string("infotext", "Molecular Crafting")
		local inv = meta:get_inventory()
		inv:set_size("src", 1)
		inv:set_size("src2", 1)
		inv:set_size("dst", 6)
		inv:set_size("tst", 1)
		local EU_used  = 0
		local molecular_crafting_is_working = 0
		local cooked = nil
		air_pressure = 1013
		pump_on = 0
		meta:set_float("internal_EU_buffer",0)
		meta:set_float("internal_EU_buffer_size",5000)
		meta:set_float("air_pressure",1013.25)
		meta:set_int(pump_on,0)
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
	internal_EU_buffer=0;
	interal_EU_buffer_size=5000;
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



minetest.register_abm({
nodenames = {"chemistry:molecular_crafting","chemistry:molecular_crafting_active"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)

local meta = minetest.env:get_meta(pos)
internal_EU_buffer= meta:get_float("internal_EU_buffer")
internal_EU_buffer_size= meta:get_float("interal_EU_buffer")
air_pressure = meta:get_float("air_pressure")
local pump_on = meta:get_int("pump_on")
if pump_on == 1 then
if internal_EU_buffer > 100 then
if air_pressure > 5 then
meta:set_float("air_pressure",air_pressure-5)
meta:set_float("internal_EU_buffer",internal_EU_buffer-100)
end
if air_pressure <= 5 then
meta:set_float("air_pressure",0)
meta:set_float("internal_EU_buffer",internal_EU_buffer-100)
end
end
end
if pump_on == 0 then
if air_pressure < 1013 then
meta:set_float("air_pressure",air_pressure+1)
end
if air_pressure >= 1013 then 
meta:set_float("air_pressure",1013.25)
end
end
local load = math.floor(internal_EU_buffer/5000 * 100)
local status = ""
if pump_on == 1 then
status = "Turn off"
end

if pump_on == 0 then
status = "Turn on"
end

meta:set_string("formspec",
"invsize[8,9;]"..
"image[1,1;1,2;technic_power_meter_bg.png^[lowpart:"..
(load)..":technic_power_meter_fg.png]"..
"list[current_name;src;3,1;1,1;]"..
"list[current_name;src2;3,2;1,1;]"..
"list[current_name;dst;5,1;3,2;]"..
"list[current_name;tst;4,3;1,1;]"..
"list[current_player;main;0,5;8,4;]"..
"label[0,0;Molecular Crafting]"..
"label[1,4;Air pressure: "..air_pressure.." hPa]"..
"label[1,3;Power level]"..
"button[5,4;2,1;turn_on;"..status.."]")



local inv = meta:get_inventory()

local molecular_crafting_is_working = meta:get_int("molecular_crafting_is_working")


local srclist = inv:get_list("src")
local srclist2 = inv:get_list("src2")

srcstack = inv:get_stack("src", 1)
if srcstack then src_item1=srcstack:to_table() end
srcstack = inv:get_stack("src2", 1)
if srcstack then src_item2=srcstack:to_table() end

dst_index=nil

dst_index=get_molecular_crafting_result(src_item1,src_item2) 

if air_pressure < 20 then
if (molecular_crafting_is_working == 1) then
if internal_EU_buffer>=150 then
internal_EU_buffer=internal_EU_buffer-150;
meta:set_float("internal_EU_buffer",internal_EU_buffer)
meta:set_float("src_time", meta:get_float("src_time") + 1)
if dst_index and meta:get_float("src_time") >= 4 then
-- check if there's room for output in "dst" list
dst_stack={}
dst_stack2={}
dst_stack["name"]=molecular_crafting_recipes[dst_index].dst_name
dst_stack["count"]=molecular_crafting_recipes[dst_index].dst_count
dst_stack2["name"]=molecular_crafting_recipes[dst_index].tst_name
dst_stack2["count"]=molecular_crafting_recipes[dst_index].tst_count
if src_item1["name"] == "default:cobble" then
dst_stack["name"]= random_dust()
dst_stack["count"]=1
dst_stack2["name"]="default:sand"
dst_stack2["count"]=0
end
if inv:room_for_item("dst",dst_stack) then
-- Put result in "dst" list
inv:add_item("dst",dst_stack)
inv:add_item("tst",dst_stack2)
-- take stuff from "src" list
for i=1,molecular_crafting_recipes[dst_index].src1_count,1 do
srcstack = inv:get_stack("src", 1)
srcstack:take_item()
inv:set_stack("src", 1, srcstack)
end
for i=1,molecular_crafting_recipes[dst_index].src2_count,1 do
srcstack = inv:get_stack("src2", 1)
srcstack:take_item()
inv:set_stack("src2", 1, srcstack)
end


else
print("Molecular Crafting inventory full!")
end
meta:set_string("src_time", 0)
end
end
end
end



if dst_index and meta:get_int("molecular_crafting_is_working")==0 then
hacky_swap_node(pos,"chemistry:molecular_crafting_active")
meta:set_string("infotext","Molecular Crafting active")
meta:set_int("molecular_crafting_is_working",1)
meta:set_string("src_time", 0)
return
end


if meta:get_int("molecular_crafting_is_working")==0 or dst_index==nil then
hacky_swap_node(pos,"chemistry:molecular_crafting")
meta:set_string("infotext","Molecular Crafting inactive")
meta:set_int("molecular_crafting_is_working",0)
meta:set_string("src_time", 0)
end

end,
})

function get_molecular_crafting_result(src_item1, src_item2)
local counter=registered_molecular_recipes_count-1
for i=1, counter,1 do
if src_item1 then
if src_item2 then
if molecular_crafting_recipes[i].src1_name==src_item1["name"] and
molecular_crafting_recipes[i].src2_name==src_item2["name"] and
molecular_crafting_recipes[i].src1_count<=src_item1["count"] and
molecular_crafting_recipes[i].src2_count<=src_item2["count"] 
then return i end
end
end
if src_item1 then
if src_item2 == nil then
if molecular_crafting_recipes[i].src1_name==src_item1["name"] and
molecular_crafting_recipes[i].src2_name==src_item2 and
molecular_crafting_recipes[i].src1_count<=src_item1["count"] and
molecular_crafting_recipes[i].src2_count==0 
then return i end
end
end
if src_item1 == nil then
if src_item2 then
if molecular_crafting_recipes[i].src1_name==src_item1 and
molecular_crafting_recipes[i].src2_name==src_item2["name"] and
molecular_crafting_recipes[i].src1_count==0 and
molecular_crafting_recipes[i].src2_count<=src_item2["count"]
then return i end
end
end
end
return nil
end



register_MV_machine ("chemistry:molecular_crafting","RE")
register_MV_machine ("chemistry:molecular_crafting_active","RE")