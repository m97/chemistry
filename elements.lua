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