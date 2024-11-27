AddCSLuaFile()

SWEP.Author = "Santinop145"
SWEP.Instructions = "RPG"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/c_rpg.mdl"
SWEP.WorldModel = "models/weapons/w_rpg.mdl"
SWEP.UseHands = true

SWEP.PrintName = "Carpet Bomber"
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

function SWEP:Initialize()
end

function SWEP:Think()
end

function SWEP:PrimaryAttack()
    if(not self:CanPrimaryAttack() or self.Charging or self.Cooldown or not self.ChargeReady) then return end
    
    self.BaseClass.ShootEffects(self)

    local bullet = {}
	bullet.Num 		= 1
	bullet.Src 		= self.Owner:GetShootPos()
	bullet.Dir 		= self.Owner:GetAimVector()
	bullet.Spread 	= Vector(0, 0, 0)
	bullet.Tracer	= 1
    bullet.TracerName = "AR2Tracer"
	bullet.Force	= 1
	bullet.Damage	= 0
	bullet.AmmoType = "AR2"
    
    bullet.Damage = 26
    bullet.Spread = Vector(0.04, 0.04, 0.04)
    self.Owner:ViewPunch(Angle(-10, 0, 0))

    if(self.ChargeReady == true) then
        ply = self.Owner
        self.ChargeReady = false
        self.Owner:FireBullets(bullet)
        self.Weapon:EmitSound("weapons/flaregun/fire.wav")
        local tr = self.Owner:GetEyeTrace()
        timer.Simple(2, function()
            for i=0, 1000 do
                timer.Simple(math.random(0, 1000) * 0.2, function()
                    local explode = ents.Create("env_explosion")
                    explode:SetOwner(self)
                    explode:SetPos(tr.HitPos + Vector(math.random(-800, 800), math.random(-800, 800), 0))
                    util.ScreenShake((tr.HitPos), 6, 40, 6, 10000, true)
                    explode:Spawn()
                    explode:SetKeyValue("iMagnitude", "1000")
                    explode:Fire("Explode", 0, 0)
                    explode:EmitSound("weapons/explode5.wav", 200, 200) 
                end)
            end
        self.Cooldown = true
        timer.Simple(1, function() self.Cooldown = false end)
        end)
        return
    end
end

function SWEP:SecondaryAttack()
    if(self.Charging or self.Cooldown or self.ChargeReady) then return end

    self.Weapon:EmitSound("weapons/physcannon/physcannon_charge.wav")
    self.Charging = true
    self:SendWeaponAnim(ACT_VM_FIDGET)
    util.ScreenShake(self:GetPos(), 4, 40, 5, 200, true)
    timer.Simple(1.8, function() self.Charging = false self.ChargeReady = true self.Weapon:EmitSound("weapons/physcannon/superphys_hold_loop.wav") end)
end

function SWEP:Reload()
end