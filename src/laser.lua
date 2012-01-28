require('entity')
require('sprite')
require('state')
require('line')

Laser = Entity:new()

function Laser:init(x, y, targetX, targetY)
	self.line = Line:new(x, y, targetX, targetY)
	self.line.colour = {0xff, 0, 0}
	self.graphic = self.line
	self.time = 0
end

function Laser:update(dtime)
	self.time = self.time + dtime
	if self.time > 0.05 then
		State.world:remove(self)
	end
end
