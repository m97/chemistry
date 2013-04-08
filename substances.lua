function register_substance (name1,image,description1)
minetest.register_alias(name1,"chemistry:"..name1)

minetest.register_craftitem("chemistry:"..name1, {    
description = description1,
inventory_image = image
})
end

register_substance("celuose","chemistry_substance.png","C6H10O5 - Celuose")
register_substance("calcium_carbonate","chemistry_calcium_carbonate.png","CaCO3 - Calcium Carbonate")
register_substance("carbon_dioxide","chemistry_carbon_dioxide.png","CO2 - Carbon Dioxide")
register_substance("calcium_carbide","chemistry_calcium_carbide.png","CaC2 - Calcium Carbide")
register_substance("calcium_hydroxide","chemistry_calcium_hydroxide.png","Ca(OH)2 - Calcium Hydroxide")
register_substance("acetyl","chemistry_acetylene.png","C2H2 - acetylene")
register_substance("silicon_dioxide","chemistry_silicon_dioxide.png","SiO2 - Silicon Dioxide")
register_substance("test_tube_water","chemistry_test_tube_water.png","Test-tube with water")
register_substance("test_tube_distilated_water","chemistry_test_tube_distilated_water.png","Test-tube with distilated water")