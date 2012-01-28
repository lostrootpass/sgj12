require("laser")
require("blade")
require("button")
require("pit")
require("door")
require("sign")
require("conveyor")

mobiles = {
	laser = Laser,
	blade = Blade,
	button = Button,
	pit = Pit,
	door = Door,
	sign = Sign,
	conveyor = Conveyor
}

function loadEntities(world, map_objects)
	--love.graphic.draw("hello", 0, 0)
	local e
	--local map_objects = tmap.TiledMap_GetMapObjects()
	for i, o in ipairs(map_objects) do
		if o.t == "door" then
			if o.y <= 64 then
				e = Door:new("n", "open")
			elseif o.y >= 576-64 then --world.height - 64 then
				e = Door:new("s", "closed")
			elseif o.x <= 64 then
				e = Door:new("w", "closed")
			else
				e = Door:new("e", "closed")
			end
			print(tostring(o.x).. tostring(o.y))
			e:setPosition(o.x, o.y)
			world:add(e)
		elseif mobiles[o.t] then
			e = mobiles[o.t]:new()
			e:setPosition(o.x, o.y)
			world:add(e)
		end
	end
end
