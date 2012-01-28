require('entity')
require('sprite')

Button = Entity:new()

function Button:init()
	self.sprite = Sprite:new('assets/graphics/terminal.png', 32, 32)
	self.sprite:add("off", {1})
	self.sprite:add("on", {2})
	self.is_pressed = false
	self.sprite:play("off")
end

function Button:draw()
	if self.is_pressed then
		self.sprite:play("on")
	end
	self.sprite:draw()
end

function Button:update(dtime)
	self.sprite:update(dtime)
end