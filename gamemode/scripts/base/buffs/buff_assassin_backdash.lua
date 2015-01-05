function BUFF:OnInitialize( ply, skid )
	if SERVER then
		ply:EmitSound( 'npc/manhack/grind_flesh' .. math.random( 1, 3 ) .. '.wav', 80, math.random( 100, 110 ), 1, -1 )
	end
end

function BUFF:OnUpdate( ply, skid )

end

function BUFF:OnRemove( ply, skid )

end