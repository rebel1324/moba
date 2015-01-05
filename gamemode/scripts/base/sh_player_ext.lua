local meta = FindMetaTable( 'Player' )
if !meta then return end

// CLASS
function meta:GetClassID( )
	return self.classID || 0
end

function meta:GetClassTables( )
	return Classes[ self:GetClassID( ) ]
end
//

// STATE
function meta:GetState( )
	return self:GetDTInt( 0 )
end

function meta:GetStateTime( )
	return self:GetDTFloat( 0 )
end

function meta:CallStateFunction( state, ... )
	local tab = States[ self:GetState( ) ]
	local func = tab[ state ]
	
	if func then
		return func( tab, self, ... )
	end
end
//

// SKILL
function meta:GetCooldown( int )
	return self:GetNWFloat( 'cooldown_' .. int )
end

function meta:GetIconChanged( int )
	return self:GetNWBool( 'icon_' .. int )
end
//

// BUFF
function meta:CallBuffFunction( int, func, ... )
	local tab = Buffs[ int ]
	local funct = tab[ func ]
	
	if funct then
		return funct( tab, self, ... )
	end
end

function meta:GetBuff( int )
	return self.buffs[ int ]
end

function meta:RemoveBuff( int )
	if SERVER then
		 net.Start( 'mw_buff_clientside_remove' )
			net.WriteInt( int, 4 )
		net.Send( self )
	end
	
	self:CallBuffFunction( int, 'OnRemove', self.buffs[ int ].SkillID )
	self.buffs[ int ] = nil
	MsgN( int, ' buff Removed!' )
end

function meta:HasBuff( int )
	if !self.buffs then return false end
	
	if self.buffs[ int ] then
		return true
	else
		return false
	end
end
//

function meta:Box2DCollision(  )
	
	
	
end