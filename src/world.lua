require('object')
require('state')
require('player')
require('entity')
require('dialogue')
require('entloader')
require('playergen')
require('entloader')
require('maploader')
require('laserturret')
require('sign')

World = Object:new()

World.entities = {}

function World:init(tilemap)
	tilemap = tilemap or "level/Darren_Room1.tmx"
	
	self.name = tilemap
	self.map = MapLoader:new(tilemap)
	
	self.entities = {}
	self.deadpool = {}
	
	loadEntities(self, self.map:getMapObjects())
	
	self.width = 800
	self.height = 576

	Dialogue:setGraphic("graphics/dialogueBg.png")
	Dialogue:setPosition(0, 470)
	Dialogue:setTextPosition(40, 40)
	Dialogue:setFont("fonts/verdana.ttf", 16)
	Dialogue:setTextColor(255, 255, 255, 255)
	Dialogue:setVisible(false)

	PlayerGen:newPlayer()

	love.audio.play(love.audio.newSource('audio/ambience02.ogg', 'stream'))
end

function World:add(entity)
	table.insert(self.entities, entity)
end

function World:draw()
	love.graphics.translate(0, 12)
	self.map:drawNearCam(432,332)
	for i = 1, table.getn(self.entities) do
		self.entities[i]:draw()
	end

	Dialogue:draw()
end

function World:update(dtime)
	for i = 1, table.getn(self.entities) do
		if self.entities[i] ~= nil then
			self.entities[i]:update(dtime)
		end
	end
	
	Dialogue:update(dtime)

	if love.keyboard.isDown("a") then
		Dialogue:hide()
	end
	
	if love.keyboard.isDown("z") then
		PlayerGen:newPlayer()
	end
	
	for dead=1, table.getn(self.deadpool) do
		for index=1, table.getn(self.entities) do
			if self.entities[index] == self.deadpool[dead] then
				table.remove(self.entities, index)
			end
		end
	end
	self.deadpool = {}
end

function World:blocked(tx, ty)
	return self.map:getMapTile(math.floor(tx / 32)+1, math.floor(ty / 32)+1, 2) ~= 0
end

function World:remove(entity)
	table.insert(self.deadpool, entity)
end

function World:getDoors()
	local doors = {n = false, s = false, w = false, e = false}
	
	for i = 1, table.getn(self.entities) do
		if self.entities[i] ~= nil and self.entities[i].type == "door" then
			local dir = self.entities[i].dir
			doors[dir] = true
		end
	end 
	
	return doors
end
