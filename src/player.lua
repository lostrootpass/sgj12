require('entity')
require('sprite')
require('hitbox')
require('corpse')
require('deathtimer')

Player = Entity:new()

function Player:init()
	self.x = 400
	self.y = 300
	self.movementSpeed = 100
	self.spriteWidth = 32
	self.moving = false
	self.direction = 'down'
	
	self.name = "NAME NOT SET"
	self.bio = "BIO NOT SET"

	sprite = Sprite:new("graphics/contestant.png", 32,  32)
	sprite:add("stand_up", {1})
	sprite:add("walk_up", {2, 3, 4, 5}, 0.1)
	
	sprite:add("stand_down", {6})
	sprite:add("walk_down", {7, 8, 9, 10}, 0.1)
	
	sprite:add("stand_left", {11})
	sprite:add("walk_left", {12, 13, 14, 15}, 0.1)
	
	sprite:add("stand_right", {16})
	sprite:add("walk_right", {17, 18, 19, 20}, 0.1)
	
	sprite:play("stand_down")
	self.graphic = sprite
	
	self.hitbox = Hitbox:new(self.x + 8, self.y + 8, 16, 24)
	
	self.alive = true
	
	self.footsteps = love.audio.newSource('audio/footsteps.ogg')
end

function Player:setPosition(x, y)
	self.x = x
	self.y = y
	self.hitbox.x = x + 8
	self.hitbox.y = y + 8
end

function Player:update(dtime)
	self.moving = false
	
	if love.keyboard.isDown("up") then
		local nextY = self.y - (self.movementSpeed * dtime)
		
		if not self:checkCollisions(self.x + 8, nextY + 8) then
			self.y = nextY
			self.moving = true
			self.direction = 'up'
		end
	elseif love.keyboard.isDown("down") then
		
		local nextY = self.y + (self.movementSpeed * dtime)
		
		if not self:checkCollisions(self.x + 8, nextY + 8) then
			self.y = nextY
			self.moving = true
			self.direction = 'down'
		end
	end
	
	if love.keyboard.isDown("left") then
		local nextX = self.x - (self.movementSpeed * dtime)
		if not self:checkCollisions(nextX + 8, self.y + 8) then
			self.x = nextX
			self.moving = true
			self.direction = 'left'
		end
			
	elseif love.keyboard.isDown("right") then
		local nextX = self.x + (self.movementSpeed * dtime)
		if not self:checkCollisions(nextX + 8, self.y + 8) then
			self.x = nextX
			self.moving = true
			self.direction = 'right'
		end
	end
	
	if self.moving == true then
		sprite:play("walk_" .. self.direction)
	else
		sprite:play("stand_" .. self.direction)
	end
	
	self.hitbox.x = self.x + 8
	self.hitbox.y = self.y + 8
	self:checkOffScreen()
	
	--[[if self.moving and self.footsteps:isStopped() then 
		self.footsteps:play()
		self.footsteps:setLooping(true)
	elseif not self.moving then
		self.footsteps:stop()
	end]]--
	
	sprite:update(dtime)	
end

function Player:checkCollisions(x, y)
	for _, e in ipairs(State.world.entities) do
		if e.solid then
			if e.hitbox:intersects(Hitbox:new(x, y, self.hitbox.width, self.hitbox.height)) then
				return true
			end
		end
	end

	if State.world:blocked(x, y) or State.world:blocked(x + self.hitbox.width, y) or State.world:blocked(x, y + self.hitbox.height) or State.world:blocked(x + self.hitbox.width, y + self.hitbox.height)  then
		gx = math.floor(x / 32)+1
		gy = math.floor((y + self.hitbox.height) / 32)+1
		return true
	end
end

function Player:checkOffScreen()
	if self.x > State.world.width then
		self.x = 0
	elseif self.x < 0 then
		self.x = State.world.width
	end
	
	if self.y > State.world.height then
		self.y = 0
	elseif self.y < 0 then
		self.y = State.world.height
	end
end

function Player:getName()
	return self.name
end

function Player:setName(name)
	self.name = name
end

function Player:getBio()
	return self.bio
end

function Player:setBio(bio)
	self.bio = bio
end

function Player:die(animation)
	if not self.alive then return end
	
	animation = animation or ''
	print "Player has died..."
	self.alive = false
	State.world:remove(self)
	local corpse = Corpse:new(animation)
	corpse.x = self.x
	corpse.y = self.y
	State.world:add(corpse)
	self.footsteps:stop()
	
	State.world:add(DeathTimer:new())
end

function Player:changeRoom(newRoom)
	self.footsteps:stop()
	State.world:remove(self)
	print("player", State.world.name, newRoom)
	State.universe:moveToArea(State.universe:nextArea(State.world.name, newRoom), newRoom)
end
