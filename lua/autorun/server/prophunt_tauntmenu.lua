-- For reference see Prop Hunt, sh_init.lua:58 and sh_init.lua:63

AddCSLuaFile("autorun/client/prophunt_tauntmenu.lua")

local tauntsTable = {}
local tauntsFixedTable = {}
local tauntPathsTable = {}

local fixedNames = {
	--[[ Hunter taunts ]]--
	-- shipped with Prop Hunt
	["taunts/hunters/come_to_papa.wav"] = "Come to papa",
	["taunts/hunters/father.wav"] = "Father",
	["taunts/hunters/fireassis.wav"] = "Fire Assist",
	["taunts/hunters/hitassist.wav"] = "Hit Assist",
	["taunts/hunters/now_what.wav"] = "Now what",
	["taunts/hunters/you_dont_know_the_power.wav"] = "Star Wars - Darth Vader - You don't know the power of the dark side",
	["taunts/hunters/you_underestimate_the_power.wav"] = "Star Wars - Darth Vader - You underestimate the power of the dark side",
	["taunts/hunters/glados-president.wav"] = "Portal - GLaDOS - Past president of the being-alive club",
	["taunts/hunters/rude.mp3"] = "Rude",
	["taunts/hunters/illfindyou.mp3"] = "I will find you and I will kill you",

	-- Half-Life 2
	["vo/k_lab/ba_guh.wav"] = "Half-Life 2 - Barney - Guh",
	["vo/npc/male01/vanswer13.wav"] = "Half-Life 2 - Stop, you're killing me",
	["vo/npc/male01/thehacks01.wav"] = "Half-Life 2 - The hacks!",
	["vo/npc/male01/runforyourlife02.wav"] = "Half-Life 2 - Run for your life!",
	["vo/npc/male01/overhere01.wav"] = "Half-Life 2 - Hey, over here!",
	["vo/npc/male01/overthere01.wav"] = "Half-Life 2 - Over there! - 1",
	["vo/npc/male01/overthere02.wav"] = "Half-Life 2 - Over there! - 2",

	--[[ Prop taunts ]]--
	-- shipped with Prop Hunt
	["taunts/boom_headshot.wav"] = "Boom, Headshot!",
	["taunts/go_away_or_i_shall.wav"] = "Go away or I shall taunt you",
	["taunts/ill_be_back.wav"] = "I'll be back",
	["taunts/negative.wav"] = "Counter-Strike - Negative",
	["taunts/doh.wav"] = "Simpsons - D'oh!",
	["taunts/oh_yea_he_will_pay.wav"] = "You will definitely pay",
	["taunts/ok_i_will_tell_you.wav"] = "Muffin man",
	["taunts/please_come_again.wav"] = "Please come again",
	["taunts/threat_neutralized.wav"] = "Counter-Strike - Threat neutralized!",
	["taunts/what_is_wrong_with_you.wav"] = "What is wrong with you!?",
	["taunts/woohoo.wav"] = "Woohoo!",
	["taunts/props/1.wav"] = "Boom, Headshot!",
	["taunts/props/2.wav"] = "Simpsons - D'oh!",
	["taunts/props/3.wav"] = "Go away or I shall taunt you",
	["taunts/props/4.wav"] = "Vince - Vince with ShamWow!",
	["taunts/props/5.wav"] = "Counter-Strike - Negative",
	["taunts/props/6.wav"] = "Over 9000",
	["taunts/props/7.wav"] = "LEEROY JENKINS",
	["taunts/props/8.wav"] = "Please come again",
	["taunts/props/9.wav"] = "This is SPARTA!",
	["taunts/props/10.wav"] = "What is wrong with you!?",
	["taunts/props/11.wav"] = "Woohoo!",
	["taunts/props/12.wav"] = "What do you like to play? Pokemon!",
	["taunts/props/13.mp3"] = "I'm cornholio",
	["taunts/props/14.wav"] = "Wheeee!",
	["taunts/props/15.wav"] = "Snooping as usual, I see",
	["taunts/props/16.wav"] = "AAAAAAAAAAATATATATATATATA",
	["taunts/props/17.mp3"] = "Aaaaaahahahaha",
	["taunts/props/18.wav"] = "Billy Maze - Get on the ball!",
	["taunts/props/19.wav"] = "Car horns",
	["taunts/props/20.wav"] = "Billy Maze - Are you on the ball?",
	["taunts/props/21.wav"] = "Billy Maze - For only 19.99!",
	["taunts/props/22.wav"] = "Billy Maze - And you'll never have to pour...",
	["taunts/props/23.wav"] = "Billy Maze - I guarantee it",
	["taunts/props/24.wav"] = "Billy Maze - It's new Oxiclean Detergent",
	["taunts/props/25.wav"] = "Billy Maze - It's so easy, even your kids can do laundry",
	["taunts/props/26.wav"] = "Billy Maze - So get on the ball!",
	["taunts/props/27.wav"] = "Billy Maze - The Oxiclean Detergent ball",
	["taunts/props/28.wav"] = "Billy Maze - Laundries just got easier",
	["taunts/props/29.wav"] = "Music - Running in the 90's",
	["taunts/props/30.wav"] = "All military forces have been eliminated",
	["taunts/props/31.mp3"] = "Music - Bad boys",
	["taunts/props/32.mp3"] = "Music - TEKKNO",
	["taunts/props/33.mp3"] = "Music - Call on me",
	["taunts/props/34.mp3"] = "Music - I am the one and only",
	["taunts/props/35.mp3"] = "Wololo",
	["taunts/hunters/laugh.wav"] = "Laugh", -- look in the Prop Hunt source if you don't believe this being a prop taunt (despite the fact the sound file is missing there)

	-- Half-life 2 taunts --
	["vo/citadel/br_ohshit.wav"] = "Half-Life 2 - Dr. Breen - Oh, shit",
	["vo/citadel/br_youfool.wav"] = "Half-Life 2 - Dr. Breen - You fool",
	["vo/citadel/br_youneedme.wav"] = "Half-Life 2 - Dr. Breen - You need me",
	["vo/coast/odessa/male01/nlo_cheer01.wav"] = "Half-Life 2 - Cheer - Male - 1",
	["vo/coast/odessa/male01/nlo_cheer02.wav"] = "Half-Life 2 - Cheer - Male - 2",
	["vo/coast/odessa/male01/nlo_cheer03.wav"] = "Half-Life 2 - Cheer - Male - 3",
	["vo/coast/odessa/male01/nlo_cheer04.wav"] = "Half-Life 2 - Cheer - Male - 4",
	["vo/coast/odessa/female01/nlo_cheer01.wav"] = "Half-Life 2 - Cheer - Female - 1",
	["vo/coast/odessa/female01/nlo_cheer02.wav"] = "Half-Life 2 - Cheer - Female - 2",
	["vo/coast/odessa/female01/nlo_cheer03.wav"] = "Half-Life 2 - Cheer - Female - 3",
	["vo/gman_misc/gman_riseshine.wav"] = "Half-Life 2 - G-Man - Rise and shine",
	["vo/npc/barney/ba_damnit.wav"] = "Half-Life 2 - Barney - Damn it",
	["vo/npc/barney/ba_laugh01.wav"] = "Half-Life 2 - Barney - Laugh - 1",
	["vo/npc/barney/ba_laugh02.wav"] = "Half-Life 2 - Barney - Laugh - 2",
	["vo/npc/barney/ba_laugh03.wav"] = "Half-Life 2 - Barney - Laugh - 3",
	["vo/npc/barney/ba_laugh04.wav"] = "Half-Life 2 - Barney - Laugh - 4",
	["vo/npc/male01/hacks01.wav"] = "Half-Life 2 - Hacks - 1",
	["vo/npc/male01/hacks02.wav"] = "Half-Life 2 - Hacks - 2",
	["vo/npc/male01/vanswer01.wav"] = "Half-Life 2 - Enough of your mumbo-jumbo",
	["vo/npc/male01/question05.wav"] = "Half-Life 2 - Oh! Deja-vu!",
	["vo/npc/male01/question06.wav"] = "Half-Life 2 - Sometimes I dream about cheese",
	["vo/npc/male01/answer34.wav"] = "Half-Life 2 - Don't forget Hawaii",
	["vo/npc/male01/question30.wav"] = "Half-Life 2 - I'm glad there's no kids around to see this",
	["vo/npc/male01/question26.wav"] = "Half-Life 2 - This is bullshit",
	["vo/npc/male01/incoming02.wav"] = "Half-Life 2 - Incoming!",
	["vo/npc/male01/gethellout.wav"] = "Half-Life 2 - Get the hell outta here",
	["vo/ravenholm/madlaugh04.wav"] = "Father Gregori - Mad laugh",
	["taunts/fixed/13_fix.wav"] = "I'm cornholio",
	["taunts/fixed/bees_fix.wav"] = "Not the bees!"
}

hook.Add("Initialize", "PH_TauntMenu_StringPooling", function()
	util.AddNetworkString("TauntList_Update")
	util.AddNetworkString("TauntMenu_Play")
end)

local function FixName(name)
	if fixedNames[name] ~= nil then return fixedNames[name] end
	return name
end

local function PlayTaunt(pl, sound)
	local team = pl:Team()
	local tauntPaths = tauntPathsTable[team]

	-- TAUNT_DELAY from Prop Hunt, sh_config.lua:172
	-- The code tries to match up with Prop Hunt, init.lua:163-178
	if GAMEMODE:InRound() && IsValid(pl) && pl:IsPlayer() && pl:Alive() && pl.last_taunt_time + TAUNT_DELAY <= CurTime()
		&& tauntPaths ~= nil && table.HasValue(tauntPaths, sound) then
		pl.last_taunt_time = CurTime()
		pl.last_taunt = sound

		pl:EmitSound(sound, 100)
	end
end

local function BroadcastUpdate()
	net.Start("TauntList_Update")
	net.WriteTable(tauntsFixedTable)
	net.Broadcast()
end

local function SendUpdate(pl)
	net.Start("TauntList_Update")
	net.WriteTable(tauntsFixedTable)
	net.Send(pl)
end

-- Detect changes in the taunt list
hook.Add("Think", "TauntList_DetectUpdate", function()
	-- If we don't have Tauntpack loader installed, we only have the global taunt tables used by Prop Hunt itself.
	if (GAMEMODE.Hunter_Taunts == nil) or (GAMEMODE.Prop_Taunts == nil) then
		if (tauntsTable[TEAM_HUNTERS] ~= HUNTER_TAUNTS)
			or (tauntsTable[TEAM_PROPS] ~= PROP_TAUNTS) then
			tauntsTable= {}
			tauntsFixedTable= {}

			-- Replace some of the names with fixed names since Tauntpack Loader
			-- just uses the file path for them which will look ugly on the UI
			tauntsTable[TEAM_HUNTERS] = HUNTER_TAUNTS
			tauntsFixedTable[TEAM_HUNTERS] = {}
			for index, path in pairs(HUNTER_TAUNTS) do
				if file.Exists("sound/" .. path, "GAME") then
					tauntsFixedTable[TEAM_HUNTERS][index] = { path, FixName(path) }
				else
					print("[PH Taunt Menu] Taunt not found, not added to menu: " .. path)
				end
			end

			tauntsTable[TEAM_PROPS] = PROP_TAUNTS
			tauntsFixedTable[TEAM_PROPS] = {}
			for index, path in pairs(PROP_TAUNTS) do
				if file.Exists("sound/" .. path, "GAME") then
					tauntsFixedTable[TEAM_PROPS][index] = { path, FixName(path) }
				else
					print("[PH Taunt Menu] Taunt not found, not added to menu: " .. path)
				end
			end

			-- Tables that hold sound paths, see Prop Hunt, sh_config.lua:70-168
			tauntPathsTable[TEAM_HUNTERS] = HUNTER_TAUNTS
			tauntPathsTable[TEAM_PROPS] = PROP_TAUNTS

			BroadcastUpdate()
		end

	-- Tauntpack loader replaces the old table with a new instance whenever it reloads the taunts.
	-- This means we can use reference equality to detect changes quickly here.
	-- For reference see sv_ph_tauntpack_loader.lua:55-56
	else if (tauntsTable[TEAM_HUNTERS] ~= GAMEMODE.Hunter_Taunts)
		or (tauntsTable[TEAM_PROPS] ~= GAMEMODE.Prop_Taunts) then

		tauntsTable= {}
		tauntsFixedTable= {}

		-- Replace some of the names with fixed names since Tauntpack Loader
		-- just uses the file path for them which will look ugly on the UI
		tauntsTable[TEAM_HUNTERS] = GAMEMODE.Hunter_Taunts
		tauntsFixedTable[TEAM_HUNTERS] = {}
		for index, item in pairs(GAMEMODE.Hunter_Taunts) do
			if file.Exists("sound/" .. item[1], "GAME") then
				tauntsFixedTable[TEAM_HUNTERS][index] = { item[1], FixName(item[2]) }
			else
				print("[PH Taunt Menu] Taunt not found, not added to menu: " .. item[1])
			end
		end

		tauntsTable[TEAM_PROPS] = GAMEMODE.Prop_Taunts
		tauntsFixedTable[TEAM_PROPS] = {}
		for index, item in pairs(GAMEMODE.Prop_Taunts) do
			if file.Exists("sound/" .. item[1], "GAME") then
				tauntsFixedTable[TEAM_PROPS][index] = { item[1], FixName(item[2]) }
			else
				print("[PH Taunt Menu] Taunt not found, not added to menu: " .. item[1])
			end
		end

		-- Tables that hold sound paths, see Prop Hunt, sh_config.lua:70-168
		tauntPathsTable[TEAM_HUNTERS] = HUNTER_TAUNTS
		tauntPathsTable[TEAM_PROPS] = PROP_TAUNTS

		BroadcastUpdate()
	end
end)

-- PlayerInitialSpawn gets called when the player gets to "Sending Client Info".
-- We let the player know all the taunts for the menu here.
hook.Add("PlayerInitialSpawn", "TauntList_UpdateFirst", function(pl)
	SendUpdate(pl)
end)

-- Sent by the client to play a custom taunt
net.Receive("TauntMenu_Play", function(len, pl)
	local path = net.ReadString()

	PlayTaunt(pl, path)
end)