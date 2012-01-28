require('object')
require('state')
require('player')
require('tmap')
require('entity')
require('dialogue')

World = Object:new()

World.entities = {}

function World:init(tilemap)
	tilemap = tilemap or "level/test4.tmx"
	TiledMap_Load(tilemap)
	
	self.entities = {}
	
	if State.player == nil then
		State.player = Player:new()
		print(State.player)
	end

	self.dialogue = Dialogue:new()
	self.dialogue:setGraphic("graphics/dialogueBg.png")
	self.dialogue:setPosition(0, 300)
	self.dialogue:setTextPosition(40, 40)
	self.dialogue:setText("hello world")
	self.dialogue:setFont("fonts/verdana.ttf", 72)
	self.dialogue:setColor(0, 0, 0, 255)
	self.dialogue:setVisible(true)
end

function World:add(entity)
	table.insert(self.entities, entity)
end

function World:draw()
	TiledMap_DrawNearCam(432,332)
	for i = 1, table.getn(self.entities) do
		self.entities[i]:draw()
	end
	
	State.player:draw()

	if self.dialogue ~= nil then
		self.dialogue:draw()
	end
end

function World:update(dtime)
	for i = 1, table.getn(self.entities) do
		self.entities[i]:update(dtime)
	end
	
	State.player:update(dtime)
end

function World:remove(entity)
	for index=1, table.getn(self.entities) do
		if self.entities[index] == entity then
			table.insert(self.entities, index)
		end
	end
end
