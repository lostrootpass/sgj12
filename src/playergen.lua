require('object')
require('player')

PlayerGen = Object:new()

PlayerGen.forenames = {
	"Albert",
	"Barry",
	"Charles"
}

PlayerGen.surnames = {
	"Xylophone",
	"Yellowson",
	"Zebra-Smith"
}

PlayerGen.bios = {
	"Has hair",
	"Does not like peaches",
	"Wishes he was massive, like REALLY massive"
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
	bio = self.bios[math.random(#self.bios)] .. " " .. self.bios[math.random(#self.bios)] .. " " .. self.bios[math.random(#self.bios)]
	print(bio)
	return bio
end
