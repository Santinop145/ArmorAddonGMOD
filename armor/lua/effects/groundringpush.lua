local EFFECT = {}

function EFFECT:Init(data)
    self.Pos = data:GetOrigin()
    self.Size = data:GetRadius() or 32
    self.Lifetime = 0.8
    self.DieTime = CurTime() + self.Lifetime
end

function EFFECT:Think()
    return CurTime() < self.DieTime
end

function EFFECT:Render()
    local delta = 1 - ((self.DieTime - CurTime()) / self.Lifetime)
    local scale = self.Size * delta
    local alpha = 255 * (1 - delta)
    render.SetMaterial(Material("effects/select_ring"))
    render.DrawQuadEasy(self.Pos + Vector(0, 0, 1), Vector(0, 0, 1), scale, scale, Color(255, 255, 255, alpha))
end

effects.Register(EFFECT, "ground_ring_burst")
