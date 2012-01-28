require('entity')
require('sprite')
require('state')

Conveyor = Entity:new()

function Conveyor:init()
	self.type = "conveyor"
	self.graphic = Sprite:new('graphics/conveyor.png', 32, 32)
	self.graphic.add("go", {1, 2, 3, 4})
	self.direction = "n"
	self.hitbox = new Hitbox(0, 0, 32, 32)
end

function Conveyor:update(dtime)
	self.graphic:update(dtime)
	if self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) then
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
