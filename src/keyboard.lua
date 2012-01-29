require('object')

Keyboard = Object:new()

Keyboard.previous = {}

function Keyboard:registerKeys(keys)
	for _, v in ipairs(keys) do
		Keyboard.previous[v] = love.keyboard.isDown(v)
	end
end

function Keyboard:isPressed(key)
	if love.keyboard.isDown(key) and not self.previous[key] then return true end
	return false
end

function Keyboard:update(dtime)
	for k, _ in pairs(self.previous) do
		self.previous[k] = love.keyboard.isDown(k)
	end
end