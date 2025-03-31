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

                        print("base damage: " .. dmg:GetDamage())

                        if(ent:Armor() > 0 and not (ent:Armor() > ent:GetMaxArmor())) then
                            ent:SetArmor(math.min(ent:Armor() + 1 + dmg:GetDamage()*0.2,ent:GetMaxArmor()))
                            dmg:ScaleDamage(0.8)
                        elseif(ent:Armor() <= 0 and not (ent:Armor() > ent:GetMaxArmor())) then
                            ent:SetArmor(math.min(ent:Armor() + 1 + dmg:GetDamage()*0.2,ent:GetMaxArmor()))
                            dmg:ScaleDamage(0.9)
                        elseif(ent:Armor() > ent:GetMaxArmor()) then
                            dmg:ScaleDamage(0.75)
                        end

                        print("scaled damage: " .. dmg:GetDamage())

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
                            print("hit vest, damage: " .. dmg:GetDamage())
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
                            print("hit helmet, damage: " .. dmg:GetDamage())
                        else
                            print("didn't hit vest")
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
                    ply:SetHealth(math.min(ply:Health() + math.Truncate(ply:Health()*0.6, 0), ply:GetMaxHealth()))
                    ply.HealthshotReady = false
                    ply:ScreenFade(SCREENFADE.IN, Color( 120, 255, 120, 128), 0.8, 0.1)
                    ply:EmitSound("items/smallmedkit1.wav", 85, 95, 1.2, CHAN_AUTO)
                    timer.Create("HealthshotCooldown" .. i, 120, 1, function() ply.HealthshotReady = true end)
                end

                if(ply:Health() < ply:GetMaxHealth()*0.6 and ply.HealthregenReady) then
                    ply.HealthregenReady = false
                    ply:EmitSound("items/medshot4.wav", 75, 110, 1, CHAN_AUTO)
                    ply:ScreenFade(SCREENFADE.IN, Color( 145, 255, 145, 128), 1.2, 0.2)
                    timer.Create("HealthregenActive" .. i, 0.25, ply:GetMaxHealth()*0.5, function() ply:SetHealth(math.min(ply:Health()+1, ply:GetMaxHealth())) end)
                    timer.Create("HealthregenCooldown" .. i, 60, 1, function() ply.HealthregenReady = true end)
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
            victim.HealthshotReady = true
            victim.HealthregenReady = true
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
end