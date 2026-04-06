local radioProp = nil
local animDict = "random@arrests"
local animName = "generic_radio_chatter"
local propModel = `prop_cs_hand_radio`

-- Menu openen via ox_lib
RegisterNetEvent('Fs-Radio:useRadio', function()
    local input = lib.inputDialog('Fs-Radio Portofoon', {
        {type = 'number', label = 'Frequentie (MHz)', description = 'Kies 1 - 500', icon = 'tower-broadcast', min = 1, max = 500},
    })

    if not input then return end
    local channel = tonumber(input[1])

    -- Toegang checken
    local canJoin, message = lib.callback.await('Fs-Radio:checkChannelAccess', false, channel)

    if canJoin then
        exports["pma-voice"]:setRadioChannel(channel)
        lib.notify({title = 'Fs-Radio', description = 'Verbonden met ' .. channel .. ' MHz', type = 'success'})
    else
        lib.notify({title = 'Geen Toegang', description = message, type = 'error'})
    end
end)

-- Animatie Starten
local function startRadioAnim()
    lib.requestModel(propModel)
    lib.requestAnimDict(animDict)
    
    local playerPed = PlayerPedId()
    radioProp = CreateObject(propModel, 0, 0, 0, true, true, true)
    
    -- Attach aan linkerhand (bone 60309)
    AttachEntityToEntity(radioProp, playerPed, GetPedBoneIndex(playerPed, 60309), 0.06, 0.05, 0.03, -90.0, 30.0, 0.0, true, true, false, true, 1, true)
    TaskPlayAnim(playerPed, animDict, animName, 8.0, 0.0, -1, 49, 0, false, false, false)
end

-- Animatie Stoppen
local function stopRadioAnim()
    if radioProp then
        DeleteEntity(radioProp)
        radioProp = nil
    end
    StopAnimTask(PlayerPedId(), animDict, animName, 1.0)
end

-- Detecteren of speler de radio gebruikt (pma-voice)
AddEventHandler('pma-voice:setTalkingOnRadio', function(talking)
    if talking then
        startRadioAnim()
    else
        stopRadioAnim()
    end
end)
