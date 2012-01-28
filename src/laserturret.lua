require('entity')
require('image')
require('state')
require('laser')

LaserTurret = Entity:new()

function LaserTurret:init(x, y)
	self.type = "turret"
	self.graphic = Image:new('graphics/laser_turret.png', 32, 32)
end

function LaserTurret:update(dtime)
	local rayX = self.x + 16
	local rayY = self.y + 16
	
	while rayX > 0 do
		rayX = rayX - 32
		
		if State.world:blocked(rayX, rayY) then
			break
		end
	end
	local leftRay = Hitbox:new(rayX-1, rayY-1, self.x + 16 - rayX, 1)

	if State.player.hitbox:intersects(leftRay) and State.player.alive then		
		State.world:add(Laser:new(self.x + 16, self.y + 16, rayX, rayY + 1))
		love.audio.play(love.audio.newSource('audio/laser.wav'))
		
		State.player:die()
	end
end
