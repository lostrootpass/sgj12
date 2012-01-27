require('entity')
require('sprite')

Player = Entity:new()

function Player:init()
	x = 400
	y = 300
	movementSpeed = 100
	spriteWidth = 32
	sprite = Sprite:new("assets/graphics/contestant.png", 32,  32)
	sprite:add("stand", {1})
	sprite:add("walk", {2, 3, 4, 5}, 0.1)
	sprite:play("stand")
end

function Player:draw()
	love.graphics.push()
		love.graphics.translate(x, y)
		sprite:draw()
	love.graphics.pop()
end

function Player:update(dtime)
	local moving = false
	
	if love.keyboard.isDown("up") then
		y = y - (movementSpeed * dtime)
		moving = true
	elseif love.keyboard.isDown("down") then
		y = y + (movementSpeed * dtime) 
		moving = true
	end
	
	if love.keyboard.isDown("left") then
		x = x - (movementSpeed * dtime)
		moving = true
	elseif love.keyboard.isDown("right") then
		x = x + (movementSpeed * dtime)
		moving = true
	end
	
	if moving == true then
		sprite:play("walk")
	else
		sprite:play("stand")
	end
	
	self.checkOffScreen()
	
	sprite:update(dtime)
end

function Player:checkOffScreen()
	if x > 800 then
		x = 0
	elseif x < 0 then
		x = 800
	end
	
	if y > 600 then
		y = 0
	elseif y < 0 then
		y = 600
	end
end