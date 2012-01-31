require('object')
require('dialogue')

Universe = Object:new()

Universe.opposites = {n = 's', s = 'n', w = 'e', e = 'w'}

function Universe:init()
	self.startingArea = nil
	self.endingArea = nil
	self.areas = {}
	self.links = {}
	self.available = {}
	self.partnerships = 0
	self.roomLimit = 50
end

function Universe:link(from, to, direction)
	local reverse = Universe.opposites[direction]

	table.insert(self.links, {to = to, from = from, direction = direction})
	table.insert(self.links, {to = from, from = to, direction = reverse})

	self.available[to][direction] = false
	self.available[from][reverse] = false

	self.partnerships = self.partnerships + 1
end

function Universe:generateLinks()
	local lfs = love.filesystem
	local filetable = lfs.enumerate("level")

	for _, name in ipairs(filetable) do
		local file = "level/" .. name
		local parsedArea = self:loadArea(file)

		self.available[file] = parsedArea:getDoors()
		self.areas[file] = parsedArea
	end

	self:findPartner(self.startingArea, "s")
end

function Universe:findPartner(fromArea, travelDirection)
	local endProbability = self.partnerships / self.roomLimit
	if self.partnerships < 10 then endProbability = 0 end
	print("end likelihood", endProbability)

	if math.random() < endProbability and travelDirection == "n" then
		self:link(fromArea, self.endingArea, travelDirection)
		return
	end

	local candidates = {}
	local opposite = Universe.opposites[travelDirection]

	for toArea, availability in pairs(self.available) do
		if availability[opposite] == true then
			table.insert(candidates, toArea)
		end
	end

	candidates = Universe.shuffle(candidates)
	local destination = candidates[1]
	self.available[destination][opposite] = false

	self:link(fromArea, destination, travelDirection)

end

function Universe:loadArea(file, background)
	if self.areas[file] == nil then
		local world = World:new(file, background)
		self.areas[file] = world
		return world
	else
		return self.areas[file]
	end
end

function Universe:moveToArea(areaName, direction, background)
	Dialogue:hide()
	print("movetoarea", areaName, direction, background)
	local area = self:loadArea(areaName, background)
	State.world = area

	if State.player ~= nil then
		State.player.footsteps:stop()
	end


	State.player = PlayerGen:newPlayer()
	area:add(State.player)

	if direction ~= nil then

		local door = nil
		for _, k in ipairs(State.world.entities) do
			if k.dir == Universe.opposites[direction] then
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

	State.world:start()
end

function Universe:nextArea(current, direction)
	for _, link in ipairs(self.links) do
		if link.from == current and link.direction == direction then
			return link.to
		end
	end

	self:findPartner(current, direction)
	return self:nextArea(current, direction)
end

function Universe:restart()
	if State.player ~= nil then
		State.player.footsteps:stop()
	end

	self:moveToArea(self.startingArea)

	Dialogue:show(State.player.name .. ": " .. State.player.bio)
end

function Universe:reboot()
	--[[self.links = {}
	self.partnerships = 0

	for name, area in pairs(self.areas) do
		self.available[name] = area:getDoors()
	end]]--

	State.universe = Universe:new()
	State.universe.startingArea = "level/tom_room_start.tmx"
	State.universe.endingArea = "level/tom_room_end.tmx"
	State.universe:generateLinks()
	State.universe:restart()
end

function Universe.shuffle(t)

	local n = #t

	while n >= 2 do
		local k = math.random(n)
		t[n], t[k] = t[k], t[n]
		n = n - 1
	end

	return t
end
