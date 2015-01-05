net.Receive( 'mw_class_selected', function( _ )
	local ply = LocalPlayer( )
	
	ply.classID = net.ReadInt( 4 )
	ply.keyBinds = { }
	ply.keyPressed = { }
	ply.skillRender = 0
	
	for k, v in pairs( ply:GetClassTables( ).Skills ) do
		ply.keyBinds[ v.KeyBind ] = k
		ply.keyPressed[ v.KeyBind ] = false
	end
end )

function GM:Think( )
	local ply = LocalPlayer( )
	
	if !ply:IsTyping( ) then
		self:KeyBindsUpdate( ply, KEY_Q )
		self:KeyBindsUpdate( ply, KEY_E )
		self:KeyBindsUpdate( ply, KEY_R )
		self:KeyBindsUpdate( ply, KEY_T )
		self:KeyBindsUpdate( ply,MOUSE_LEFT, true )
		self:KeyBindsUpdate( ply,MOUSE_RIGHT, true )
	end
end

function GM:CreateMove( cmd )
	self:RemoveKeys( cmd )
end

function GM:RemoveKeys( cmd )
	cmd:RemoveKey( IN_USE )
	cmd:RemoveKey( IN_WALK )
	cmd:RemoveKey( IN_SPEED )
	cmd:RemoveKey( IN_JUMP )
	cmd:RemoveKey( IN_DUCK )
end

function GM:PostDrawOpaqueRenderables( )
	local ply = LocalPlayer( )
	self:SkillRenderables( ply )
end