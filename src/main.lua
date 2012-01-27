require('object')
require('world')
require('state')

function love.load()
	love.graphics.setCaption('Ouroboros')
	State.world = World:new("assets/level/test3.tmx")
end

function love.draw()
	State.world:draw()
end


function love.update(dtime)
	State.world:update(dtime)
end
