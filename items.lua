minetest.register_alias("test_tube","chemistry:test_tube")
minetest.register_alias("test_tube_water", "chemistry:test_tube_water")
minetest.register_alias("test_tube_distilated_water", "chemistry:test_tube_distilated_water")
minetest.register_alias("stainless_steel_block", "chemistry:stainless_steel_block")
minetest.register_alias("stamen", "chemistry:stamen")
minetest.register_alias("molecular_manipulator", "chemistry:molecular_manipulator")
minetest.register_alias("aluminum_alloy_base", "chemistry:aluminum_alloy_base")
minetest.register_alias("aluminum_alloy", "chemistry:aluminum_alloy")
minetest.register_alias("vacuum_chamber", "chemistry:vacuum_chamber")
minetest.register_alias("vacuum_pump", "chemistry:vacuum_pump")
minetest.register_alias("microprocessor", "chemistry:microprocessor")
minetest.register_alias("marble_dust", "chemistry:marble_dust")
minetest.register_alias("marble-coal_dust", "chemistry:marble_coal_dust")
minetest.register_alias("aluminum_dustc", "chemistry:aluminum_dust")

minetest.register_alias("hydrogen", "chemistry:hydrogen")
minetest.register_alias("carbon", "chemistry:carbon")
minetest.register_alias("oxygen", "chemistry:oxygen")
minetest.register_alias("calcium", "chemistry:calcium")
minetest.register_alias("silicon", "chemistry:silicon")

minetest.register_alias("celuose", "chemistry:celuose")
minetest.register_alias("calcium_carbonate", "chemistry:calcium_carbonate")
minetest.register_alias("carbon_dioxide", "chemistry:carbon_dioxide")
minetest.register_alias("calcium_carbide", "chemistry:calcium_carbide")
minetest.register_alias("calcium_hydroxide", "chemistry:calcium_hydroxide")
minetest.register_alias("acetylene", "chemistry:acetylene")
minetest.register_alias("silicon_dioxide", "chemistry:silicon_dioxide")


minetest.register_craftitem("chemistry:test_tube", {	
description = "test-tube",
inventory_image = "chemistry_test_tube.png"
})

minetest.register_craftitem("chemistry:test_tube_water", {	
description = "test-tube with water",
inventory_image = "chemistry_test_tube_water.png"
})

minetest.register_craftitem("chemistry:test_tube_distilated_water", {	
description = "test-tube with distilated water",
inventory_image = "chemistry_test_tube_distilated_water.png"
})

minetest.register_craftitem("chemistry:hydrogen", {	
description = "H - Hydrogen",
inventory_image = "chemistry_hydrogen.png"
})

minetest.register_craftitem("chemistry:carbon", {	
description = "C - Carbon",
inventory_image = "chemistry_carbon.png"
})

minetest.register_craftitem("chemistry:oxygen", {	
description = "O - Oxygen",
inventory_image = "chemistry_oxygen.png"
})


minetest.register_craftitem("chemistry:celuose", {	
description = "C6H10O5 - Celuose",
inventory_image = "chemistry_substance.png"
})

minetest.register_craftitem("chemistry:marble_dust", {	
description = "Marble dust",
inventory_image = "chemistry_marble_dust.png"
})

minetest.register_craftitem("chemistry:marble_coal_dust", {	
description = "Marble-coal dust",
inventory_image = "chemistry_marble_coal_dust.png"
})

minetest.register_craftitem("chemistry:calcium_carbonate", {	
description = "CaCO3 - Calcium carbonate",
inventory_image = "chemistry_calcium_carbonate.png"
})

minetest.register_craftitem("chemistry:carbon_dioxide", {	
description = "CO2 - Carbon dioxide",
inventory_image = "chemistry_carbon_dioxide.png"
})

minetest.register_craftitem("chemistry:calcium", {	
description = "Ca - Calcium",
inventory_image = "chemistry_calcium.png"
})

minetest.register_craftitem("chemistry:calcium_carbide", {	
description = "CaC2 - calcium carbide",
inventory_image = "chemistry_calcium_carbide.png"
})

minetest.register_craftitem("chemistry:calcium_hydroxide", {	
description = "Ca(OH)2 - calcium hydroxide",
inventory_image = "chemistry_calcium_hydroxide.png"
})

minetest.register_craftitem("chemistry:acetylene", {	
description = "C2H2 - acetylene",
inventory_image = "chemistry_acetylene.png"
})

minetest.register_craftitem("chemistry:silicon", {	
description = "Si - Silicon",
inventory_image = "chemistry_silicon.png"
})

minetest.register_craftitem("chemistry:silicon_dioxide", {	
description = "SiO2 - silicon dioxide",
inventory_image = "chemistry_silicon_dioxide.png"
})

minetest.register_craftitem("chemistry:stamen", {	
description = "Stamen",
inventory_image = "chemistry_stamen.png"
})

minetest.register_craftitem("chemistry:molecular_manipulator", {	
description = "Molecular manipulator",
inventory_image = "chemistry_molecular_manipulator.png"
})

minetest.register_craftitem("chemistry:molecular_manipulator", {	
description = "Molecular manipulator",
inventory_image = "chemistry_molecular_manipulator.png"
})

minetest.register_craftitem("chemistry:aluminum_alloy_base", {	
description = "Aluminum alloy base",
inventory_image = "chemistry_aluminum_alloy_base.png"
})

minetest.register_craftitem("chemistry:aluminum_alloy", {	
description = "Aluminum alloy",
inventory_image = "chemistry_aluminum_alloy.png"
})

minetest.register_craftitem("chemistry:vacuum_chamber", {	
description = "Vacuum chamber",
inventory_image = "chemistry_vacuum_chamber.png"
})

minetest.register_craftitem("chemistry:vacuum_pump", {	
description = "Vacuum pump",
inventory_image = "chemistry_vacuum_pump.png"
})

minetest.register_craftitem("chemistry:microprocessor", {	
description = "Microprocessor",
inventory_image = "chemistry_microprocessor.png"
})

minetest.register_craftitem("chemistry:aluminum_dust", {	
description = "Aluminum dust",
inventory_image = "chemistry_aluminum_dust.png"
})

minetest.register_craft({
	output = '"chemistry:test_tube" 16',
	recipe = {
		{'', '', ''},
		{'default:glass', '', 'default:glass'},
		{'', 'default:glass', ''},
	}
})

minetest.register_craft({
		type = "shapeless",
		output = "chemistry:marble_coal_dust 2",
		recipe = {
			"chemistry:marble_dust","chemistry:marble_dust",
			"technic:coal_dust"
		}
})

minetest.register_craft({
		type = "shapeless",
		output = "chemistry:test_tube_water 8",
		recipe = {
			"bucket:bucket_water","chemistry:test_tube","chemistry:test_tube",
  			"chemistry:test_tube","chemistry:test_tube","chemistry:test_tube",
			"chemistry:test_tube","chemistry:test_tube","chemistry:test_tube"
		},	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_craft({
		type = "shapeless",
		output = "chemistry:calcium_carbide 3",
		recipe = {
			"chemistry:calcium","chemistry:carbon",
			"chemistry:carbon"
		}
})

minetest.register_craft({
		type = "shapeless",
		output = "chemistry:acetylene 1",
		recipe = {
			"chemistry:calcium_carbide","chemistry:test_tube_distilated_water",
			"chemistry:test_tube_distilated_water"
		},
		replacements = {{"chemistry:calcium_carbide", "chemistry:calcium_hydroxide"},{"chemistry:test_tube_distilated_water", "chemistry:calcium_hydroxide"}}
})

minetest.register_craft({
		type = "shapeless",
		output = "default:paper",
		recipe = {
			"chemistry:celuose","chemistry:celuose",
		}
})

minetest.register_craft({
		type = "shapeless",
		output = "chemistry:acetylene",
		recipe = {
			"chemistry:carbon","chemistry:carbon","chemistry:hydrogen",
			"chemistry:hydrogen",
		},
replacements = {{"chemistry:carbon", "chemistry:test_tube"},{"chemistry:carbon", "chemistry:test_tube"},{"chemistry:hydrogen", "chemistry:test_tube"}}
})

minetest.register_craft({
	output = "chemistry:stainless_steel_block",
	recipe = {
		{'technic:stainless_steel_ingot', 'technic:stainless_steel_ingot', 'technic:stainless_steel_ingot'},
		{'technic:stainless_steel_ingot', 'technic:stainless_steel_ingot', 'technic:stainless_steel_ingot'},
		{'technic:stainless_steel_ingot', 'technic:stainless_steel_ingot', 'technic:stainless_steel_ingot'},
	}
})

minetest.register_craft({
		type = "shapeless",
		output = "technic:stainless_steel 9",
		recipe = {
			"chemistry:stainless_steel_block",
		}
})

minetest.register_craft({
	output = 'chemistry:stamen 6',
	recipe = {
		{'', '', 'technic:rebar'},
		{'', 'technic:rebar', ''},
		{'technic:rebar', '', ''},
	}
})

minetest.register_craft({
		output = "chemistry:molecular_manipulator",
		recipe = {
			{'technic:control_logic_unit','technic:rebar','technic:control_logic_unit'},
			{'technic:motor','chemistry:stamen','technic:motor'},
			{'','technic:diamond',''},
		}
})

minetest.register_craft({
		type = "shapeless",
		output = "chemistry:aluminum_alloy_base 3",
		recipe = {
			"chemistry:aluminum_ingot","chemistry:aluminum_ingot","moreores:copper_ingot"
		}
})

minetest.register_craft({
	output = "chemistry:vacuum_chamber",
	recipe = {
		{"chemistry:aluminum_alloy", "chemistry:aluminum_alloy", "chemistry:aluminum_alloy"},
		{"chemistry:aluminum_alloy", "", "chemistry:aluminum_alloy"},
		{"chemistry:aluminum_alloy", "chemistry:aluminum_alloy", "chemistry:aluminum_alloy"}
	}
})

minetest.register_craft({
	output = "chemistry:vacuum_pump",
	recipe = {
		{"chemistry:aluminum_alloy", "technic:control_logic_unit", "chemistry:aluminum_alloy"},
		{"technic:stainless_steel_ingot", "technic:motor", "technic:stainless_steel_ingot"},
		{"chemistry:aluminum_alloy", "technic:stainless_steel_ingot", "chemistry:aluminum_alloy"}
	}
})

minetest.register_craft({
	output = "chemistry:microprocessor",
	recipe = {
		{"technic:control_logic_unit", "moreores:silver_ingot", "technic:control_logic_unit"},
		{"moreores:silver_ingot", "technic:control_logic_unit", "moreores:silver_ingot"},
		{"technic:control_logic_unit", "moreores:silver_ingot", "technic:control_logic_unit"}
	}
})

minetest.register_node("chemistry:stainless_steel_block", {
	description = "Stainless steel block",
	tiles = {"chemistry_stainless_steel_block.png"},
	groups = {oddly_breakable_by_hand = 1},
	drawtype = "normal",
	sounds = default.node_sound_stone_defaults(),
	})
