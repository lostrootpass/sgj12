require('object')

Entity = Object:new()

function Entity:init()
	self.graphic = nil
	self.x = 0
	self.y = 0
	self.visible = true
end

function Entity:setGraphic(filepath)
	self.graphic = love.graphics.newImage(filepath)
end

function Entity:setPosition(x, y)
	self.x = x
	self.y = y
end

function Entity:setVisible(isVisible)
	self.visible = isVisible or true
end

function Entity:draw()
	if self.visible then
		if self.graphic ~= nil then
			love.graphics.draw(self.graphic, self.x, self.y)
		end
	end
end

function Entity:update(dtime)
end
