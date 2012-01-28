require('entity')
require('sprite')

Conveyor = Entity:new()

function Conveyor:init()
	self.type = "conveyor"
	self.graphic = Sprite:new('graphics/conveyor.png', 32, 32)
end

function Conveyor:update(dtime)
	self.graphic:update(dtime)
end
