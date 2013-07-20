dofile(minetest.get_modpath("chemistry").."/elements.lua")
dofile(minetest.get_modpath("chemistry").."/substances.lua")

minetest.register_alias("test_tube","chemistry:test_tube")
minetest.register_alias("stamen", "chemistry:stamen")
minetest.register_alias("molecular_manipulator", "chemistry:molecular_manipulator")
minetest.register_alias("aluminum_alloy_base", "chemistry:aluminum_alloy_base")
minetest.register_alias("aluminum_alloy", "chemistry:aluminum_alloy")
minetest.register_alias("vacuum_chamber", "chemistry:vacuum_chamber")
minetest.register_alias("vacuum_pump", "chemistry:vacuum_pump")
minetest.register_alias("microprocessor", "chemistry:microprocessor")
minetest.register_alias("marble_dust", "chemistry:marble_dust")
minetest.register_alias("marble-coal_dust", "chemistry:marble_coal_dust")
minetest.register_alias("aluminum_dust", "chemistry:aluminum_dust")
minetest.register_alias("pressure_chamber", "chemistry:pressure_chamber")
minetest.register_alias("dewar_vessel", "chemistry:dewar_vessel")
minetest.register_alias("nitrogen_dewar_vessel", "chemistry:nitrogen_dewar_vessel")


minetest.register_craftitem("chemistry:test_tube", {	
description = "test-tube",
inventory_image = "chemistry_test_tube.png"
})

minetest.register_craftitem("chemistry:marble_dust", {	
description = "Marble dust",
inventory_image = "chemistry_marble_dust.png"
})

minetest.register_craftitem("chemistry:marble_coal_dust", {	
description = "Marble-coal dust",
inventory_image = "chemistry_marble_coal_dust.png"
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

minetest.register_craftitem("chemistry:pressure_chamber", {	
description = "Pressure Chamber",
inventory_image = "chemistry_pressure_chamber.png"
})

minetest.register_craftitem("chemistry:dewar_vessel", {	
description = "Dewar Vessel - empty",
inventory_image = "chemistry_dewar_vessel.png"
})

minetest.register_tool("chemistry:nitrogen_dewar_vessel", {
	description = "Dewar Vessel - liquid nitrogen",
	inventory_image = "chemistry_nitrogen_dewar_vessel.png",
	stack_max = 1,
    tool_capabilities = {
        max_drop_level=0,
        groupcaps= {
            cracky={times={}, uses=5000, maxlevel=0}
        }
	
    }
})