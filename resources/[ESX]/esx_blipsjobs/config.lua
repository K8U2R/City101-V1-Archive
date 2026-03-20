Config = {}


Config.emergencyJobs = {
    ['police'] = {
	ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 29,
            flashColors = {
                29,
                29,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 29,
            },
        },
        canSee = {
            ['police'] = true,
            ['agent'] = true,
            ['mechanic'] = true,
            ['ambulance'] = true,
            ['admin'] = true,
        }
    },
	['agent'] = {
	ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 2,
            flashColors = {
                2,
                2,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 2,
            },
        },
        canSee = {
            ['police'] = true,
            ['agent'] = true,
            ['mechanic'] = true,
            ['ambulance'] = true,
            ['admin'] = true,
        }
    },
	['mechanic'] = {
	ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 55,
            flashColors = {
                55,
                55,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 55,
            },
        },
        canSee = {
            ['police'] = true,
            ['agent'] = true,
            ['mechanic'] = true,
            ['ambulance'] = true,
            ['admin'] = true,
            ['unemployed'] = true,
            ['vegetables'] = true,
            ['taxi'] = true,
            ['tailor'] = true,
            ['slaughterer'] = true,
            ['reporter'] = true,
            ['miner'] = true,
            ['lumberjack'] = true,
            ['fueler'] = true,
            ['fork'] = true,
            ['fisherman'] = true,
            ['farmer'] = true,
        }
    },
	['admin'] = {
	ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 59,
            flashColors = {
                59,
                59,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 59,
            },
        },
        canSee = {
            ['admin'] = true,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
            ['unemployed'] = false,
            ['vegetables'] = false,
            ['taxi'] = false,
            ['tailor'] = false,
            ['slaughterer'] = false,
            ['reporter'] = false,
            ['miner'] = false,
            ['lumberjack'] = false,
            ['fueler'] = false,
            ['fork'] = false,
            ['fisherman'] = false,
            ['farmer'] = false,
        }
    },
    ['ambulance'] = {
        ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 47,
            flashColors = {
                47,
                47,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 47,
            },
        },
        canSee = {
            ['police'] = true,
            ['agent'] = true,
            ['mechanic'] = true,
            ['ambulance'] = true,
            ['admin'] = true,
            ['unemployed'] = true,
            ['vegetables'] = true,
            ['taxi'] = true,
            ['tailor'] = true,
            ['slaughterer'] = true,
            ['reporter'] = true,
            ['miner'] = true,
            ['lumberjack'] = true,
            ['fueler'] = true,
            ['fork'] = true,
            ['fisherman'] = true,
            ['farmer'] = true,
        }
    },
    ['unemployed'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['vegetables'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['taxi'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['tailor'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['slaughterer'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['reporter'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['miner'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['lumberjack'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['fueler'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['fork'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['fisherman'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    },
    ['farmer'] = {
    ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                0,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 1,
                color = 0,
            },
        },
        canSee = {
            ['admin'] = false,
            ['police'] = false,
            ['agent'] = false,
            ['mechanic'] = false,
            ['ambulance'] = false,
        }
    }
}