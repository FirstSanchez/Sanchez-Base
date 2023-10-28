Config = {}

-- Config.Marker = {
--   ["type"] = 0,
--   ["scale"] = vector3(0.5, 0.5, 0.5),
--   ["color"] = ,
-- }

Config.Elevators = {
    [1] = { -- Pillbox MD
        pos = vector3(316.9114, -577.0412, 43.2758),
        floors = {
            [1] = vector3(327.8128, -569.1534, 48.2111),
            [0] = vector3(316.9114, -577.0412, 43.2758), -- Erdgeschoss
            [-1] = vector3(316.6460, -597.3953, 38.3293),
        }
    },

    [2] = { -- PD
        pos = vector3(-1096.4634, -850.0781, 19.0012),
        floors = {
            [5] = vector3(-1096.0105, -850.5018, 38.2432),
            [4] = vector3(-1096.2672, -850.1996, 34.3607),
            [3] = vector3(-1096.3011, -850.2303, 30.7572),
            [2] = vector3(-1096.1583, -850.3533, 26.8276),
            [1] = vector3(-1096.0242, -850.4318, 23.0387),
            [0] = vector3(-1096.4634, -850.0781, 19.0012), -- Erdgeschoss
            [-1] = vector3(-1096.1996, -850.3205, 10.2743),
            [-2] = vector3(-1096.1996, -850.3205, 4.8842),
        }
    },
}