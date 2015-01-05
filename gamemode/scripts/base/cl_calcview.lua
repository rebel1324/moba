function GM:ShouldDrawLocalPlayer( ply ) return true end

function GM:CalcView( ply, pos, ang, fov )
	local view = { }
	
	if !ply.camAng then
		ply.camAng = Angle( 0, 0, 0 )
	end
	
	local curAng = ply.camAng
	
	local traceData = { }
	traceData.start = ply:GetPos( ) + ply:GetViewOffset( ) + curAng:Up( ) * 16
	traceData.endpos = traceData.start - curAng:Forward( ) * 160
	traceData.filter = ply
	
	local tr = util.TraceLine( traceData )
	
	local viewAng =  ( ply:GetShootPos( ) - tr.HitPos ):Angle( )
	ply:SetEyeAngles( Angle( 0, viewAng.y, 0 ) )
	
	view.origin = tr.HitPos
	view.angles = curAng
	
	return view
end

local camAng_p, camAng_y = 0, 0
function GM:InputMouseApply( cmd, x, y, ang )
	local ply = LocalPlayer( )
	if !IsValid( ply ) then return false end
	
	camAng_p = math.Clamp( math.NormalizeAngle( camAng_p + y / 50 ), 0, 32 )
	camAng_y = math.NormalizeAngle( camAng_y - x / 50 )
	
	ply.camAng = Angle( camAng_p, camAng_y, 0 )
	
	return true
end

hook.Add( 'HUDPaintBackground', 'DrawCustomCrosshair', function( )
	local ply = LocalPlayer( )
	
	local traceData = { }
	traceData.start = ply:GetPos( ) + ply:GetViewOffset( ) / 2
	traceData.endpos = traceData.start + ply:GetAimVector( ) * 512
	traceData.filter = player.GetAll( )
	traceData.ignoreworld = true
	
	local tr = util.TraceLine( traceData )
	local toscreen = tr.HitPos:ToScreen( )
	local w = toscreen.x
	local h = toscreen.y
	
	local dist = 10
	local fatness = 3
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawRect( w, h, fatness, fatness )

	surface.DrawRect( w, h + dist, fatness, fatness )
	surface.DrawRect( w, h - dist, fatness, fatness )

	surface.DrawRect( w + dist, h, fatness, fatness )
	surface.DrawRect( w - dist, h, fatness, fatness )
end )

local hud = { 'CHudHealth', 'CHudBattery', 'CHudAmmo', 'CHudSecondaryAmmo', 'CHudCrosshair', 'CHudDamageIndicator', 'CHudWeapon', 'CHudWeaponSelection' }
function GM:HUDShouldDraw( name )
	for k, v in pairs( hud ) do
		if ( name == v ) then return false end
	end
	
	return true
end

function GM:HUDDrawTargetID( ) end