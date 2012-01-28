require('entity')
require('sprite')
require('state')

Laser = Entity:new()

function Laser:init()
	self.sprite = Sprite:new('graphics/laser_turret.png', 32, 32)
end

function Laser:draw()
	self.sprite:draw()
end

function Laser:update(dtime)
	self.sprite:update(dtime)
end