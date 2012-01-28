require('object')
require('maploader')
require('state')

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
			local level = LevelData:new("level/" .. v)
			table.insert(self.levels, level)
		end
	end
end

function Director:restart()
	print("Restarting")
	self:loadLevelByName("test4.tmx")
end

function Director:loadLevelByName(name)
	for i, v in ipairs(self.levels) do
		if v.levelName == name then
			self:loadLevelFromData(v)
			return
		end
	end
end

function Director:loadLevelFromData(data)
	self.currentLevel = data
	State.world.map = self.currentLevel.levelMap
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
	
	for i, v in ipairs(self.levels) do
		if v.doors[entrance] and v.adjoiningLevels[entrance] == nil then
			v.adjoiningLevels[entrance] = self.currentLevel
			
			local door = v:getDoor(entrance)
			
			local x = 0
			local y = 0
			
			if entrance == "s" then
				x = door.x + 16
				y = door.y - 32
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
	print(name)
	self.levelName = name
	self.levelMap = nil
	self.implemented = false
	
	self.adjoiningLevels = { n = nil, s = nil, w = nil, e = nil }
	self.doors = {}
	
	self:loadLevel()
end

function LevelData:loadLevel()
	self.levelMap = MapLoader:new(self.levelName)
	
	local objects = self.levelMap:getMapObjects()
	
	for i, o in ipairs(objects) do
		if o.type == "door" then
			table.insert(self.doors, o.dir)
		end
	end
end

function LevelData:getDoor(dir)
	local objects = self.levelMap:getMapObjects()
	
	for i, o in ipairs(objects) do
		if o.type == "door" and o.dir == dir then
			return o
		end
	end
end