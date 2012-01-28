require('entity')

Sprite = Object:new()

Sprite.x = 0
Sprite.y = 0
Sprite.time = 0
Sprite.frame = 1
Sprite.animation = ''
Sprite.frameWidth = 32
Sprite.frameHeight = 32
Sprite.loop = true

function Sprite:init(imageName, frameWidth, frameHeight)
	self.animations = {}
	self.image = love.graphics.newImage(imageName)
	self.frameWidth = frameWidth or 32
	self.frameHeight = frameHeight or 32	
end

function Sprite:add(animation, frames, frameTime)
	frameTime = frameTime or 1
	self.animations[animation] = {frames = {}, frameTime = frameTime}
	for i = 1, table.getn(frames) do
		
		local rowLength = self.image:getWidth() / self.frameWidth
		local fx = (frames[i]-1) % rowLength
		local fy = math.floor((frames[i]-1) / rowLength)
		
		table.insert(self.animations[animation].frames, love.graphics.newQuad(fx * self.frameWidth, fy * self.frameHeight, self.frameWidth, self.frameHeight, self.image:getWidth(), self.image:getHeight()))
	end
	
	if self.animation == "" then
		self.animation = animation
	end
end

function Sprite:draw()
	love.graphics.drawq(self.image, self.animations[self.animation].frames[self.frame], self.x, self.y)
end	

function Sprite:play(animation, loop)
	if loop == nil then loop = true end
	self.loop = loop
	
	if self.animation == animation then
		return
	end

	self.frame = 1
	self.animation = animation
end

function Sprite:update(dtime)
	self.time = self.time + dtime
	local animation = self.animations[self.animation]
	if(self.time >= animation.frameTime) then
		self.time = 0
		self.frame = self.frame + 1
		if self.frame > table.getn(animation.frames) then 
			if self.loop then
				self.frame = 1 
			else
				self.frame = table.getn(animation.frames)
			end
		end
	end
end
