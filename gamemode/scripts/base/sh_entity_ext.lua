local meta = FindMetaTable( 'Entity' )
if ( !meta ) then return end

function InBox( pos, mins, maxs )
	if
	( pos.x >= mins.x && pos.x <= maxs.x ) &&
	( pos.y >= mins.y && pos.y <= maxs.y ) &&
	( pos.z >= mins.z && pos.z <= maxs.z )
	then
		return true
	end
	
	return false
end

function meta:FindInBox( mins, maxs )
	local tab = { }
	
	for k, v in pairs( player.GetAll( ) ) do
		if v == self:GetOwner( ) then continue end
		
		local W = v:LocalToWorld( self:OBBCenter( ) )
		local L = self:WorldToLocal( W )
		if InBox( L, mins, maxs ) then
			tab[ k ] = v
		end
		
	end
	
	return tab
end