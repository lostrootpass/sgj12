require('object')

Universe = Object:new()

function Universe:init()
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

function Universe:moveToArea(areaName)
	local area = self:loadArea(areaName)
	State.world = area
	State.player = Player:new()
	area:add(State.player)
	State.player.x = 96
	State.player.y = 96
	
	State.player.graphic:play('stand_right')
end

function Universe:nextArea(current, direction)
	for _, link in ipairs(self.links) do
		print(current, direction)
		if link.from == current and link.direction == direction then
			return link.to
		end
	end
end
