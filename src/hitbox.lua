require('object')

Hitbox = Object:new()

function Hitbox:init(x, y, w, h)
	self.x = x
	self.y = y
	self.width = w
	self.height = h
end

function Hitbox:bottom()
	return self.y + self.height
end

function Hitbox:intersects(box)
	if self.x > box:right() then return false end
	if self:right() < box.x then return false end
	if self.y > box:bottom() then return false end
	if self:bottom() < box.y then return false end
	return true
end

function Hitbox:pointIntersects(x, y)
	if self.x > x then return false end
	if self:right() < x  then return false end
	if self.y > y then return false end
	if self:bottom() < y then return false end
	return true
end

function Hitbox:left()
	return self.x
end

function Hitbox:right()
	return self.x + self.width
end

function Hitbox:top()
	return self.y
end
