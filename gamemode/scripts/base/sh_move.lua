function GM:OnPlayerHitGround( ply )
	return true
end

function GM:GetFallDamage( )
	return false
end

function GM:Move( ply, move )
	if SERVER then
		if ply:GetState( ) ~= STATE_NONE && ply:GetStateTime( ) <= CurTime( ) then
			ply:SetState( STATE_NONE )
		end
	end
	
	return ply:CallStateFunction( 'Move', move )
end