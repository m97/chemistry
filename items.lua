minetest.register_alias("chemistry_test_tube","chemistry:chemistry_test_tube")
minetest.register_alias("chemistry_test_tube_water", "chemistry:chemistry_test_tube_water")
minetest.register_alias("hydrogen", "chemistry:hydrogen")
minetest.register_alias("carbon", "chemistry:carbon")
minetest.register_alias("oxygen", "chemistry:oxygen")
minetest.register_alias("calcium", "chemistry:calcium")
minetest.register_alias("celuose", "chemistry:celuose")
minetest.register_alias("marble_dust", "chemistry:marble_dust")
minetest.register_alias("marble-coal_dust", "chemistry:marble_coal_dust")
minetest.register_alias("calcium_carbonate", "chemistry:calcium_carbonate")
minetest.register_alias("carbon_dioxide", "chemistry:carbon_dioxide")


minetest.register_craftitem("chemistry:test_tube", {	
description = "test-tube",
inventory_image = "chemistry_test_tube.png"
})

minetest.register_craftitem("chemistry:test_tube_water", {	
description = "test-tube with distilled water",
inventory_image = "chemistry_test_tube_water.png"
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
		output = "chemistry:marble_coal_dust",
		recipe = {
			"chemistry:marble_dust","chemistry:marble_dust",
			"technic:coal_dust"
		}
})


