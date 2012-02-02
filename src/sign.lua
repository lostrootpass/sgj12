require('entity')
require('sprite')
require('dialogue')

Sign = Entity:new()

function Sign:init()
	self.type = "sign"
	self.sprite = Image:new('graphics/sign.png')
	self.text = "This is a sign."
	self.hitbox = Hitbox:new(0, 32, 32, 32)
	self.showing = false
end

function Sign:draw()
	self.sprite:draw()
end

function Sign:update(dtime)
	self.sprite.x = self.x
	self.sprite.y = self.y
	self.hitbox.x = self.x
	self.hitbox.y = self.y + 32

	if self.hitbox:intersects(State.player.hitbox) then
		if not self.showing then
			Dialogue:show(self.text)
			self.showing = true
		end
	elseif self.showing then
		Dialogue:hide()
		self.showing = false
	end
end
