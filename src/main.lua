require('object')
require('world')

world = World:new()

function love.load()
	love.graphics.setCaption('Ouroboros')
end

function love.draw()
	world:draw()
end


function love.update(dtime)
	world:update(dtime)
end
