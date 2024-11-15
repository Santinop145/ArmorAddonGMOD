if SERVER then
    MaxMorphine = CreateConVar("s145_maxmorphine", 3, FCVAR_NOTIFY, "Maximum amount of morphine shots players can carry")
    -- Initializes addon
    timer.Create("AddonStartup", 7, 0, function() 
        -- Gets the data of all connected players
        Players = player.GetHumans()
        -- Creates a table of cooldowns of armor for each player
        SurgeCooldowns = {}
        -- Creates a table of cooldowns of morphine for each player
        MorphineCooldowns = {}
        -- Creates a table with the amount of morphine for each player
        MorphineAmount = {}
        -- Creates a for loop to assign default values to all playes on their respective tables
        for i=1, game.MaxPlayers() do
            SurgeCooldowns[i] = true
            MorphineCooldowns[i] = true
            MorphineAmount[i] = MaxMorphine:GetInt()
        end
        PrintMessage(HUD_PRINTTALK, "Santinop's addon started!")
        timer.Remove("AddonStartup")
        end
    )
    -- Define the main function and take ent and dmg from the hook
    local function ArmorReduceDamage(ent, dmg)
    -- Check if targeted entity is a player, then check if it received more than 0 damage.
        if(ent:IsPlayer() and dmg:GetDamage() > 0 and ent:Alive() and not dmg:IsDamageType(DMG_FALL) and not dmg:IsDamageType(DMG_DROWN)) then
            -- Obtains players again (just in case.)
            Players = player.GetHumans()
            -- Creates a for loop to run the individual code on each player
            for i=1, table.Count(Players) do
                if(ent == Players[i]) then
                    local ply = Players[i]
                    -- Define the targeted entity as a player variable.
                    local effectdata = EffectData()
                    -- Get player position and define it as the effectdata tag value
                    effectdata:SetOrigin(ply:GetPos())
                    -- Define the entity to utilize as the player
                    effectdata:SetEntity(ply)
                    -- Get current armor.
                    local CurrentArmor = ply:Armor()
                    -- Get current max armor.
                    local CurrentMaxArmor = ply:GetMaxArmor()
                    -- Get current armor percentage.
                    local MaxArmorPercentage = CurrentMaxArmor / 100
                    local ArmorPercentage = CurrentArmor / CurrentMaxArmor
                    local DamageReduction = MaxArmorPercentage - ArmorPercentage + 0.3

                    -- Create a timer to check if player is dead, then reset cooldown if true
                    timer.Simple(0.5, function()
                        if(not ply:Alive())then
                            SurgeCooldowns[i] = true
                        end
                    end)
                    
                    -- If chunk to add effects and sounds
                    if(ArmorPercentage > MaxArmorPercentage or CurrentArmor > 100) then
                        dmg:ScaleDamage(0.15)
                        ply:EmitSound("weapons/crossbow/hit1.wav", 35, 20, 1, CHAN_AUTO) 
                        ply:EmitSound("weapons/crowbar/crowbar_impact1.wav", 20, 40, 1, CHAN_AUTO) 
                        ply:EmitSound("weapons/fx/rics/ric3.wav", 35, 110, 1, CHAN_AUTO) 
                        ply:EmitSound("weapons/stunstick/spark3.wav", 60, 80, 1, CHAN_AUTO) 
                        ply:EmitSound("weapons/stunstick/stunstick_impact1.wav", 40, 75, 1, CHAN_AUTO) 
                        util.Effect("ManhackSparks", effectdata)
                        util.Effect("StunstickImpact", effectdata)
                    elseif(ArmorPercentage > MaxArmorPercentage * 0.3) then
                        dmg:ScaleDamage(DamageReduction)
                        ply:EmitSound("weapons/crossbow/hit1.wav", 35, 20, 1, CHAN_AUTO) 
                        ply:EmitSound("weapons/crowbar/crowbar_impact1.wav", 20, 40, 1, CHAN_AUTO) 
                        ply:EmitSound("weapons/fx/rics/ric3.wav", 35, 110, 1, CHAN_AUTO) 
                        ply:EmitSound("weapons/stunstick/spark3.wav", 60, 80, 1, CHAN_AUTO) 
                        ply:EmitSound("weapons/stunstick/stunstick_impact1.wav", 40, 75, 1, CHAN_AUTO) 
                        util.Effect("ManhackSparks", effectdata)
                        util.Effect("StunstickImpact", effectdata)
                    elseif(ArmorPercentage <= MaxArmorPercentage * 0.3) then
                        dmg:ScaleDamage(0.9)
                        ply:EmitSound("weapons/crossbow/hit1.wav", 35, 25, 1, CHAN_AUTO) 
                        ply:EmitSound("weapons/crowbar/crowbar_impact1.wav", 20, 45, 1, CHAN_AUTO) 
                        ply:EmitSound("weapons/fx/rics/ric3.wav", 35, 110, 1, CHAN_AUTO) 
                    elseif(ArmorPercentage <= 0) then
                        dmg:ScaleDamage(1)
                        ply:EmitSound("weapons/fx/rics/ric3.wav", 35, 110, 1, CHAN_AUTO)
                    end

                    if(CurrentArmor > 50 and CurrentArmor < CurrentMaxArmor and ply:Health() < ply:GetMaxHealth()) then
                        ply:SetArmor(CurrentArmor + 1)
                        ply:SetHealth(ply:Health()+0.5)
                        ply:EmitSound("player/pl_burnpain1.wav", 35, 130, 1, CHAN_AUTO)
                    elseif(CurrentArmor > 0 and CurrentArmor < CurrentMaxArmor) then
                        ply:SetArmor(CurrentArmor + 1)
                        ply:EmitSound("player/pl_burnpain1.wav", 35, 130, 1, CHAN_AUTO)
                    end

                    -- Create the armor surge code
                    if(SurgeCooldowns[i] and ArmorPercentage <= MaxArmorPercentage * 0.75 and ArmorPercentage > 0)then
                        ply:SetArmor(CurrentArmor + 5)
                        SurgeCooldowns[i] = false
                        ply:ScreenFade(SCREENFADE.IN, Color( 0, 120, 120, 20), 0.5, 0.8)
                        ply:ScreenFade(SCREENFADE.IN, Color( 0, 130, 130, 30), 1.5, 0.1)
                        ply:EmitSound("HL1/fvox/power_restored.wav", 100, 100, 1, CHAN_AUTO)
                        ply:EmitSound("items/suitchargeok1.wav", 50, 100, 1, CHAN_AUTO)
                        util.Effect("VortDispel", effectdata)
                        timer.Create("ArmorSurge" .. i, 0.05, 40, function() if(ply:Armor() < 100)then CurrentArmor = ply:Armor() ply:SetArmor(CurrentArmor + 1) end end)
                        timer.Simple(20, function() SurgeCooldowns[i] = true if(ply:Alive()) then ply:EmitSound("HL1/fvox/beep.wav", 100, 100, 1, CHAN_AUTO) ply:PrintMessage(HUD_PRINTTALK, "Armor surge ready!") end end)
                    end
                end
            end
        elseif(ent:IsPlayer() and dmg:IsDamageType(DMG_FALL)) then
            ply = ent
            if(ply:Armor() > 0 and dmg:GetDamage() < 20) then
                dmg:ScaleDamage(0)
                ply:EmitSound("physics/metal/metal_canister_impact_hard3.wav", 40, 90, 1, CHAN_AUTO)
                ply:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 35, 90, 1, CHAN_AUTO)
                ply:EmitSound("physics/metal/weapon_impact_soft3.wav", 70, 90, 1, CHAN_AUTO)
                if(ply:Armor() > 4) then
                    ply:SetArmor(ply:Armor() - 5)
                end
            elseif(ply:Armor() > 0 and dmg:GetDamage() > 20) then
                ply:EmitSound("physics/metal/metal_canister_impact_hard3.wav", 50, 90, 1, CHAN_AUTO)
                ply:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 40, 90, 1, CHAN_AUTO)
                ply:EmitSound("physics/metal/weapon_impact_hard3.wav", 100, 90, 1, CHAN_AUTO)
                if(ply:Armor() > 0 and ply:Armor() - dmg:GetDamage()/2 > 0) then
                    ply:SetArmor(ply:Armor() - dmg:GetDamage()/2)
                elseif(ply:Armor() > 0 and ply:Armor() - dmg:GetDamage()/2 < 0) then
                    ply:SetArmor(0)
                end
                dmg:ScaleDamage(0.05)
            end
        end
    end
    local function MorphineShot(ent, dmg)
        -- Check if targeted entity is a player and if damage is above 10.
        if(ent:IsPlayer() and dmg:GetDamage() > 4 and ent:Alive()) then
            local maxMorphine = MaxMorphine:GetInt()
            -- Get player table again
            Players = player.GetHumans()
            -- Create a for loop to run the individual code on each player
            for i=1, table.Count(Players) do
                if(ent == Players[i]) then
                    local ply = Players[i]
                    -- Get health and max health to create a percentage
                    local HealthPercentage = ply:Health() / ply:GetMaxHealth()
                    -- Define the amount of health morphine will give, the time delay and the cooldown variable
                    local MorphineHealthAmount = 0
                    -- Run a timer to check if player is dead, if true, reset cooldown
                    timer.Simple(0.5, function()
                        if(not ply:Alive())then
                            MorphineCooldowns[i] = true
                            MorphineAmount[i] = maxMorphine
                            timer.Remove("TemporaryHealth" .. i)
                        end
                    end)
                
                    -- Run morphine code
                    if(HealthPercentage <= 0.55 and MorphineCooldowns[i]) then
                        ply:EmitSound("HL1/fvox/automedic_on.wav", 60, 100, 1, CHAN_AUTO) 
                        timer.Simple(3.5, function() 
                                if(ply:Health() ~= ply:GetMaxHealth() and ply:Health() ~= 0 and ply:Alive() and MorphineAmount[i] > 0)then
                                    MorphineHealthAmount = ply:Health() + 150 * HealthPercentage
                                    ply:EmitSound("items/medshot4.wav", 80, 100, 1, CHAN_AUTO)
                                    ply:EmitSound("HL1/fvox/morphine_shot.wav", 60, 100, 1, CHAN_AUTO)
                                    MorphineAmount[i] = MorphineAmount[i] - 1
                                    ply:PrintMessage(HUD_PRINTTALK, "Morphine shot applied! Morphine shots left: " .. MorphineAmount[i])
                                    ply:ScreenFade(SCREENFADE.IN, Color( 120, 255, 120, 128), 0.8, 0.1)
                                    ply:ScreenFade(SCREENFADE.IN, Color( 40, 180, 40, 20), 5.0, 0.5)
                                    ply:SetHealth(MorphineHealthAmount)
                                    if(ply:Alive())then
                                        timer.Simple(2, function()
                                                if(ply:Alive())then
                                                ply:EmitSound("hl1/fvox/boop.wav", 80, 100, 1, CHAN_AUTO)
                                                ply:EmitSound("hl1/fvox/wound_sterilized.wav", 80, 100, 1, CHAN_AUTO)
                                                end
                                            end
                                        )
                                    end
                                    if(not timer.Exists("TemporaryHealth")) then
                                        timer.Create("TemporaryHealth" .. i, 0.3, ply:GetMaxHealth() * HealthPercentage, function() 
                                            if(ply:Health() > 0 and ply:Alive()) then ply:SetHealth(ply:Health()-1) 
                                            elseif(ply:Alive()) then ply:Kill() MorphineAmount[i] = maxMorphine timer.Remove("TemporaryHealth" .. i) 
                                            elseif(not ply:Alive()) then MorphineAmount[i] = maxMorphine timer.Remove("TemporaryHealth" .. i) 
                                            end 
                                        end)
                                    else 
                                        timer.Adjust("TemporaryHealth" .. i, 0.2, timer.RepsLeft("TemporaryHealth" .. i) + 50)
                                    end
                                elseif(MorphineAmount[i] > 0) then
                                    ply:EmitSound("hl1/fvox/fuzz.wav", 60, 100, 1, CHAN_AUTO)
                                    ply:EmitSound("hl1/fvox/internal_bleeding.wav", 60, 100, 1, CHAN_AUTO)
                                    timer.Simple(2.5, function()
                                        ply:EmitSound("hl1/fvox/beep.wav", 60, 100, 1, CHAN_AUTO)
                                        ply:EmitSound("hl1/fvox/innsuficient_medical.wav", 60, 100, 1, CHAN_AUTO)
                                        end
                                    )
                                    timer.Simple(7, function()
                                        ply:EmitSound("hl1/fvox/boop.wav", 60, 100, 1, CHAN_AUTO)
                                        ply:EmitSound("hl1/fvox/hev_general_fail.wav", 60, 100, 1, CHAN_AUTO)
                                        end
                                    )
                                else
                                    ply:EmitSound("hl1/fvox/beep.wav", 60, 100, 1, CHAN_AUTO)
                                    ply:EmitSound("hl1/fvox/innsuficient_medical.wav", 60, 100, 1, CHAN_AUTO)
                                end
                            end
                        )
                        MorphineCooldowns[i] = false
                        timer.Simple(20, function() MorphineCooldowns[i] = true if(MorphineAmount[i] > 0 and ply:Alive()) then ply:EmitSound("HL1/fvox/beep.wav", 100, 100, 1, CHAN_AUTO) ply:PrintMessage(HUD_PRINTTALK, "Morphine shot ready!") end end)
                    end
                end
            end
        end
    end
    local function MorphineRefill(player, item)
        local maxMorphine = MaxMorphine:GetInt()
        for i=1, table.Count(Players) do
            if(player:Health() < player:GetMaxHealth() and IsValid(item) and item:GetClass() == "item_healthkit" and player == Players[i] and MorphineAmount[i] < maxMorphine or item:GetClass() == "hl1_item_healthkit" and player == Players[i] and MorphineAmount[i] < maxMorphine and player:Health() < player:GetMaxHealth() and IsValid(item)) then
                player:EmitSound("hl1/fvox/fuzz.wav", 80, 100, 1, CHAN_AUTO)
                MorphineAmount[i] = MorphineAmount[i]+1
                player:PrintMessage(HUD_PRINTTALK, "Morphine Obtained! Current Morphine: " .. MorphineAmount[i])
            end
        end
        return true
    end
    hook.Add("EntityTakeDamage", "ArmorReduceDamage", ArmorReduceDamage)
    hook.Add("EntityTakeDamage", "AdministerMorphine", MorphineShot)
    hook.Add("PlayerCanPickupItem", "MorphineRefill", MorphineRefill)
end