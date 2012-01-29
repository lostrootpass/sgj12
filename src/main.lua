require('object')
require('world')
require('state')
require('universe')

function love.load()
	love.graphics.setCaption('Ouroboros')
	State.universe = Universe:new()
	State.universe.startingArea = "level/tom_room_start.tmx"
	State.universe.endingArea = "level/tom_room_end.tmx"
	State.universe:generateLinks()
	State.universe:restart()
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
end
