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
                dmg:ScaleDamage(0.25)
                ply:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 40, 100, 1, CHAN_AUTO)
                ply:EmitSound("physics/flesh/flesh_impact_hard2.wav", 25, 100, 1, CHAN_AUTO)
            elseif(ArmorPercentage >= 0.5) then
                dmg:ScaleDamage(0.5)
                ply:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 40, 110, 1, CHAN_AUTO)
                ply:EmitSound("physics/flesh/flesh_impact_hard2.wav", 40, 100, 1, CHAN_AUTO)
            elseif(ArmorPercentage >= 0.25) then
                dmg:ScaleDamage(0.75)
                ply:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 40, 120, 1, CHAN_AUTO)
                ply:EmitSound("physics/flesh/flesh_impact_bullet1.wav", 45, 110, 1, CHAN_AUTO)
                ply:EmitSound("physics/flesh/flesh_impact_hard2.wav", 35, 100, 1, CHAN_AUTO)
            elseif(ArmorPercentage > 0) then
                dmg:ScaleDamage(0.9)
                ply:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 40, 130, 1, CHAN_AUTO)
                ply:EmitSound("physics/flesh/flesh_impact_bullet1.wav", 50, 115, 1, CHAN_AUTO)
                ply:EmitSound("physics/flesh/flesh_impact_hard2.wav", 40, 100, 1, CHAN_AUTO)
                ply:EmitSound("physics/flesh/flesh_squishy_impact_hard3.wav", 30, 100, 1, CHAN_AUTO)
            elseif(ArmorPercentage == 0) then
                dmg:ScaleDamage(1)
                ply:EmitSound("physics/metal/metal_sheet_impact_soft2.wav", 30, 90, 1, CHAN_AUTO)
                ply:EmitSound("physics/flesh/flesh_impact_bullet1.wav", 50, 110, 1, CHAN_AUTO)
                ply:EmitSound("physics/flesh/flesh_impact_hard2.wav", 45, 100, 1, CHAN_AUTO)
                ply:EmitSound("physics/flesh/flesh_squishy_impact_hard3.wav", 45, 100, 1, CHAN_AUTO)
            end

            -- Check if the player has armor, and if it's below the max armor, then add 1 armor point on damage.
            -- If player's health is below 50, whenever receiving damage, add 1 health point and add a sound cue.
            if(CurrentArmor > 0 and CurrentArmor < CurrentMaxArmor) then
                ply:SetArmor(CurrentArmor + 1)
                if(ply:Health() < 50)then
                    ply:SetHealth(ply:Health() + 2)
                    ply:EmitSound("items/medshot4.wav", 30, 50, 1, CHAN_AUTO)
                    ply:EmitSound("player/pl_burnpain1.wav", 50, 110, 1, CHAN_AUTO)
                end
            end
        end
    end
    -- Add the function to the EntityTakeDamage hook so it is called whenever an entity takes damage.
    local MorphineCooldown = true
    local function MorphineShot(ent, dmg)
        -- Check if targeted entity is a player and if damage is above 10.
        if(ent:IsPlayer() and dmg:GetDamage() > 10) then
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
            Change the cooldown]]
            if(HealthPercentage < 0.5 and MorphineCooldown) then
                MorphineHealthAmount = CurrentHealth * (HealthPercentage + 1)
                ply:SetHealth(MorphineHealthAmount)
                ply:EmitSound("items/medshot4.wav", 80, 100, 1, CHAN_AUTO)
                ply:EmitSound("HL1/fvox/morphine_shot.wav", 100, 100, 1, CHAN_AUTO)
                MorphineCooldown = false
                timer.Simple(10, function() MorphineCooldown = true end )
            end
        end
    end
    hook.Add("EntityTakeDamage", "ArmorReduceDamage", ArmorReduceDamage)
    hook.Add("EntityTakeDamage", "AdministerMorphine", MorphineShot)
end