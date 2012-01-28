require('object')
require('state')
require('player')
require('tmap')
require('entity')
require('dialogue')

World = Object:new()

World.entities = {}

function World:init(tilemap)
	tilemap = tilemap or "tile1"
	
	self.entities = {}
	
	if State.player == nil then
		State.player = Player:new()
		print(State.player)
	end
	player = Entity:new()
	player:setGraphic("assets/graphics/tile.png")
	player:setPosition(100, 100)
	self:add(player)

	local hints = Dialogue:new()
	hints:setText("Hello World")
	hints:setGraphic("assets/graphics/dialogueBg.png")
	hints:setPosition(0, 400)
	hints:setVisible(false)
	self.dialogue = hints
end

function World:add(entity)
	table.insert(self.entities, entity)
end

function World:draw()
	for i = 1, table.getn(self.entities) do
		self.entities[i]:draw()
	end
	
	State.player:draw()
	self.dialogue:draw()
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
