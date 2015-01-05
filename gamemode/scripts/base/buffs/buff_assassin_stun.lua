function BUFF:OnInitialize( ply, id )
	ply:Freeze( true )
end

function BUFF:OnUpdate( ply )

end

function BUFF:OnRemove( ply, id )
	ply:Freeze( false )
end