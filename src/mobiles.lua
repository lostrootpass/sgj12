require("laser")
require("blade")
require("button")
require("pit")
require("door")
require("sign")
require("conveyer")

mobiles = {
	laser = Laser,
	blade = Blade,
	button = Button,
	pit = Pit,
	door = Door,
	sign = Sign,
	conveyer = Conveyer
}

function loadEntities(map_objects)
	local e
	local map_objects = tmap.TiledMap_GetMapObjects()
	for i, o in ipairs(map_objects) do
		if o.t == "door" then
			if o.y < 64 then
				e = Door:new("n")
			elseif o.y > state.world.height - 64 then
				e = Door:new("s")
			elseif o.x > 64 then
				e = Door:new("w")
			else o.x < state.world.width - 64 then
				e = Door:new("e")
			end
			e = Door:new()
			e:setPosition(o.x, o.y)
			state.world:add(e)
		elseif mobiles[o.t] then
			e = mobiles[o.t]:new()
			e:setPosition(o.x, o.y)
			state.world:add(e)
		end
	end
end