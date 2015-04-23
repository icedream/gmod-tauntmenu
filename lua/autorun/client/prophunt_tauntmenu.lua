-- Sent by the server to let us know about available taunts
local sortedTaunts = {}
local lastMenu = nil

net.Receive("TauntList_Update", function()

	local tauntsTable = net.ReadTable()
	
	--[[
	print("Got tauntlist update:")
	PrintTable(tauntsTable)
	--]]

	-- Syntax of the table is just the same as for tauntpacks.
	-- We categorize the taunts by splitting the names up and making use of the parts.
	sortedTaunts = {}
	for team, taunts in pairs(tauntsTable) do
		sortedTaunts[team] = { sounds={}, categories={} }

		for _, value in pairs(taunts) do
			local path = value[1]
			local description = value[2]
			local name = nil
			local parent = sortedTaunts[team]

			-- split the name for categorization
			for _, i in pairs(string.Split(description, " - ")) do
				if name ~= nil then
					if parent.categories[name] == nil then
						parent.categories[name] = { sounds={}, categories={} }
					end
					parent = parent.categories[name]
				end

				name = i
			end

			parent.sounds[name] = path
		end
	end
end)

local windowColor = Color(128, 128, 128, 192)
local textColor = Color(255, 255, 255)

local function PlayTaunt(sound)
	net.Start("TauntMenu_Play")
	net.WriteString(sound)
	net.SendToServer()
end

local function Apply(menu, taunts)
	if not IsValid(menu) then return end

	-- sort sounds
	local sounds = {}
	for key,value in pairs(taunts.sounds) do
		table.insert(sounds, { key=key, value=value })
	end
	table.sort(sounds, function(a, b)
		return string.lower(a.key) < string.lower(b.key)
	end)

	menu:AddSpacer()

	-- sort categories
	local categories = {}
	for key,value in pairs(taunts.categories) do
		table.insert(categories, { key=key, value=value })
	end
	table.sort(categories, function(a, b)
		return string.lower(a.key) < string.lower(b.key)
	end)

	-- add categories to the menu
	for _, item in pairs(categories) do
		Apply(menu:AddSubMenu(item.key), item.value)
	end

	-- add sounds to the menu
	for _, item in pairs(sounds) do
		menu:AddOption(item.key, function()
			PlayTaunt(item.value)
		end)
	end
end

local function CreateMenu()
	-- does the team even have taunts? (spectators don't, so no menu for them!)
	local team = LocalPlayer():Team()
	local teamTaunts = sortedTaunts[team]
	if teamTaunts == nil then
		return nil
	end

	-- menu bar
	local menu = vgui.Create("DMenu")

	-- build submenus
	Apply(menu, teamTaunts)

	return menu
end

hook.Add( "PlayerBindPress", "PlayerBindPressFKeyMenus", function(pl, bind, pressed)
	if bind == "gm_showspare2" and pressed then
		if IsValid(lastMenu) and lastMenu ~= nil then
			lastMenu:Hide()
		end
		lastMenu = CreateMenu()
		if IsValid(lastMenu) and lastMenu ~= nil then
			lastMenu:Open()
		end
	end
end);