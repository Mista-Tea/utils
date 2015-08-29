--[[--------------------------------------------------------------------------
	Utils Library
		
	Author:
		Mista-Tea ([IJWTB] Thomas)
		
	License:
		
	Changelog:
		- Created April 12th, 2014

----------------------------------------------------------------------------]]

--[[--------------------------------------------------------------------------
-- Namespace Tables
--------------------------------------------------------------------------]]--

utils = utils or {}

--[[--------------------------------------------------------------------------
-- Localized Functions & Variables
--------------------------------------------------------------------------]]--

local net  = net
local hook = hook
local file = file
local type = type
local pairs = pairs
local ipairs = ipairs
local assert = assert
local string = string
local player = player
local include = include
local tostring = tostring
local AddCSLuaFile = AddCSLuaFile

--[[--------------------------------------------------------------------------
-- Namespace Functions
--------------------------------------------------------------------------]]--

local flags = {
	include = include,
	client  = AddCSLuaFile,
	shared  = function( path ) include( path ) AddCSLuaFile( path ) end,
}

--[[--------------------------------------------------------------------------
--
-- 	utils.AddFiles( string, boolean, string )
--
--]]--
function utils.AddFiles( dir, flag, isRecursive )
	
	flag = ( flag and flag:lower() ) or "include"
	
	if ( isRecursive ) then

		utils.IncludeDirRecursive( dir, flag )
		
	else
		
		utils.IncludeDir( dir, flag )
		
	end

end

--[[--------------------------------------------------------------------------
--
-- 	utils.IncludeDir( string, int enum )
--
--]]--
function utils.IncludeDir( dir, flag )

	assert(  dir and type( dir ) == "string", "Directory must be a string folder path - given " .. tostring( dir ) )
	assert( flag and flags[ flag ],           "Flag was not a valid parameter - given "         .. tostring( flag ) )
	
	local files, folders = file.Find( dir .. "/*.lua", "LUA", "nameasc" )
	
	if ( #files == 0 ) then print( "utils.IncludeDir - '" .. dir .. "' folder was empty or does not exist" ) return end
	
	for _, filename in ipairs( files ) do
		
		local path = dir .. "/" .. filename
		flags[ flag ]( path )
		
	end

end

--[[--------------------------------------------------------------------------
--
-- 	utils.IncludeDirRecursive( string, int enum )
--
--]]--
function utils.IncludeDirRecursive( dir, flag )

	assert(  dir and type( dir ) == "string", "Directory must be a string folder path - given " .. tostring( dir ) )
	assert( flag and flags[ flag ],           "Flag was not a valid parameter - given "         .. tostring( flag ) )
	
	local files, folders = file.Find( dir .. "/*", "LUA", "nameasc" )

	local path = ""
	
	for _, filename in ipairs( files ) do

		path = dir .. "/" .. filename
		flags[ flag ]( path )
		
	end
	
	for _, folder in ipairs( folders ) do
	
		path = dir .. "/" .. folder
		IncludeDirRecursive( path, flag )
		
	end
	
end