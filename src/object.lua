Object = {}
local mt = {}
Object.prototype = nil

mt.__index = function(table, key) 
	local value = rawget(table, key)
	if value ~= nil then
		return value
	elseif(rawget(table, 'prototype') ~= nil) then
		return rawget(table, 'prototype')[key]
	end
	return nil
end

setmetatable(Object, mt)

function Object:init()
end

function Object:new()
	local o = {}
	
	o.prototype = self	
	setmetatable(o, mt)
	o:init()
	return o
end
