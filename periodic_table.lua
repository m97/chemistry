

minetest.register_alias("periodic_table","chemistry:periodic_table")

periodic_table_formspec =
	"invsize[0,0;]"..
	"image[-7,-5;18,12;chemistry_periodic_table.png]"

minetest.register_craftitem("chemistry:periodic_table", {	
description = "Periodic Table of Elements",
inventory_image = "chemistry_periodic_table_item.png",
			on_place = function(itemstack, user, pointed_thing)
				local player_name=user:get_player_name()
				minetest.show_formspec(player_name, "chemistry:periodic_table", periodic_table_formspec)
			end
})

minetest.register_craft({
	output = '"chemistry:periodic_table" 1',
	recipe = {
		{'chemistry:test_tube', 'chemistry:test_tube', 'chemistry:test_tube'},
		{'chemistry:test_tube', 'default:paper', 'chemistry:test_tube'},
		{'chemistry:test_tube', 'chemistry:test_tube', 'chemistry:test_tube'},
	}
})

