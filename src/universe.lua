require('object')

Universe = Object:new()

function Universe:init()
	self.startingArea = nil
	self.areas = {}
	self.links = {}
end

function Universe:link(from, to, direction)
	table.insert(self.links, {to = to, from = from, direction = direction})
end

function Universe:loadArea(file)
	local world = World:new(file)
	self.areas[file] = world
	return world
end

function Universe:moveToArea(areaName, direction)
	local area = self:loadArea(areaName)
	State.world = area
	State.player = Player:new()
	area:add(State.player)
	
	if direction ~= nil then	
		local opposites = {n = 's', s = 'n', w = 'e', e = 'w'}
		
		door = nil
		for _, k in ipairs(State.world.entities) do
			if k.dir == opposites[direction] then
				door = k
			end
		end
		
		if door then
			if direction == 's' then
				State.player.x = door.x + 16
				State.player.y = door.y + 32
			elseif direction == 'n' then
				State.player.x = door.x + 16
				State.player.y = door.y - 32
			elseif direction == 'w' then
				State.player.x = door.x - 32
				State.player.y = door.y + 16
			elseif direction == 'e' then
				State.player.x = door.x + 32
				State.player.y = door.y + 16
			end
		end	
	end
end

function Universe:nextArea(current, direction)
	for _, link in ipairs(self.links) do
		print(current, direction)
		if link.from == current and link.direction == direction then
			return link.to
		end
	end
end

function Universe:restart()
	self:moveToArea(self.startingArea)
end
