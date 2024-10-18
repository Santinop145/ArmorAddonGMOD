if SERVER then
    -- Define the main function and take ent and dmg from the hook.
    local function ArmorReduceDamage(ent, dmg)
    -- Check if targeted entity is a player, then check if it received more than 0 damage.
        if(ent:IsPlayer() and dmg:GetDamage() > 0) then
            -- Define the targeted entity as a player variable.
            ply = ent
            -- Get current armor.
            local CurrentArmor = ply:Armor()
            -- Get current max armor.
            local CurrentMaxArmor = ply:GetMaxArmor()
            -- Get current armor percentage.
            local ArmorPercentage = CurrentArmor / CurrentMaxArmor

            -- Apply global damage reduction.
            if(ArmorPercentage > 0) then
                dmg:ScaleDamage(0.8)
            end

            --[[
            Apply reduction to damage after certain percentages. Default: 
            75% damage reduction when above 75 armor
            50% damage reduction when above 50 armor
            25% damage reduction when above 25 armor
            20% damage reduction overall (applies before armor reduction)
            Also apply sound effects on player damage to give a sound cue to damage reduction.
            --]]


            if(ArmorPercentage >= 0.75) then
                dmg:ScaleDamage(0.6)
                ply:EmitSound("weapons/crossbow/hit1.wav", 35, 20, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/crowbar/crowbar_impact1.wav", 20, 40, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/fx/rics/ric3.wav", 35, 110, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/stunstick/spark3.wav", 60, 80, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/stunstick/stunstick_impact1.wav", 40, 75, 1, CHAN_AUTO) 
            elseif(ArmorPercentage >= 0.5) then
                dmg:ScaleDamage(0.7)
                ply:EmitSound("weapons/crossbow/hit1.wav", 35, 25, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/crowbar/crowbar_impact1.wav", 20, 45, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/fx/rics/ric3.wav", 35, 110, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/stunstick/spark3.wav", 50, 80, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/stunstick/stunstick_impact1.wav", 35, 75, 1, CHAN_AUTO) 
            elseif(ArmorPercentage >= 0.25) then
                dmg:ScaleDamage(0.8)
                ply:EmitSound("weapons/crossbow/hit1.wav", 35, 25, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/crowbar/crowbar_impact1.wav", 20, 45, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/fx/rics/ric3.wav", 35, 110, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/stunstick/spark3.wav", 40, 80, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/stunstick/stunstick_impact1.wav", 30, 70, 1, CHAN_AUTO) 
            elseif(ArmorPercentage > 0) then
                dmg:ScaleDamage(0.9)
                ply:EmitSound("weapons/crossbow/hit1.wav", 35, 25, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/crowbar/crowbar_impact1.wav", 20, 45, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/fx/rics/ric3.wav", 35, 110, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/stunstick/spark3.wav", 30, 80, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/stunstick/stunstick_impact1.wav", 20, 70, 1, CHAN_AUTO) 
            elseif(ArmorPercentage == 0) then
                dmg:ScaleDamage(1)
                ply:EmitSound("weapons/crossbow/hit1.wav", 35, 25, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/crowbar/crowbar_impact1.wav", 20, 45, 1, CHAN_AUTO) 
                ply:EmitSound("weapons/fx/rics/ric3.wav", 35, 110, 1, CHAN_AUTO) 
            end

            -- Check if the player has armor, and if it's below the max armor, then add 1 armor point on damage.
            -- If player's health is below 50, whenever receiving damage, add 1 health point and add a sound cue.
            if(CurrentArmor > 0 and CurrentArmor < CurrentMaxArmor) then
                ply:SetArmor(CurrentArmor + 1)
                ply:EmitSound("player/pl_burnpain1.wav", 35, 130, 1, CHAN_AUTO)
            end
        end
    end
    -- Add the function to the EntityTakeDamage hook so it is called whenever an entity takes damage.
    local MorphineCooldown = true
    local function MorphineShot(ent, dmg)
        -- Check if targeted entity is a player and if damage is above 10.
        if(ent:IsPlayer() and dmg:GetDamage() > 5) then
            -- Define entity as a player variable.
            ply = ent
            -- Get health and max health to create a percentage
            local CurrentHealth = ply:Health()
            local CurrentMaxHealth = ply:GetMaxHealth()
            local HealthPercentage = CurrentHealth / CurrentMaxHealth
            -- Define the amount of health morphine will give, the time delay and the cooldown variable
            local MorphineHealthAmount = 0

            --[[ Check if player has less than 50% health. If true, check if MorphineCooldown is above the server's current time.
            If true, set the Morphine health amount as an overly complicated formula for no reason at all because I wanted to have a funny number
            as a healing value. Why not?
            Afterwards, add the morphine's health amount to the player's health.
            Change the cooldown
            Add a timer that increases health in a fancy way]]
            if(HealthPercentage <= 0.5 and MorphineCooldown) then
                ply:EmitSound("HL1/fvox/automedic_on.wav", 60, 100, 1, CHAN_AUTO) 
                timer.Simple(3.5, function() 
                        if(ply:Health() ~= 100 and ply:Health() ~= 0)then
                            MorphineHealthAmount = CurrentHealth * (HealthPercentage + 1)
                            ply:EmitSound("items/medshot4.wav", 80, 100, 1, CHAN_AUTO)
                            ply:EmitSound("HL1/fvox/morphine_shot.wav", 60, 100, 1, CHAN_AUTO) 
                            ply:SetHealth(MorphineHealthAmount)
                            timer.Simple(2, function()
                                ply:EmitSound("hl1/fvox/boop.wav", 80, 100, 1, CHAN_AUTO)
                                ply:EmitSound("hl1/fvox/wound_sterilized.wav", 80, 100, 1, CHAN_AUTO)
                                end
                            )
                            timer.Simple(4, function()
                                ply:EmitSound("hl1/fvox/blip.wav", 60, 100, 1, CHAN_AUTO)
                                ply:EmitSound("hl1/fvox/medical_repaired.wav", 60, 100, 1, CHAN_AUTO)
                                end
                            )
                            timer.Create("HealOverTime", 0.5, 10, function() CurrentHealth = ply:Health() ply:SetHealth(CurrentHealth + 1) end)
                        else 
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
                        end
                    end
                )
                MorphineCooldown = false
                timer.Simple(20, function() MorphineCooldown = true end)
            end
        end
    end
    hook.Add("EntityTakeDamage", "ArmorReduceDamage", ArmorReduceDamage)
    hook.Add("EntityTakeDamage", "AdministerMorphine", MorphineShot)
end