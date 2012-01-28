require('entity')
require('sprite')

Sign = Entity:new()

function Sign:init()
	self.sprite = Sprite:new('assets/graphics/terminal.png', 32, 32)
end

function Sign:draw()
	self.sprite:draw()
end

function Sign:update(dtime)
	self.sprite:update(dtime)
end