require('object')
require('world')
require('state')
require('director')

function love.load()
	love.graphics.setCaption('Ouroboros')
	d = Director:new()
	State.director = d
	d:loadAllLevels()
	d:restart()
	--State.world = World:new("level/test4.tmx")
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
