include("autorun/armorbehavior.lua")

local alpha1 = 0
local alpha2 = 0
local alpha3 = 0
local alpha4 = 0
local alpha5 = 0
local Bar1Active = false
local Bar2Active = false
local Bar3Active = false
local Bar4Active = false
local BoostsActive = false

local npcDispositions = {}

net.Receive("HiTech_UpdateNPCDisposition", function()
    local npc = net.ReadEntity()
    local disposition = net.ReadInt(3)

    if IsValid(npc) then
        npcDispositions[npc] = disposition
    end
end)

function DrawHUD()
    local ply = LocalPlayer()
    local scrw, scrh = ScrW(), ScrH()
    local boxW = scrw * 0.1
    local boxH = scrh * 0.02

    local healthRegenTime = ply:GetNWInt("HealthregenTimeLeft", 0)
    local healthShotTime = ply:GetNWInt("HealthshotTimeLeft", 0)
    local armorRegenTime = ply:GetNWInt("ArmorRegenTimeLeft", 0)
    local boostTime = ply:GetNWInt("BoostTimeLeft", 0)
    local boostAmount = ply:GetNWInt("BoostAmount", 0)
    local armorOn = ply:GetNWBool("HiTechArmorEquipped", false)

    if not armorOn then return end

    if healthRegenTime > 0 and not Bar1Active then
        Bar1Active = true
    elseif healthRegenTime <= 0 and Bar1Active then
        Bar1Active = false
    end

    if healthShotTime > 0 and not Bar2Active then
        Bar2Active = true
    elseif healthShotTime <= 0 and Bar2Active then
        Bar2Active = false
    end

    if armorRegenTime > 0 and not Bar3Active then
        Bar3Active = true
    elseif armorRegenTime <= 0 and Bar3Active then
        Bar3Active = false
    end

    if boostTime > 0 and not Bar4Active then
        Bar4Active = true
    elseif boostTime <= 0 and Bar4Active then
        Bar4Active = false
    end

    if boostAmount > 0 and not BoostsActive then
        BoostsActive = true
    elseif boostAmount <= 0 and BoostsActive then
        BoostsActive = false
    end
    
    if Bar1Active then
        alpha1 = math.min(alpha1 + 3, 255)
    else
        alpha1 = math.max(alpha1 - 4, 0)
    end

    if Bar2Active then
        alpha2 = math.min(alpha2 + 3, 255)
    else
        alpha2 = math.max(alpha2 - 4, 0)
    end

    if Bar3Active then
        alpha3 = math.min(alpha3 + 3, 255)
    else
        alpha3 = math.max(alpha3 - 4, 0)
    end

    if Bar4Active then
        alpha4 = math.min(alpha4 + 3, 255)
    else
        alpha4 = math.max(alpha4 - 4, 0)
    end

    if BoostsActive then
        alpha5 = math.min(alpha5 + 3, 255)
    else
        alpha5 = math.max(alpha5 - 4, 0)
    end

    if(alpha1 > 0) then
        surface.SetDrawColor(0,0,0,alpha1/2)
        surface.DrawRect(scrw - boxW * 1.1, scrh - boxH * 15, boxW, boxH)
        surface.SetDrawColor(75,200,75,alpha1)
        surface.DrawOutlinedRect(scrw - boxW * 1.1, scrh - boxH * 15, boxW, boxH,2)
        surface.SetDrawColor(100,255,100,alpha1)
        surface.DrawRect(scrw - boxW * 1.1, scrh - boxH * 15, (boxW * ((60 - ply:GetNWInt("HealthUpgradeValue") * 5) - healthRegenTime)) / (60 - ply:GetNWInt("HealthUpgradeValue") * 5), boxH)
        surface.SetFont( "Default" )
	    surface.SetTextColor(50,225,50, alpha1)
	    surface.SetTextPos(scrw - boxW * 1.1, scrh - boxH * 14) 
	    surface.DrawText("Health systems recharging... " .. math.max(math.Round(healthRegenTime), 1), true)
    end

    if(alpha2 > 0) then
        surface.SetDrawColor(0,0,0,alpha2/2)
        surface.DrawRect(scrw - boxW * 1.1, scrh - boxH * 17, boxW, boxH)
        surface.SetDrawColor(50,150,50,alpha2)
        surface.DrawOutlinedRect(scrw - boxW * 1.1, scrh - boxH * 17, boxW, boxH,2)
        surface.SetDrawColor(75,200,75,alpha2)
        surface.DrawRect(scrw - boxW * 1.1, scrh - boxH * 17, (boxW * ((120 - ply:GetNWInt("HealthUpgradeValue") * 15) - healthShotTime)) / (120 - ply:GetNWInt("HealthUpgradeValue") * 15), boxH)
        surface.SetFont( "Default" )
	    surface.SetTextColor(50,225,50, alpha2)
	    surface.SetTextPos(scrw - boxW * 1.1, scrh - boxH * 16) 
	    surface.DrawText("Resupplying morphine shot... " .. math.max(math.Round(healthShotTime), 1), true)
    end

    if(alpha3 > 0) then
        surface.SetDrawColor(0,0,0,alpha3/2)
        surface.DrawRect(scrw - boxW * 5.5, scrh - boxH * 10, boxW, boxH/2)
        surface.SetDrawColor(50,200,200,alpha3)
        surface.DrawOutlinedRect(scrw - boxW * 5.5, scrh - boxH * 10, boxW, boxH/2,2)
        surface.SetDrawColor(0,255,255,alpha3)
        surface.DrawRect(scrw - boxW * 5.5, scrh - boxH * 10, (boxW * ((7 - ply:GetNWInt("RegenUpgradeValue", 0)) - armorRegenTime)) / (7 - ply:GetNWInt("RegenUpgradeValue", 0)), boxH/2)
        surface.SetFont( "Default" )
	    surface.SetTextColor(0,255,255, alpha3)
	    surface.SetTextPos(scrw - boxW * 5.19, scrh - boxH * 9.5) 
	    surface.DrawText("Suit integrity", true)
    end

    if(alpha4 > 0) then
        surface.SetDrawColor(0,0,0,alpha4/2)
        surface.DrawRect(scrw - boxW * 1.1, scrh - boxH * 18.5, boxW, boxH/2)
        surface.SetDrawColor(255,150,0,alpha4)
        surface.DrawOutlinedRect(scrw - boxW * 1.1, scrh - boxH * 18.5, boxW, boxH/2,2)
        surface.SetDrawColor(255,100,0,alpha4)
        surface.DrawRect(scrw - boxW * 1.1, scrh - boxH * 18.5, (boxW * (2.5 - boostTime)) / 2.5, boxH/2)
        surface.SetFont("Default")
	    surface.SetTextColor(255,150,0, alpha4)
	    surface.SetTextPos(scrw - boxW * 1.1, scrh - boxH * 18) 
	    surface.DrawText("Thrusters cooling down... ", true)
    end

    if(alpha5 > 0) then
        surface.SetDrawColor(0,0,0,alpha5/2)
        surface.DrawRect(scrw - boxW * 0.3, scrh - boxH * 19.5, boxW/8, boxH/2)
        surface.SetDrawColor(255,150,0,alpha5)
        surface.DrawOutlinedRect(scrw - boxW * 0.3, scrh - boxH * 19.5, boxW/8, boxH/2,2)
        surface.SetDrawColor(255,100,0,alpha5/1.5)
        if(boostAmount > 0) then
            surface.DrawRect(scrw - boxW * 0.3, scrh - boxH * 19.5, boxW/8, boxH/2)
        end
        surface.SetDrawColor(0,0,0,alpha5/2)
        surface.DrawRect(scrw - boxW * 0.45, scrh - boxH * 19.5, boxW/8, boxH/2)
        surface.SetDrawColor(255,150,0,alpha5)
        surface.DrawOutlinedRect(scrw - boxW * 0.45, scrh - boxH * 19.5, boxW/8, boxH/2,2)
        surface.SetDrawColor(255,100,0,alpha5/1.5)
        if(boostAmount > 1) then
            surface.DrawRect(scrw - boxW * 0.45, scrh - boxH * 19.5, boxW/8, boxH/2)
        end
        surface.SetDrawColor(0,0,0,alpha5/2)
        surface.DrawRect(scrw - boxW * 0.6, scrh - boxH * 19.5, boxW/8, boxH/2)
        surface.SetDrawColor(255,150,0,alpha5)
        surface.DrawOutlinedRect(scrw - boxW * 0.6, scrh - boxH * 19.5, boxW/8, boxH/2,2)
        surface.SetDrawColor(255,100,0,alpha5/1.5)
        if(boostAmount > 2) then
            surface.DrawRect(scrw - boxW * 0.6, scrh - boxH * 19.5, boxW/8, boxH/2)
        end
        surface.SetDrawColor(0,0,0,alpha5/2)
        surface.DrawRect(scrw - boxW * 0.6, scrh - boxH * 20.5, boxW/8, boxH/2)
        surface.SetDrawColor(255,150,0,alpha5)
        surface.DrawOutlinedRect(scrw - boxW * 0.6, scrh - boxH * 20.5, boxW/8, boxH/2,2)
        surface.SetDrawColor(255,100,0,alpha5/1.5)
        if(boostAmount > 3) then
            surface.DrawRect(scrw - boxW * 0.6, scrh - boxH * 20.5, boxW/8, boxH/2)
        end
        surface.SetDrawColor(0,0,0,alpha5/2)
        surface.DrawRect(scrw - boxW * 0.45, scrh - boxH * 20.5, boxW/8, boxH/2)
        surface.SetDrawColor(255,150,0,alpha5)
        surface.DrawOutlinedRect(scrw - boxW * 0.45, scrh - boxH * 20.5, boxW/8, boxH/2,2)
        surface.SetDrawColor(255,100,0,alpha5/1.5)
        if(boostAmount > 4) then
            surface.DrawRect(scrw - boxW * 0.45, scrh - boxH * 20.5, boxW/8, boxH/2)
        end
        surface.SetDrawColor(0,0,0,alpha5/2)
        surface.DrawRect(scrw - boxW * 0.3, scrh - boxH * 20.5, boxW/8, boxH/2)
        surface.SetDrawColor(255,150,0,alpha5)
        surface.DrawOutlinedRect(scrw - boxW * 0.3, scrh - boxH * 20.5, boxW/8, boxH/2,2)
        surface.SetDrawColor(255,100,0,alpha5/1.5)
        if(boostAmount > 5) then
            surface.DrawRect(scrw - boxW * 0.3, scrh - boxH * 20.5, boxW/8, boxH/2)
        end
    end

    for _, target in ipairs(ents.FindInCone(ply:GetPos(), ply:EyeAngles():Forward(), 3000, 0.4)) do
        if (target ~= ply and target:IsPlayer() and target:Alive()) or (target:IsNPC()) then
            local pos = target:EyePos()
            local scrPos = pos:ToScreen()
            if scrPos.visible then
                local distSqr = ply:GetPos():DistToSqr(target:GetPos())
                local distance = math.sqrt(distSqr)
                local size = math.min(20, 0.00005 * distSqr)
                local alpha = math.Clamp(255 * (distance / 1000), 100, 255)
    
                local color = Color(255, 255, 0, alpha)
    
                if target:IsNPC() then
                    local disposition = npcDispositions[target] or 2

                    if disposition == 1 then
                        color = Color(255, 0, 0, alpha)
                    elseif disposition == 3 then
                        color = Color(0, 255, 0, alpha)
                    end
                elseif target:IsPlayer() and target ~= ply then
                    if target:Team() == ply:Team() then
                        color = Color(0, 255, 0, alpha)
                    else
                        color = Color(255, 0, 0, alpha)
                    end
                end
    
                surface.SetDrawColor(color)
                surface.DrawOutlinedRect(scrPos.x - size/2, scrPos.y - size/2, size, size)
    
                surface.SetFont("DermaDefault")
                surface.SetTextColor(color.r, color.g, color.b, alpha)
    
                local name = target:IsPlayer() and target:Nick() or (target.PrintName ~= "" and target.PrintName) or target:GetClass()
                local text = string.format("%s [%.0fm] [%d HP]", name, distance / 52.4934, target:Health())
                local textW, textH = surface.GetTextSize(text)
    
                surface.SetTextPos(scrPos.x - textW/2, scrPos.y - size/2 - textH - 2)
                surface.DrawText(text)
            end
        end
    end    
end

concommand.Add("open_upgrademenu", function()
    local ply = LocalPlayer()
    if(ply:GetNWBool("HiTechArmorEquipped", false)) then
        local frame = vgui.Create("DFrame")
        frame:SetTitle("Armor Upgrade")
        frame:SetSize(300, 250)
        frame:Center()
        frame:MakePopup()

        local regenBtn = vgui.Create("DButton", frame)
        regenBtn:SetText("Upgrade armor regeneration")
        regenBtn:SetSize(260, 30)
        regenBtn:SetPos(20, 130)
        regenBtn.DoClick = function()
            net.Start("RequestArmorRegenUpgrade")
            net.SendToServer()
        end

        local defenseBtn = vgui.Create("DButton", frame)
        defenseBtn:SetText("Upgrade armor defense")
        defenseBtn:SetSize(260, 30)
        defenseBtn:SetPos(20, 90)
        defenseBtn.DoClick = function()
            net.Start("RequestDefenseUpgrade")
            net.SendToServer()
        end

        local healthBtn = vgui.Create("DButton", frame)
        healthBtn:SetText("Upgrade health systems")
        healthBtn:SetSize(260, 30)
        healthBtn:SetPos(20, 50)
        healthBtn.DoClick = function()
            net.Start("RequestHealthRegenUpgrade")
            net.SendToServer()
        end
    else
        ply:PrintMessage(HUD_PRINTTALK, "You don't have the high tech armor equipped!")
    end
end)

hook.Add("HUDPaint", "DrawHUD", DrawHUD)
