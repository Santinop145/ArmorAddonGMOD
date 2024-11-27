AddCSLuaFile()

SWEP.Author = "Santinop145"
SWEP.Instructions = "AR4"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/c_IRifle.mdl"
SWEP.WorldModel = "models/weapons/w_IRifle.mdl"
SWEP.UseHands = true
SWEP.HoldType = "ar2"

SWEP.PrintName = "Pulse-Rifle Light Machinegun"
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 60
SWEP.Primary.DefaultClip = 120
SWEP.Secondary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

function SWEP:Initialize()
end

function SWEP:Think()
end

function SWEP:PrimaryAttack()
    if(not self:CanPrimaryAttack() or self.ChargeReady or self.Charging or self.Cooldown) then return end
    
    local tr = self.Owner:GetEyeTrace()
    self.Weapon:EmitSound("weapons/ar2/fire1.wav", 40, 70, 1, CHAN_AUTO)
    self.BaseClass.ShootEffects(self)

    local bullet = {}
	bullet.Num 		= 1
	bullet.Src 		= self.Owner:GetShootPos()
	bullet.Dir 		= self.Owner:GetAimVector()
	bullet.Spread 	= Vector(0.08, 0.08, 0.08)
	bullet.Tracer	= 1
    bullet.TracerName = "AR2Tracer"
	bullet.Force	= 1
	bullet.Damage	= 18
	bullet.AmmoType = "AR2"
    
    if(not self.Owner:Crouching() and not self.Owner:IsOnGround()) then
        bullet.Spread = Vector(0.1, 0.1, 0.1)
        self.Owner:FireBullets(bullet)
        self:SetNextPrimaryFire(CurTime() + 0.06)
        self.Owner:ViewPunch(Angle(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2)))
        self:TakePrimaryAmmo(1)
    elseif(not self.Owner:Crouching()) then
        self.Owner:FireBullets(bullet)
        self:SetNextPrimaryFire(CurTime() + 0.05)
        self.Owner:ViewPunch(Angle(-0.5, math.random(-0.5, 0.5), math.random(-0.5, 0.5)))
        self:TakePrimaryAmmo(1)
    elseif(self.Owner:Crouching() and not self.Owner:IsOnGround()) then
        bullet.Spread = Vector(0.1, 0.1, 0.1)
        self.Owner:FireBullets(bullet)
        self:SetNextPrimaryFire(CurTime() + 0.06)
        self.Owner:ViewPunch(Angle(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2)))
        self:TakePrimaryAmmo(1)
    else
        bullet.Damage = 26
        bullet.Spread = Vector(0.04, 0.04, 0.04)
        self.Owner:FireBullets(bullet)
        self:SetNextPrimaryFire(CurTime() + 0.11)
        self.Owner:ViewPunch(Angle(-0.25, 0, 0))
        self:TakePrimaryAmmo(1)
    end
end

function SWEP:SecondaryAttack()
    if(self.Charging or self.Cooldown) then return end

    local effectdata = EffectData()

    if(self.ChargeReady == true) then
        self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
        self.ChargeReady = false

        local tr = self.Owner:GetEyeTrace()
        local explode = ents.Create("env_explosion")
        explode:SetPos(tr.HitPos)
        explode:SetOwner(self.Owner)
        explode:Spawn()
        explode:SetKeyValue("iMagnitude", "100")
        explode:Fire("Explode", 0, 0)
        explode:EmitSound("weapons/explode5.wav", 200, 200)
        effectdata:SetEntity(self.Owner)
        effectdata:SetOrigin(tr.HitPos)
        util.Effect("HelicopterMegaBomb", effectdata)
        self.Weapon:EmitSound("weapons/airboat/airboat_gun_energy1.wav")
        self.Cooldown = true
        timer.Simple(1, function() self.Cooldown = false end)
        return
    end

    self.Weapon:EmitSound("weapons/physcannon/physcannon_charge.wav")
    self.Charging = true
    self:SendWeaponAnim(ACT_VM_FIDGET)
    util.ScreenShake(self:GetPos(), 4, 40, 5, 200, true)
    timer.Simple(1.8, function() self.Charging = false self.ChargeReady = true self.Weapon:EmitSound("weapons/physcannon/superphys_hold_loop.wav") end)
end

function SWEP:Reload()
    self:DefaultReload(ACT_VM_RELOAD)
end