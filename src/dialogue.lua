require('entity')

Dialogue = Entity:new()

function Dialogue:init()
	self.text = ""
	self.textX = 0
	self.textY = 0
	self.font = nil
	self.textColor = {255, 255, 255, 255}
end

function Dialogue:setText(text)
	self.text = text
end

function Dialogue:setTextPosition(x, y)
	self.textX = x
	self.textY = y
end

function Dialogue:setFont(filepath, size)
	self.font = love.graphics.newFont(filepath, size)
end

function Dialogue:setTextColor(r, g, b, a)
	self.textColor = {r, g, b, a}
end

function Dialogue:show(text)
	self:setText(text)
	self:setVisible(true)
end

function Dialogue:hide()
	self:setVisible(false)
end

function Dialogue:draw()
	Entity.draw(self)

	if self.visible then
		if self.text ~= nil then
			if self.font ~= nil then
				font = love.graphics.getFont()
				love.graphics.setFont(self.font)
			end

			r, g, b, a = love.graphics.getColor()
			love.graphics.setColor(self.textColor)
			love.graphics.print(self.text, self.x + self.textX, self.y + self.textY)
			love.graphics.setColor(r, g, b, a)

			if self.font ~= nil then
				love.graphics.setFont(font)
			end
		end
	end
end

function Dialogue:update(dtime)

end
