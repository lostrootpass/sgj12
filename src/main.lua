require('object')
require('world')
require('state')
require('universe')

function love.load()
	love.graphics.setCaption('Ouroboros')
	State.universe = Universe:new()
	
	State.universe:link("level/max_level4.tmx", "level/Darren_Room1.tmx", "s")
	State.universe:link("level/Darren_Room1.tmx", "level/max_level4.tmx", "n")
	
	State.world = State.universe:loadArea("level/max_level4.tmx")	
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
