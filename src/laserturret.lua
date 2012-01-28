require('entity')
require('image')
require('state')
require('laser')

LaserTurret = Entity:new()

function LaserTurret:init(x, y)
	self.type = "turret"
	self.graphic = Image:new('graphics/laser_turret.png', 32, 32)
	self.charge = 0
	self.chargeTime = 0.5
end

function LaserTurret:fire(targetX, targetY)	
	State.world:add(Laser:new(self.x + 16, self.y + 16, targetX, targetY))
	love.audio.play(love.audio.newSource('audio/laser.wav'))
	
	State.player:die()
end

function LaserTurret:scanX(dx, dtime)
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
		self.charging = true
		self.charge = self.charge + dtime
		if self.charge > self.chargeTime then
			self:fire(rayX+1, rayY+1)
		end
	end
end

function LaserTurret:scanY(dy, dtime)
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
		self.charging = true
		self.charge = self.charge + dtime
		if self.charge > self.chargeTime then
			self:fire(rayX+1, rayY+1)
		end
	end
end

function LaserTurret:update(dtime)
	self.charging = false
	self:scanX(32, dtime)
	self:scanX(-32, dtime)
	self:scanY(32, dtime)
	self:scanY(-32, dtime)
	if not self.charging then self.charge = 0 end
end
