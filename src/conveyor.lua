require('entity')
require('sprite')
require('state')

Conveyor = Entity:new()

function Conveyor:init()
	self.type = "conveyor"
	self.graphic = Sprite:new('graphics/conveyor.png', 32, 32)
	self.graphic:add("go", {1, 2, 3, 4}, 0.1)
	self.direction = "n"
	self.hitbox = Hitbox:new(0, 0, 30, 30)
	self.timer = 0
end

function Conveyor:update(dtime)
	self.graphic:update(dtime)
	
	self.hitbox.x = self.x + 1
	self.hitbox.y = self.y + 1
	if self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) 
	or self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32)) then 
		self.timer = self.timer + dtime
		if self.timer > .1 then
			self.timer = 0
			if self.direction == "n" then
				State.player.y = self.y - State.player.hitbox.height
			elseif self.direction == "s" then
				State.player.y = self.y + self.hitbox.height
			elseif self.direction == "w" then
				State.player.x = self.x - State.player.hitbox.width
			elseif self.direction == "e" then
				State.player.x = self.x + self.hitbox.width
			end
		end
	end
end
