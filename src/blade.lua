require('entity')
require('sprite')
--require('s

Blade = Entity:new()

function Blade:init()
	self.graphic = Sprite:new('graphics/blade.png', 32, 32)
	self.graphic:add("spin", {1, 2, 3}, 0.05)
	self.dir = 1
	self.speed = 100
end

function Blade:update(dtime)
	self.graphic:update(dtime)
	self.y = self.y + (self.speed * dtime * self.dir)
	
	if State.world:blocked(x, y) or State.world:blocked(x + self.hitbox.width, y) 
	or State.world:blocked(x, y + self.hitbox.height) or State.world:blocked(x + self.hitbox.width, y + self.hitbox.height) then
		self.dir = self.dir * -1
	end
	
	if self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) then
		State.player:die()
	end
end
