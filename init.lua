
lib_architecture = {}

local _lib_architecture = {}



function lib_architecture.register_nodes(node_name, node_desc, node_texture, node_craft_mat, node_sounds)

--COLUMNS
	lib_architecture.register_column_base_100_height_100_width(node_name .. "_column_base_100_height_100_width", node_desc .. "column_base_100_height_100_width", node_texture, node_craft_mat, node_sounds)
	
	lib_architecture.register_column_base_050_height_100_width(node_name .. "_column_base_050_height_100_width", node_desc .. "column_base_050_height_100_width", node_texture, node_craft_mat, node_sounds)
	
	lib_architecture.register_column_beam(node_name .. "_column_beam", node_desc .. "column_beam", node_texture, node_craft_mat, node_sounds)

	lib_architecture.register_column_beam_with_support(node_name .. "_column_beam_with_support", node_desc .. "column_beam_with_support", node_texture, node_craft_mat, node_sounds)

	lib_architecture.register_column_pillar_075_width(node_name .. "_column_pillar_075_width", node_desc .. "column_pillar_075_width", node_texture, node_craft_mat, node_sounds)
	
	lib_architecture.register_column_pillar_050_width(node_name .. "_column_pillar_050_width", node_desc .. "column_pillar_050_width", node_texture, node_craft_mat, node_sounds)
	
	lib_architecture.register_column_pillar_with_slab_100_height_050_width(node_name .. "_column_pillar_with_slab_100_height_050_width", node_desc .. "wall_with_slab_100_height_050_width", node_texture, node_craft_mat, node_sounds)

	lib_architecture.register_column_pillar_with_full_wall_075_width(node_name .. "_column_pillar_with_full_wall_075_width", node_desc .. "column_pillar_with_full_wall_075_width", node_texture, node_craft_mat, node_sounds)
	
	lib_architecture.register_column_pillar_with_full_wall_050_width(node_name .. "_column_pillar_with_full_wall_050_width", node_desc .. "column_pillar_with_full_wall_050_width", node_texture, node_craft_mat, node_sounds)
	
	
--STEPS
	lib_architecture.register_steps_open_basic_01(node_name .. "_steps_open_basic_01", node_desc .. "Steps Open Basic 01", node_texture, node_craft_mat, node_sounds)

	lib_architecture.register_steps_solid_basic_01(node_name .. "_steps_solid_basic_01", node_desc .. "Steps Solid Basic 01", node_texture, node_craft_mat, node_sounds)
	
	
--WALLS
	lib_architecture.register_wall_100_height_075_width(node_name .. "_wall_100_height_075_width", node_desc .. "wall_100_height_075_width", node_texture, node_craft_mat, node_sounds)

	lib_architecture.register_wall_100_height_050_width(node_name .. "_wall_100_height_050_width", node_desc .. "wall_100_height_050_width", node_texture, node_craft_mat, node_sounds)

	lib_architecture.register_wall_100_height_025_width(node_name .. "_wall_100_height_025_width", node_desc .. "wall_100_height_025_width", node_texture, node_craft_mat, node_sounds)

	lib_architecture.register_wall_junction_with_slab_100_height_050_width(node_name .. "_wall_junction_with_slab_100_height_050_width", node_desc .. "wall_with_slab_100_height_050_width", node_texture, node_craft_mat, node_sounds)

	lib_architecture.register_wall_with_deco_01_100_height_050_width(node_name .. "_wall_with_deco_01_100_height_050_width", node_desc .. "wall_with_deco_01_100_height_050_width", node_texture, node_craft_mat, node_sounds)

	lib_architecture.register_wall_with_slab_100_height_050_width(node_name .. "_wall_with_slab_100_height_050_width", node_desc .. "wall_with_slab_100_height_050_width", node_texture, node_craft_mat, node_sounds)


end




lib_architecture.register_column_base_100_height_100_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
	node_box = {
		type = "fixed",
		fixed = {
		   {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		   {-0.5, 0.0, -0.25, 0.5, 0.5, 0.25},
		   {-0.25, 0.0, -0.5, 0.25, 0.5, 0.5},
		   {-0.4375, 0.0, -0.4375, 0.4375, 0.4375, 0.4375},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_column_base_100_height_100_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_column_base_050_height_100_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
		node_box = {
			type = "fixed",
			fixed = {
			   {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
			   {-0.5, 0, -0.25, 0.5, 0.5, 0.25},
			   {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
			   {-0.4375, 0.0625, -0.4375, 0.4375, 0.4375, 0.4375},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_column_base_050_height_100_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_column_beam = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general", "group:lib_lights" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0, -0.5, 0.25, 0.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0, -0.5, 0.25, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0, -0.5, 0.25, 0.5, 0.5},
		},
	},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_column_beam", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_column_beam_with_support = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
	node_box = {
		type = "fixed",
		fixed = {
		   {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
		   {-0.125, -0.5, -0.125, 0.125, 0, 0.125},
		   {-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875},
		   {-0.1875, -0.125, -0.1875, 0.1875, 0, 0.1875},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
		   {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
		   {-0.125, -0.5, -0.125, 0.125, 0, 0.125},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
		   {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
		   {-0.125, -0.5, -0.125, 0.125, 0, 0.125},
		},
	},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_column_beam_with_support", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_column_pillar_075_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
		},
	},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_column_pillar_075_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_column_pillar_050_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
		},
	},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_column_pillar_050_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_column_pillar_with_slab_100_height_050_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
		node_box = {
			type = "connected",
			fixed = {
				{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
				{-0.25, -0.5, -0.25, 0.25, 0.0, 0.25}
			},
			connect_front = {
				{-0.25, -0.5, -0.5, 0.25, 0.0, -0.25},
			},
			connect_back = {
				{-0.25, -0.5, 0.25, 0.25, 0.0, 0.5},
			},
			connect_left = {
				{-0.5, -0.5, -0.25, -0.25, 0.0, 0.25},
			},
			connect_right = {
				{0.25, -0.5, -0.25, 0.5, 0.0, 0.25},
			},
		},
		selection_box = {
			type = "connected",
			fixed = {
				{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
				{-0.25, -0.5, -0.25, 0.25, 0.0, 0.25}
			},
			connect_front = {
				{-0.25, -0.5, -0.5, 0.25, 0.0, -0.25},
			},
			connect_back = {
				{-0.25, -0.5, 0.25, 0.25, 0.0, 0.5},
			},
			connect_left = {
				{-0.5, -0.5, -0.25, -0.25, 0.0, 0.25},
			},
			connect_right = {
				{0.25, -0.5, -0.25, 0.5, 0.0, 0.25},
			},
		},
		collision_box = {
			type = "connected",
			fixed = {
				{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
				{-0.25, -0.5, -0.25, 0.25, 0.0, 0.25}
			},
			connect_front = {
				{-0.25, -0.5, -0.5, 0.25, 0.0, -0.25},
			},
			connect_back = {
				{-0.25, -0.5, 0.25, 0.25, 0.0, 0.5},
			},
			connect_left = {
				{-0.5, -0.5, -0.25, -0.25, 0.0, 0.25},
			},
			connect_right = {
				{0.25, -0.5, -0.25, 0.5, 0.0, 0.25},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_column_pillar_with_slab_100_height_050_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_column_pillar_with_full_wall_075_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general", "group:lib_lights"},
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
	node_box = {
		type = "connected",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
		},
		connect_front = {
			{-0.1875, -0.5, -0.5,  0.1875, 0.5, -0.375}
		},
		connect_left = {
			{-0.5, -0.5, -0.1875, -0.375, 0.5,  0.1875}
		},
		connect_back = {
			{-0.1875, -0.5,  0.375,  0.1875, 0.5,  0.5}
		},
		connect_right = {
			{ 0.375, -0.5, -0.1875,  0.5, 0.5,  0.1875}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
		},
	},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_column_pillar_with_full_wall_075_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_column_pillar_with_full_wall_050_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general", "group:lib_lights"},
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
	node_box = {
		type = "connected",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
		},
		connect_front = {
			{-0.1875, -0.5, -0.5,  0.1875, 0.5, -0.25}
		},
		connect_left = {
			{-0.5, -0.5, -0.1875, -0.25, 0.5,  0.1875}
		},
		connect_back = {
			{-0.1875, -0.5,  0.25,  0.1875, 0.5,  0.5}
		},
		connect_right = {
			{ 0.25, -0.5, -0.1875,  0.5, 0.5,  0.1875}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
		},
	},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_column_pillar_with_full_wall_050_width", ''},
			{ '', wall_mat, ''},
		}
	})

end


lib_architecture.register_steps_open_basic_01 = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
		node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.3125, -0.5, 0.5, -0.25, -0.25},
					{-0.5, -0.0625, -0.25, 0.5, 0, 0},
					{-0.5, 0.1875, 0, 0.5, 0.25, 0.25},
					{-0.5, 0.4375, 0.25, 0.5, 0.5, 0.5},
				},
			},
		selection_box = {
			type = "fixed",
			fixed = {
					{-0.5, -0.3125, -0.5, 0.5, -0.25, -0.25},
					{-0.5, -0.0625, -0.25, 0.5, 0, 0},
					{-0.5, 0.1875, 0, 0.5, 0.25, 0.25},
					{-0.5, 0.4375, 0.25, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
					{-0.5, -0.3125, -0.5, 0.5, -0.25, -0.25},
					{-0.5, -0.0625, -0.25, 0.5, 0, 0},
					{-0.5, 0.1875, 0, 0.5, 0.25, 0.25},
					{-0.5, 0.4375, 0.25, 0.5, 0.5, 0.5},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_steps_open_basic_01", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_steps_solid_basic_01 = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, -0.25},
			{-0.5, -0.25, -0.25, 0.5, 0, 0},
			{-0.5, 0, 0, 0.5, 0.25, 0.25},
			{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, -0.25},
			{-0.5, -0.25, -0.25, 0.5, 0, 0},
			{-0.5, 0, 0, 0.5, 0.25, 0.25},
			{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, -0.25},
			{-0.5, -0.25, -0.25, 0.5, 0, 0},
			{-0.5, 0, 0, 0.5, 0.25, 0.25},
			{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
		},
	},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_steps_solid_basic_01", ''},
			{ '', wall_mat, ''},
		}
	})

end




lib_architecture.register_wall_100_height_075_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
		node_box = {
				type = "fixed",
				fixed = {
					{-0.375, -0.5, -0.5, 0.375, 0.5, 0.5}
				},
			},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.375, -0.5, -0.5, 0.375, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.375, -0.5, -0.5, 0.375, 0.5, 0.5},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_wall_100_height_075_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_wall_100_height_050_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
		node_box = {
				type = "fixed",
				fixed = {
					{-0.25, -0.5, -0.5, 0.25, 0.5, 0.5}
				},
			},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.5, -0.5, 0.25, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.5, -0.5, 0.25, 0.5, 0.5},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_wall_100_height_050_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_wall_100_height_025_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
		node_box = {
				type = "fixed",
				fixed = {
					{-0.125, -0.5, -0.5, 0.125, 0.5, 0.5}
				},
			},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.5, -0.5, 0.125, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.5, -0.5, 0.125, 0.5, 0.5},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_wall_100_height_025_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_wall_junction_with_slab_100_height_050_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
		node_box = {
			type = "connected",
			fixed = {
				{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
				{-0.25, -0.5, -0.25, 0.25, 0.0, 0.25}
			},
			connect_front = {
				{-0.25, -0.5, -0.5, 0.25, 0.0, -0.25},
			},
			connect_back = {
				{-0.25, -0.5, 0.25, 0.25, 0.0, 0.5},
			},
			connect_left = {
				{-0.5, -0.5, -0.25, -0.25, 0.0, 0.25},
			},
			connect_right = {
				{0.25, -0.5, -0.25, 0.5, 0.0, 0.25},
			},
		},
		selection_box = {
			type = "connected",
			fixed = {
				{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
				{-0.25, -0.5, -0.25, 0.25, 0.0, 0.25}
			},
			connect_front = {
				{-0.25, -0.5, -0.5, 0.25, 0.0, -0.25},
			},
			connect_back = {
				{-0.25, -0.5, 0.25, 0.25, 0.0, 0.5},
			},
			connect_left = {
				{-0.5, -0.5, -0.25, -0.25, 0.0, 0.25},
			},
			connect_right = {
				{0.25, -0.5, -0.25, 0.5, 0.0, 0.25},
			},
		},
		collision_box = {
			type = "connected",
			fixed = {
				{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
				{-0.25, -0.5, -0.25, 0.25, 0.0, 0.25}
			},
			connect_front = {
				{-0.25, -0.5, -0.5, 0.25, 0.0, -0.25},
			},
			connect_back = {
				{-0.25, -0.5, 0.25, 0.25, 0.0, 0.5},
			},
			connect_left = {
				{-0.5, -0.5, -0.25, -0.25, 0.0, 0.25},
			},
			connect_right = {
				{0.25, -0.5, -0.25, 0.5, 0.0, 0.25},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_wall_junction_with_slab_100_height_050_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_wall_with_deco_01_100_height_050_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
		node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.25, 0.5, 0, 0.25},
					{-0.5, 0, -0.3125, 0.5, 0.5, 0.5},
					{-0.5, 0.375, -0.5, 0.5, 0.5, -0.3125},
					{-0.375, 0.125, -0.4375, -0.125, 0.375, -0.3125},
					{0.125, 0.125, -0.4375, 0.375, 0.375, -0.3125},
				},
			},
		selection_box = {
			type = "fixed",
			fixed = {
					{-0.5, -0.5, -0.25, 0.5, 0, 0.25},
					{-0.5, 0, -0.3125, 0.5, 0.5, 0.5},
					{-0.5, 0.375, -0.5, 0.5, 0.5, -0.3125},
					{-0.375, 0.125, -0.4375, -0.125, 0.375, -0.3125},
					{0.125, 0.125, -0.4375, 0.375, 0.375, -0.3125},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
					{-0.5, -0.5, -0.25, 0.5, 0, 0.25},
					{-0.5, 0, -0.3125, 0.5, 0.5, 0.5},
					{-0.5, 0.375, -0.5, 0.5, 0.5, -0.3125},
					{-0.375, 0.125, -0.4375, -0.125, 0.375, -0.3125},
					{0.125, 0.125, -0.4375, 0.375, 0.375, -0.3125},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_wall_with_deco_01_100_height_050_width", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_architecture.register_wall_with_slab_100_height_050_width = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)

	minetest.register_node("lib_architecture:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_architecture = 3 },
		sounds = wall_sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
				{-0.25, -0.5, -0.5, 0.25, 0.0, 0.5}
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
				{-0.25, -0.5, -0.5, 0.25, 0.0, 0.5}
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
				{-0.25, -0.5, -0.5, 0.25, 0.0, 0.5}
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_architecture:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_wall_with_slab_100_height_050_width", ''},
			{ '', wall_mat, ''},
		}
	})

end






lib_architecture.register_nodes("cobble", "Cobblestone ", "default_cobble.png",
		"default:cobble", default.node_sound_stone_defaults())
lib_architecture.register_nodes("mossycobble", "Mossy Cobblestone ", "default_mossycobble.png",
		"default:mossycobble", default.node_sound_stone_defaults())
lib_architecture.register_nodes("desertcobble", "Desert Cobblestone ", "default_desert_cobble.png",
		"default:desert_cobble", default.node_sound_stone_defaults())

lib_architecture.register_nodes("sandstone", "Sandstone ", "default_sandstone.png",
		"default:sandstone", default.node_sound_stone_defaults())
lib_architecture.register_nodes("desert_stone", "Desert Stone ", "default_desert_stone.png",
		"default:desert_stone", default.node_sound_stone_defaults())
lib_architecture.register_nodes("desert_sandstone", "Desert Sand Stone ", "default_desert_sandstone.png",
		"default:desert_sandstone", default.node_sound_stone_defaults())
lib_architecture.register_nodes("stone", "Stone ", "default_stone.png",
		"default:stone", default.node_sound_stone_defaults())
lib_architecture.register_nodes("obsidian", "Obsidian ", "default_obsidian.png",
		"default:obsidian", default.node_sound_stone_defaults())

lib_architecture.register_nodes("sandstone_block", "Sandstone Block ", "default_sandstone_block.png",
		"default:sandstone_block", default.node_sound_stone_defaults())
lib_architecture.register_nodes("desert_stone_block", "Desert Stone Block ", "default_desert_stone_block.png",
		"default:desert_stone_block", default.node_sound_stone_defaults())
lib_architecture.register_nodes("desert_sandstone_block", "Desert Sand Stone Block ",
		"default_desert_sandstone_block.png","default:desert_sandstone_block", default.node_sound_stone_defaults())
lib_architecture.register_nodes("stone_block", "Stone Block ", "default_stone_block.png",
		"default:stone_block", default.node_sound_stone_defaults())
lib_architecture.register_nodes("obsidian_block", "Obsidian Block ", "default_obsidian_block.png",
		"default:obsidian_block", default.node_sound_stone_defaults())

lib_architecture.register_nodes("sandstone_brick", "Sandstone Brick ", "default_sandstone_brick.png",
		"default:sandstonebrick", default.node_sound_stone_defaults())
lib_architecture.register_nodes("desertstone_brick", "Desert Stone Brick ", "default_desert_stone_brick.png",
		"default:desert_stonebrick", default.node_sound_stone_defaults())
lib_architecture.register_nodes("desert_sandstone_brick", "Desert Stone Brick ",
		"default_desert_sandstone_brick.png","default:desert_sandstone_brick", default.node_sound_stone_defaults())
lib_architecture.register_nodes("stone_brick", "Stone Brick ", "default_stone_brick.png",
		"default:stonebrick", default.node_sound_stone_defaults())
lib_architecture.register_nodes("obsidian_brick", "Obsidian Brick ", "default_obsidian_brick.png",
		"default:obsidianbrick", default.node_sound_stone_defaults())



lib_architecture.register_nodes("glass", "Glass ", "default_glass.png",
		"default:glass", default.node_sound_stone_defaults())

--[[
		
lib_architecture.register_nodes("tree", "Tree ", "default_tree.png",
		"default:tree", default.node_sound_stone_defaults())
lib_architecture.register_nodes("wood", "Wood ", "default_wood.png",
		"default:wood", default.node_sound_stone_defaults())
lib_architecture.register_nodes("jungletree", "Jungle Tree ", "default_jungletree.png",
		"default:jungletree", default.node_sound_stone_defaults())
lib_architecture.register_nodes("junglewood", "Jungle Wood ", "default_junglewood.png",
		"default:junglewood", default.node_sound_stone_defaults())

lib_architecture.register_nodes("acacia_tree", "Acacia Tree ", "default_acacia_tree.png",
		"default:acacia_tree", default.node_sound_stone_defaults())
lib_architecture.register_nodes("acacia_wood", "Acacia Wood ", "default_acacia_wood.png",
		"default:acacia_wood", default.node_sound_stone_defaults())

--]]










