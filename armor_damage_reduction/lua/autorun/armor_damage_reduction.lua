if SERVER then
    local function ArmorReduceDamage(ent, dmg)
    if(ent:IsPlayer() and dmg:GetDamage() > 0) then
            ply = ent
            local CurrentArmor = ply:Armor()
            local CurrentMaxArmor = ply:GetMaxArmor()
            local ArmorPercentage = CurrentArmor / CurrentMaxArmor

            if(ArmorPercentage > 0) then
                dmg:ScaleDamage(0.8)
            end

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

            if(CurrentArmor > 0 and CurrentArmor < CurrentMaxArmor) then
                ply:SetArmor(CurrentArmor + 1)
                if(ply:Health() < 50)then
                    ply:SetHealth(ply:Health() + 1)
                    ply:EmitSound("items/medshot4.wav", 30, 50, 1, CHAN_AUTO)
                end
            end
        end
    end
    hook.Add("EntityTakeDamage", "ArmorReduceDamage", ArmorReduceDamage)
end