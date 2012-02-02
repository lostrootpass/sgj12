require('entity')
require('layers')

Corpse = Entity:new()

function Corpse:init(animation)
	if animation == "ash" then
		self.graphic = Sprite:new("graphics/ash.png", 32, 32)
		self.graphic:add("collapse", {1, 2, 3, 4, 5, 6}, 0.1)
		self.graphic:play("collapse", true)

	elseif animation == "gibs" then
		self.graphic = Sprite:new("graphics/gibs.png", 32, 32)
		self.graphic:add("collapse", {1, 2, 3, 4}, 0.1)
		self.graphic:play("collapse", true)
	end
	self.layer = Layers.FLOOR
end

function Corpse:update(dtime)
	if self.graphic ~= nil then self.graphic:update(dtime) end
end
