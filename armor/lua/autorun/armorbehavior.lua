if SERVER then
    function TakingDamage(ent, dmg)
        Players = player.GetHumans()
        if(ent:IsPlayer()) then
            Players = player.GetHumans()
            for i=1, table.Count(Players) do
                if(ent == Players[i]) then
                    print("found player")

                    if(ent.LightArmorEquipped) then
                        if(dmg:GetDamageType() == DMG_FALL) then
                            local randSFX = math.random(3)
                            ent:EmitSound("physics/metal/metal_barrel_impact_soft1.wav", 40, 145, 0.3, CHAN_AUTO)
                            ent:EmitSound("physics/plaster/drywall_impact_hard" .. randSFX .. ".wav", 70, 110, 0.9, CHAN_AUTO)
                            ent:EmitSound("physics/metal/weapon_impact_hard2.wav", 80, 90, 1, CHAN_AUTO)
                            return
                        end

                        print("base damage: " .. dmg:GetDamage())
                        dmg:ScaleDamage(0.9)
                        print("scaled damage: " .. dmg:GetDamage())
                        if(ent:LastHitGroup() == HITGROUP_CHEST or ent:LastHitGroup() == HITGROUP_STOMACH) then
                            local randSFX = math.random(3)
                            local randSFX2 = math.random(3)
                            ent:EmitSound("physics/rubber/rubber_tire_impact_soft" .. randSFX .. ".wav", 75, 135, 0.6, CHAN_AUTO)
                            ent:EmitSound("physics/rubber/rubber_tire_impact_bullet" .. randSFX2 .. ".wav", 75, 135, 0.7, CHAN_AUTO)
                            dmg:ScaleDamage(0.7)
                            print("hit vest, damage: " .. dmg:GetDamage())
                        elseif(ent:LastHitGroup() == HITGROUP_HEAD) then
                            local randSFX = math.random(3)
                            ent:EmitSound("physics/metal/metal_box_impact_bullet" .. randSFX .. ".wav", 75, 135, 0.7, CHAN_AUTO)
                            ent:EmitSound("physics/metal/metal_barrel_impact_soft1.wav", 75, 120, 0.6, CHAN_AUTO)
                            dmg:ScaleDamage(0.8)
                            ent:ViewPunch(Angle(dmg:GetDamage()*(-1), dmg:GetDamage()*math.random(-1,1), dmg:GetDamage()*math.random(-1,1)))
                            eyeang = ent:EyeAngles()
                            eyeang.pitch = eyeang.pitch - dmg:GetDamage()*(0.25)
                            eyeang.yaw = eyeang.yaw - math.Rand(dmg:GetDamage()*math.random(-1,1), dmg:GetDamage()*math.random(-1,1))
                            ent:SetEyeAngles(eyeang)
                            print("hit helmet, damage: " .. dmg:GetDamage())
                        else
                            print("didn't hit vest")
                        end
                    end

                    if(ent.HeavyArmorEquipped) then
                        if(dmg:GetDamageType() == DMG_FALL) then
                            local randSFX = math.random(3)
                            ent:EmitSound("physics/metal/metal_barrel_impact_soft1.wav", 40, 145, 0.3, CHAN_AUTO)
                            ent:EmitSound("physics/plaster/drywall_impact_hard" .. randSFX .. ".wav", 70, 110, 0.9, CHAN_AUTO)
                            ent:EmitSound("physics/metal/weapon_impact_hard2.wav", 80, 90, 1, CHAN_AUTO)
                            return
                        end

                        print("base damage: " .. dmg:GetDamage())
                        dmg:ScaleDamage(0.8)
                        print("scaled damage: " .. dmg:GetDamage())

                        if(ent:LastHitGroup() == HITGROUP_CHEST or ent:LastHitGroup() == HITGROUP_STOMACH) then
                            local randSFX = math.random(3)
                            local randSFX2 = math.random(3)
                            local randSFX3 = math.random(5,6)
                            ent:EmitSound("physics/rubber/rubber_tire_impact_soft" .. randSFX .. ".wav", 75, 135, 0.6, CHAN_AUTO)
                            ent:EmitSound("physics/rubber/rubber_tire_impact_bullet" .. randSFX2 .. ".wav", 75, 135, 0.7, CHAN_AUTO)
                            ent:EmitSound("physics/metal/metal_barrel_impact_hard" .. randSFX3 .. ".wav", 55, 135, 0.6, CHAN_AUTO)
                            dmg:ScaleDamage(0.6)
                            print("hit vest, damage: " .. dmg:GetDamage())
                        elseif(ent:LastHitGroup() == HITGROUP_HEAD) then
                            local randSFX = math.random(3)
                            local randSFX2 = math.random(3)
                            ent:EmitSound("physics/metal/metal_box_impact_bullet" .. randSFX .. ".wav", 75, 135, 0.7, CHAN_AUTO)
                            ent:EmitSound("physics/metal/metal_barrel_impact_soft1.wav", 75, 120, 0.6, CHAN_AUTO)
                            ent:EmitSound("physics/glass/glass_sheet_step4.wav", 60, 120, 0.4, CHAN_AUTO)
                            ent:EmitSound("physics/glass/glass_impact_bullet" .. randSFX2 .. ".wav", 75, 120, 0.5, CHAN_AUTO)
                            dmg:ScaleDamage(0.7)
                            ent:ViewPunch(Angle(dmg:GetDamage()*(-1), dmg:GetDamage()*math.random(-1,1), dmg:GetDamage()*math.random(-1,1)))
                            eyeang = ent:EyeAngles()
                            eyeang.pitch = eyeang.pitch - dmg:GetDamage()*(0.25)
                            eyeang.yaw = eyeang.yaw - math.Rand(dmg:GetDamage()*math.random(-1,1), dmg:GetDamage()*math.random(-1,1))
                            ent:SetEyeAngles(eyeang)
                            print("hit helmet, damage: " .. dmg:GetDamage())
                        else
                            print("didn't hit vest")
                        end
                    end

                    if(ent.HiTechArmorEquipped) then
                        if(dmg:GetDamageType() == DMG_FALL) then
                            dmg:ScaleDamage(0)
                            local randSFX = math.random(3)
                            ent:EmitSound("physics/plaster/drywall_impact_hard" .. randSFX .. ".wav", 60, 150, 0.7, CHAN_AUTO)
                            ent:EmitSound("player/suit_sprint.wav", 75, 80, 1, CHAN_AUTO)
                            return
                        end

                        if(dmg:GetDamageType() == DMG_SHOCK) then
                            ent:SetArmor(math.min(ent:Armor() + dmg:GetDamage(),ent:GetMaxArmor()*2))
                            dmg:ScaleDamage(0.4)
                            return
                        end

                        if ent.ArmorRegenReady then
                            ent.ArmorRegenReady = false
                        end

                        if timer.Exists("ArmorRegenCooldown" .. i) then
                            timer.Remove("ArmorRegenCooldown" .. i)
                        end

                        if timer.Exists("ArmorRegen" .. i) then
                            timer.Remove("ArmorRegen" .. i)
                        end

                        if(dmg:GetDamageType() == DMG_BURN) then
                            ent:SetLastHitGroup(HITGROUP_GENERIC)
                            ent:SetArmor(math.min(ent:Armor() + dmg:GetDamage()*0.5,ent:GetMaxArmor()))
                            dmg:ScaleDamage(0.5)
                            return
                        end

                        if(dmg:GetDamageType() == DMG_BLAST or dmg:GetDamageType() == DMG_PLASMA or dmg:GetDamageType() == DMG_ENERGYBEAM) then
                            ent:SetLastHitGroup(HITGROUP_GENERIC)
                            ent:SetArmor(math.min(ent:Armor() + dmg:GetDamage()*0.3,ent:GetMaxArmor()))
                            dmg:ScaleDamage(0.8)
                            return
                        end

                        if(ent:Armor() > 0 and not (ent:Armor() > ent:GetMaxArmor())) then
                            ent:SetArmor(math.min(ent:Armor() + 1 + dmg:GetDamage()*0.2 + (ent:GetNWInt("DefenseUpgradeValue", 0) * 0.05), ent:GetMaxArmor()))
                            dmg:ScaleDamage(0.8 - (ent:GetNWInt("DefenseUpgradeValue", 0) * 0.05))
                        elseif(ent:Armor() <= 0 and not (ent:Armor() > ent:GetMaxArmor())) then
                            ent:SetArmor(math.min(ent:Armor() + 1 + dmg:GetDamage()*0.2, ent:GetMaxArmor()))
                            dmg:ScaleDamage(0.9)
                        elseif(ent:Armor() > ent:GetMaxArmor()) then
                            dmg:ScaleDamage(0.75 - (ent:GetNWInt("DefenseUpgradeValue", 0) * 0.05))
                        end

                        if(ent:LastHitGroup() == HITGROUP_CHEST or ent:LastHitGroup() == HITGROUP_STOMACH) then
                            local randSFX = math.random(3)
                            local randSFX2 = math.random(3)
                            local randSFX3 = math.random(5,7)
                            ent:EmitSound("physics/metal/metal_canister_impact_soft" .. randSFX .. ".wav", 75, 145, 0.8, CHAN_AUTO)
                            ent:EmitSound("physics/metal/metal_box_impact_bullet" .. randSFX2 .. ".wav", 75, 125, 0.7, CHAN_AUTO)
                            ent:EmitSound("physics/metal/metal_barrel_impact_hard" .. randSFX3 .. ".wav", 55, 135, 0.6, CHAN_AUTO)
                            if(ent:Armor() > 0) then
                                dmg:ScaleDamage(0.7)
                            else
                                dmg:ScaleDamage(0.9)
                            end
                        elseif(ent:LastHitGroup() == HITGROUP_HEAD) then
                            local randSFX = math.random(3)
                            local randSFX2 = math.random(3)
                            ent:EmitSound("physics/metal/metal_box_impact_bullet" .. randSFX .. ".wav", 75, 135, 0.7, CHAN_AUTO)
                            ent:EmitSound("physics/metal/metal_barrel_impact_soft1.wav", 75, 120, 0.6, CHAN_AUTO)
                            ent:EmitSound("physics/glass/glass_sheet_step4.wav", 60, 120, 0.4, CHAN_AUTO)
                            ent:EmitSound("physics/glass/glass_impact_bullet" .. randSFX2 .. ".wav", 75, 120, 0.6, CHAN_AUTO)
                            if(ent:Armor() > 0) then
                                dmg:ScaleDamage(0.8)
                            end
                            ent:ViewPunch(Angle(dmg:GetDamage()*(-1), dmg:GetDamage()*math.random(-1,1), dmg:GetDamage()*math.random(-1,1)))
                            eyeang = ent:EyeAngles()
                            eyeang.pitch = eyeang.pitch - dmg:GetDamage()*(0.25)
                            eyeang.yaw = eyeang.yaw - math.Rand(dmg:GetDamage()*math.random(-1,1), dmg:GetDamage()*math.random(-1,1))
                            ent:SetEyeAngles(eyeang)
                        end
                    end
                end
            end
        end
    end

    function HiTechBehavior()
        Players = player.GetHumans()
        for i=1, table.Count(Players) do
            if(Players[i].HiTechArmorEquipped) then
                local ply = Players[i]
                if(ply:Health() < ply:GetMaxHealth()*0.3 and ply.HealthshotReady and not timer.Exists("HealthregenActive" .. i)) then
                    ply:SetHealth(math.min(ply:Health() + math.Truncate(ply:Health()*0.8 + ply:GetNWInt("HealthUpgradeValue") * 5, 0), ply:GetMaxHealth()))
                    ply.HealthshotReady = false
                    ply:ScreenFade(SCREENFADE.IN, Color( 120, 255, 120, 128), 0.8, 0.1)
                    ply:EmitSound("items/smallmedkit1.wav", 85, 95, 1.2, CHAN_AUTO)
                    timer.Create("HealthshotCooldown" .. i, 120 - ply:GetNWInt("HealthUpgradeValue") * 15, 1, function() ply.HealthshotReady = true end)
                end

                if(ply:Health() < ply:GetMaxHealth()*0.6 and ply.HealthregenReady) then
                    ply.HealthregenReady = false
                    ply:EmitSound("items/medshot4.wav", 75, 110, 1, CHAN_AUTO)
                    ply:ScreenFade(SCREENFADE.IN, Color( 145, 255, 145, 128), 1.2, 0.2)
                    timer.Create("HealthregenActive" .. i, 0.25 - ply:GetNWInt("HealthUpgradeValue") * 0.05, ply:GetMaxHealth()* (0.5 + ply:GetNWInt("HealthUpgradeValue") * 0.1), function() ply:SetHealth(math.min(ply:Health()+1, ply:GetMaxHealth())) end)
                    timer.Create("HealthregenCooldown" .. i, 60 - ply:GetNWInt("HealthUpgradeValue") * 5, 1, function() ply.HealthregenReady = true end)
                end
                
                if(ply:Armor() > ply:GetMaxArmor()) then
                    ply:SetRunSpeed(ply.DefaultRunSpeed*1.5)
                    ply:SetWalkSpeed(ply.DefaultWalkSpeed*1.5)
                    if(not timer.Exists("ArmordepleteActive" .. i)) then
                        timer.Create("ArmordepleteActive" .. i, 0.5, ply:Armor() - ply:GetMaxArmor(), function()
                            if(ply:Armor() > ply:GetMaxArmor()) then 
                                ply:SetArmor(ply:Armor() - 1)
                                local effectdata = EffectData()
                                effectdata:SetOrigin(ply:GetPos())
                                effectdata:SetEntity(ply)
                                effectdata:SetMagnitude(2)
                                util.Effect("TeslaHitboxes", effectdata)
                            end 
                        end)
                    end
                else
                    ply:SetRunSpeed(ply.DefaultRunSpeed)
                    ply:SetWalkSpeed(ply.DefaultWalkSpeed)
                end

                if(ply:Armor() < ply:GetMaxArmor()) then
                    if((not timer.Exists("ArmorRegenCooldown" .. i)) and not ply.ArmorRegenReady) then
                        timer.Create("ArmorRegenCooldown" .. i, 7 - ply:GetNWInt("RegenUpgradeValue"), 1, function() ply.ArmorRegenReady = true end) 
                    end

                    if ply.ArmorRegenReady then
                        if(not timer.Exists("ArmorRegen" .. i)) then
                            timer.Create("ArmorRegen" .. i, 0.25 - ply:GetNWInt("RegenUpgradeValue") * 0.05, 1, function() ply:SetArmor(math.min(ply:Armor() + 1 + ply:GetNWInt("RegenUpgradeValue") * 0.34, ply:GetMaxArmor())) end)
                        end
                    end
                end

                if(ply.BoostReady > 0 and ply:KeyPressed(IN_JUMP)) then
                local CheckBoostDelay = 0.5
                    if(ply:KeyDown(IN_JUMP) and not ply:OnGround()) then
                        local t = CurTime()
                        if(t - ply.lastJump <= CheckBoostDelay) then
                            local dir = Vector(0,0,4)
                            if(ply:KeyDown(IN_FORWARD)) then
                                dir = ply:EyeAngles():Forward()
                            elseif(ply:KeyDown(IN_BACK)) then
                                dir = ply:EyeAngles():Forward()
                                dir:Negate()
                            elseif(ply:KeyDown(IN_MOVERIGHT)) then
                                dir = ply:EyeAngles():Right()
                            elseif(ply:KeyDown(IN_MOVELEFT)) then
                                dir = ply:EyeAngles():Right()
                                dir:Negate()
                            end
                            dir:Normalize()
                            if(ply:Armor() > ply:GetMaxArmor()) then
                                ply:SetVelocity(Vector(dir.x*200,dir.y*200,(dir.z*150) + 350))
                                ply:EmitSound("weapons/physcannon/physcannon_pickup.wav", 90, 75, 0.5, CHAN_AUTO)
                                ply:EmitSound("weapons/underwater_explode3.wav", 95, 145, 0.45, CHAN_AUTO)
                            else
                                ply:SetVelocity(Vector(dir.x*150,dir.y*150,(dir.z*100) + 300))
                                ply:EmitSound("weapons/physcannon/physcannon_pickup.wav", 85, 55, 0.4, CHAN_AUTO)
                                ply:EmitSound("weapons/underwater_explode3.wav", 90, 145, 0.45, CHAN_AUTO)
                            end
                            local dirNorm = dir:GetNormalized()
                            local flameDir = (dirNorm + Vector(0, 0, -0.3)):GetNormalized()

                            local leftBone = ply:LookupBone("ValveBiped.Bip01_L_Foot")
                            local rightBone = ply:LookupBone("ValveBiped.Bip01_R_Foot")

                            if leftBone then
                                local fx = EffectData()
                                fx:SetEntity(ply)
                                fx:SetAttachment(leftBone)
                                fx:SetNormal(flameDir)
                                util.Effect("jet_thrust_effect", fx)
                            end

                            if rightBone then
                                local fx = EffectData()
                                fx:SetEntity(ply)
                                fx:SetAttachment(rightBone)
                                fx:SetNormal(flameDir)
                                util.Effect("jet_thrust_effect", fx)
                            end

                            local groundTrace = util.TraceLine({
                                start = ply:GetPos(),
                                endpos = ply:GetPos() - Vector(0, 0, 60),
                                filter = ply
                            })

                            if groundTrace.Hit then
                                if (ply:Armor() > ply:GetMaxArmor()) then
                                    local burst = EffectData()
                                    burst:SetOrigin(groundTrace.HitPos + Vector(0, 0, 2))
                                    burst:SetRadius(150)
                                    util.Effect("ground_ring_burst", burst)
                                else
                                    local burst = EffectData()
                                    burst:SetOrigin(groundTrace.HitPos + Vector(0, 0, 2))
                                    burst:SetRadius(250)
                                    util.Effect("ground_ring_burst", burst)
                                end
                            end
                            ply.BoostReady = ply.BoostReady - 1
                        else
                            ply.lastJump = t
                        end
                    end
                elseif(ply.BoostReady < 6) then
                    if(not timer.Exists("BoostCooldown" .. i)) then
                        timer.Create("BoostCooldown" .. i, 2.5, 1, function() ply.BoostReady = ply.BoostReady + 1 end)
                    end
                end

                if(timer.Exists("HealthregenCooldown" .. i)) then
                    Players[i]:SetNWInt("HealthregenTimeLeft", timer.TimeLeft("HealthregenCooldown" .. i))
                else
                    Players[i]:SetNWInt("HealthregenTimeLeft", 0)
                end

                if(timer.Exists("HealthshotCooldown" .. i)) then
                    Players[i]:SetNWInt("HealthshotTimeLeft", timer.TimeLeft("HealthshotCooldown" .. i))
                else
                    Players[i]:SetNWInt("HealthshotTimeLeft", 0)
                end

                if(timer.Exists("ArmorRegenCooldown" .. i)) then
                    Players[i]:SetNWInt("ArmorRegenTimeLeft", timer.TimeLeft("ArmorRegenCooldown" .. i))
                else
                    Players[i]:SetNWInt("ArmorRegenTimeLeft", 0)
                end

                if(timer.Exists("BoostCooldown" .. i)) then
                    Players[i]:SetNWInt("BoostTimeLeft", timer.TimeLeft("BoostCooldown" .. i))
                else
                    Players[i]:SetNWInt("BoostTimeLeft", 0)
                end

                Players[i]:SetNWInt("BoostAmount", ply.BoostReady)

                Players[i]:SetNWBool("HiTechArmorEquipped", true)
            end
        end
    end

    function OverchargeJump(ply)
        if(ply:Armor() > ply:GetMaxArmor()) then
            ply:SetVelocity(Vector(0, 0, 150))
        end
    end
    
    hook.Add("EntityTakeDamage", "TakingDamage", TakingDamage)
    hook.Add( "PlayerFootstep", "CustomFootstep", function( ply, pos, foot, sound, volume, rf )
        if(ply.LightArmorEquipped) then
            local randSFX = math.random(4,6)
            ply:EmitSound("npc/combine_soldier/gear" .. randSFX .. ".wav", 40, 105, 0.4, CHAN_AUTO)
        end

        if(ply.HeavyArmorEquipped) then
            local randSFX = math.random(4,6)
            local randSFX2 = math.random(4)
            local randSFX3 = math.random(2)
            ply:EmitSound("npc/combine_soldier/gear" .. randSFX .. ".wav", 40, 105, 0.4, CHAN_AUTO)
            ply:EmitSound("physics/plaster/drywall_footstep" .. randSFX2 .. ".wav", 40, 105, 0.4, CHAN_AUTO)
            ply:EmitSound("physics/metal/weapon_footstep" .. randSFX3 .. ".wav", 40, 105, 0.3, CHAN_AUTO)
        end

        if(ply.HiTechArmorEquipped) then
            local randSFX = math.random(4,6)
            local randSFX2 = math.random(4)
            local randSFX3 = math.random(2)
            ply:EmitSound("npc/combine_soldier/gear" .. randSFX .. ".wav", 40, 105, 0.4, CHAN_AUTO)
            ply:EmitSound("physics/plaster/drywall_footstep" .. randSFX2 .. ".wav", 40, 105, 0.4, CHAN_AUTO)
            ply:EmitSound("physics/metal/weapon_footstep" .. randSFX3 .. ".wav", 40, 105, 0.3, CHAN_AUTO)
        end
    end )
    hook.Add( "PlayerDeath", "UnequipArmor", function( victim, inflictor, attacker )
        if(victim.LightArmorEquipped or victim.HeavyArmorEquipped or victim.HiTechArmorEquipped) then
            if(victim.HeavyArmorEquipped or victim.HiTechArmorEquipped) then
                victim:SetRunSpeed(victim.DefaultRunSpeed)
                victim:SetWalkSpeed(victim.DefaultWalkSpeed)
            end
            victim.LightArmorEquipped = false
            victim.HeavyArmorEquipped = false
            victim.HiTechArmorEquipped = false
            victim.RegenUpgradeValue = 0
            victim.DefenseUpgradeValue = 0
            victim.HealthUpgradeValue = 0
            victim:SetNWBool("HiTechArmorEquipped", false)
            victim.HealthshotReady = true
            victim.HealthregenReady = true
            victim.ArmorRegenReady = true
            victim.BoostReady = 3
            victim:SetNWInt("RegenUpgradeValue", victim.RegenUpgradeValue)
            victim:SetNWInt("DefenseUpgradeValue", victim.DefenseUpgradeValue)
            victim:SetNWInt("HealthUpgradeValue", victim.HealthUpgradeValue)
            Players = player.GetHumans()
            for i=1, table.Count(Players) do
                if(victim == Players[i]) then
                    if(timer.Exists("HealthregenActive" .. i)) then
                        timer.Remove("HealthregenActive" .. i)
                    end

                    if(timer.Exists("HealthshotCooldown" .. i)) then
                        timer.Remove("HealthshotCooldown" .. i)
                    end

                    if(timer.Exists("HealthregenCooldown" .. i)) then
                        timer.Remove("HealthregenCooldown" .. i)
                    end

                    if(timer.Exists("ArmordepleteActive" .. i)) then
                        timer.Remove("ArmordepleteActive" .. i)
                    end

                    if(timer.Exists("ArmorRegen" .. i)) then
                        timer.Remove("ArmorRegen" .. i)
                    end

                    if(timer.Exists("ArmorRegenCooldown" .. i)) then
                        timer.Remove("ArmorRegenCooldown" .. i)
                    end

                    if(timer.Exists("BoostCooldown" .. i)) then
                        timer.Remove("BoostCooldown" .. i)
                    end
                end
            end
        end
    end)
    hook.Add("Think", "HiTechBehavior", HiTechBehavior)
    hook.Add("EntityEmitSound", "SuppressFallDamageSound", function(data)
        if data.Entity:IsPlayer() and data.Entity.HiTechArmorEquipped and (data.SoundName == "player/pl_fallpain1.wav" or data.SoundName == "player/pl_fallpain3.wav") then
            return false
        end
    end)
    hook.Add("OnPlayerJump", "OverchargeJump", OverchargeJump)
    util.AddNetworkString("HiTech_UpdateNPCDisposition")
    local lastDispositions = {}  
    hook.Add("Think", "HiTech_DynamicDispositionReliable", function()
        for npcID, npcData in pairs(lastDispositions) do
            if not IsValid(Entity(npcID)) then
                lastDispositions[npcID] = nil
            end
        end

        for _, ply in ipairs(player.GetAll()) do
            if not IsValid(ply) then continue end

            for _, npc in ipairs(ents.FindByClass("npc_*")) do
                if not IsValid(npc) or not npc:IsNPC() then continue end

                local npcID = npc:EntIndex()
                local plyID = ply:EntIndex()

                lastDispositions[npcID] = lastDispositions[npcID] or {}

                local rawDisp = npc:Disposition(ply)
                local effectiveDisp = rawDisp

                if rawDisp == D_NU then
                    if npc:GetEnemy() == ply then
                        effectiveDisp = D_HT
                    elseif npc:GetClass() == "npc_citizen" then
                        effectiveDisp = D_LI
                    end
                end

                local lastDisp = lastDispositions[npcID][plyID]

                if lastDisp ~= effectiveDisp then
                    lastDispositions[npcID][plyID] = effectiveDisp

                    net.Start("HiTech_UpdateNPCDisposition")
                        net.WriteEntity(npc)
                        net.WriteInt(effectiveDisp, 3)
                    net.Send(ply)
                end
            end
        end
    end)

    util.AddNetworkString("RequestArmorRegenUpgrade")
    util.AddNetworkString("RequestDefenseUpgrade")
    util.AddNetworkString("RequestHealthRegenUpgrade")

    net.Receive("RequestArmorRegenUpgrade", function(len, ply)
        local cur = ply:GetNWInt("RegenUpgradeValue", 0)
        if cur < 3 then
            ply:SetNWInt("RegenUpgradeValue", cur + 1)
            ply:PrintMessage(HUD_PRINTTALK, "Server: Armor regen upgraded! " .. (cur + 1))
        else
            ply:PrintMessage(HUD_PRINTTALK, "Server: Already at max level!")
        end
    end)

    net.Receive("RequestDefenseUpgrade", function(len, ply)
        local cur = ply:GetNWInt("DefenseUpgradeValue", 0)
        if cur < 3 then
            ply:SetNWInt("DefenseUpgradeValue", cur + 1)
            ply:PrintMessage(HUD_PRINTTALK, "Server: Armor defense upgraded! " .. (cur + 1))
        else
            ply:PrintMessage(HUD_PRINTTALK, "Server: Already at max level!")
        end
    end)

    net.Receive("RequestHealthRegenUpgrade", function(len, ply)
        local cur = ply:GetNWInt("HealthUpgradeValue", 0)
        if cur < 3 then
            ply:SetNWInt("HealthUpgradeValue", cur + 1)
            ply:PrintMessage(HUD_PRINTTALK, "Server: Health systems upgraded! " .. (cur + 1))
        else
            ply:PrintMessage(HUD_PRINTTALK, "Server: Already at max level!")
        end
    end)
end