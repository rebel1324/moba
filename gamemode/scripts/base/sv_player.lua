function GM:PlayerInitialSpawn( ply )
	net.Start( 'mw_classmenu' )
	net.Send( ply )
	
	ply:Initialize( )
end

function GM:PlayerSpawn( ply )
	if ply:GetObserverMode( ) == OBS_MODE_ROAMING then return end
	
	local tab = ply:GetClassTables( )
	
	ply:SetModel( tab.Model )
	ply:SetHealth( tab.Health )
	ply:SetMaxHealth( tab.Health )
	ply:Give( tab.Weapon )
	ply:SetSpeed( tab.Speed )
end

function GM:PlayerSelectSpawn( ply )
	local tab = team.GetSpawnPoint( ply:Team( ) )
	
	return tab[ math.random( 1, #tab ) ]
end

net.Receive( 'mw_classmenu_selected', function( _, ply )
	ply:SetClassID( net.ReadInt( 4 ) )
end )

function GM:Think( )
	for k, v in pairs( player.GetAll( ) ) do
		self:PlayerBuffUpdate( v )
	end
end

function GM:PlayerDeathThink( ply )

		if ( ply.NextSpawnTime && ply.NextSpawnTime > CurTime( ) ) then return end
		ply:Spawn( )
end

function GM:AllowPlayerPickup( ply, ent )
	return false
end