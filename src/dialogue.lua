require('entity')

Dialogue = Entity:new()

function Dialogue:init()
	self.text = ""
	self.textX = 0
	self.textY = 0
end

function Dialogue:setText(text)
	self.text = text
end

function Dialogue:setTextPosition(x, y)
	self.textX = x
	self.textY = y
end

function Dialogue:draw()
	Entity.draw(self)

	if self.visible then
		if self.text ~= nil then
			love.graphics.print(self.text, self.x + self.textX, self.y + self.textY)
		end
	end
end

function Dialogue:update(dtime)

end
