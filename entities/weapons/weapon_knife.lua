SWEP.ViewModel = "models/weapons/v_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl" 

SWEP.DrawWeaponInfoBox = false

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.Damage = 10
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = 'none'
SWEP.Primary.Delay = 0.8
SWEP.Primary.Distance = 50

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Damage = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = 'none'

function SWEP:Initialize( ) 
	self:SetWeaponHoldType( 'knife' )
end 

function SWEP:Deploy()
	local ply = self.Owner
	local duration = ply:GetViewModel( ):SequenceDuration( )
	
	self.Idle = CurTime( ) + duration
	self:SetNextPrimaryFire( CurTime( ) + duration )
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:EmitSound( 'Weapon_Knife.Deploy' )
	
	return true
end

function SWEP:PrimaryAttack( )
	local ply = self.Owner
	
	ply:LagCompensation( true )
	
	local shootpos = ply:GetShootPos( )
	local calcpos = shootpos + ply:GetAimVector( ) * self.Primary.Distance
	
	local trMins = -Vector( 8, 8, 0.5 )
	local trMaxs = Vector( 8, 8, 0.5 )
	
	local tab = {
		start = shootpos,
		endpos = calcpos,
		filter = ply,
		mask = MASK_SHOT_HULL,
		mins = trMins,
		maxs = trMaxs
	}
	
	local tr = util.TraceHull( tab )
	local ent = tr.Entity
	
	local tab2 = {
		start = shootpos,
		endpos = calcpos,
		filter = ply,
		mask = MASK_SHOT_HULL
	}
	
	if !IsValid( ent ) then
      tr = util.TraceLine( tab2 )
	end
	
	--[[
	if IsValid( ent ) then
		self:SendWeaponAnim( ACT_VM_HITCENTER )
	else
		self:SendWeaponAnim( ACT_VM_MISSCENTER )
	end
	--]]
	
	ply:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_HITCENTER )
	
	if SERVER then
	
		self:SetNextPrimaryFire( CurTime( ) + self.Primary.Delay )
		
		if tr.Hit && tr.HitNonWorld && IsValid( ent ) then
			local dmg = DamageInfo( )
			dmg:SetDamage( self.Primary.Damage )
			dmg:SetAttacker( ply )
			dmg:SetInflictor( ply )
			dmg:SetDamageForce( ply:GetAimVector( ) * 5 )
			dmg:SetDamagePosition( ply:GetPos( ) )
			dmg:SetDamageType( DMG_SLASH )
			ent:DispatchTraceAttack( dmg, shootpos + ply:GetAimVector( ) * 3, calcpos )
			
			ply:EmitSound( 'weapons/knife/knife_hit' .. math.random( 1, 4 ) .. '.wav' )
			
			if ent:IsPlayer( ) then
				local effect = EffectData( )
				effect:SetStart( shootpos )
				effect:SetOrigin( tr.HitPos )
				effect:SetNormal( tr.Normal )
				effect:SetEntity( ent )
				util.Effect( 'BloodImpact', effect )
				
				if ply:HasBuff( BUFF_ASSASSIN_STUN_OWNER ) then
					ply:RemoveBuff( BUFF_ASSASSIN_STUN_OWNER )
					
					ent:GiveBuff( BUFF_ASSASSIN_STUN, 1 )
				end
			end
		else
			ply:EmitSound( 'weapons/iceaxe/iceaxe_swing1.wav' )
		end
	end
	
		
	ply:LagCompensation( false )
end

function SWEP:SecondaryAttack( )
	return false
end

function SWEP:Reload( )
	return false
end

function SWEP:OnRemove( )
	return true
end

function SWEP:Holster( )
	return true
end
--[[
hook.Add( 'PostDrawOpaqueRenderables', 'SWEP_Debug', function( )
	local ply = LocalPlayer( )
	
	local shootpos = ply:GetShootPos( )
	local calcpos = ply:GetShootPos( ) + ply:GetAimVector( ) * 50
	
	local trMins = -Vector( 8, 8, 0.5 )
	local trMaxs = Vector( 8, 8, 0.5 )
	
	local tab = {
		start = shootpos,
		endpos = calcpos,
		filter = ply,
		mask = MASK_SHOT_HULL,
		mins = trMins,
		maxs = trMaxs
	}
	
	local tr = util.TraceHull( tab )
	local ent = tr.Entity

	if IsValid( ent ) then
		render.DrawWireframeBox( tr.HitPos, Angle( ), trMins, trMaxs, Color( 255, 0, 0 ) )
	else
		render.DrawWireframeBox( tr.HitPos, Angle( ), trMins, trMaxs, Color( 255, 255, 255 ) )
	end
end )
--]]