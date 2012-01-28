require('entity')
require('sprite')

Blade = Entity:new()

function Blade:init()
	self.graphic = Sprite:new('graphics/blade.png', 32, 32)
	self.graphic:add("spin", {1, 2, 3}, 0.05)
end

function Blade:update(dtime)
	self.graphic:update(dtime)
end
