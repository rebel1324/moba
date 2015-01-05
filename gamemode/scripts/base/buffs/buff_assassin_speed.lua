BUFF.AddSpeed = 120

function BUFF:OnInitialize( ply, skid )
	if SERVER then
		ply:AddSpeed( self.AddSpeed )
	end
end

function BUFF:OnUpdate( ply, skid )

end

function BUFF:OnRemove( ply, skid )
	if SERVER then
		ply:AddSpeed( -self.AddSpeed )
	end
end