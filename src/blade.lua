require('entity')
require('sprite')

Blade = Entity:new()

function Blade:init()
	self.sprite = Sprite:new('graphics/blade.png', 32, 32)
	self.sprite:add("spin", {1, 2, 3}, 0.05)
end

function Blade:draw()
	self.sprite:draw()
end

function Blade:update(dtime)
	self.sprite:update(dtime)
end
