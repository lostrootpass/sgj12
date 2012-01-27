require('object')

World = Object:new()

World.entities = {}

function World:init()
	self.entities = {}
end

function World:add(entity)
	table.insert(self.entities, entity)
end

function World:draw()
	for i = 1, table.getn(self.entities) do
		self.entities[i]:draw()
	end
end

function World:update(dtime)
	for i = 1, table.getn(self.entities) do
		self.entities[i]:update(dtime)
	end
end

function World:remove(entity)
	for index=1, table.getn(self.entities) do
		if self.entities[index] == entity then
			table.insert(self.entities, index)
		end
	end
end
