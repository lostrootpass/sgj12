require('entity')
require('sprite')

HiddenPit = Entity:new()

function HiddenPit:init()
	self.type = "hiddenpit"
	self.sprite = Sprite:new('graphics/pit.png', 32, 32)
	self.hitbox = Hitbox:new(0, 0, 32, 32)
	self.sprite:add("hidden", {1})
	self.sprite:add("visible", {2})
	self.sprite:play("hidden", 1)
	self.graphic = self.sprite
	self.scream = love.audio.newSource('audio/wilhelm.wav')
end

function HiddenPit:update(dtime)
	self.sprite.x = self.x
	self.sprite.y = self.y
	self.hitbox.x = self.x
	self.hitbox.y = self.y
	if State.player.alive and self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) then
		self.sprite:play("visible", 1)
		State.player:die()
		love.audio.play(self.scream)
	end
end
