require('entity')
require('sprite')

Button = Entity:new()

function Button:init()
	self.type = "button"
	self.graphic = Sprite:new('graphics/terminal.png', 32, 32)
	self.graphic:add("off", {1})
	self.graphic:add("on", {2})
	self.is_pressed = false
	self.graphic:play("off")
	self.hitbox = Hitbox:new(0, 32, 32, 32)
	self.id = nil
end

function Button:broadcast(id)
	for _, e in ipairs(State.world.entities) do
		if e.id == id then
			e.activate()
		end
	end
end	

function Button:update(dtime)
	self.hitbox.x = self.x
	self.hitbox.y = self.y + 32
	
	self.graphic:update(dtime)
	if self.is_pressed then
		self.graphic:play("on")
	end
	
	if love.keyboard.isDown(' ') then
		if self.hitbox:intersects(State.player.hitbox) then
			self.is_pressed = true
			if self.id then
				self:broadcast(self.id)
			end
		end
	end
end
