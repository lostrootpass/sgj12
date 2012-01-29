require('object')
require('world')
require('state')
require('universe')
require('keyboard')

function love.load()
	love.graphics.setCaption('MUD: Multi-User Deathtrap')
	--love.graphics.setMode(800, 600, true)
	State.universe = Universe:new()
	State.universe.startingArea = "level/tom_room_start.tmx"
	State.universe.endingArea = "level/tom_room_end.tmx"
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

	if love.keyboard.isDown('escape') then
		love.event.push('q')
	end

	if Keyboard:isPressed("q") then
		State.debug = not State.debug
	end

	Keyboard:update(dtime)
end

function love.quit()
	--profiler.stop()
end
