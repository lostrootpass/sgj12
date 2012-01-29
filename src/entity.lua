require('object')
require('image')

Entity = Object:new()

function Entity:init()
	self.type = "generic"
	self.graphic = nil
	self.x = 0
	self.y = 0
	self.visible = true
	self.hitbox = nil
end

function Entity:setGraphic(filepath)
	self.graphic = Image:new(filepath)
end

function Entity:setPosition(x, y)
	self.x = x
	self.y = y
end

function Entity:getType()
	return self.type
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

			if State.debug then
				local r, g, b, a = love.graphics.getColor()
				love.graphics.setColor(0,255,0,255)
				love.graphics.rectangle("line", self.x, self.y, self.graphic:getWidth(), self.graphic:getHeight())
				love.graphics.setColor(r, g, b, a)
			end
		end
	end

	if State.debug and self.hitbox ~= nil then
		--print "debug"
		local r, g, b, a = love.graphics.getColor()
		love.graphics.setColor(255,0, 0, 255)
		love.graphics.rectangle("line", self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)
		love.graphics.setColor(r, g, b, a)
	end
end

function Entity:update(dtime)
end
