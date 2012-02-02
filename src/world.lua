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
require('sfx')

World = Object:new()

World.entities = {}

function depthSort(lhs, rhs)
	if rhs.layer == nil then return false end
	if lhs.layer == nil then return true end
	return lhs.layer < rhs.layer
end

function World:init(tilemap, background)
	tilemap = tilemap or "level/tom_room_menu.tmx"

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

	local music = ""
	if tilemap == "level/tom_room_menu.tmx" then
		self.bgm = Sfx.title
	else
		self.bgm = Sfx.ambience
	end
end

function World:add(entity)
	table.insert(self.entities, entity)
end

function World:draw()
	self.map:drawNearCam(432,332)
	table.sort(self.entities, depthSort)
	for i = 1, table.getn(self.entities) do
		self.entities[i]:draw()
	end

	Dialogue:draw()
end

function World:start()
	if self.bgm ~= Sfx.bgm then
		love.audio.stop()
		self.bgm:setVolume(0.20)
		self.bgm:play()
		self.bgm:setLooping(true)
		Sfx.bgm = self.bgm
	end
end

function World:update(dtime)

	if Keyboard:isPressed(" ") and Dialogue.visible then
		Dialogue:hide()
	end

	for i = 1, table.getn(self.entities) do
		if self.entities[i] ~= nil then
			self.entities[i]:update(dtime)
		end
	end

	Dialogue:update(dtime)

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

function World:getType(type)
	local ents = {}
	for _, e in ipairs(self.entities) do
		if e.type == type then
			table.insert(ents, e)
		end
	end
	return ents
end
