function GM:KeyBindsUpdate( ply, key, mouse )
	if !ply.keyBinds || !ply.keyPressed then return end
	
	if input.IsButtonDown( key ) and !ply.keyPressed[ key ] then
		ply.keyPressed[ key ] = true
		
		if mouse then
			if ply.skillRender then
				net.Start( 'mw_skillcast_start' )
					net.WriteInt( ply.skillRender, 4 )
				net.SendToServer( )
			
				ply.skillRender = nil
			end
		else
			local classTab = ply:GetClassTables( )
			if classTab.Skills[ ply.keyBinds[ key ] ] then
				if !classTab.Skills[ ply.keyBinds[ key ] ].Render then
					ply.skillRender = nil
					
					net.Start( 'mw_skillcast_start' )
						net.WriteInt( ply.keyBinds[ key ], 4 )
					net.SendToServer( )
					
				else
					ply.skillRender = ply.keyBinds[ key ]
				end
			end
		end
		
	elseif !input.IsButtonDown( key ) and ply.keyPressed[ key ] then
		ply.keyPressed[ key ] = false
	end
	
--[[
	if input.IsButtonDown( key ) and !ply.keyPressed[ key ] then
		ply.keyPressed[ key ] = true
		
		net.Start( 'mw_skillcast_start' )
			net.WriteInt( ply.keyBinds[ key ], 4 )
		net.SendToServer( )
		
	elseif !input.IsButtonDown( key ) and ply.keyPressed[ key ] then
		ply.keyPressed[ key ] = false
		
		net.Start( 'mw_skillcast_finish' )
			net.WriteInt( ply.keyBinds[ key ], 4 )
		net.SendToServer( )
	end
--]]
end

function GM:SkillRenderables( ply )
	local classTab = ply:GetClassTables( )
	
	if ply.skillRender then
		if classTab.Skills[ ply.skillRender ] && classTab.Skills[ ply.skillRender ].Render then
			classTab.Skills[ ply.skillRender ].Render( ply )
		end
	end
end