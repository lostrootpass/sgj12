require('entity')
require('sprite')

Player = Entity:new()

function Player:init()
	x = 400
	y = 300
	movementSpeed = 10
	spriteWidth = 32
	sprite = Sprite:new("assets/graphics/player.png")
end

function Player:draw()
	sprite:draw()
end

function Player:update(dtime)
	if love.keyboard.isDown("up") then
		y = y - (movementSpeed * dtime)
	else if love.keyboard.isDown("down") then
		y = y + (movementSpeed * dtime) 
	end
	
	if love.keyboard.isDown("left") then
		x = x - (movementSpeed * dtime)
	else if love.keyboard.isDown("right") then
		x = x + (movementSpeed * dtime)
	end
	
	if love.keyboard.isDown("space") then
		#not now
	end
	
	sprite:update(dtime)
end