require('entity')
require('sprite')

Sign = Entity:new()

function Sign:init()
	self.sprite = Sprite:new('assets/graphics/terminal.png', 32, 32)
	self.sprite:add("off", {1})
	self.sprite:add("on", {2})
	self.is_pressed = false
	self.play("off")
end

function Sign:draw()
	if self.is_pressed then
		self.play("on")
	end
	self.sprite:draw()
end

function Sign:update(dtime)
	self.sprite:update(dtime)
end