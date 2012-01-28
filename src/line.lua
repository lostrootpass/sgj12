require('object')

Line = Object:new()

function Line:init(x0, y0, x1, y1)
	self.x0 = x0
	self.y0 = y0
	self.x1 = x1
	self.y1 = y1
	
	self.colour = {0xff, 0xff, 0xff, 0xff}
end

function Line:draw()
	love.graphics.setColor(self.colour)
	love.graphics.line(self.x0, self.y0, self.x1, self.y1)
	love.graphics.setColor({0xff, 0xff, 0xff, 0xff})
end
