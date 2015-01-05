local DrawHud = function( ply, x, y )
	local w, h = 450, 80
	local scrW, scrH = ( ( x / 2 ) - ( w / 2 ) ), ( y - h )
	local classTab = ply:GetClassTables( )
	
	for i = 1, #classTab.Skills do
		local dist = i * 80
		local size = 54
		if classTab.Skills[ i ].Icon_Sub then
			classTab.Skills[ i ].Icon_Sub( ply, i )
		else
			surface.SetMaterial( Material( classTab.Skills[ i ].Icon, 'smooth' ) )
		end
		
		local cooldown = ( ( ply:GetCooldown( i ) ) - CurTime( ) )
		if ply:GetCooldown( i ) < CurTime( ) then
			surface.SetDrawColor( 255, 255, 255 )
			surface.DrawTexturedRect( scrW + dist, scrH + 15, size, size )
		else
			surface.SetDrawColor( 50, 50, 255 )
			surface.DrawTexturedRect( scrW + dist, scrH + 15, size, size )
			
			local ft = math.floor( cooldown )
			if ft < 1 then
				ft = Format( '%.1f', cooldown )
			end
			draw.SimpleTextBlurred( ft, 25, scrW + dist + 27, scrH + 29, Color( 255, 255, 255 ), 1 )
		end
	end
	
	local hp = ply:Health( )
	local mhp = ply:GetMaxHealth( )
	
	surface.SetDrawColor( 10, 10, 10 )
	surface.DrawRect( scrW, scrH - 25, 450, 16 )
	
	surface.SetDrawColor( 60, 255, 60 )
	surface.DrawRect( scrW, scrH - 25, hp / mhp * 450, 16 )
	draw.SimpleTextBlurred( hp .. ' / ' .. mhp, 16, scrW * 1.5, scrH - 25, Color( 200, 200, 200 ), 1 )
end

local DrawHealthInfo = function( ply, v )

end

function GM:HUDPaint( )
	local ply = LocalPlayer( )
	
	if !IsValid( ply ) then return end
	if !ply:GetClassTables( ) then return end
	
	local x = ScrW( )
	local y = ScrH( )
	
	DrawHud( ply, x, y )
end