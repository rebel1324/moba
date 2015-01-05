net.Receive( 'mw_skillcast_start', function( _, ply )
	local skid = net.ReadInt( 4 )
	local tab = ply:GetClassTables( ).Skills[ skid ]
	
	if ply:GetCooldown( skid ) >= CurTime( ) then return end
	
	if !tab.CustomCooldown then
		ply:SetCooldown( skid, tab.Cooldown )
	end
	
	tab.OnCast( ply, skid )
end )

net.Receive( 'mw_skillcast_finish', function( _ )
	local skid = net.ReadInt( 4 )
	
end )