require('entity')
require('sprite')
require('hitbox')
require('state')

Door = Entity:new()

function Door:init(dir, st)
	self.type = "door"
	self.state = st or "closed"
	self.dir = dir
	self.switchOffsetX = 0
	self.switchOffsetY = 0
	self.id = nil

	local x = 0
	local y = 0

	if dir == "n" or dir == "s" then
		x = 64
		y = 32
	elseif dir =="e"  or dir == "w" then
		x = 32
		y = 64
	end

	if dir == "n" then
		self.graphic = Sprite:new('graphics/door_n.png', 64, 32)
		self.doorHitbox = Hitbox:new(0, 0, 64, 32)
		self.switchHitbox = Hitbox:new(0, 32, 64, 32)
		self.switchOffsetY = 32
	elseif dir =="e" then
		self.graphic = Sprite:new('graphics/door_e.png', 32, 64)
		self.doorHitbox = Hitbox:new(0, 0, 32, 64)
		self.switchHitbox = Hitbox:new(-32, 0, 32, 64)
		self.switchOffsetX = -32
	elseif dir == "s" then
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


function Door:activate()
	self:open()
end

function Door:setPosition(x, y)
	self.x = x
	self.y = y
	
	self.hitbox = Hitbox:new(self.x, self.y, x, y)
end

function Door:open()
	self.state = "open"
end

function Door:update(dtime)
	self.doorHitbox.x = self.x
	self.doorHitbox.y = self.y
	self.switchHitbox.x = self.x + self.switchOffsetX
	self.switchHitbox.y = self.y + self.switchOffsetY

	if self.state == "closed" and self.switchHitbox ~= nil and self.switchHitbox:intersects(State.player.hitbox) then
		self.graphic:play("opening", true)
	end

	if self.doorHitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) then--and self.state == "open" then
		State.player:changeRoom( self.dir )
	end

	self.graphic:update(dtime)
end
