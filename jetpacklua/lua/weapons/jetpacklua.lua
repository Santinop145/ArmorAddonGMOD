AddCSLuaFile()

SWEP.Author = "Santinop145"
SWEP.Instructions = "Press left click to arm, space to thrust upwards"
SWEP.Spawnable = true
SWEP.ViewModel = "placeholder"
SWEP.WorldModel = "placeholder"
SWEP.UseHands = true
SWEP.HoldType = "dual"

SWEP.PrintName = "Jetpack"
SWEP.Primary.Ammo = "fuel"
SWEP.Primary.ClipSize = 500
SWEP.Primary.DefaultClip = 500
SWEP.Secondary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false

SWEP.JetpackArmed = false

function SWEP:Think()
    if(self.JetpackArmed and not self.Owner:IsOnGround() and self.Owner:KeyDown() == 2) then
        self.Weapon:EmitSound("player/suit_sprint.wav")
        self.Owner:SetUpSpeed(200)
        self:TakePrimaryAmmo(1)
    end
end

function SWEP:Initialize()
    self.Owner:PrintMessage(HUD_PRINTTALK, "You equipped the jetpack! Use left click to arm it. Whenever you hold space, the jetpack will activate automatically")
    self.Weapon:EmitSound("weapons/physcannon/superphys_launch3.wav", 100, 80, 1, CHAN_AUTO)
end

function SWEP:PrimaryAttack()
    if(self.JetpackArmed) then
        self.Owner:PrintMessage(HUD_PRINTTALK, "Jetpack armed!")
        self.JetpackArmed = true
    else
        self.Owner:PrintMessage(HUD_PRINTTALK, "Jetpack disarmed.")
        self.JetpackArmed = false
    end
end

