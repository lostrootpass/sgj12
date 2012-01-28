require('object')

Universe = Object:new()

Universe.opposites = {n = 's', s = 'n', w = 'e', e = 'w'}

function Universe:init()
	self.startingArea = nil
	self.areas = {}
	self.links = {}
	self.available = {}
end

function Universe:link(from, to, direction)	
	table.insert(self.links, {to = to, from = from, direction = direction})
	table.insert(self.links, {to = from, from = to, direction = Universe.opposites[direction]})
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
	
	self.available = self:shuffle(self.available)
	self:findPartner(self.startingArea, "s")
end

function Universe:findPartner(fromArea, travelDirection)
	for toArea, availability in self.available do
		local opposite = Universe.opposites[travelDirection]
		
		if availability[opposite] == true then
			availability[opposite] = false
			
			self:link(fromArea, toArea, travelDirection)
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
	local area = self:loadArea(areaName)
	State.world = area
	State.player = Player:new()
	area:add(State.player)
	
	if direction ~= nil then
		
		door = nil
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
end

function Universe:restart()
	self:moveToArea(self.startingArea)
end

function Universe:shuffle(t)
	math.randomseed(os.time())
	local n = #t
	
	while n >= 2 do
		local k = math.random(n)
		t[n], t[k] = t[k], t[n]
		n = n - 1
	end
	
	return t
end
