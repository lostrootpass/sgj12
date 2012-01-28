require('entity')
require('sprite')

Door = Entity:new()

function Door:init(dir, st)
	self.state = st or "closed"
	
	if dir == "n" then
		self.graphic = Sprite:new('graphics/door_n.png', 64, 32)
	elseif dir =="e" then
		self.graphic = Sprite:new('graphics/door_e.png', 32, 64)
	elseif dir == "s" then
		self.graphic = Sprite:new('graphics/door_s.png', 64, 32)
	else
		self.graphic = Sprite:new('graphics/door_w.png', 32, 64)
	end
	
	self.graphic:add("closed", {1})
	self.graphic:add("opening", {1, 2, 3})
	self.graphic:add("open", {3})
	
	self.is_pressed = false
	self.graphic:play(self.state)
end

function Door:update(dtime)
	self.graphic:update(dtime)
end