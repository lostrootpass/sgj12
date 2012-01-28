require('entity')
require('sprite')
require('tmap')

Player = Entity:new()

function Player:init()
	x = 400
	y = 300
	movementSpeed = 100
	spriteWidth = 16
	spriteHeight = 32
	sprite = Sprite:new("graphics/contestant.png", 32,  32)
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
		desiredY = y - (movementSpeed * dtime)
		local tile = TiledMap_GetMapTile(math.ceil(x/32)+1, math.floor((desiredY + 8)/32)+1, 1)
		
		if tile == 0 then
			y = desiredY
			moving = true
		else
			return
		end
	elseif love.keyboard.isDown("down") then
		desiredY = y + (movementSpeed * dtime)
		local tile = TiledMap_GetMapTile(math.ceil(x/32)+1, math.floor((desiredY + spriteHeight)/32)+1, 1)
		
		if tile == 0 then
			y = desiredY
			moving = true
		else
			return
		end
	end
	
	if love.keyboard.isDown("left") then
		desiredX = x - (movementSpeed * dtime)
		local tile = TiledMap_GetMapTile(math.floor((desiredX +16)/32)+1, math.ceil(y/32)+1, 1)
		local tile2 = TiledMap_GetMapTile(math.floor((desiredX + 16)/32)+1, math.floor(y/32)+1, 1)
		
		if tile == 0 and tile2 == 0 then
			x = desiredX
			moving = true
		else
			return
		end
	elseif love.keyboard.isDown("right") then
		desiredX = x + (movementSpeed * dtime)
		local tile = TiledMap_GetMapTile(math.floor((desiredX + spriteWidth + 8)/32)+1, math.floor(y/32)+1, 1)
		local tile2 = TiledMap_GetMapTile(math.floor((desiredX + spriteWidth + 8)/32)+1, math.ceil(y/32)+1, 1)
		
		if tile == 0 and tile2 == 0 then
			x = desiredX
			moving = true
		else
			return
		end
	end
	
	if love.keyboard.isDown(" ") then
		print("X: " .. x)
	end
	
	if moving == true then
		sprite:play("walk")
	else
		sprite:play("stand")
	end
	
	self.checkOffScreen()
	
	sprite:update(dtime)
end

function Player:checkCollisions()
	local tile = TiledMap_GetMapTile(math.floor(x/32), math.floor(y/32), 0)
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