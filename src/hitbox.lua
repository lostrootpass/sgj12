require('object')

Hitbox = Object:new()

function Hitbox:init(x, y, w, h)
	this.x = x
	this.y = y
	this.width = w
	this.height = h
end

function Hitbox:bottom()
	return this.y + this.h
end

function Hitbox:intersects(box)
	if self.x > box.right() then return false end
	if self.right() < box.x then return false end
	if self.y > box.bottom() then return false end
	if self.bottom() < box.y then return false end
	return true
end

function Hitbox:left()
	return this.x
end

function Hitbox:right()
	return this.x + this.width
end

function Hitbox:top()
	return this.y
end
