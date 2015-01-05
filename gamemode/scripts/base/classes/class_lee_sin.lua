CLASS.Name = '리 신'
CLASS.Model = 'models/player/breen.mdl'
CLASS.Health = 100
CLASS.Weapon = 'weapon_knife'
CLASS.Speed = 200
CLASS.Icon = '.png'
CLASS.PickSound = ''
CLASS.DeathSound = { }
CLASS.Passive = { }
CLASS.Skills = {
	{
		KeyBind = KEY_Q,
		Name = '',
		Cooldown = 1,
		Icon = '.png',
		
		Render = function( ply )
			local size = 512
			
			local pos = ply:GetPos( )
			local ang = ply:EyeAngles( )
			
			
			cam.Start3D2D( pos + ply:GetUp( ) * 0.1, Angle( 0, ang.y - 90, 0 ), 1 )
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( Material( 'hob/shape/square_1.png', 'smooth' ) )
				surface.DrawTexturedRect( -size / 32, -size, size / 16, size )
			cam.End3D2D( )
		end,
		
		OnCast = function( ply, skid )
		
			g_proj:Create( 'proj_sonicwave', ply, ply:GetPos( ) + ply:GetViewOffset( ) / 2, Angle( 0, 0, 0 ), ply:GetAimVector( ) * 1000 )
			
		end
	},
	
	{
		KeyBind = KEY_E,
		Name = '',
		Cooldown = 12,
		Icon = '.png',
		OnCast = function( ply, skid )
		end
	},
	
	{
		KeyBind = KEY_R,
		Name = '',
		CustomCooldown = true,
		Icon = '.png',
		OnCast = function( ply, skid )
		end
	},
	
	{
		KeyBind = KEY_T,
		Name = '',
		Cooldown = 35,
		Icon = '.png',
		OnCast = function( ply, skid )
		end
	}
}