util.AddNetworkString( 'g_proj_create' )
util.AddNetworkString( 'g_proj_remove' )

g_proj = g_proj or { }
g_proj.prototype = g_proj.prototype or { }
g_proj.id = g_proj.id or 0

function g_proj:Create( class, ply, pos, ang, vel )
	self.id = self.id + 1
	
	local tab = { }
	local proj = GetProjectile( class )
	
	tab.Class = class
	tab.ID = self.id
	tab.Own = ply
	tab.Pos = pos
	tab.Ang = ang
	tab.Vel = vel
	tab.LastPos = pos
	tab.OldPos = pos
	tab.LastTime = CurTime( )
	
	self:ClientsideProjectileCreate( tab )
	
	self.prototype[ self.id ] = tab
	
	if proj.OnCreate then
		proj:OnCreate( tab )
	end
end

function g_proj:ClientsideProjectileCreate( tab )
	
	net.Start( 'g_proj_create' )
		net.WriteString( tab.Class )
		net.WriteInt( tab.ID, 32 )
		net.WriteVector( tab.Pos )
		net.WriteVector( tab.Vel )
	net.Broadcast( )
end

function g_proj:ClientsideProjectileRemove( id )
	net.Start( 'g_proj_remove' )
		net.WriteInt( id, 32 )
	net.Broadcast( )
end

function g_proj:Remove( id )
	local tab = g_proj.prototype[ id ]
	local proj = GetProjectile( tab.Class )
	
	if proj.OnRemove then
		proj:OnRemove( tab )
	end
	
	g_proj:ClientsideProjectileRemove( id )
	g_proj.prototype[ id ] = nil
end

hook.Add( 'Think', 'g_proj_Think', function( )
	for k, v in pairs( g_proj.prototype ) do
		local delta = ( CurTime( ) - v.LastTime )
		local proj = GetProjectile( v.Class )
		
		if proj.OnUpdate then
			proj:OnUpdate( v )
		end
		
		v.Pos = ( v.Pos + ( v.Vel * delta ) )
		v.LastPos = v.Pos
		v.LastTime = CurTime( )
	end
end )