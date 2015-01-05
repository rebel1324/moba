GM.Version = ' - dev'
GM.Name = 'Heroes of Battle ' .. GM.Version
GM.Author = 'LOL / Fristet'

TEAM_SPECTATOR = 0
TEAM_BLUE = 1
TEAM_RED = 2

team.SetUp( TEAM_SPECTATOR, '관전자', Color( 200, 200, 0 ) )
team.SetUp( TEAM_BLUE, '파랭이', Color( 0, 0, 200 ) )
team.SetUp( TEAM_RED, '빨갱이', Color( 200, 0, 0 ) )

GM.SpawnPoints = GM.SpawnPoints or { }

Classes = Classes or { }
States = States or { }
Buffs = Buffs or { }

Projectiles = Projectiles or { }
SProjectiles = SProjectiles or { }

STRUCTURE = STRUCTURE or { }
Structures = Structures or { }

local function ClassRegister( )
	local dir = GM.FolderName .. '/gamemode/scripts/base/classes/'
	
	for k, v in pairs( file.Find( dir .. '*.lua', 'LUA' ) ) do
		CLASS = { }
		
		if SERVER then
			AddCSLuaFile( dir .. v )
		end
		include( dir .. v )
		
		Classes[ k ] = CLASS
		
		CLASS = nil
	end
end

local function StateRegister( )
	local dir = GM.FolderName .. '/gamemode/scripts/base/states/'
	
	for k, v in pairs( file.Find( dir .. '*.lua', 'LUA' ) ) do
		STATE = { }
		
		if SERVER then
			AddCSLuaFile( dir .. v )
		end
		include( dir .. v )
		
		local str_sub = string.sub( v, 1, -5 )
		local str_upper = string.upper( str_sub )
		
		_G[ str_upper ] = k
		
		States[ k ] = STATE
		
		STATE = nil
	end
end

local function BuffRegister( )
	local dir = GM.FolderName .. '/gamemode/scripts/base/buffs/'
	
	for k, v in pairs( file.Find( dir .. '*.lua', 'LUA' ) ) do
		BUFF = { }
		
		if SERVER then
			AddCSLuaFile( dir .. v )
		end
		include( dir .. v )
		
		local str_sub = string.sub( v, 1, -5 )
		local str_upper = string.upper( str_sub )
		_G[ str_upper ] = k
		
		Buffs[ k ] = BUFF
		Buffs[ k ].ID = k
		
		BUFF = nil
	end
end

local function ProjectileRegister( )
	local dir = GM.FolderName .. '/entities/entities/projectiles/'
	
	for k, v in pairs( file.Find( dir .. '*.lua', 'LUA' ) ) do
		Projectile = { }
		
		if SERVER then
			AddCSLuaFile( dir .. v )
		end
		include( dir .. v )
		
		Projectiles[ k ] = Projectile
		
		local str_sub = string.sub( v, 1, -5 )
		SProjectiles[ str_sub ] = k
		
		Projectile = nil
	end
end

function GetProjectile( class )
	return Projectiles[ SProjectiles[ class ] ]
end

ClassRegister( )
StateRegister( )
BuffRegister( )

ProjectileRegister( )

function STRUCTURE:Add( map, class, pos, ang, teamid )
	local tab = { }
	tab.Map = map
	tab.Class = class
	tab.Pos = pos
	tab.Ang = ang
	tab.TeamID = teamid
	
	table.insert( Structures, tab )
end

function STRUCTURE:GetTable( )
	return Structures
end

--  Vec.z -70
STRUCTURE:Add( 'gm_construct', 'mw_structure_nexus', Vector( 472.001465, -1048.555786, -149.968750 ), Angle( 0, 0, 0 ), TEAM_BLUE )
STRUCTURE:Add( 'gm_construct', 'mw_structure_nexus', Vector( -1147.809692, 680.400452, -153.664246 ), Angle( 0, 0, 0 ), TEAM_RED )

STRUCTURE:Add( 'gm_construct', 'mw_spawnpoint', Vector( 597.832764, -1257.711548, -79.968750 ), Angle( 0, 0, 0 ), TEAM_BLUE )
STRUCTURE:Add( 'gm_construct', 'mw_spawnpoint', Vector( -1370.333252, 891.908936, -83.777908 ), Angle( 0, 0, 0 ), TEAM_RED )

local function LoadBaseLuaFiles( )
	local dir = GM.FolderName .. '/gamemode/scripts/base'
	
	for k, v in pairs( file.Find( dir .. '/sv_*', 'LUA' ) ) do
		if ( SERVER ) then
			include( 'base/' .. v )
		end
	end
	
	for k, v in pairs( file.Find( dir .. '/cl_*', 'LUA' ) ) do
		if ( SERVER ) then
			AddCSLuaFile( 'base/' .. v )
		else
			include( 'base/' .. v )
		end
	end
	
	for k, v in pairs( file.Find( dir .. '/sh_*', 'LUA' ) ) do
		if ( SERVER ) then
			AddCSLuaFile( 'base/' .. v )
		end
		include( 'base/' .. v)
	end
end
	
LoadBaseLuaFiles( )