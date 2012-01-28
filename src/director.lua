require('object')

Director = Object:new()

function Director:init()
	self.levels = {}
end

function Director:loadAllLevels()
	
end

function Director:loadLevel(name)

end


LevelData = Object:new()

function LevelData:init()
	self.levelName = nil
	self.northLevel = nil
	self.southLevel = nil
	self.westLevel = nil
	self.eastLevel = nil
end