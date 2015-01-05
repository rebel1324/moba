local meta = FindMetaTable( "Entity" )
if ( !meta ) then return end

local min = Vector( -0.75, -0.75, -0.75 )
local max = Vector( 0.75, 0.75, 0.75 )
local trace = { mask = MASK_SHOT, mins = min, maxs = max }
function meta:BulletTrace( startposition, endposition, filter )
	trace.start = startposition
	trace.endpos = endposition
	trace.filter = filter
	
	return util.TraceHull( trace )
end

function meta:GiveDamage( dmg, attacker )
	local dmginfo = DamageInfo( )
	dmginfo:SetAttacker( attacker )
	dmginfo:SetInflictor( attacker )
	dmginfo:SetDamage( dmg )
	dmginfo:SetDamageForce( Vector( ) )
	dmginfo:SetDamageType( DMG_BULLET )
	
	self:TakeDamageInfo( dmginfo )
end