require('entity')
require('sprite')
require('state')

Laser = Entity:new()

function Laser:init()
	self.graphic = Sprite:new('graphics/laser_turret.png', 32, 32)
end

function Laser:update(dtime)
	self.graphic:update(dtime)
end