require('entity')
require('sprite')
require('hitbox')
require('state')

Door = Entity:new()

function Door:init(dir, st)
	self.type = "door"
	self.state = st
	self.dir = dir
	
	local x = 0
	local y = 0
	
	if dir == "n" or dir == "s" then
		x = 64
		y = 32
	elseif dir =="e"  or dir == "w" then
		x = 32
		y = 64
	end
	
	self.graphic = Sprite:new('graphics/door_e.png', x, y)
	
	self.graphic:add("closed", {1})
	self.graphic:add("opening", {1, 2, 3})
	self.graphic:add("open", {3})
	
	self.is_pressed = false
	self.graphic:play("open")
	
	self.hitbox = Hitbox:new(self.x, self.y, x, y)
end

function Door:update(dtime)
	self.graphic:update(dtime)
	if self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) then --and self.state == "open" then
		State.player:changeRoom( self.dir )
	end
	
end