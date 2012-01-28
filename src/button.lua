require('entity')
require('sprite')

Button = Entity:new()

function Button:init()
	self.graphic = Sprite:new('graphics/terminal.png', 32, 32)
	self.graphic:add("off", {1})
	self.graphic:add("on", {2})
	self.is_pressed = false
	self.graphic:play("off")
end

function Button:update(dtime)
	self.graphic:update(dtime)
	if self.is_pressed then
		self.graphic:play("on")
	end
end