AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'shared.lua' )

include( 'shared.lua' )

function ENT:Initialize( )
	self.Destroyed = false
	
	self:SetModel( self.TeamID == TEAM_BLUE && 'models/lment/structures/nexus.mdl' || 'models/lment/structures/nexus_red.mdl' )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	
	self:SetHealth( 5000 )
end

function ENT:Think( )
	if !self.Destroyed && self:Health( ) <= 0 then
		self.Destroyed = true
		
		self:OnDestroy( )
	end
	
	self:NextThink( CurTime( ) )
	return true
end

function ENT:OnTakeDamage( data )
	local attacker = data:GetAttacker( )
	
	if self.TeamID == attacker:Team( ) then return end
	if self.Destroyed then return end
	
	local dmg = data:GetDamage( )
	
	self:SetHealth( self:Health( ) - dmg )
end

function ENT:OnDestroy( )
	self:SetColor( Color( 50, 50, 50 ) )
	
	local wteam = 0
	local lteam = 0
	
	if self.TeamID == TEAM_BLUE then
		wteam = TEAM_RED
		lteam = TEAM_BLUE
	elseif self.TeamID == TEAM_RED then
		wteam = TEAM_BLUE
		lteam = TEAM_RED
	end
	
	GAMEMODE:GameOver( wteam, lteam )
end

function ENT:UpdateTransmitState( )
	return TRANSMIT_ALWAYS 
end