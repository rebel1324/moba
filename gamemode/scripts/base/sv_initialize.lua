function GM:Initialize( )

end

function GM:InitPostEntity( )
	local t_blue = { }
	local t_red = { }
	
	
	t_blue = table.Add( t_blue, ents.FindByClass( 'hob_spawnpoint_blue' ) )
	t_red = table.Add( t_red, ents.FindByClass( 'hob_spawnpoint_red' ) )
	
	PrintTable( t_blue )
	PrintTable( t_red )
	
	team.SetSpawnPoint( TEAM_BLUE, t_blue )
	team.SetSpawnPoint( TEAM_RED, t_red )
end

function GM:GameOver( wteam, lteam )
	if self.gameOver then return end
	self.gameOver = true
	
	MsgN( wteam, lteam )
end