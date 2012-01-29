require('object')
require('world')
require('state')
require('universe')
require('keyboard')

function love.load()
	love.graphics.setCaption('Ouroboros')
	State.universe = Universe:new()
	State.universe.startingArea = "level/max_level4.tmx"
	State.universe:generateLinks()
	State.universe:restart()

	Keyboard:registerKeys({"q"})
end

function love.draw()
	love.graphics.translate(0, 12)
	
	if State.world ~= nil then
		State.world:draw()
	end
end

function love.update(dtime)
	if State.world ~= nil then
		State.world:update(dtime)
	end

	if Keyboard:isPressed("q") then
		State.debug = not State.debug
	end

	Keyboard:update(dtime)
end
