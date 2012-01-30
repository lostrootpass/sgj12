require('entity')
require('sprite')
require('hitbox')
require('sfx')

Blade = Entity:new()

function Blade:init()
	self.type = "blade"
	self.graphic = Sprite:new('graphics/blade.png', 32, 32)
	self.graphic:add("spin", {1, 2, 3}, 0.05)
	self.dir = 1
	self.speed = 100
	self.timer = 0
	self.hitbox = Hitbox:new(0, 0, 16, 31)
end

function Blade:update(dtime)
	self.graphic:update(dtime)
	self.timer = self.timer + dtime
	local py = self.y + (self.speed * dtime * self.dir)

	self.hitbox.x = self.x + 8
	self.hitbox.y = self.y

	if self.timer > .2 and (State.world:blocked(self.x, py) or State.world:blocked(self.x + self.hitbox.width, py)
	or State.world:blocked(self.x, py + self.hitbox.height) or State.world:blocked(self.x + self.hitbox.width, py + self.hitbox.height) ) then
		self.dir = self.dir * -1
		self.timer = 0
	else
		self.y = py
	end

	if State.player.alive and self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) then
		State.player:die("gibs")
		love.audio.play(Sfx.deathsaw)
	end
end
