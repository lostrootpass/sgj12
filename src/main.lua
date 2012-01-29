require('object')
require('world')
require('state')
require('universe')
--require('profiler')

function love.load()
	love.graphics.setCaption('Ouroboros')
	State.universe = Universe:new()
	State.universe.startingArea = "level/tom_room_start.tmx"
	State.universe.endingArea = "level/tom_room_end.tmx"
	State.universe:generateLinks()
	State.universe:restart()
	
	--profiler.start()
end

function love.draw()
	
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
end

function love.quit()
	--profiler.stop()
end
