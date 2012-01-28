require('object')
require('player')

PlayerGen = Object:new()

PlayerGen.forenames = {
	"Forename 1",
	"Forename 2",
	"Forename 3"
}

PlayerGen.surnames = {
	"Surname 1",
	"Surname 2",
	"Surname 3"
}

PlayerGen.bios1 = {
	"Bio 1 - 1",
	"Bio 1 - 2",
	"Bio 1 - 3"
}

PlayerGen.bios2 = {
	"Bio 2 - 1",
	"Bio 2 - 2",
	"Bio 2 - 3"
}

PlayerGen.bios3 = {
	"Bio 3 - 1",
	"Bio 3 - 2",
	"Bio 3 - 3"
}

function PlayerGen:newPlayer()
	player = Player:new()
	player:setName(self:randomName())
	player:setBio(self:randomBio())

	return player
end

function PlayerGen:randomName()
	name = self.forenames[math.random(#self.forenames)] .. " " .. self.surnames[math.random(#self.surnames)]
	print(name)
	return name
end

function PlayerGen:randomBio()
	bio = self.bios1[math.random(#self.bios1)] .. " " .. self.bios2[math.random(#self.bios2)] .. " " .. self.bios3[math.random(#self.bios3)]
	print(bio)
	return bio
end
