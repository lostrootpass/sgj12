require('entity')
require('sprite')

Pit = Entity:new()

function Pit:init()
	self.type = "pit"
	self.sprite = Sprite:new('graphics/pit.png')
	self.hitbox = Hitbox:new(0, 0, 32, 32)
	self.sprite:add("visible", {2})
	self.sprite:play("visible", 1)
	self.graphic = self.sprite
end

function Pit:draw()
	self.sprite:draw()
end

function Pit:update(dtime)
	self.sprite.x = self.x
	self.sprite.y = self.y
	self.hitbox.x = self.x
	self.hitbox.y = self.y
	if State.player.alive and self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) then
		love.audio.play(Sfx.scream)
		State.player:die()
	end
end
