require('entity')
require('sprite')
require('hitbox')
require('state')

Gate = Entity:new()

function Gate:init(dir)
	self.type = "gate"
	self.state = "closed"
	self.switchOffsetX = 0
	self.switchOffsetY = 0
	self.id = nil
	
	if dir > 32 then
		self.dir = "n"
	end

	local x = 0
	local y = 0

	if self.dir == "n" then
		x = 64
		y = 32
	elseif self.dir =="e" then
		x = 32
		y = 64
	end

	if self.dir == "n" then
		self.graphic = Sprite:new('graphics/door_n.png', 64, 32)
		self.doorHitbox = Hitbox:new(0, 0, 64, 32)
		self.switchHitbox = Hitbox:new(0, 32, 64, 32)
		self.switchOffsetY = 32
	elseif self.dir =="e" then
		self.graphic = Sprite:new('graphics/door_e.png', 32, 64)
		self.doorHitbox = Hitbox:new(0, 0, 32, 64)
		self.switchHitbox = Hitbox:new(-32, 0, 32, 64)
		self.switchOffsetX = -32
	elseif self.dir == "s" then
		self.graphic = Sprite:new('graphics/door_s.png', 64, 32)
		self.doorHitbox = Hitbox:new(0, 0, 64, 32)
		self.switchHitbox = Hitbox:new(0, -32, 64, 32)
		self.switchOffsetY = -32
	else
		self.graphic = Sprite:new('graphics/door_w.png', 32, 64)
		self.doorHitbox = Hitbox:new(0, 0, 32, 64)
		self.switchHitbox = Hitbox:new(32, 0, 32, 64)
		self.switchOffsetX = 32
	end

	self.graphic:add("closed", {1})
	self.graphic:add("opening", {1, 2, 3}, 0.15)
	self.graphic:add("open", {3})

	self.is_pressed = false
	self.graphic:play(self.state)
end


function Gate:activate()
	self:open()
end

function Gate:setPosition(x, y)
	self.x = x
	self.y = y
	
	self.hitbox = Hitbox:new(self.x, self.y, x, y)
end

function Gate:open()
	self.state = "open"
end

function Gate:update(dtime)
	self.doorHitbox.x = self.x
	self.doorHitbox.y = self.y
	self.switchHitbox.x = self.x + self.switchOffsetX
	self.switchHitbox.y = self.y + self.switchOffsetY

	if self.state == "closed" and self.switchHitbox ~= nil and self.switchHitbox:intersects(State.player.hitbox) then
		self.graphic:play("opening", true)
	end
	self.graphic:update(dtime)
	
end