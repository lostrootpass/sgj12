require('entity')
require('sprite')

HiddenPit = Entity:new()

function HiddenPit:init()
	self.type = "hiddenpit"
	self.sprite = Image:new('graphics/pit.png')
	self.hitbox = Hitbox:new(0, 0, 32, 32)
	self.visible = false
end

function HiddenPit:update(dtime)
	self.sprite.x = self.x
	self.sprite.y = self.y
	self.hitbox.x = self.x
	self.hitbox.y = self.y
	if self.hitbox:pointIntersects(State.player.x + (32 / 2), State.player.y + (32 / 2)) then
		self.visible = true
		State.player:die()
	end
end