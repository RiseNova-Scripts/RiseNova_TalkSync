Config = {}

-- "none", "qb" (more in future)
Config.Framework = "none"

-- When should TalkSync be disabled?
Config.DisableWhen = {
    Dead = true,        -- disable when dead
    InLastStand = true, -- QBCore metadata "inlaststand"
    Cuffed = true,      -- QBCore metadata "ishandcuffed"
    InJail = false      -- for custom use (not wired by default)
}

--  GENERAL SETTINGS
Config.EnabledByDefault = true
Config.IdleCheckInterval = 300
Config.TalkingCheckInterval = 0

--  EXPRESSION LEVEL
-- "low", "medium", "high"
Config.ExpressionLevel = "high"

Config.ExpressionProfiles = {
    low = {
        GestureMin = 3500,
        GestureMax = 6500,
        EnableMicroMoves = false
    },
    medium = {
        GestureMin = 2000,
        GestureMax = 4500,
        EnableMicroMoves = true
    },
    high = {
        GestureMin = 900,   -- constantly moving
        GestureMax = 2200,
        EnableMicroMoves = true
    }
}

--  FACIAL ANIMATION SETTINGS
Config.EnableFacialAnim = true
Config.FacialDict = "mp_facial"
Config.FacialAnim = "mic_chatter"

--  GESTURE SETTINGS
Config.EnableGestures = true
Config.GesturesInVehicle = false
Config.DisableGesturesWhileAiming = true

Config.GestureDictMale = "gestures@m@standing@casual"
Config.GestureDictFemale = "gestures@f@standing@casual"

Config.Gestures = {
    "gesture_easy_now",
    "gesture_hand_down",
    "gesture_you_soft",
    "gesture_calm_down"
}

--  MICRO MOVEMENTS (SMALL EXTRA ANIMS)
Config.EnableMicroMoves = true

Config.MicroMoveDict = "anim@mp_player_intcelebrationmale@nod" -- example
Config.MicroMoves = {
    "nod_yes",  -- small nod
}

Config.MicroMoveIntervalMin = 5000
Config.MicroMoveIntervalMax = 9000

--  RESTRICTIONS
Config.EnableInVehicle = true
Config.OnlyOnFoot = false
Config.DisableInPauseMenu = true

--  DEBUG
Config.Debug = false
