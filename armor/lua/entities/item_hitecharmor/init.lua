AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel( "models/props_junk/wood_crate001a_damaged.mdl" ) -- Sets the model for the Entity.
    self:PhysicsInit( SOLID_VPHYSICS ) -- Initializes physics for the Entity, making it solid and interactable.
    self:SetMoveType( MOVETYPE_VPHYSICS ) -- Sets how the Entity moves, using physics.
    self:SetSolid( SOLID_VPHYSICS ) -- Makes the Entity solid, allowing for collisions.
    local phys = self:GetPhysicsObject() -- Retrieves the physics object of the Entity.
    if phys:IsValid() then -- Checks if the physics object is valid.
        phys:Wake() -- Activates the physics object, making the Entity subject to physics (gravity, collisions, etc.).
    end
end

function ENT:Use( activator )

	if ( activator:IsPlayer() and not activator.LightArmorEquipped and not activator.HeavyArmorEquipped and not activator.HiTechArmorEquipped) then 
        activator.HiTechArmorEquipped = true
        activator.HealthshotReady = true
        activator.HealthregenReady = true
        activator.DefaultRunSpeed = activator:GetRunSpeed()
        activator.DefaultWalkSpeed = activator:GetWalkSpeed()
        activator:SetArmor(activator:GetMaxArmor())
        activator:PrintMessage( HUD_PRINTTALK, "High Tech Armor equipped." )
        self:Remove()
	end

end