function BUFF:OnInitialize( ply, skid )
	if SERVER then
		ply:DrawShadow( false )
		ply:DrawWorldModel( false )
	end
end

function BUFF:OnUpdate( ply, skid )
end

function BUFF:OnRemove( ply, skid )
	if SERVER then
		ply:DrawShadow( true )
		ply:DrawWorldModel( true )
	end
end