local EFFECT = {}

function EFFECT:Init(data)
    self.Player = data:GetEntity()
    self.BoneID = data:GetAttachment()
    self.Dir = data:GetNormal()
    self.DieTime = CurTime() + 0.3
    self.Emitter = ParticleEmitter(Vector(0,0,0))
end

function EFFECT:Think()
    if not IsValid(self.Player) or not self.Player:LookupBone("ValveBiped.Bip01_Head1") then return false end
    if CurTime() > self.DieTime then return false end

    if self.BoneID then
        local pos = self.Player:GetBonePosition(self.BoneID)
        if pos then
            local part = self.Emitter:Add("particles/flamelet" .. math.random(1, 5), pos)
            if part then
                part:SetVelocity(-self.Dir * 155 + VectorRand() * 12)
                part:SetDieTime(math.Rand(0.15, 0.35))
                part:SetStartAlpha(240)
                part:SetEndAlpha(0)
                part:SetStartSize(6)
                part:SetEndSize(1.5)
                part:SetRoll(math.Rand(-180, 180))
                part:SetColor(255, 170 + math.random(35), 20)
                part:SetLighting(false)
            end
        end
    end

    return true
end

function EFFECT:Render()
end

function EFFECT:OnRemove()
    if self.Emitter then self.Emitter:Finish() end
end

effects.Register(EFFECT, "jet_thrust_effect")