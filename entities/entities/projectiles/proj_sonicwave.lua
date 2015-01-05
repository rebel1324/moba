function Projectile:OnCreate( proj )
end

function Projectile:OnClientsideCreate( proj )
	proj.Emitter = ParticleEmitter( proj.Pos )
end

function Projectile:OnRemove( proj )
end

function Projectile:OnClientsideRemove( proj )
end

function Projectile:OnUpdate( proj )
	MsgN( proj.OldPos:Distance( proj.Pos ) )
	
	if proj.OldPos:Distance( proj.Pos ) >= 500 then
		g_proj:Remove( proj.ID )
	end
end
			
function Projectile:OnClientsideUpdate( proj )
	local pos = proj.Pos
	local vel = proj.Vel
	local forward = proj.Ang:Forward( )
	
	local particle = proj.Emitter:Add( 'sprites/glow04_noz', pos + VectorRand( ) * 8 )
	particle:SetColor( 100, 150, 210 )
	particle:SetDieTime( 0.2 )
	particle:SetLifeTime( 0 )
	particle:SetStartSize( 50 )
	particle:SetEndSize( 0 )
	particle:SetStartAlpha( 255 )
	particle:SetEndAlpha( 0 )
	particle:SetAirResistance( 0 )
	
	local particle = proj.Emitter:Add( 'sprites/glow04_noz', pos )
	particle:SetColor( 100, 100, 210 )
	particle:SetDieTime( 0.5 )
	particle:SetLifeTime( 0 )
	particle:SetStartSize( 16 )
	particle:SetEndSize( 0 )
	particle:SetStartAlpha( 255 )
	particle:SetEndAlpha( 0 )
	particle:SetAirResistance( 0 )
end