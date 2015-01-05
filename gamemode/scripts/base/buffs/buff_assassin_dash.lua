function BUFF:OnInitialize( ply, skid )
	if SERVER then
		MsgN(skid)
		ply:SetCooldown( skid, 0.3 )
		ply:EmitSound( 'npc/manhack/grind_flesh' .. math.random( 1, 3 ) .. '.wav', 80, math.random( 100, 110 ), 1, -1 )
	end
end

function BUFF:OnUpdate( ply, skid )

end

function BUFF:OnRemove( ply, skid )
	if SERVER then
		ply:SetCooldown( skid, 12 )
	end
end