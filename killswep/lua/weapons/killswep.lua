AddCSLuaFile()

SWEP.Author = "Santinop145"
SWEP.Instructions = "Point and kill"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.PrimaryAmmo = "none"

SWEP.PrintName = "Kill Gun"
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.Mode = 0

function SWEP:Initialize()
    self.Mode = 0
end

function SWEP:Reload()
    self.Owner:SetHealth(1000)
    self.Owner:SetArmor(1000)
end

function SWEP:Think()
end

function SWEP:PrimaryAttack()
    local tr = self.Owner:GetEyeTrace()

    if(self.Mode == 0) then
        self.Primary.Automatic = false
        self.Weapon:EmitSound("weapons/ar2/npc_ar2_altfire.wav", 100, 100, 1, CHAN_AUTO)
        self.BaseClass.ShootEffects(self)
        
        self:ShootBullet(50000, 30, 0.2, self.Primary.Ammo, 1, 1)
        util.ScreenShake(self:GetPos(), 15, 40, 3, 1000, true)
        ply = self:GetOwner()
        ply:ViewPunch(Angle(-10, 0, 0))
    elseif(self.Mode == 1) then
        self.Primary.Automatic = true
        self.Weapon:EmitSound("weapons/airboat/airboat_gun_lastshot2.wav", 100, 100, 1, CHAN_AUTO)
        self.BaseClass.ShootEffects(self)
        
        self:ShootBullet(10000, 2, 0.2, self.Primary.Ammo, 1, 1)
        util.ScreenShake(self:GetPos(), 5, 40, 2, 1000, true)
        ply = self:GetOwner()
        ply:ViewPunch(Angle(-1, 0, 0))
        
        self:SetNextPrimaryFire(CurTime() + 0.05)
    else
        local explode = ents.Create("env_explosion")
        explode:SetPos(tr.HitPos)
        explode:SetOwner(self.Owner)
        explode:Spawn()
        explode:SetKeyValue( "iMagnitude", "500" )
        explode:Fire( "Explode", 0, 0 )
        explode:EmitSound("weapons/explode5.wav", 1000, 1000)
        self.Primary.Automatic = false
        self.Weapon:EmitSound("weapons/physcannon/superphys_launch3.wav", 100, 80, 1, CHAN_AUTO)
        self.BaseClass.ShootEffects(self)
        
        self:ShootBullet(100000, 50, 0.2, self.Primary.Ammo, 1, 0)
        util.ScreenShake(self:GetPos(), 100, 40, 4, 1000, true)
        ply = self:GetOwner()
        ply:ViewPunch(Angle(-40, 0, 0))
    end
end

function SWEP:SecondaryAttack()
    self.Weapon:EmitSound("weapons/ar2/ar2_empty.wav")

    if(self.Mode < 2) then 
        self.Mode = self.Mode + 1 
    else 
        self.Mode = 0
    end

    if(self.Mode == 0) then
        ply:PrintMessage(HUD_PRINTTALK, "Mode switched to: Shotgun")
    elseif(self.Mode == 1) then
        ply:PrintMessage(HUD_PRINTTALK, "Mode switched to: Automatic")
    else 
        ply:PrintMessage(HUD_PRINTTALK, "Mode switched to: Explosive")
    end
end