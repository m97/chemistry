minetest.register_alias("mineral_aluminum","chemistry:mineral_aluminum")
minetest.register_alias("aluminum_lump","chemistry:aluminum_lump")
minetest.register_alias("aluminum_ingot","chemistry:aluminum_ingot")

minetest.register_node( "chemistry:mineral_aluminum", {
	description = "Aluminum Ore",
	tiles = { "default_stone.png^chemistry_mineral_aluminum.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "chemistry:aluminum_lump" 1',
})

minetest.register_craftitem( "chemistry:aluminum_lump", {
	description = "Aluminum Lump",
	inventory_image = "chemistry_aluminum_lump.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "chemistry:aluminum_ingot", {
	description = "Aluminum Ingot",
	inventory_image = "chemistry_aluminum_ingot.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
	type = "cooking",
	recipe = "chemistry:aluminum_lump",
	output = "chemistry:aluminum_ingot",
})

minetest.register_craft({
	type = "cooking",
	recipe = "chemistry:aluminum_dust",
	output = "chemistry:aluminum_ingot",
})

--=================================Generate ores=======================================================================
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:mineral_aluminum",
	wherein        = "default:stone",
	clust_scarcity = 10*10*10,
	clust_num_ores = 2,
	clust_size     = 3,
	height_min     = -31000,
	height_max     = -100,
})