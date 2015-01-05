g_proj_cl = g_proj_cl or { }
g_proj_cl.prototype = g_proj_cl.prototype or { }

net.Receive( 'g_proj_create', function( _ )
	local class = net.ReadString( )
	local id = net.ReadInt( 32 )
	local pos = net.ReadVector( )
	local vel = net.ReadVector( )
	
	local tab = { }
	tab.Class = class
	tab.ID = id
	tab.Pos = pos
	tab.Ang = vel:Angle( )
	tab.Vel = vel
	tab.LastPos = pos
	tab.LastTime = CurTime( )
	
	g_proj_cl.prototype[ tab.ID ] = tab
	
	local proj = GetProjectile( tab.Class )
	if proj.OnClientsideCreate then
		proj:OnClientsideCreate( tab )
	end
end )

net.Receive( 'g_proj_remove', function( _ )
	local id = net.ReadInt( 32 )
	local tab = g_proj_cl.prototype[ id ]
	
	local proj = GetProjectile( tab.Class )
	if proj.OnClientsideRemove then
		proj:OnClientsideRemove( tab )
	end
	
	g_proj_cl.prototype[ id ] = nil
end )

hook.Add( 'Think', 'g_proj_cl_Think', function( )
	for k, v in pairs( g_proj_cl.prototype ) do
		local delta = ( CurTime( ) - v.LastTime )
		local proj = GetProjectile( v.Class )
		
		if proj.OnClientsideUpdate then
			proj:OnClientsideUpdate( v )
		end
		
		v.Pos = ( v.Pos + ( v.Vel * delta ) )
		v.LastPos = v.Pos
		v.LastTime = CurTime( )
	end
end )

--[[
	if ( !IsValid( v.csmdl ) )then
		v.csmdl = ClientsideModel( 'models/Items/crossbowrounds.mdl', RENDER_GROUP_VIEW_MODEL_OPAQUE )
	else
		v.csmdl:SetPos( v.Pos )
		v.csmdl:SetAngles( v.Ang )
	end
--]]