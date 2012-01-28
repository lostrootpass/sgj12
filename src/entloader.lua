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
	local e
	--local map_objects = tmap.TiledMap_GetMapObjects()
	for i, o in ipairs(map_objects) do
		if o.t == "door" then
			if o.y < 64 then
				e = Door:new("n")
			elseif o.y > 576-64 then --world.height - 64 then
				e = Door:new("s")
			elseif o.x > 64 then
				e = Door:new("w")
			else
				e = Door:new("e")
			end
			e:setPosition(o.x, o.y)
			world:add(e)
		elseif mobiles[o.t] then
			e = mobiles[o.t]:new()
			e:setPosition(o.x, o.y)
			world:add(e)
		end
	end
end
