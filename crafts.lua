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
			{'','default:diamond',''},
		}
})

minetest.register_craft({
		type = "shapeless",
		output = "chemistry:aluminum_alloy_base 3",
		recipe = {
			"chemistry:aluminum_ingot","chemistry:aluminum_ingot","default:copper_ingot"
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
