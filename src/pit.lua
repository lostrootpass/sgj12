require('entity')
require('sprite')

Pit = Entity:new()

function Pit:init()
	self.sprite = Sprite:new('graphics/pit.png', 32, 32)
end

function Pit:draw()
	self.sprite:draw()
end

function Pit:update(dtime)
	self.sprite:update(dtime)
end