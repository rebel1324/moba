function BUFF:OnInitialize( ply, skid )
	if SERVER then
		local wep = ply:GetActiveWeapon( )
		wep:SetNextPrimaryFire( CurTime( ) + 0.1 )
	end
end

function BUFF:OnUpdate( ply, skid )
end

function BUFF:OnRemove( ply, skid )
	if SERVER then
		ply:SetCooldown( skid, 8 )
	end
end