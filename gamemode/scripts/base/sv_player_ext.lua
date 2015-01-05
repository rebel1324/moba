local meta = FindMetaTable( 'Player' )

if ( !meta ) then return end

function meta:Initialize( )
	self:Spectate( OBS_MODE_ROAMING )
	
	self:SetState( STATE_NONE )
	
	self.baseRunSpeed = 180
	self.baseWalkSpeed = 180
	self.baseJumpPower = 220
	self.baseCrouchSpeed = self:GetCrouchedWalkSpeed( )
	
	self:SetRunSpeed( self.baseRunSpeed )
	self:SetMaxSpeed( self.baseRunSpeed )
	self:SetWalkSpeed( self.baseWalkSpeed )
	self:SetJumpPower( self.baseJumpPower )
	self:SetCrouchedWalkSpeed( self.baseCrouchSpeed )
	self:SetCanZoom( false )
	
	local t1 = team.NumPlayers( 1 ) or 0
	local t2 = team.NumPlayers( 2 ) or 0
	
	if ( t1 == t2 ) then
		self:SetTeam( math.random( 1, 2 ) )
	elseif ( t1 > t2 ) then
		self:SetTeam( 2 )
	else
		self:SetTeam( 1 )
	end
end

function meta:SetSpeed( float )
	self:SetRunSpeed( float )
	self:SetMaxSpeed( float )
	self:SetWalkSpeed( float )
end

function meta:AddSpeed( float )
	self:SetRunSpeed( self:GetRunSpeed( ) + float )
	self:SetMaxSpeed( self:GetMaxSpeed( ) + float )
	self:SetWalkSpeed( self:GetWalkSpeed( ) + float )
end

function meta:SetColorAlpha( a )
	local c = self:GetColor( )
	self:SetColor( Color( c.r, c.g, c.b, a ) )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
end

// CLASS
function meta:SetClassID( int )
	self.classID = int
	
	net.Start( 'mw_class_selected' )
		net.WriteInt( int, 4 )
	net.Send( self )
	
	self:UnSpectate( )
	self:Spawn( )
end
//

// STATE
function meta:SetState( int, float )
	self:SetDTInt( 0, int )
	if float then
		self:SetDTFloat( 0, CurTime( ) + float )
	end
end
//

// SKILL
function meta:SetCooldown( int, float )
	self:SetNWFloat( 'cooldown_' .. int, CurTime( ) + float )
end
//

// BUFF
function meta:GiveBuff( int, float, int2 )
	local tab = { }
	if !self.buffs then self.buffs = { } end
	
	if !float then
		float = 0
	end
	
	net.Start( 'mw_buff_clientside_send' )
		net.WriteInt( int, 4 )
		net.WriteFloat( float )
		if int2 then
			net.WriteInt( int2, 4 )
		end
	net.Send( self )
	
	tab.DieTime = CurTime( ) + float
	tab.SkillID = int2
	self.buffs[ int ] = tab
	
	self:CallBuffFunction( int, 'OnInitialize', int2 )
	
	MsgN( int, ' buff Gived!' )
end
//