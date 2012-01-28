require('entity')
require('sprite')

Door = Entity:new()

function Door:init(dir, st)
	self.state = st
	
	if dir = "n" then
		self.sprite = Sprite:new('assets/graphics/door_n.png', 32, 64)
	elseif dir = "e" then
		self.sprite = Sprite:new('assets/graphics/door_e.png', 64, 32)
	elseif dir = "s" then
		self.sprite = Sprite:new('assets/graphics/door_s.png', 32, 64)
	elseif die = "w" then
		self.sprite = Sprite:new('assets/graphics/door_w.png', 64, 32)
	end
	
	self.sprite:add("closed", {1})
	self.sprite.add("opening", {1, 2, 3})
	self.sprite:add("open", {3})
	
	self.is_pressed = false
	self.play(st)
end

function Door:draw()
	self.sprite:draw()
end

function Door:update(dtime)
	self.sprite:update(dtime)
end