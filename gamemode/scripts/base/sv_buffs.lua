function GM:PlayerBuffUpdate( ply )
	local tab = ply.buffs
	if !tab then return end
	
	for k, v in pairs( tab ) do
		if v.DieTime < CurTime( ) then
			ply:RemoveBuff( k )
		else
			ply:CallBuffFunction( k, 'OnUpdate', v.SkillID )
		end
	end
end

hook.Add( 'DoPlayerDeath', 'Buff Remove', function( ply )
	local tab = ply.buffs
	if !tab then return end
	
	for k, v in pairs( tab ) do
		ply:RemoveBuff( k )
	end
end )