Config = {}

Config.Item = {
    Require = true,
    name = "radio"
}

Config.KeyMappings = {
    Enabled = true, 
    Key = "F12"
}

Config.ClientNotification = function(msg, type)
    ESX.ShowNotification(msg)
end
  
Config.ServerNotification = function(msg, type, player)
    TriggerClientEvent('esx:showNotification', player, msg)
end


--- Resticts in index order
Config.RestrictedChannels = {
    { -- Channel 1
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 2
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 3
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 4
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 5
        admin = true,   
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 6
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 7
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 8
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 9
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 10
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 11
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 12
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 13
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 14
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    },
    { -- Channel 15
        admin = true,
        police = true,
        agent = true,
        ambulance = true,
        mechanic = true,
    }
}

Config.MaxFrequency = 500

Config.messages = {
    ["not on radio"] = "لقد خرجت من الموجة",
    ["on radio"] = "انت ب الفعل موجود في الموجودة",
    ["joined to radio"] = "لقد نضممت الى الموجة رقم: ",
    ["restricted channel error"] = "لايمكنك الدخول الى هذه الموجة!",
    ["invalid radio"] = "هذه الموجة غير موجودة",
    ["you on radio"] = "انت ب الفعل موجود في الموجودة",
    ["you leave"] = "لقد خرجت من الموجة",
    ['volume radio'] = 'صوت جديد ',
    ['decrease radio volume'] = 'صوت الراديو اعلى شي',
    ['increase radio volume'] = 'صوت الراديو اقل شي',
    ['increase decrease radio channel'] = 'موجة جديدة ',
}
