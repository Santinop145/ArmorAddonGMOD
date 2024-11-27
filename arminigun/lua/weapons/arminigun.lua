AddCSLuaFile()

SWEP.Author = "Santinop145"
SWEP.Instructions = "ARMinigun"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/c_IRifle.mdl"
SWEP.WorldModel = "models/weapons/w_IRifle.mdl"
SWEP.UseHands = true
SWEP.HoldType = "ar2"

SWEP.PrintName = "Pulse Rifle HMG"
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 200
SWEP.Primary.DefaultClip = 400
SWEP.Secondary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

SWEP.Overheat = false
SWEP.heat = 0
SWEP.viewpunchAngle = Angle(-1,0,0)
SWEP.fireDelay = 0.15
SWEP.Spread = Vector(0.11,0.11,0.11)
SWEP.Damage = 8
SWEP.TurretMode = false

function SWEP:Initialize()
end

function SWEP:Think()
end

function SWEP:PrimaryAttack()
    if(not self:CanPrimaryAttack() or self.Overheat or self.TurretCooldown) then return end
    
    local tr = self.Owner:GetEyeTrace()
    self.Weapon:EmitSound("weapons/ar2/fire1.wav", 40, 50, 1, CHAN_AUTO)
    self.BaseClass.ShootEffects(self)

    local bullet = {}
	bullet.Num 		= 2
	bullet.Src 		= self.Owner:GetShootPos()
	bullet.Dir 		= self.Owner:GetAimVector()
	bullet.Spread 	= self.Spread
	bullet.Tracer	= 1
    bullet.TracerName = "AR2Tracer"
	bullet.Force	= 1
	bullet.Damage	= self.Damage
	bullet.AmmoType = "AR2"
    
    if(not self.TurretMode)then
        if(not timer.Exists("FiringSpeed")) then
            timer.Create("FiringSpeed", 0.1, 8, function() 
                if(self.heat < 100)then 
                    self.heat = self.heat + 1 
                    self.fireDelay = math.max(self.fireDelay - 0.002, 0.05)
                    self.viewpunchAngle = self.viewpunchAngle + Angle(0.01,0,0)
                    self.Damage = self.Damage + 0.1
                    self.Spread = self.Spread - Vector(0.001,0.001,0.001)
                    if(timer.Exists("ReturnHeat")) then
                        timer.Remove("ReturnHeat")
                        timer.Create("ReturnHeat", 3, 1, function() self.Spread = Vector(0.11,0.11,0.11) self.heat = 0 self.Damage = 8 self.fireDelay = 0.15 self.viewpunchAngle = Angle(-1, 0, 0) self:EmitSound("ambient/energy/spark2.wav", 80, 100, 1, CHAN_WEAPON) timer.Remove("FiringSpeed") end)
                    else
                        timer.Create("ReturnHeat", 3, 1, function() self.Spread = Vector(0.11,0.11,0.11) self.heat = 0 self.Damage = 8 self.fireDelay = 0.15 self.viewpunchAngle = Angle(-1, 0, 0) self:EmitSound("ambient/energy/spark2.wav", 80, 100, 1, CHAN_WEAPON) timer.Remove("FiringSpeed") end)
                    end
                else
                    timer.Remove("FiringSpeed")
                    timer.Remove("ReturnHeat")
                    self.heat = 0
                    self.viewpunchAngle = Angle(-1, 0, 0)
                    self.fireDelay = 0.15
                    self.Overheat = true
                    self.Damage = 8
                    self.Spread = Vector(0.11,0.11,0.11)
                    self:EmitSound("common/warning.wav", 100, 100, 1, CHAN_AUTO)
                    self:EmitSound("ambient/energy/electric_loop.wav", 60, 90, 1, CHAN_WEAPON)
                    timer.Simple(5, function() self.Overheat = false self:EmitSound("ambient/energy/spark2.wav", 80, 100, 1, CHAN_WEAPON) end)
                end
            end)
        end
        self:SetNextPrimaryFire(CurTime() + self.fireDelay)
        self.Owner:FireBullets(bullet)
        self.Owner:ViewPunch(self.viewpunchAngle)
        util.ScreenShake(self:GetPos(), 2, 40, 2, 500, true)
        self:TakePrimaryAmmo(1)
    else
        if(not timer.Exists("FiringSpeed")) then
            timer.Create("FiringSpeed", 0.1, 8, function() 
                if(self.heat < 100)then 
                    self.heat = self.heat + 1
                    self.fireDelay = math.max(self.fireDelay - 0.003, 0.04)
                    self.viewpunchAngle = Angle(-0.05,0,0)
                    self.Damage = self.Damage + 0.2
                    self.Spread = Vector(0.02,0.02,0.02)
                    if(timer.Exists("ReturnHeat")) then
                        timer.Remove("ReturnHeat")
                        timer.Create("ReturnHeat", 3, 1, function() self.Spread = Vector(0.11,0.11,0.11) self.heat = 0 self.Damage = 8 self.fireDelay = 0.15 self.viewpunchAngle = Angle(-1, 0, 0) self:EmitSound("ambient/energy/spark2.wav", 80, 100, 1, CHAN_WEAPON) timer.Remove("FiringSpeed") end)
                    else
                        timer.Create("ReturnHeat", 3, 1, function() self.Spread = Vector(0.11,0.11,0.11) self.heat = 0 self.Damage = 8 self.fireDelay = 0.15 self.viewpunchAngle = Angle(-1, 0, 0) self:EmitSound("ambient/energy/spark2.wav", 80, 100, 1, CHAN_WEAPON) timer.Remove("FiringSpeed") end)
                    end
                else
                    timer.Remove("FiringSpeed")
                    timer.Remove("ReturnHeat")
                    self.heat = 0
                    self.viewpunchAngle = Angle(-1, 0, 0)
                    self.fireDelay = 0.15
                    self.Overheat = true
                    self.Damage = 8
                    self.Spread = Vector(0.11,0.11,0.11)
                    self:EmitSound("common/warning.wav", 100, 100, 1, CHAN_AUTO)
                    self:EmitSound("ambient/energy/electric_loop.wav", 60, 90, 1, CHAN_WEAPON)
                    timer.Simple(5, function() self.Overheat = false self:EmitSound("ambient/energy/spark2.wav", 80, 100, 1, CHAN_WEAPON) end)
                end
            end)
        end

        self:SetNextPrimaryFire(CurTime() + self.fireDelay)
        self.Owner:FireBullets(bullet)
        self.Owner:ViewPunch(self.viewpunchAngle)
        util.ScreenShake(self:GetPos(), 2, 40, 2, 500, true)
        self:TakePrimaryAmmo(1)
    end
end

function SWEP:SecondaryAttack()
    if(not self.TurretMode)then
        self.TurretMode = true
        self.OwnerSpeed = self.Owner:GetWalkSpeed()
        self.OwnerSlowSpeed = self.Owner:GetSlowWalkSpeed()
        self.OwnerRunSpeed = self.Owner:GetRunSpeed()
        self.OwnerFov = self.Owner:GetFOV()
        self.Owner:SetWalkSpeed(1)
        self.Owner:SetSlowWalkSpeed(1)
        self.Owner:SetRunSpeed(1)
        self.Owner:SetFOV(60)
    else
        self.TurretMode = false
        self.Owner:SetFOV(self.OwnerFov)
        self.Owner:SetWalkSpeed(self.OwnerSpeed)
        self.Owner:SetSlowWalkSpeed(self.OwnerSlowSpeed)
        self.Owner:SetRunSpeed(self.OwnerRunSpeed)
        self.TurretCooldown = true
        timer.Simple(3.5, function() self.TurretCooldown = false end)
    end
end

function SWEP:Reload()
    timer.Remove("FiringSpeed")
    self:DefaultReload(ACT_VM_RELOAD)
end