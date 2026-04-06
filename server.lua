local ESX = exports["es_extended"]:getSharedObject()

-- Item 'radio' bruikbaar maken
ESX.RegisterUsableItem('radio', function(source)
    TriggerClientEvent('Fs-Radio:useRadio', source)
end)

-- Beveiliging voor specifieke kanalen (Politie/Ambu)
lib.callback.register('Fs-Radio:checkChannelAccess', function(source, channel)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end

    -- Configuratie van beveiligde kanalen (Kanaalnummer = Job)
    local restricted = {
        [1] = 'police',
        [2] = 'police',
        [3] = 'ambulance',
        [4] = 'ambulance',
        [5] = 'police'
    }

    local requiredJob = restricted[channel]
    
    if requiredJob then
        if xPlayer.job.name == requiredJob then
            return true
        else
            return false, "Dit kanaal is versleuteld voor " .. requiredJob
        end
    end

    return true
end)
