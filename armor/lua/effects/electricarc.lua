EFFECT.StartPos = Vector(0, 0, 0)
EFFECT.EndPos = Vector(0, 0, 0)

function EFFECT:Init(data)
    self.EndPos = data:GetOrigin()
    self.StartPos = data:GetStart()
    self.DieTime = CurTime() + 0.05
end

function EFFECT:Think()
    return CurTime() < self.DieTime
end

function EFFECT:Render()
    render.SetMaterial(Material("trails/laser"))
    render.DrawBeam(self.StartPos, self.EndPos, 5, 0, 1, Color(255, 255, 255))
    render.DrawBeam(self.StartPos+VectorRand(-5,5), self.EndPos+VectorRand(-5,5), 1, 0, 1, Color(255, 255, 255))
end