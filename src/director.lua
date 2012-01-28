require('object')
require('maploader')
require('state')
require('world')

Director = Object:new()

function Director:init()
	self.levels = {}
	self.currentLevel = {}
end

function Director:loadAllLevels()
	local lfs = love.filesystem
	local filetable = lfs.enumerate("level")
	
	for i, v in ipairs(filetable) do
		if string.sub(v, -1, -1) ~= "~" then
			if string.sub(v, 1, 7) ~= "forrest" then
				local level = LevelData:new("level/" .. v)
				table.insert(self.levels, level)
			end
		end
	end
end

function Director:restart()
	print("Restarting")
	self:loadLevelByName("max_level4.tmx")
	--State.world = World:new(self.currentLevel.levelMap)
end

function Director:loadLevelByName(name)
	for i, v in ipairs(self.levels) do
		if v.levelName == "level/" .. name then
			self:loadLevelFromData(v)
			return
		end
	end
end

function Director:loadLevelFromData(data)
	self.currentLevel = data
	State.world = World:new(self.currentLevel.levelMap)
	State.world:add(State.player)
end

function Director:loadNextLevel(lastExit)
	if self.currentLevel.adjoiningLevels[lastExit] ~= nil then
		self:loadLevelFromData(self.currentLevel.adjoiningLevels[lastExit])
		return
	end
	
	local entrance
	
	if lastExit == "n" then
		entrance = "s"
	elseif lastExit == "s" then
		entrance = "n"
	elseif lastExit == "e" then
		entrance = "w"
	elseif lastExit == "w" then
		entrance = "e"
	end
	
	self.levels = shuffle(self.levels)
	for i, v in ipairs(self.levels) do
		if v.doors[entrance] and v.adjoiningLevels[entrance] == nil then
			v.adjoiningLevels[entrance] = self.currentLevel
			
			local door = v.doors[entrance]
			
			local x = 0
			local y = 0
			
			if entrance == "s" then
				x = door.x + 16
				y = door.y - 48
			elseif entrance == "n" then
				x = door.x + 16
				y = door.y + 32
			elseif entrance == "w" then
				x = door.x + 32
				y = door.y + 16
			elseif entrance == "e" then
				x = door.x - 32
				y = door.y + 16
			end
			
			State.player:setPosition(x, y)
			
			self:loadLevelFromData(v)
		end
	end
end

LevelData = Object:new()

function LevelData:init(name)
	--print(name)
	self.levelName = name
	self.levelMap = MapLoader:new(self.levelName)
	self.implemented = false
	
	self.adjoiningLevels = { n = nil, s = nil, w = nil, e = nil }
	self.doors = { n = nil, s = nil, w = nil, e = nil}
	
	self:loadLevel()
end

function LevelData:loadLevel()
	--self.levelMap = MapLoader:new(self.levelName)
	
	local objects = self.levelMap:getMapObjects()
	
	for i, o in ipairs(objects) do
		if o.t == "door" then
			local d
			if o.y <= 64 then
				d = "n"
			elseif o.y >= 576-64 then --world.height - 64 then
				d = "s"
			elseif o.x <= 64 then
				d = "w"
			else
				d = "e"
			end
		
			self.doors[d] = o
			print(d)
		end
	end
end

function LevelData:getDoor(dir)
	local objects = self.levelMap:getMapObjects()
	
	for i, o in ipairs(objects) do
		if o.type == "door" then
			if o.y <= 64 and dir == "n" then
				return o
			elseif o.y >= 576-64 and dir == "s" then --world.height - 64 then
				return o
			elseif o.x <= 64 and dir == "w" then
				return o
			else if o.x > 776-64 and dir == "e" then
				return o
			end
		end
	end
	end
end

function shuffle(t)
	local n = #t
	
	while n >= 2 do
		local k = math.random(n)
		t[n], t[k] = t[k], t[n]
		n = n - 1
	end
	
	return t
end