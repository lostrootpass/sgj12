require('entity')
require('sprite')
require('hitbox')
require('state')

Gate = Entity:new()

function Gate:init(dir, i)
	self.type = "gate"
	self.state = "closed"
	self.id = nil or i
	self.solid = true
	
	local x = 0
	local y = 0
	
	if dir > 32 then
		self.dir = "n"
	else
		self.dir = "e"
	end

	if self.dir == "n" then
		x = 64
		y = 32
	elseif self.dir =="e" then
		x = 32
		y = 64
	end

	if self.dir == "n" then
		self.graphic = Sprite:new('graphics/door_n.png', 64, 32)
		self.hitbox = Hitbox:new(0, 0, 64, 32)
	elseif self.dir =="e" then
		self.graphic = Sprite:new('graphics/door_e.png', 32, 64)
		self.hitbox = Hitbox:new(0, 0, 32, 64)
	elseif self.dir == "s" then
		self.graphic = Sprite:new('graphics/door_s.png', 64, 32)
		self.hitbox = Hitbox:new(0, 0, 64, 32)
	else
		self.graphic = Sprite:new('graphics/door_w.png', 32, 64)
		self.hitbox = Hitbox:new(0, 0, 32, 64)
	end

	self.graphic:add("closed", {1})
	self.graphic:add("opening", {1, 2, 3}, 0.15)
	self.graphic:add("open", {3})

	self.graphic:play(self.state)
end


function Gate:activate()
	self:open()
end

function Gate:setPosition(x, y)
	self.x = x
	self.y = y
	
	self.hitbox.x = self.x
	self.hitbox.y = self.y
end

function Gate:open()
	self.state = "open"
	self.graphic:play("opening", true)
	self.solid = false
end

function Gate:update(dtime)
	self.hitbox.x = self.x
	self.hitbox.y = self.y

	--[[
	if self.state == "closed" and self.hitbox ~= nil and self.hitbox:intersects(State.player.hitbox) then
		self.graphic:play("opening", true)
	end
	]]
	self.graphic:update(dtime)
	
end