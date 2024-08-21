local m = RegisterMod("AutoSwitch", 1)
local hascard = false
local card = nil
local pickupnum1 = 0
local nownum1 = 0
local subtype = nil
local allowcard = false
local haspill = false
local pill = nil
local allowpill = false
local pickupnum2 = 0
local nownum2 = 0


function m.detectcard()
    allowcard = false
    local player = Isaac.GetPlayer()
    if not hascard and player:GetCard(0) ~= 0 then
        Switch()
        hascard = true
        card = player:GetCard(1) + player:GetCard(0)
    end
    if hascard then
        nownum1 = Isaac.CountEntities(nil, EntityType.ENTITY_PICKUP)
        if nownum1 == pickupnum1 + 1 then
            for i, entity in ipairs(Isaac.GetRoomEntities()) do
                if entity.Type == 5 and entity.Variant == 300 then
                    subtype = entity.SubType
                end
            end
            if subtype == card then
                    allowcard = true
            end
        end
    end
    if allowcard and player:GetCard(0) ~= 0 then
        Switch()
        hascard = true
        card = player:GetCard(1) + player:GetCard(0)
        allowcard = false
    end
    if player:GetCard(1) == 0 and player:GetCard(0) == 0 then
        hascard = false
    end
    pickupnum1 = Isaac.CountEntities(nil, EntityType.ENTITY_PICKUP)
end

function m.detectpill()
    allowpill = false
    local player = Isaac.GetPlayer()
    if not haspill and player:GetPill(0) ~= 0 then
        Switch()
        haspill = true
        pill = player:GetPill(1) + player:GetPill(0)
    end
    if haspill then
        nownum2 = Isaac.CountEntities(nil, EntityType.ENTITY_PICKUP)
        if nownum2 == pickupnum2 + 1 then
            for i, entity in ipairs(Isaac.GetRoomEntities()) do
                if entity.Type == 5 and entity.Variant == 70 then
                    subtype = entity.SubType
                end
            end
            if subtype == pill then
                allowpill = true
            end
        end
    end
    if allowpill and player:GetPill(0) ~= 0 then
        Switch()
        haspill = true
        pill = player:GetPill(1) + player:GetPill(0)
        allowpill = false
    end
    if player:GetPill(1) == 0 and player:GetPill(0) == 0 then
        haspill = false
    end
    pickupnum2 = Isaac.CountEntities(nil, EntityType.ENTITY_PICKUP)
end

function Switch()
    local player = Isaac.GetPlayer()
    local name = player:GetName()
    if name ~= '???' then
        local item = player:GetActiveItem(2)
        local charge = player:GetActiveCharge(2)
        player:SetPocketActiveItem(item, 2, false)
        player:SetActiveCharge(charge, 2)
    end
end

m:AddCallback(ModCallbacks.MC_POST_UPDATE, m.detectcard)
m:AddCallback(ModCallbacks.MC_POST_UPDATE, m.detectpill)





