local QBCore = nil
local externalBlocked = false
local isTalking = false
local talksyncEnabled = Config.EnabledByDefault

local lastGesture = 0
local nextGestureDelay = 0

local lastMicroMove = 0
local nextMicroMoveDelay = 0

local activeProfile = Config.ExpressionProfiles[Config.ExpressionLevel] or Config.ExpressionProfiles["medium"]

if Config.Framework == "qb" then
    CreateThread(function()
        local ok, core = pcall(function()
            return exports['qb-core']:GetCoreObject()
        end)

        if ok and core then
            QBCore = core
            if Config.Debug then
                print('[RiseNova:TalkSync] QBCore detected, framework hooks enabled.')
            end
        else
            if Config.Debug then
                print('[RiseNova:TalkSync] QBCore not found, falling back to standalone.')
            end
        end
    end)
end

local function LoadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(5)
        end
    end
end

local function GetGestureDictForPed(ped)
    if IsPedMale(ped) then
        return Config.GestureDictMale
    else
        return Config.GestureDictFemale
    end
end

local function StartFacialAnim(ped)
    if not Config.EnableFacialAnim then return end
    SetFacialIdleAnimOverride(ped, Config.FacialAnim, Config.FacialDict)
end

local function StopFacialAnim(ped)
    if not Config.EnableFacialAnim then return end
    ClearFacialIdleAnimOverride(ped)
end

local function DoRandomGesture(ped)
    if not Config.EnableGestures or #Config.Gestures == 0 then return end
    if not DoesEntityExist(ped) then return end

    if Config.DisableGesturesWhileAiming then
        if IsPlayerFreeAiming(PlayerId()) or IsPedInCombat(ped, 0) then
            return
        end
    end

    if not Config.GesturesInVehicle and IsPedInAnyVehicle(ped, false) then
        return
    end

    local dict = GetGestureDictForPed(ped)
    LoadAnimDict(dict)

    local gesture = Config.Gestures[math.random(1, #Config.Gestures)]

    TaskPlayAnim(
        ped,
        dict,
        gesture,
        8.0,
        -8.0,
        1200,
        49,
        0.0,
        false,
        false,
        false
    )
end

local function DoMicroMove(ped)
    if not Config.EnableMicroMoves then return end
    if not activeProfile.EnableMicroMoves then return end
    if not DoesEntityExist(ped) then return end
    if #Config.MicroMoves == 0 then return end

    LoadAnimDict(Config.MicroMoveDict)

    local anim = Config.MicroMoves[math.random(1, #Config.MicroMoves)]

    TaskPlayAnim(
        ped,
        Config.MicroMoveDict,
        anim,
        2.0,
        -2.0,
        1200,
        49,
        0.0,
        false,
        false,
        false
    )
end

RegisterNetEvent('RiseNova:TalkSync:SetBlocked', function(state)
    externalBlocked = state and true or false
    if Config.Debug then
        print('[RiseNova:TalkSync] External block state:', externalBlocked)
    end
end)

local function IsTalkSyncBlocked()
    local ped = PlayerPedId()

    if externalBlocked then
        return true
    end

    if Config.DisableWhen.Dead and IsEntityDead(ped) then
        return true
    end

    if Config.Framework == "qb" and QBCore then
        local pdata = QBCore.Functions.GetPlayerData()
        if pdata and pdata.metadata then
            if Config.DisableWhen.Dead and pdata.metadata["isdead"] then
                return true
            end
            if Config.DisableWhen.InLastStand and pdata.metadata["inlaststand"] then
                return true
            end
            if Config.DisableWhen.Cuffed and pdata.metadata["ishandcuffed"] then
                return true
            end
        end
    end

    return false
end

CreateThread(function()
    while true do
        local sleep = Config.IdleCheckInterval

        if talksyncEnabled then
            local playerId = PlayerId()
            local ped = PlayerPedId()
            local talkingNow = NetworkIsPlayerTalking(playerId)

            if Config.DisableInPauseMenu and IsPauseMenuActive() then
                talkingNow = false
            end

            if not Config.EnableInVehicle and IsPedInAnyVehicle(ped, false) then
                talkingNow = false
            end

            if IsTalkSyncBlocked() then
                talkingNow = false
            end

            -- started talking
            if talkingNow and not isTalking then
                isTalking = true
                StartFacialAnim(ped)

                lastGesture = GetGameTimer()
                nextGestureDelay = math.random(activeProfile.GestureMin, activeProfile.GestureMax)

                lastMicroMove = GetGameTimer()
                nextMicroMoveDelay = math.random(Config.MicroMoveIntervalMin, Config.MicroMoveIntervalMax)

                TriggerEvent('RiseNova:TalkSync:TalkingStarted')
            end

            -- stopped talking
            if not talkingNow and isTalking then
                isTalking = false
                StopFacialAnim(ped)

                TriggerEvent('RiseNova:TalkSync:TalkingStopped')
            end

            if isTalking then
                sleep = Config.TalkingCheckInterval

                local now = GetGameTimer()

                if now - lastGesture > nextGestureDelay then
                    lastGesture = now
                    nextGestureDelay = math.random(activeProfile.GestureMin, activeProfile.GestureMax)
                    DoRandomGesture(ped)
                end

                if Config.EnableMicroMoves and activeProfile.EnableMicroMoves then
                    if now - lastMicroMove > nextMicroMoveDelay then
                        lastMicroMove = now
                        nextMicroMoveDelay = math.random(Config.MicroMoveIntervalMin, Config.MicroMoveIntervalMax)
                        DoMicroMove(ped)
                    end
                end
            end
        end

        if sleep < 0 then sleep = 0 end
        Wait(sleep)
    end
end)
