require('object')

Image = Object:new()

function Image:init(image)
	self.image = love.graphics.newImage(image)
	self.x = 0
	self.y = 0
end	

function Image:draw()
	love.graphics.draw(self.image, self.x, self.y)
end
	
function Image:getWidth()
	return self.image:getWidth()
end

function Image:getHeight()
	return self.image:getHeight()
end
