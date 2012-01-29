require('entity')
require('sprite')
require('state')

Conveyor = Entity:new()

function Conveyor:init(dir)
	self.type = "conveyor"
	--self.graphic = Sprite:new('graphics/conveyor.png', 32, 32)
	self.direction = dir
	self.hitbox = Hitbox:new(0, 0, 32, 32)
	self.timer = 0
	
	local x = 0
	local y = 0

	if dir == "n" or dir == "s" then
		x = 64
		y = 32
	elseif dir =="e"  or dir == "w" then
		x = 32
		y = 64
	end

	if dir == "n" then
		self.graphic = Sprite:new('graphics/conveyor_n.png', 32, 32)
		self.doorHitbox = Hitbox:new(0, 0, 64, 32)
	elseif dir =="e" then
		self.graphic = Sprite:new('graphics/conveyor_e.png', 32, 32)
		self.doorHitbox = Hitbox:new(0, 0, 32, 64)
	elseif dir == "s" then
		self.graphic = Sprite:new('graphics/conveyor_s.png', 32, 32)
		self.doorHitbox = Hitbox:new(0, 0, 64, 32)
	else
		self.graphic = Sprite:new('graphics/conveyor_w.png', 32, 32)
		self.doorHitbox = Hitbox:new(0, 0, 32, 64)
	end
	self.graphic:add("go", {4, 3, 2, 1}, 0.1)
end

function Conveyor:update(dtime)
	self.graphic:update(dtime)
	
	self.hitbox.x = self.x + 2
	self.hitbox.y = self.y + 2
	if self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) 
	or self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32)) then 
		self.timer = self.timer + dtime
		if self.timer > .1 then
			self.timer = 0
			if self.direction == "n" then
				State.player.x = self.hitbox.x
				State.player.y = self.hitbox.y - State.player.hitbox.height
			elseif self.direction == "s" then
				State.player.x = self.hitbox.x
				State.player.y = self.hitbox.y + self.hitbox.height
			elseif self.direction == "w" then
				State.player.y = self.hitbox.y
				State.player.x = self.hitbox.x - State.player.hitbox.width
			elseif self.direction == "e" then
				State.player.y = self.hitbox.y
				State.player.x = self.hitbox.x + self.hitbox.width
			end
		end
	end
end
