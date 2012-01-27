require('entity')

Sprite = Object:new()

Sprite.x = 0
Sprite.y = 0
Sprite.time = 0
Sprite.frame = 1
Sprite.animation = ''
Sprite.animations = {}
Sprite.frameWidth = 32
Sprite.frameHeight = 32

function Sprite:init(imageName, frameWidth, frameHeight)
print(imageName)
	self.image = love.graphics.newImage(imageName)
end

function Sprite:add(animation, frames, frameTime)
	frameTime = frameTime or 1
	self.animations[animation] = {frames = {}, frameTime = frameTime}
	for i = 1, table.getn(frames) do
		local x = self.frameWidth * (frames[i]-1)
		table.insert(self.animations[animation].frames, love.graphics.newQuad(x, 0, self.frameWidth, self.frameHeight, self.image:getWidth(), self.image:getHeight()))
	end
	
	if self.animation == "" then
		self.animation = animation
	end
end

function Sprite:draw()
	love.graphics.drawq(self.image, self.animations[self.animation].frames[self.frame], self.x, self.y)
end	

function Sprite:play(animation)
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
		if self.frame > table.getn(animation.frames) then self.frame = 1 end
	end
end
