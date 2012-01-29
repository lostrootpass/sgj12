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
	print("end likelihood", endProbability)
	
	math.randomseed(os.time())
	if math.random() < endProbability and travelDirection == "n" then
		self:link(fromArea, self.endingArea, travelDirection)
		return
	end

	self.available = Universe.shuffle(self.available)
	
	for toArea, availability in pairs(self.available) do
		local opposite = Universe.opposites[travelDirection]
		if availability[opposite] == true then
			print(toArea, availability)
			availability[opposite] = false
			
			self:link(fromArea, toArea, travelDirection)
			return
		end
	end
end

function Universe:loadArea(file)
	if self.areas[file] == nil then
		local world = World:new(file)
		self.areas[file] = world
		return world
	else
		return self.areas[file]
	end
end

function Universe:moveToArea(areaName, direction)
	Dialogue:hide()
	print("movetoarea", areaName, direction)
	local area = self:loadArea(areaName)
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

function Universe.shuffle(t)
	math.randomseed(os.time())
	
	local n = #t
	
	while n >= 2 do
		local k = math.random(n)
		print(n, k)
		t[n], t[k] = t[k], t[n]
		n = n - 1
	end
	
	for a, b in pairs(t) do
		print(a, b)
	end
	
	return t
end
