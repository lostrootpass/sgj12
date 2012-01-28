require('object')
require('player')

PlayerGen = Object:new()

PlayerGen.forenames = {
	"Barry",
	"Bob",
	"Heinrich",
	"Wilhelm",
	"BJ",
	"Ricky",
	"Sebastian",
	"Grayson",
	"Harold",
	"Lesley",
	"Curly",
	"Alan",
	"William",
	"Herman",
	"Billy Bob",
	"Harry",
	"Big Phil",
	"Jake",
	"Kevin",
	"Lawrence",
	"Lorenzo",
	"Rupert",
	"Nathan",
	"Ethan",
	"Gaston",
	"Timothy",
	"Solomon",
	"Dennis",
	"Hugo",
	"Cyril",
	"Raymond"
}

PlayerGen.surnames = {
	"Humpton",
	"Kissinger",
	"von Strumpet",
	"le Grande",
	"Prixalot",
	"Milkwort",
	"van der Romp",
	"Joyce",
	"Beaky",
	"Fondle",
	"Quest",
	"Storm",
	"Royce",
	"Muggins",
	"Winkle",
	"Venture",
	"Cage",
	"Pollock",
	"Loveless",
	"Cringe",
	"Gandhi",
	"Chasseur",
	"B. Grayson",
	"Perry",
	"Zeppelin",
	"West",
	"Eriksson",
	"Tupnell",
	"Rockefeller",
	"Clogburn",
	"Wrigglesworth",
	"Stevenage",
	"le Boeuf",
	"Nilsson",
	"Nixon"
}

PlayerGen.bios1 = {
	"This lucky candidate hails from Outer Ward 15.",
	"This lucky candidate is from Inner Ward 24.",
	"This brave candidate has come all the way from the New Wormwood Penal Colony.",
	"Our next candidate was volunteered by the Metropolitan Judiciary.",
	"This fellow is a fan favourite.",
	"This lucky candidate used to be a music teacher.",
	"This feisty young man is ready for action.",
	"This plucky contender has been here before.",
	"This candidate used to live in the Junk Desert.",
	"This candidate is from is Precinct 35.",
	"This candidate hails from Inner Ward 9.",
	"This candidate is from the Milton Projects.",
	"This lucky candidate is from New Washington."
}

PlayerGen.bios2 = {
	"He likes cats,",
	"He's a published author,",
	"He's an amateur botanist,",
	"He has a college degree,",
	"He reads French poetry,",
	"He's a big fan of the opera,",
	"He plays the harmonium,",
	"He has a history of insurance fraud,",
	"He's well known to local law enforcement,",
	"He's fond of astrology,",
	"He hates cats,",
	"He works as a medic,",
	"He works as a waste disposal technician,",
	"He works as an executive masseur,",
	"He's a hydroponic labourer,",
	"He's a clerical assistant,",
	"He wears turtleneck sweaters,",
	"He's a political columnist,",
	"He's a promising jockey,",
	"He used to be a political columnist,",
	"He's an amateur wrestler,",
	"He works on a cruise ship,",
	"He has beautiful hair,",
	"He's a former lobbyist,",
	"He works in a soyburger kiosk,",
	"He's a private in the security forces,",
	"He's a former journalist,",
	"He likes to play roulette,"
}

PlayerGen.bios3 = {
	"and has a history of political insurrection.",
	"and has a fear of deadly traps, which doesn't bode well for his future.",
	"and likes to play chess in his spare time.",
	"and has reasonable survival odds of 75-1.",
	"and has great survival odds of 23-2.",
	"and has survival odds of a meagre 148-1.",
	"and is afraid of heights.",
	"and once ran for public office.",
	"and has a season ticket with his local football team.",
	"and has an unusual fondness for beef tea.",
	"and is a keen pidgeon fancier.",
	"and is a competitive marrow grower.",
	"and loves seafood.",
	"and is known for his anti-authoritarian attitude.",
	"and is extremely cautious.",
	"and is hopeless at following orders.",
	"and tends to be impulsive.",
	"and is being investigated by the authorities.",
	"and voted incorrectly in the last election.",
	"and has a remaining life expectancy of less than five minutes.",
	"and his favourite colour is lilac.",
	"and has a life expectancy of under ten minutes.",
	"and is expected to demise after 2.5 rooms.",
	"and is likely to perish after 3 rooms or less.",
	"and has turned up late for work for the last time.",
	"and is the proud owner of a string of gambling debts.",
	"and is here to pay off his alimony.",
	"and owes the state ninety-five credits.",
	"and has failed his monthly happiness check.",
	"and is saving up for a holiday.",
	"and loves to party hard.",
	"and is hoping to pay off his mortgage.",
	"and likes dressing up.",
	"and has a poor sense of direction.",
	"and wears a hairpiece.",
	"and frequently gets lost in mazes.",
	"and loves to dance.",
	"and has donated credits to opponents of the state."
}

function PlayerGen:newPlayer()
	player = Player:new()
	player:setName(self:randomName())
	player:setBio(self:randomBio())

	return player
end

function PlayerGen:randomName()
	name = self.forenames[math.random(#self.forenames)] .. " " .. self.surnames[math.random(#self.surnames)]
	return name
end

function PlayerGen:randomBio()
	bio = self.bios1[math.random(#self.bios1)] .. " " .. self.bios2[math.random(#self.bios2)] .. " " .. self.bios3[math.random(#self.bios3)]
	return bio
end
