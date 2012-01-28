require('entity')
require('sprite')
--require('s

Blade = Entity:new()

function Blade:init()
	self.graphic = Sprite:new('graphics/blade.png', 32, 32)
	self.graphic:add("spin", {1, 2, 3}, 0.05)
	self.dir = 1
	self.speed = 100
	self.timer = 0
	self.hitbox = Hitbox:new(0, 0, 32, 32)
end

function Blade:update(dtime)
	self.graphic:update(dtime)
	self.timer = self.timer + dtime
	self.y = self.y + (self.speed * dtime * self.dir)
	
	self.hitbox.x = self.x
	self.hitbox.y = self.y
	
	if self.timer > .2 and (State.world:blocked(self.x, self.y) or State.world:blocked(self.x + self.hitbox.width, self.y) 
	or State.world:blocked(self.x, self.y + self.hitbox.height) or State.world:blocked(self.x + self.hitbox.width, self.y + self.hitbox.height) ) then
		self.dir = self.dir * -1
		self.timer = 0
	end
	
	if self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) then
		State.player:die()
	end
end
