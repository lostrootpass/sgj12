require('object')
require('world')
require('state')

function love.load()
	love.graphics.setCaption('Ouroboros')
	State.world = World:new("level/test4.tmx")
end

function love.draw()
	love.graphics.translate(0, 12)
	State.world:draw()
end


function love.update(dtime)
	State.world:update(dtime)
end
