-- ⠀⢀⣤⣶⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣷⡆⠀⢸⣿⣿⣿⣿⡄⠀⠀⠀⢰⣿⣿⣿⣿⠀⠀⠀⣿⣿⣿⠀⠀⢸⣿⣿⡇⠀⠀⠀⢸⣿⣿⡇⠀⠀⣿⣿⣿⣿⣧⠀⠀⠀⠀⣾⣿⣿⣿⡇⠀⠀⢸⣿⣿⣿⣿⣿⣿⡆⠘⢿⣿⣿⣄⠀⠀⣰⣿⣿⡿⠃
-- ⢀⣾⣿⣿⠟⠉⠉⠛⣿⣿⣿⡆⠀⢰⣿⣿⣿⠉⠉⠙⠛⠀⠀⢸⣿⣿⣿⣿⣧⠀⠀⠀⣾⣿⣿⣿⣿⠀⠀⠀⣿⣿⣿⠀⠀⢸⣿⣿⡇⠀⠀⠀⢸⣿⣿⡇⠀⠀⣿⣿⣿⣿⣿⡄⠀⠀⢰⣿⣿⣿⣿⡇⠀⠀⢸⣿⣿⡏⠉⠉⠉⠁⠀⠈⢻⣿⣿⣆⣰⣿⣿⡿⠁
-- ⢸⣿⣿⡿⠀⠀⠀⠀⢸⣿⣿⣷⠀⠈⢿⣿⣿⣷⣦⣤⡀⠀⠀⢸⣿⣿⡏⣿⣿⡆⠀⢸⣿⡿⢸⣿⣿⠀⠀⠀⣿⣿⣿⠀⠀⢸⣿⣿⡇⠀⠀⠀⢸⣿⣿⡇⠀⠀⣿⣿⣿⢹⣿⣷⠀⠀⣿⣿⠇⣿⣿⡇⠀⠀⢸⣿⣿⣧⣤⣤⣤⠀⠀⠀⠀⠻⣿⣿⣿⣿⠟
-- ⢸⣿⣿⣷⠀⠀⠀⠀⢸⣿⣿⣿⠀⠀⠀⠙⠛⠿⣿⣿⣿⣆⠀⢸⣿⣿⡇⢹⣿⣷⢀⣿⣿⠃⢸⣿⣿⠀⠀⠀⣿⣿⣿⠀⠀⢸⣿⣿⡇⠀⠀⠀⢸⣿⣿⡇⠀⠀⣿⣿⣿⠈⣿⣿⡆⣸⣿⡟⠀⣿⣿⡇⠀⠀⢸⣿⣿⡿⠿⠿⠿⠀⠀⠀⠀⣴⣿⣿⣿⣿⣆
-- ⠈⣿⣿⣿⣦⣀⣀⣤⣿⣿⣿⠇⠀⢰⣤⣄⣀⣀⣸⣿⣿⡟⠀⢸⣿⣿⡇⠀⣿⣿⣿⣿⡟⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿⠀⠀⠘⣿⣿⣿⣄⣀⣠⣾⣿⣿⠇⠀⠀⣿⣿⣿⠀⢸⣿⣿⣿⣿⠃⠀⣿⣿⡇⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⢀⣾⣿⣿⠏⠹⣿⣿⣧⡀
-- ⠀⠈⠻⢿⣿⣿⣿⣿⡿⠟⠃⠀⠀⠸⢿⣿⣿⣿⣿⡿⠟⠁⠀⢸⣿⣿⡇⠀⠸⣿⣿⣿⠃⠀⢸⣿⣿⠀⠀⠀⣿⣿⣿⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⣿⣿⣿⠀⠀⢿⣿⣿⡟⠀⠀⣿⣿⡇⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⣠⣿⣿⣿⠃⠀⠀⠙⣿⣿⣿⣄

-- ----------------------------------------------------------------------------------------------------------------------------

local QBCore = exports['qb-core']:GetCoreObject()

local function insertIntoTable(table, value)
    -- same as table.insert(table, value)
    table[#table + 1] = value
end

local function GetOfflinePlayers()
    allCitizenIdsFromDB = MySQL.prepare.await("SELECT `citizenid` FROM `players`")
    local offlinePlayers = {}

    for _, v in pairs(allCitizenIdsFromDB) do
        if not QBCore.Functions.GetPlayerByCitizenId(v.citizenid) then
            insertIntoTable(offlinePlayers, QBCore.Functions.GetOfflinePlayer(v.citizenid))
        end
    end
    
    return offlinePlayers
end

local function sendEmail(citizenId, heistType, randomPlayerAmount, randomPlayerAccount) 
    if not RealisticHeistsConfig.enableEmails then return end
    local mailData = {
        sender = "Los Santos City News",
        subject = "Affected by a Heist",
        message = "You have been affected by a "..heistType.." heist! $"..randomPlayerAmount.." has been taken from your "..randomPlayerAccount.." account!",
    }
    TriggerEvent("qb-phone:server:sendNewEventMail", citizenId, mailData)
end

RegisterNetEvent("osm-realisticheists:server:triggerHeistDeductions")
AddEventHandler("osm-realisticheists:server:triggerHeistDeductions", function(heistAmount, heistType)
    triggerHeistDeductions(heistAmount, heistType)
end)

function triggerHeistDeductions(heistAmount, heistType)
    if not heistAmount or heistAmount < 0 then
        print("[RealisticHeists] Heist amount was not specified or is less than 0")
        return
    end

    local affectedPeopleOnline = {}
    local affectPeopleOffline = {}
    local onlinePlayers = QBCore.Functions.GetQBPlayers()

    local totalAffectedPeople = math.min(#onlinePlayers, math.random(RealisticHeistsConfig.totalAffectedPeople.min, RealisticHeistsConfig.totalAffectedPeople.max))
    local onlinePlayersAffected = math.ceil(totalAffectedPeople * RealisticHeistsConfig.totalAffectedPeople.onlinePlayerRatio)
    local offlinePlayersAffected = totalAffectedPeople - onlinePlayersAffected
    
    local totalAmountToTake = math.ceil(heistAmount * RealisticHeistsConfig.totalAmountRatio)

    if RealisticHeistsConfig.randomizedDeductionAmount then
        totalAmountToTake = math.ceil(heistAmount * math.random() * (RealisticHeistsConfig.randomizeAmountRatioRange.max - RealisticHeistsConfig.randomizeAmountRatioRange.min) + RealisticHeistsConfig.randomizeAmountRatioRange.min)
    end
    
    if RealisticHeistsConfig.enableDebug then
        print("Online Players: " .. #onlinePlayers)
        print("Total Affected People: " .. totalAffectedPeople)
        print("Online Players Affected: " .. onlinePlayersAffected)
        print("Offline Players Affected: " .. offlinePlayersAffected)
        print("Total Amount to Take: $" .. totalAmountToTake)
    end
    
    for i = 1, onlinePlayersAffected do
        local randomPlayerKey = math.random(1, #onlinePlayers)
        local randomPlayer = onlinePlayers[randomPlayerKey] 

        local randomPlayerSrc = randomPlayer.PlayerData.source
        local randomPlayerData = randomPlayer.PlayerData
        local randomPlayerAmount = math.min(RealisticHeistsConfig.totalAffectedPeople.maxAmountPerPerson, totalAmountToTake // totalAffectedPeople)

        for _, account in pairs(RealisticHeistsConfig.moneyAccountsAffected) do
            if randomPlayerData.money[account] >= randomPlayerAmount then
                insertIntoTable(affectedPeopleOnline, {
                    src = randomPlayerSrc,
                    amount = randomPlayerAmount,
                    account = account
                })
                break
            end
        end

        table.remove(onlinePlayers, randomPlayerKey)
    end

    if RealisticHeistsConfig.enableDebug then
        for _, player in pairs(affectedPeopleOnline) do
            print("Player Source: " .. player.src)
            print("Amount: $" .. player.amount)
            print("Account: " .. player.account)
        end
    end
    

    for _, player in pairs(affectedPeopleOnline) do
        local randomPlayerSrc = player.src
        local randomPlayerAmount = player.amount
        local randomPlayerAccount = player.account
        
        local randomPlayer = QBCore.Functions.GetPlayer(randomPlayerSrc)
        if randomPlayer then
            randomPlayer.Functions.RemoveMoney(randomPlayerAccount, randomPlayerAmount)
            if RealisticHeistsConfig.enableNotifications then
                TriggerClientEvent('QBCore:Notify', randomPlayerSrc, 'You have been affected by a '..heistType..' heist! $'..randomPlayerAmount..' has been taken from your '..randomPlayerAccount..' account!', 'error', 8000)
            end
            sendEmail(randomPlayer.PlayerData.citizenid, heistType, randomPlayerAmount, randomPlayerAccount)
        end
    end

    local offlinePlayers = GetOfflinePlayers()
    for i = 1, offlinePlayersAffected do
        local randomPlayerKey = math.random(1, #onlinePlayers)
        local randomPlayer = offlinePlayers[randomPlayerKey]
        local randomPlayerData = randomPlayer
        local randomPlayerAmount = math.min(RealisticHeistsConfig.totalAffectedPeople.maxAmountPerPerson, totalAmountToTake // totalAffectedPeople)

        for _, account in pairs(RealisticHeistsConfig.moneyAccountsAffected) do
            if randomPlayerData.money[account] >= randomPlayerAmount then
                table.insert(affectPeopleOffline, {
                    playerObj = randomPlayer,
                    amount = randomPlayerAmount,
                    account = account
                })
                break
            end
        end

        table.remove(offlinePlayers, randomPlayerKey)
    end

    for _, player in pairs(affectPeopleOffline) do
        local randomPlayer = player.playerObj
        local randomPlayerAmount = player.amount
        local randomPlayerAccount = player.account
        
        randomPlayer.money[randomPlayerAccount] = randomPlayer.money[randomPlayerAccount] - randomPlayerAmount

        MySQL.update.await("UPDATE `players` SET `money` = @money WHERE `citizenid` = @citizenid", {
            ['@money'] = json.encode(randomPlayer.money),
            ['@citizenid'] = randomPlayer.citizenid
        })
        sendEmail(randomPlayer.citizenid, heistType, randomPlayerAmount, randomPlayerAccount)
    end     
end

exports('triggerHeistDeductions', triggerHeistDeductions)
