require('entity')
require('sprite')
require('dialogue')

Sign = Entity:new()

function Sign:init()
	self.sprite = Image:new('graphics/sign.png')
	self.text = "This is a sign."
	self.hitbox = Hitbox:new(0, 32, 32, 32)
end

function Sign:draw()
	self.sprite:draw()
end

function Sign:update(dtime)
	self.sprite.x = self.x
	self.sprite.y = self.y
	self.hitbox.x = self.x
	self.hitbox.y = self.y + 32
	
	if love.keyboard.isDown(' ') then
		if self.hitbox:intersects(State.player.hitbox) then
			Dialogue:show(self.text)
		end
	end
end
