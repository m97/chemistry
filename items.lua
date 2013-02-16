minetest.register_alias("test_tube","chemistry:test_tube")
minetest.register_alias("test_tube_water", "chemistry:test_tube_water")
minetest.register_alias("test_tube_distilated_water", "chemistry:test_tube_distilated_water")
minetest.register_alias("hydrogen", "chemistry:hydrogen")
minetest.register_alias("carbon", "chemistry:carbon")
minetest.register_alias("oxygen", "chemistry:oxygen")
minetest.register_alias("calcium", "chemistry:calcium")
minetest.register_alias("celuose", "chemistry:celuose")
minetest.register_alias("marble_dust", "chemistry:marble_dust")
minetest.register_alias("marble-coal_dust", "chemistry:marble_coal_dust")
minetest.register_alias("calcium_carbonate", "chemistry:calcium_carbonate")
minetest.register_alias("carbon_dioxide", "chemistry:carbon_dioxide")
minetest.register_alias("calcium_carbide", "chemistry:calcium_carbide")
minetest.register_alias("calcium_hydroxide", "chemistry:calcium_hydroxide")
minetest.register_alias("acetylene", "chemistry:acetylene")


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