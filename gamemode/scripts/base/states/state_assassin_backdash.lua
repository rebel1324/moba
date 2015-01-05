STATE.Velocity = -500
STATE.Velocity_Z = 50

function STATE:Move( ply, move )
	local forward = ply:GetForward( )
	
	ply:SetGroundEntity( nil )
	
	move:SetSideSpeed( 0 )
	move:SetForwardSpeed( 0 )
	move:SetMaxSpeed( 0 )
	move:SetMaxClientSpeed( 0 )
	move:SetVelocity( ( forward * self.Velocity ) + Vector( 0, 0, self.Velocity_Z ) )
end