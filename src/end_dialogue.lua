require('entity')
require('keyboard')
require('universe')

EndDialogue = Entity:new()

function EndDialogue:init()
	self.text = nil
	self.textX = 40
	self.textY = 40
	self.textColor = {255, 255, 255, 255}
	self.lines = {}
	self.line = 1
	self.font = love.graphics.newFont("fonts/verdana.ttf", 16)
	self:setGraphic("graphics/dialogueBg.png")
end

function EndDialogue:add(text)
	table.insert(self.lines, text)
end

function EndDialogue:nextLine()
	self.text = self.lines[self.line]
	self:setVisible(true)
	self.line = self.line + 1
	if self.line > #self.lines then
		--State.world:remove(self)
		State.universe:reboot()
	end
end

function EndDialogue:draw()
	Entity.draw(self)

	if self.visible then
		if self.text ~= nil then

			local r, g, b, a = love.graphics.getColor()
			love.graphics.setColor(self.textColor)
			love.graphics.printf(self.text, self.x + self.textX, self.y + self.textY, 760)
			love.graphics.setColor(r, g, b, a)

			if self.font ~= nil then
				love.graphics.setFont(font)
			end
		end
	end
end

function EndDialogue:update(dtime)
	if Keyboard:isPressed("return") then
		self:nextLine()
	end
end
