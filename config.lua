Config              = {}
Config.DrawDistance = 100.0
Config.IsMoneyDirtyMoney = false --If true, the money you get from treasure crates will be given in dirty money. If false, the player will get normal cash money.
Config.ContainerModel = "prop_box_wood05a" --Crate model.
Config.ShowBlips = false --If true crate blips are shown on the map.
Config.OnePersonOpen = false --If true, a crate that was once open can't be opened again by anybody (1 use). If false, the crate can be opened once by everybody (1 use/person).
Config.MarkerCircle = 1 --Marker type. Set to 1 if you want the marker visible or to -1 if you want it invisible

Config.Treasure = {
	Treasure1 = {
		Name = "High East Island Crate", --Each crate must have a unique name
		Pos = {x = 3511.36, y = 2538.47, z = 7.53}, --Position on the map
		Size = {x = 3.0, y = 3.0, z = 1.0}, --Marker size (even if invisible)
		Color = {r = 204, g = 204, b = 0}, --Maker color
		Type = Config.MarkerCircle, --Marker type. defined above
		Money = 5000, --Money given
		Items = { --Array of items given
			Item1 = { --Item
				Name = 'weed', --Item name (make sure to use the name from the DB)
				Amount = 180, --How many of this item you want to give
			},
			Item2 = { --Another item
				Name = 'coke', --The item's name
				Amount = 90, --The amount
			},
		},
		Weapons = { --Array of weapons given
			Weapon1 = { --Weapon
				Name = 'WEAPON_PISTOL50', --The weapon's name (can be found in es_extended/config.weapons.lua)
				Ammo = 80, --Amount of ammo
			},
		},
	},
	--If you don't want the crate to give items or weapons, just leave the Items and Weapons array empty
	--If you don't want the crate to give money, set the money to 0, DON'T GO INTO NEGATIVE
	--See examples below

	Treasure2 = {
		Name = "Lighthouse Crate",
		Pos = {x = 3299.19, y = 5202.89, z = 17.17},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 5000,
		Items = {
		},
		Weapons = {
			Weapon1 = {
				Name = 'WEAPON_FLAREGUN',
				Ammo = 10,
			},
		},
	},

	Treasure3 = {
		Name = "Hatchet Crate",
		Pos = {x = 1443.29, y = 6333.99, z = 22.89},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 7500,
		Items = {
		},
		Weapons = {
			Weapon1 = {
				Name = 'WEAPON_HATCHET',
				Ammo = 1,
			},
		},
	},

	Treasure4 = {
		Name = "Man of the woods crate",
		Pos = {x = -575.88, y = 5953.77, z = 21.89},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 0,
		Items = {
		},
		Weapons = {
			Weapon1 = {
				Name = 'WEAPON_COMBATPDW',
				Ammo = 180,
			},
		},
	},

	Treasure5 = {
		Name = "Hiker's crate",
		Pos = {x = -767.10, y = 4335.09, z = 147.21},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 12500,
		Items = {
		},
		Weapons = {
			Weapon1 = {
				Name = 'WEAPON_PISTOL50',
				Ammo = 180,
			},
		},
	},

	Treasure6 = {
		Name = "Warehouse worker's crate",
		Pos = {x = 246.25, y = 370.13, z = 104.80},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 0,
		Items = {
			Item1 = {
				Name = 'coke',
				Amount = 180,
			},
		},
		Weapons = {
		},
	},

	Treasure7 = {
		Name = "Boat crate",
		Pos = {x = 1235.09, y = -2918.19, z = 28.75},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 0,
		Items = {
		},
		Weapons = {
			Weapon1 = {
				Name = 'WEAPON_MICROSMG',
				Ammo = 120,
			},
		},
	},

	Treasure8 = {
		Name = "Weed dealer's crate",
		Pos = {x = -1165.29, y = -1566.74, z = 3.51},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 0,
		Items = {
			Item1 = {
				Name = 'weed',
				Amount = 180,
			},
		},
		Weapons = {
		},
	},
}