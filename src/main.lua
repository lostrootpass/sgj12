require('object')
require('world')
require('state')

function love.load()
	love.graphics.setCaption('Ouroboros')
	State.world = World:new("level/max_level4.tmx")
end

function love.draw()
	State.world:draw()
end

function love.update(dtime)
	State.world:update(dtime)
end
