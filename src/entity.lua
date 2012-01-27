require('object')

Entity = Object:new()

function Entity:init()
	graphic = nil
	x = 0
	y = 0
end

function Entity:setGraphic(filepath)
	self.graphic = love.graphics.newImage(filepath)
end

function Entity:setPosition(x, y)
	self.x = x
	self.y = y
end

function Entity:draw()
	if self.graphic ~= nil then
		love.graphics.draw(self.graphic, self.x, self.y)
	end
end

function Entity:update(dtime)
end
