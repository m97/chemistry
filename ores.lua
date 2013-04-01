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
local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x - minp.x + 1) * (y_max - y_min + 1) * (maxp.z - minp.z + 1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local chunk_size = 3
	if ore_per_chunk <= 4 then
		chunk_size = 2
	end
	local inverse_chance = math.floor(chunk_size * chunk_size * chunk_size / ore_per_chunk)
	-- print(generate_ore num_chunks: ..dump(num_chunks))
	for i=1,num_chunks do
	if (y_max-chunk_size+1 <= y_min) then return end
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1	
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.env:get_node(p2).name == wherein then
						minetest.env:set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
	 --minetest.debug("generate_ore done")
end

minetest.register_on_generated(function(minp, maxp, seed)
	math.randomseed(os.time())
	local current_seed = seed + math.random(10, 100)
	local function get_next_seed()
		current_seed = current_seed + 1
		return current_seed
	end
	generate_ore("chemistry:mineral_aluminum", "default:stone", minp, maxp, get_next_seed()+120,1/10/10/10, 10, -31000, -60)
end)