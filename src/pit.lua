require('entity')
require('sprite')

Pit = Entity:new()

function Pit:init()
	self.sprite = Image:new('graphics/pit.png')
	self.hitbox = Hitbox:new(0, 0, 32, 32)
end

function Pit:draw()
	self.sprite:draw()
end

function Pit:update(dtime)
	self.sprite.x = self.x
	self.sprite.y = self.y
	self.hitbox.x = self.x
	self.hitbox.y = self.y
	if self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) then
		State.player:die()
	end
end