minetest.register_alias("chemistry_test_tube","chemistry:chemistry_test_tube")
minetest.register_alias("chemistry_test_tube_water", "chemistry:chemistry_test_tube_water")
minetest.register_alias("hydrogen", "chemistry:hydrogen")
minetest.register_alias("carbon", "chemistry:carbon")
minetest.register_alias("oxygen", "chemistry:oxygen")
minetest.register_alias("celuose", "chemistry:celuose")


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
inventory_image = "chemistry_substance.png"
})

minetest.register_craftitem("chemistry:carbon", {	
description = "C - Carbon",
inventory_image = "chemistry_substance.png"
})

minetest.register_craftitem("chemistry:oxygen", {	
description = "O - Oxygen",
inventory_image = "chemistry_substance.png"
})


minetest.register_craftitem("chemistry:celuose", {	
description = "C6H10O5 - Celuose",
inventory_image = "chemistry_substance.png"
})

minetest.register_craft({
	output = '"chemistry:test_tube" 16',
	recipe = {
		{'', '', ''},
		{'default:glass', '', 'default:glass'},
		{'', 'default:glass', ''},
	}
})


