require('entity')
require('sprite')

Sign = Entity:new()

function Sign:init()
	self.sprite = Sprite:new('graphics/conveyer.png', 32, 32)
	self.sprite:add("go", {1, 2, 3, 4})
end

function Sign:draw()
	self.sprite:draw()
end

function Sign:update(dtime)
	self.sprite:update(dtime)
end