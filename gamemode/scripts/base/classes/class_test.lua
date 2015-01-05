CLASS.Name = '테스트'
CLASS.Model = 'models/player/breen.mdl'
CLASS.Health = 100
CLASS.Weapon = 'weapon_knife'
CLASS.Speed = 200
CLASS.Icon = 'test.png'
CLASS.PickSound = ''
CLASS.DeathSound = { }
CLASS.Passive = { }
CLASS.Skills = {
	{
		KeyBind = KEY_Q,
		Name = '스턴',
		CustomCooldown = true,
		Icon = 'aniserver/classes/assassin/q_skill.png',
		OnCast = function( ply, skid )
			local ent = ents.Create( 'mw_test' )
			ent:SetOwner( ply )
			ent:SetPos( ply:GetShootPos( ) )
			ent:SetAngles( ply:GetAimVector( ):Angle( ) )
			ent:Spawn( )
			
			local mins = -Vector( 16, 16, 64 )
			local maxs = Vector( 200, 16, 64 )
			local find = ent:FindInBox( mins, maxs )
			
			for k, v in pairs( find ) do
				v:Kill( )
			end
			
			ent:Remove( )
		end
	},
	
	{
		KeyBind = KEY_E,
		Name = '유체화',
		Cooldown = 12,
		Icon = 'aniserver/classes/assassin/e_skill.png',
		OnCast = function( ply, skid )
			ply:GiveBuff( BUFF_ASSASSIN_SPEED, 5 )
		end
	},
	
	{
		KeyBind = KEY_R,
		Name = '대쉬 / 백 대쉬',
		CustomCooldown = true,
		Icon_Sub = function( ply, skid )
			if ply:HasBuff( BUFF_ASSASSIN_DASH ) then
				surface.SetMaterial( Material( 'aniserver/classes/assassin/backdash.png', 'smooth' ) )
			else
				surface.SetMaterial( Material( 'aniserver/classes/assassin/dash.png', 'smooth' ) )
			end
		end,
		OnCast = function( ply, skid )
			if !ply:HasBuff( BUFF_ASSASSIN_DASH ) then
				ply:GiveBuff( BUFF_ASSASSIN_DASH, 5, skid )
				ply:SetState( STATE_ASSASSIN_DASH, 0.25 )
			else
				ply:RemoveBuff( BUFF_ASSASSIN_DASH )
				ply:GiveBuff( BUFF_ASSASSIN_BACKDASH )
				ply:SetState( STATE_ASSASSIN_BACKDASH, 0.25 )
			end
		end
	},
	
	{
		KeyBind = KEY_T,
		Name = '투명',
		Cooldown = 35,
		Icon = 'aniserver/classes/assassin/clock.png',
		OnCast = function( ply, skid )
			ply:GiveBuff( BUFF_ASSASSIN_INVISIBLE, 10 )
		end
	}
}