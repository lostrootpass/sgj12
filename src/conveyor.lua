require('entity')
require('sprite')
require('state')

Conveyor = Entity:new()

function Conveyor:init(dir)
	self.type = "conveyor"
	--self.graphic = Sprite:new('graphics/conveyor.png', 32, 32)
	self.direction = dir
	self.hitbox = Hitbox:new(0, 0, 32, 32)
	self.timer = 0
	self.layer = Layers.FLOOR

	local x = 0
	local y = 0

	if dir == "n" or dir == "s" then
		x = 64
		y = 32
	elseif dir =="e"  or dir == "w" then
		x = 32
		y = 64
	end

	local speeds = {
		n = {0, -256},
		s = {0, 256},
		e = {256, 0},
		w = {-256, 0}
	}

	self.speed = speeds[dir]

	if dir == "n" then
		self.graphic = Sprite:new('graphics/conveyor_n.png', 32, 32)
		self.doorHitbox = Hitbox:new(0, 0, 64, 32)
	elseif dir =="e" then
		self.graphic = Sprite:new('graphics/conveyor_e.png', 32, 32)
		self.doorHitbox = Hitbox:new(0, 0, 32, 64)
	elseif dir == "s" then
		self.graphic = Sprite:new('graphics/conveyor_s.png', 32, 32)
		self.doorHitbox = Hitbox:new(0, 0, 64, 32)
	else
		self.graphic = Sprite:new('graphics/conveyor_w.png', 32, 32)
		self.doorHitbox = Hitbox:new(0, 0, 32, 64)
	end
	self.graphic:add("go", {4, 3, 2, 1}, 0.1)
end

function Conveyor:update(dtime)
	self.graphic:update(dtime)

	self.hitbox.x = self.x + 0
	self.hitbox.y = self.y + 0
end
