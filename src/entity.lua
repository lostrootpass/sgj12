require('object')
require('image')

Entity = Object:new()

function Entity:init()
	self.graphic = nil
	self.x = 0
	self.y = 0
	self.visible = true
end

function Entity:setGraphic(filepath)
	self.graphic = Image:new(filepath)
end

function Entity:setPosition(x, y)
	self.x = x
	self.y = y
end

function Entity:setVisible(isVisible)
	if isVisible == nil then
		self.visible = true
	else
		self.visible = isVisible
	end
end

function Entity:draw()
	if self.visible then
		if self.graphic ~= nil then
			self.graphic.x = self.x
			self.graphic.y = self.y
			self.graphic:draw()
		end
	end
end

function Entity:update(dtime)
end
