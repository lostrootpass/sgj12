require('entity')

Corpse = Entity:new()

function Corpse:init()
	self.graphic = Sprite:new("graphics/ash.png", 32, 32)
	self.graphic:add("collapse", {1, 2, 3, 4, 5, 6}, 0.1)
	self.graphic:play("collapse", false)
end

function Corpse:update(dtime)
	self.graphic:update(dtime)
end
