function register_element (name1,image,description1)
minetest.register_alias(name1,"chemistry:"..name1)

minetest.register_craftitem("chemistry:"..name1, {    
description = description1,
inventory_image = image
})
end

register_element("carbon","chemistry_carbon.png","C - Carbon")
register_element("hydrogen","chemistry_hydrogen.png","H - Hydrogen")
register_element("oxygen","chemistry_oxygen.png","O - Oxygen")
register_element("calcium","chemistry_calcium.png","Ca - Calcium")
register_element("silicon","chemistry_silicon.png","Si - Silicon")
register_element("copper","chemistry_copper.png","Cu - Copper")
register_element("iron","chemistry_iron.png","Fe - Iron")
register_element("silver","chemistry_silver.png","Ag - Silver")
register_element("sulfur","chemistry_sulfur.png","S - Sulfur")
register_element("gold","chemistry_gold.png","Au - Gold")
register_element("zinc","chemistry_zinc.png","Zn - Zinc")
register_element("aluminum","chemistry_aluminum.png","Al - Aluminum")