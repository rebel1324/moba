net.Receive( 'mw_buff_clientside_send', function( _ )
	local ply = LocalPlayer( )
	local tab = { }
	local int = net.ReadInt( 4 )
	local float = net.ReadFloat( )
	local int2 = net.ReadInt( 4 )
	
	if !ply.buffs then ply.buffs = { } end
	
	tab.DieTime = CurTime( ) + float
	tab.SkillID = int2
	ply.buffs[ int ] = tab
	
	ply:CallBuffFunction( int, 'OnInitialize', int2 )
end )

net.Receive( 'mw_buff_clientside_remove', function( _ )
	local ply = LocalPlayer( )
	
	ply:RemoveBuff( net.ReadInt( 4 ) )
end )