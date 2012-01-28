require('object')
require('state')

DeathTimer = Object:new()

function DeathTimer:init()
	self.time = 0
	self.respawnTime = 1.5
end

function DeathTimer:draw() end

function DeathTimer:update(dtime)
	if not self.alive then 
		self.time = self.time + dtime 
		if self.time > self.respawnTime then
			--State.director:restart()
			print("respawn")
			State.world:remove(self)
		end
	end
end
