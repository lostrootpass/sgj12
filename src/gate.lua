require('entity')
require('sprite')
require('hitbox')
require('state')

Gate = Entity:new()

function Gate:init(dir, i)
	self.type = "gate"
	self.state = "closed"
	self.id = i or 0
	self.solid = true
	
	local x = 0
	local y = 0

	if dir > 32 then
		x = 64
		y = 32
	else
		x = 32
		y = 64
	end

	if dir > 32 then
		self.graphic = Sprite:new('graphics/gate_h.png', 64, 32)
		self.hitbox = Hitbox:new(0, 0, 64, 32)
	else
		self.graphic = Sprite:new('graphics/gate_v.png', 32, 64)
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