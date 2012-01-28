require('object')
require('state')
require('player')
require('tmap')
require('entity')
require('dialogue')
require('entloader')
require('playergen')
require('entloader')
require('laserturret')

require('sign')

World = Object:new()

World.entities = {}

function World:init(tilemap)
	tilemap = tilemap or "level/test4.tmx"
	TiledMap_Load(tilemap)
	
	self.entities = {}
	
	loadEntities(self, TiledMap_GetMapObjects())
	
	self.width = 800
	self.height = 576

	Dialogue:setGraphic("graphics/dialogueBg.png")
	Dialogue:setPosition(0, 470)
	Dialogue:setTextPosition(40, 40)
	Dialogue:setFont("fonts/verdana.ttf", 16)
	Dialogue:setTextColor(255, 255, 255, 255)
	Dialogue:setVisible(false)

	PlayerGen:newPlayer()

	if State.player == nil then
		State.player = Player:new()
		print(State.player)
	end
	
	love.audio.play(love.audio.newSource('audio/ambience02.ogg', 'stream'))
	local sign = Sign:new()
	sign.x = 320
	sign.y = 32
	self:add(sign)
	
	local turret = LaserTurret:new()
	turret.x = 320
	turret.y = 320
	self:add(turret)
	
end

function World:add(entity)
	table.insert(self.entities, entity)
end

function World:draw()
	love.graphics.translate(0, 12)
	TiledMap_DrawNearCam(432,332)
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
	
	if love.keyboard.isDown("z") then
		PlayerGen:newPlayer()
	end
end

function World:blocked(tx, ty)
	return TiledMap_GetMapTile(math.floor(tx / 32)+1, math.floor(ty / 32)+1, 1) ~= 0
end

function World:remove(entity)
	for index=1, table.getn(self.entities) do
		if self.entities[index] == entity then
			table.remove(self.entities, index)
		end
	end
end
