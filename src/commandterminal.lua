require('entity')
require('sprite')

CommandTerminal = Entity:new()

function Button:init()
	self.type = "commandterminal"
	self.graphic = Sprite:new('graphics/command_terminal.png', 32, 32)
	self.graphic:add("off", {1})
	self.graphic:add("on", {2})
	self.is_pressed = false
	self.graphic:play("off")
	self.interactBox = Hitbox:new(0, 32, 32, 32)
	self.hitbox = Hitbox:new(8, 8, 16, 24)
	self.id = nil
	self.solid = true
end

function CommandTerminal:activate()
	
end	

function CommandTerminal:update(dtime)
	self.interactBox.x = self.x
	self.interactBox.y = self.y + 32
	
	self.hitbox.x = self.x + 8
	self.hitbox.y = self.y + 8
	
	self.graphic:update(dtime)
	if self.is_pressed then
		self.graphic:play("on")
	end
	
	if love.keyboard.isDown(' ') then
		if self.interactBox:intersects(State.player.hitbox) and not self.is_pressed then
			self.is_pressed = true
			love.audio.play(love.audio.newSource('audio/terminal.wav'))
			if self.id then
				self:activate()
			end
		end
	end
end
