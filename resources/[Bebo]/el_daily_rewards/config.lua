local type = {money=1,item=2,weapon=3} -- no touchey, thank you
Config = {}

Config.claimed = "💲 لقد أستلمت <font color=orange> المكافأة</font> اليومية"
Config.rewards = {
    {
        type = type.money,
        value = 6500
    },
    {
        --type = type.item, -- item
        type = type.money, -- money
		value = 7000 -- money
        --item = "test", -- item
        --count = 3 item
    },
    {
        type = type.money, -- money
		value = 8500 -- money
    },
    {
        --type = type.weapon, -- weapon
        --weapon = "WEAPON_PISTOL", -- if they already have the weapon, they'll only get the ammo -- weapon
        --ammo = 10 -- weapon
		type = type.money, -- money
		value = 10000 -- money
    }
}

Config.random_rewards_enabled = true
Config.random_rewards = {
    {
        chance = 40, -- this can be any whole number (higher = better chance)
        {
            type = type.money,
            value = 11500
        },
        {
            type = type.money,
            value = 15000
        },
        {
            type = type.money,
            value = 17000
        }
    },
    {
        chance = 10,
        {
            --type = type.item,
            --item = "test",
            --count = 5
			type = type.money,
            value = 25000
        },
        {
            type = type.money,
            value = 30000
        }
    }
}