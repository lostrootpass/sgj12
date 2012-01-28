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
	
	self.width = 800
	self.height = 576

	Dialogue:setGraphic("graphics/dialogueBg.png")
	Dialogue:setPosition(0, 480)
	Dialogue:setTextPosition(40, 40)
	Dialogue:setFont("fonts/verdana.ttf", 16)
	Dialogue:setTextColor(255, 255, 255, 255)
	Dialogue:setVisible(false)

	if State.player == nil then
		State.player = Player:new()
		print(State.player)
	end

	Dialogue:show("Welcome")
end

function World:add(entity)
	table.insert(self.entities, entity)
end

function World:draw()
	TiledMap_DrawNearCam(432,332 - 12)
	for i = 1, table.getn(self.entities) do
		self.entities[i]:draw()
	end
	
	State.player:draw()

	Dialogue:draw()
end

function World:update(dtime)
	for i = 1, table.getn(self.entities) do
		self.entities[i]:update(dtime)
	end
	
	State.player:update(dtime)

	Dialogue:update(dtime)

	if love.keyboard.isDown("a") then
		Dialogue:hide()
	end
end

function World:remove(entity)
	for index=1, table.getn(self.entities) do
		if self.entities[index] == entity then
			table.insert(self.entities, index)
		end
	end
end
