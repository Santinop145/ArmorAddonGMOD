AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel( "models/items/car_battery01.mdl" ) -- Sets the model for the Entity.
    self:PhysicsInit( SOLID_VPHYSICS ) -- Initializes physics for the Entity, making it solid and interactable.
    self:SetMoveType( MOVETYPE_VPHYSICS ) -- Sets how the Entity moves, using physics.
    self:SetSolid( SOLID_VPHYSICS ) -- Makes the Entity solid, allowing for collisions.
    local phys = self:GetPhysicsObject() -- Retrieves the physics object of the Entity.
    if phys:IsValid() then -- Checks if the physics object is valid.
        phys:Wake() -- Activates the physics object, making the Entity subject to physics (gravity, collisions, etc.).
    end
end

local function ElectricCurrent(ent, exclude)
    local foundEnts = ents.FindInSphere(ent:GetPos(), 200)
    for i=1, table.Count(foundEnts) do
        if(foundEnts[i]:IsPlayer() or foundEnts[i]:IsNPC() or foundEnts[i]:IsRagdoll()) then

            local tr1 = util.TraceLine({
                start = ent:GetPos()+ Vector(0, 0, 1),
                endpos = foundEnts[i]:GetPos() + Vector(0, 0, 50),
                filter = ent
            })

            local tr2 = util.TraceLine({
                start = ent:GetPos()+ Vector(0, 0, 1),
                endpos = foundEnts[i]:EyePos() + Vector(0, 0, 1),
                filter = ent
            })

            local tr3 = util.TraceLine({
                start = ent:GetPos()+ Vector(0, 0, 1),
                endpos = foundEnts[i]:GetPos() + Vector(0, 0, 35),
                filter = ent
            })

            if (tr1.Hit and tr1.Entity == foundEnts[i] and foundEnts[i] ~= exclude or tr2.Hit and tr2.Entity == foundEnts[i] and foundEnts[i] ~= exclude or tr3.Hit and tr3.Entity == foundEnts[i] and foundEnts[i] ~= exclude) then
                if(foundEnts[i].BeingShocked == true) then
                    if(not timer.Exists("BeingShocked" .. i)) then
                        timer.Create("BeingShocked" .. i, 0.05, 1, function() 
                            if(foundEnts[i]:IsValid()) then
                                foundEnts[i].BeingShocked = false 
                            end
                        end)
                    end
                    return
                end
                local tr
                if(tr1.Hit) then
                    tr = tr1
                elseif (tr2.Hit) then
                    tr = tr2
                elseif(tr3.Hit) then
                    tr = tr3
                end
                local dmg = DamageInfo()
                dmg:SetDamage(2)
                dmg:SetAttacker(ent)
                dmg:SetDamageType(DMG_SHOCK)
                dmg:SetDamagePosition(foundEnts[i]:GetPos())
                local randSFX = math.random(6)
                ent:EmitSound("ambient/energy/spark" .. randSFX .. ".wav", 70, 95, 0.6, CHAN_AUTO)
                foundEnts[i]:TakeDamageInfo(dmg)
                local effectdata = EffectData()
                effectdata:SetOrigin(foundEnts[i]:GetPos())
                effectdata:SetEntity(foundEnts[i])
                effectdata:SetMagnitude(2)
                util.Effect("TeslaHitboxes", effectdata)
                local subdivide = ((tr.HitPos - ent:GetPos())/2 + ent:GetPos()) + VectorRand(-10,10)
                local subdivide2 = ((tr.HitPos - ent:GetPos())/2 + ent:GetPos()) + VectorRand(-10,10)
                local ef = EffectData()
                ef:SetOrigin(subdivide)
                ef:SetStart(tr.StartPos + VectorRand(-5,5))
                util.Effect("electricarc", ef)
                ef:SetOrigin(subdivide2)
                util.Effect("electricarc", ef)
                ef:SetOrigin(tr.HitPos + VectorRand(-10,10))
                ef:SetStart(subdivide)
                util.Effect("electricarc", ef)
                ef:SetOrigin(tr.HitPos + VectorRand(-10,10))
                ef:SetStart(subdivide2)
                util.Effect("electricarc", ef)
                ent.BeingShocked = true
                ElectricCurrent(foundEnts[i], ent)
            end
        end
    end
end

function ENT:Think()
    self:GetPhysicsObject():AddVelocity(VectorRand(-50,50))
    local randSFX = math.random(6)
    self:EmitSound("ambient/energy/spark" .. randSFX .. ".wav", 70, 90, 0.3, CHAN_AUTO)
    local ef = EffectData()
	ef:SetOrigin(self:GetPos()+VectorRand(-20,20))
	ef:SetStart(self:GetPos()+VectorRand(-5,5))
    util.Effect("electricarc", ef)
    local foundEnts = ents.FindInSphere(self:GetPos(), 200)
    for i=1, table.Count(foundEnts) do
        if(foundEnts[i]:IsPlayer() or foundEnts[i]:IsNPC() or foundEnts[i]:IsRagdoll()) then

            local tr1 = util.TraceLine({
                start = self:GetPos()+ Vector(0, 0, 1),
                endpos = foundEnts[i]:GetPos() + Vector(0, 0, 50),
                filter = self
            })

            local tr2 = util.TraceLine({
                start = self:GetPos()+ Vector(0, 0, 1),
                endpos = foundEnts[i]:EyePos() + Vector(0, 0, 1),
                filter = self
            })

            local tr3 = util.TraceLine({
                start = self:GetPos()+ Vector(0, 0, 1),
                endpos = foundEnts[i]:GetPos() + Vector(0, 0, 35),
                filter = self
            })

            if (tr1.Hit and tr1.Entity == foundEnts[i] or tr2.Hit and tr2.Entity == foundEnts[i] or tr3.Hit and tr3.Entity == foundEnts[i]) then
                local tr
                if(tr1.Hit) then
                    tr = tr1
                elseif(tr2.Hit) then
                    tr = tr2
                elseif(tr3.Hit) then
                    tr = tr3
                end
                local dmg = DamageInfo()
                dmg:SetDamage(8)
                dmg:SetAttacker(self)
                dmg:SetDamageType(DMG_SHOCK)
                dmg:SetDamagePosition(foundEnts[i]:GetPos())
                local randSFX = math.random(6)
                self:EmitSound("ambient/energy/spark" .. randSFX .. ".wav")
                foundEnts[i]:TakeDamageInfo(dmg)
                local effectdata = EffectData()
                effectdata:SetOrigin(foundEnts[i]:GetPos())
                effectdata:SetEntity(foundEnts[i])
                effectdata:SetMagnitude(2)
                util.Effect("TeslaHitboxes", effectdata)
                local subdivide = ((tr.HitPos - self:GetPos())/2 + self:GetPos()) + VectorRand(-10,10)
                local subdivide2 = ((tr.HitPos - self:GetPos())/2 + self:GetPos()) + VectorRand(-10,10)
                local ef = EffectData()
			    ef:SetOrigin(subdivide)
			    ef:SetStart(self:GetPos()+ VectorRand(-5,5))
			    util.Effect("electricarc", ef)
                ef:SetOrigin(subdivide2)
                util.Effect("electricarc", ef)
                ef:SetOrigin(tr.HitPos + VectorRand(-10,10))
			    ef:SetStart(subdivide)
                util.Effect("electricarc", ef)
                ef:SetOrigin(tr.HitPos + VectorRand(-10,10))
			    ef:SetStart(subdivide2)
                util.Effect("electricarc", ef)
                ElectricCurrent(foundEnts[i])
            end
        end
    end

    self:NextThink(CurTime() + 0.25)
    return true
end