require('entity')
require('image')
require('state')
require('laser')

LaserTurret = Entity:new()

function LaserTurret:init(x, y)
	self.type = "turret"
	self.graphic = Image:new('graphics/laser_turret.png', 32, 32)
end

function LaserTurret:fire(targetX, targetY)	
	State.world:add(Laser:new(self.x + 16, self.y + 16, targetX, targetY))
	love.audio.play(love.audio.newSource('audio/laser.wav'))
	
	State.player:die()
end

function LaserTurret:scanX(dx)
	local rayX = self.x + 16
	local rayY = self.y + 16
	
	while rayX > 0 and rayX < State.world.width do

		rayX = rayX + dx
		
		if State.world:blocked(rayX, rayY) then
			break
		end
	end
	local rayBox = Hitbox:new(rayX-1, rayY-1, self.x + 16 - rayX, 1)
	if(rayBox.width < 0) then
		rayBox.x = rayBox.x + rayBox.width
		rayBox.width = -rayBox.width
	end

	if State.player.hitbox:intersects(rayBox) and State.player.alive then		
		self:fire(rayX+1, rayY+1)
	end
end

function LaserTurret:scanY(dy)
	local rayX = self.x + 16
	local rayY = self.y + 16
	
	while rayY > 0 and rayY < State.world.height do
		rayY = rayY + dy		
		if State.world:blocked(rayX, rayY) then
			break
		end
	end
	
	local rayBox = Hitbox:new(rayX-1, rayY-1, 1, self.y + 16 - rayY)
	if(rayBox.height < 0) then
		rayBox.y = rayBox.y + rayBox.height
		rayBox.height = -rayBox.height
	end

	if State.player.hitbox:intersects(rayBox) and State.player.alive then	
		self:fire(rayX+1, rayY+1)
	end
end

function LaserTurret:update(dtime)
	self:scanX(32)
	self:scanX(-32)
	self:scanY(32)
	self:scanY(-32)
end
