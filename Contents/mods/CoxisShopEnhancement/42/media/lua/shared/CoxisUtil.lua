CoxisUtil = {};



-- **************************************************************************************
-- 读Lua
-- **************************************************************************************
CoxisUtil.readLua = function(_modID, _filename)
	local inidata = {};
	-- local settingsFile = getModFileReader(_modID, _filename, false);
	-- local line = nil;
	-- local section = nil;
	-- while true do
	-- 	line = settingsFile:readLine();
	-- 	if line == nil then
	-- 		settingsFile:close();
	-- 		break;
	-- 	end
	-- 	if (luautils.stringStarts(line, "--|[")) then
	-- 		section = string.sub(line, 5, -2);
	-- 		inidata[section] = {};
	-- 	end
	-- 	if (luautils.stringStarts(line, "--|")) then
	-- 		line = string.sub(line, 4, -1);
	-- 		local splitedLine = string.split(line, "=");
	-- 		local key = splitedLine[1];
	-- 		local value = splitedLine[2];
	-- 		inidata[section][key] = value;
	-- 	end
	-- end

	inidata["BASIC"] = {}
	inidata["BASIC"]["initialMoney"] = "2000"
	inidata["BASIC"]["amount"] = "5"
	inidata["BASIC"]["daily"] = "0"
	inidata["BASIC"]["bonus"] = "0.025"

	inidata["VARIOUS"] = {}
	inidata["VARIOUS"]["Base.Money"] = "1"
	inidata["VARIOUS"]["Bag_Schoolbag"] = "100"
	inidata["VARIOUS"]["Base.Bag_NormalHikingBag"] = "200"
	inidata["VARIOUS"]["Base.Bag_BigHikingBag"] = "300"
	inidata["VARIOUS"]["Base.Bag_ALICEpack"] = "800"
	inidata["VARIOUS"]["Base.Bag_ALICEpack_Army"] = "1000"
	inidata["VARIOUS"]["Base.Vest_BulletCivilian"] = "200"
	inidata["VARIOUS"]["Base.Vest_BulletPolice"] = "300"
	inidata["VARIOUS"]["Base.Vest_BulletArmy"] = "400"
	inidata["VARIOUS"]["Base.Belt2"] = "100"
	-- inidata["VARIOUS"]["Base.DigitalWatch"] = "100"
	-- inidata["VARIOUS"]["Base.Pan"] = "100"
	-- inidata["VARIOUS"]["Base.Pot"] = "100"
	-- inidata["VARIOUS"]["Base.Sledgehammer"] = "2000"
	-- inidata["VARIOUS"]["Base.Hammer"] = "100"
	-- inidata["VARIOUS"]["Base.BallPeenHammer"] = "100"
	-- inidata["VARIOUS"]["Base.Screwdriver"] = "100"
	-- inidata["VARIOUS"]["Base.Saw"] = "100"
	-- inidata["VARIOUS"]["Base.Wrench"] = "100"
	-- inidata["VARIOUS"]["Base.LugWrench"] = "100"
	-- inidata["VARIOUS"]["Base.TirePump"] = "100"
	-- inidata["VARIOUS"]["Base.Scissors"] = "100"
	-- inidata["VARIOUS"]["Base.Jack"] = "100"
	-- inidata["VARIOUS"]["Base.TinOpener"] = "100"
	-- inidata["VARIOUS"]["Base.Tweezers"] = "100"
	-- inidata["VARIOUS"]["Base.Needle"] = "100"
	-- inidata["VARIOUS"]["Base.Thread"] = "100"
	-- inidata["VARIOUS"]["Base.LeatherStrips"] = "10"
	-- inidata["VARIOUS"]["Base.Tongs"] = "100"
	-- inidata["VARIOUS"]["Base.SutureNeedle"] = "100"
	-- inidata["VARIOUS"]["Base.KnittingNeedles"] = "100"
	-- inidata["VARIOUS"]["farming.HandShovel"] = "100"
	-- inidata["VARIOUS"]["farming.GardeningSprayFull"] = "100"
	-- inidata["VARIOUS"]["Base.PipeWrench"] = "100"
	-- inidata["VARIOUS"]["Base.WeldingMask"] = "100"
	-- inidata["VARIOUS"]["Base.BlowTorch"] = "100"
	-- inidata["VARIOUS"]["Base.PropaneTank"] = "100"
	-- inidata["VARIOUS"]["Base.Lighter"] = "100"
	-- inidata["VARIOUS"]["Base.Cigarettes"] = "20"
	-- inidata["VARIOUS"]["Base.Battery"] = "100"
	-- inidata["VARIOUS"]["Base.NailsBox"] = "100"
	-- inidata["VARIOUS"]["Base.PaperclipBox"] = "100"
	-- inidata["VARIOUS"]["Base.ScrewsBox"] = "100"
	-- inidata["VARIOUS"]["Base.DuctTape"] = "100"
	-- inidata["VARIOUS"]["Base.Glue"] = "100"
	-- inidata["VARIOUS"]["Base.Book"] = "100"
	-- inidata["VARIOUS"]["Base.Garbagebag"] = "100"
	-- inidata["VARIOUS"]["Base.Mop"] = "100"
	-- inidata["VARIOUS"]["Base.Bleach"] = "100"
	-- inidata["VARIOUS"]["Base.CarBatteryCharger"] = "1000"
	-- inidata["VARIOUS"]["Base.PetrolCan"] = "1000"
	-- inidata["VARIOUS"]["Base.MechanicMag1"] = "500"
	-- inidata["VARIOUS"]["Base.MechanicMag2"] = "500"
	-- inidata["VARIOUS"]["Base.MechanicMag3"] = "500"
	-- inidata["VARIOUS"]["Base.ElectronicsMag4"] = "1000"
	-- inidata["VARIOUS"]["Base.Generator"] = "4000"
	-- inidata["VARIOUS"]["camping.CampingTentKit"] = "1000"
	-- inidata["VARIOUS"]["camping.CampfireKit"] = "200"
	-- inidata["VARIOUS"]["Base.Notebook"] = "100"
	-- inidata["VARIOUS"]["Base.SheetMetal"] = "100"
	-- inidata["VARIOUS"]["Base.SmallSheetMetal"] = "100"
	-- inidata["VARIOUS"]["Base.MetalBar"] = "100"
	-- inidata["VARIOUS"]["Base.MetalPipe"] = "100"
	-- inidata["VARIOUS"]["Base.ScrapMetal"] = "100"
	-- inidata["VARIOUS"]["Base.ElectronicsScrap"] = "100"
	-- inidata["VARIOUS"]["Base.Battery"] = "100"
	-- inidata["VARIOUS"]["Base.WeldingRods"] = "100"
	-- inidata["VARIOUS"]["Base.Wire"] = "100"
	-- inidata["VARIOUS"]["Radio.ElectricWire"] = "100"
	-- inidata["VARIOUS"]["Base.Charcoal"] = "100"
	-- inidata["VARIOUS"]["Base.Log"] = "50"
	-- inidata["VARIOUS"]["Base.BackpackExpansion"] = "1000"

	inidata["FOOD"] = {}
	-- inidata["FOOD"]["Base.CannedCornedBeef"] = "50"
	-- inidata["FOOD"]["Base.CannedFruitBeverage"] = "50"
	-- inidata["FOOD"]["Base.WaterBottleFull"] = "50"
	-- inidata["FOOD"]["Base.WhiskeyFull"] = "100"

	inidata["WEAPONS"] = {}
	-- inidata["WEAPONS"]["Base.KitchenKnife"] = "100"
	-- inidata["WEAPONS"]["Base.HuntingKnife"] = "200"
	-- inidata["WEAPONS"]["Base.BaseballBat"] = "200"
	-- inidata["WEAPONS"]["Base.Crowbar"] = "300"
	-- inidata["WEAPONS"]["Base.Axe"] = "400"
	-- inidata["WEAPONS"]["Base.PickAxe"] = "500"
	-- inidata["WEAPONS"]["Base.Katana"] = "2000"
	-- inidata["WEAPONS"]["Base.Shotgun"] = "1000"
	-- inidata["WEAPONS"]["Base.Pistol"] = "1000"
	-- inidata["WEAPONS"]["Base.ShotgunShellsBox"] = "200"
	-- inidata["WEAPONS"]["Base.Bullets9mmBox"] = "200"
	-- inidata["WEAPONS"]["Base.Bullets38Box"] = "200"
	-- inidata["WEAPONS"]["Base.Bullets44Box"] = "200"
	-- inidata["WEAPONS"]["Base.Bullets45Box"] = "200"
	-- inidata["WEAPONS"]["Base.223Box"] = "200"
	-- inidata["WEAPONS"]["Base.308Box"] = "200"
	-- inidata["WEAPONS"]["Base.556Box"] = "200"
	-- inidata["WEAPONS"]["Base.9mmClip"] = "100"
	-- inidata["WEAPONS"]["Base.44Clip"] = "100"
	-- inidata["WEAPONS"]["Base.45Clip"] = "100"
	-- inidata["WEAPONS"]["Base.223Clip"] = "100"
	-- inidata["WEAPONS"]["Base.308Clip"] = "100"
	-- inidata["WEAPONS"]["Base.556Clip"] = "100"
	-- inidata["WEAPONS"]["Base.M14Clip"] = "100"
	-- inidata["WEAPONS"]["farming.BroccoliBagSeed"] = "100"
	-- inidata["WEAPONS"]["farming.CabbageBagSeed"] = "100"
	-- inidata["WEAPONS"]["farming.CarrotBagSeed"] = "100"
	-- inidata["WEAPONS"]["farming.PotatoBagSeed"] = "100"
	-- inidata["WEAPONS"]["farming.StrewberrieBagSeed"] = "100"
	-- inidata["WEAPONS"]["farming.TomatoBagSeed"] = "100"

	inidata["MEDICINES"] = {}
	-- inidata["MEDICINES"]["Base.AlcoholBandage"] = "20"
	-- inidata["MEDICINES"]["Base.AlcoholWipes"] = "20"
	-- inidata["MEDICINES"]["Base.PillsBeta"] = "100"
	-- inidata["MEDICINES"]["Base.Pills"] = "100"
	-- inidata["MEDICINES"]["Base.PillsAntiDep"] = "100"
	-- inidata["MEDICINES"]["Base.Antibiotics"] = "100"
	-- inidata["MEDICINES"]["Base.PillsVitamins"] = "100"
	-- inidata["MEDICINES"]["Base.PillsSleepingTablets"] = "100"

	inidata["SKILLS"] = {}
	inidata["SKILLS"]["Sprinting"] = "600"
	inidata["SKILLS"]["Lightfoot"] = "600"
	inidata["SKILLS"]["Nimble"] = "600"
	inidata["SKILLS"]["Sneak"] = "600"
	inidata["SKILLS"]["Axe"] = "600"
	inidata["SKILLS"]["Woodwork"] = "600"
	inidata["SKILLS"]["Cooking"] = "600"
	inidata["SKILLS"]["Farming"] = "600"
	inidata["SKILLS"]["Doctor"] = "600"
	inidata["SKILLS"]["Electricity"] = "600"
	inidata["SKILLS"]["MetalWelding"] = "600"
	inidata["SKILLS"]["Aiming"] = "600"
	inidata["SKILLS"]["Reloading"] = "600"
	inidata["SKILLS"]["Fishing"] = "600"
	inidata["SKILLS"]["Trapping"] = "600"
	inidata["SKILLS"]["PlantScavenging"] = "600"
	inidata["SKILLS"]["Tailoring"] = "600"
	inidata["SKILLS"]["Mechanics"] = "600"
	inidata["SKILLS"]["Spear"] = "600"
	inidata["SKILLS"]["Blunt"] = "600"
	inidata["SKILLS"]["SmallBlunt"] = "600"
	inidata["SKILLS"]["LongBlade"] = "600"
	inidata["SKILLS"]["SmallBlade"] = "600"
	inidata["SKILLS"]["Maintenance"] = "600"
	inidata["SKILLS"]["Fitness"] = "600"
	inidata["SKILLS"]["Strength"] = "600"

	inidata["SPECIALS"] = {}
	inidata["SPECIALS"]["UI_CoxisShop_Healing"] = "5000"
	inidata["SPECIALS"]["UI_CoxisShop_Repairing"] = "2000"
	inidata["SPECIALS"]["UI_CoxisShop_GetKey"] = "2000"
	inidata["SPECIALS"]["UI_CoxisShop_Repair_Vehicle"] = "4000"
	inidata["SPECIALS"]["UI_CoxisShop_Copy_RH_Equipment"] = "4000"
	inidata["SPECIALS"]["UI_CoxisShop_Teleport"] = "1000"
	inidata["SPECIALS"]["UI_CoxisShop_Get_By_Type"] = "4000"
	inidata["SPECIALS"]["UI_CoxisShop_Learn_All_Recipes"] = "4000"

	inidata["SPECIFICATION_SELLING"] = {}
	inidata["SPECIFICATION_SELLING"]["Base.Money"] = "1"
	inidata["SPECIFICATION_SELLING"]["Base.Cigarettes"] = "1"


	return inidata;
end

---
-- Reads in a ini-formatted file from your mod folder in to a properly formatted
-- 2dim table. If the file is not present it will get created.
-- The return value will be the 2dim table. If the file was not present nil is
-- returned.
-- Access the table like this: inidata[section][key]
--
-- @param _modID - The modID of your mod (needed to identify the mod-folder)
-- @param _filename - The name of the file you want to read in, with ending
--
-- @return - 2dim table if file present, nil if file was not present
--
-- @author Dr_Cox1911
--
CoxisUtil.readINI = function(_modID, _filename)
	local settingsFile = getModFileReader(_modID, _filename, true);
	local inidata = {};
	-- we fetch our file to bind our keys (load the file)
	local line = nil;
	local section = "empty";
	local sectionFound = false;
	local keyFound = false;

	-- we read each line of our file
	while true do
		line = settingsFile:readLine();
		if line == nil then
			settingsFile:close();
			break;
		end

		if (luautils.stringStarts(line, "[")) then
			section = string.sub(line, 2, -2);
			inidata[section] = {};
			-- print("found a section: " .. section);
			sectionFound = true;
		end
		if (not luautils.stringStarts(line, "[") and not luautils.stringStarts(line, ";") and line ~= "") then
			local splitedLine = string.split(line, "=")
			local key = splitedLine[1]
			local value = splitedLine[2]--tonumber(splitedLine[2])
			-- print("found a key: " .. tostring(key) .. " value: " .. tostring(value));
			-- ignore obsolete bindings, override the default key
			inidata[section][key] = value;
			keyFound = true;
		end
	end

	-- for section, key in pairs(inidata) do
	-- 	CoxisUtil.printDebug("CoxisUtil", "Processing section: " .. tostring(section));
	-- 	for key, value in pairs(inidata[section]) do
	-- 		CoxisUtil.printDebug("CoxisUtil", "Processing key: " .. tostring(key) .. " with value: " .. tostring(value));
	-- 	end
	-- end

	if sectionFound and keyFound then
		return inidata;
	end
	return nil;
end


---
-- Writes a ini-formatted 2dim table in to a properly formatted ini-file located
-- in your mod folder.
-- The table has to look like this: inidata[section][key]
--
-- @param _modID - The modID of your mod (needed to identify the mod-folder)
-- @param _filename - The name of the file you want to write to, with ending
-- @param _createIfNull - If the file is not already present it gets created
-- @param _append - Append to the file or overwrite it
-- @param _inidata - The 2dim table you want to write
--
-- @author Dr_Cox1911
--
CoxisUtil.writeINI = function(_modID, _filename, _createIfNull, _append, _inidata)
	local modFileWriter = getModFileWriter(_modID, _filename, _createIfNull, _append)
	for section, key in pairs(_inidata) do
		CoxisUtil.printDebug("CoxisUtil", "Processing section: " .. tostring(section));
		modFileWriter:write("[" .. tostring(section) .. "]\r\n");
		for key, value in pairs(_inidata[section]) do
			CoxisUtil.printDebug("CoxisUtil", "Processing key: " .. tostring(key) .. " with value: " .. tostring(value));
			modFileWriter:write(tostring(key) .. "=" .. tostring(value) .. "\r\n");
		end
		modFileWriter:write("\r\n");
	end
	modFileWriter:close();
end


---
-- Reads in a simple txt file from your mod folder in to a string.
-- If the file is not present it will get created.
-- The return value will be the contents of the file.
-- If the file was not present nil is returned.
-- Access the table like this: inidata[section][key]
--
-- @param _modID - The modID of your mod (needed to identify the mod-folder)
-- @param _filename - The name of the file you want to read in, with ending
--
-- @return - string if file present, nil if file was not present
--
-- @author Dr_Cox1911
--
CoxisUtil.readTXT = function(_modID, _filename)
	local modFileReader = getModFileReader(_modID, _filename, true);
	local line = nil;
	local txt = "";
		while true do
		line = modFileReader:readLine();
		if line == nil then
			modFileReader:close();
			break;
		end
		txt = txt .. tostring(line) .. "\r\n";
	end
	if txt ~= "" then
		return txt;
	end
	return nil;
end

---
-- Writes a simple string to your mod folder in to a file.
--
-- @param _modID - The modID of your mod (needed to identify the mod-folder)
-- @param _filename - The name of the file you want to write to, with ending
-- @param _createIfNull - If the file is not already present it gets created
-- @param _append - Append to the file or overwrite it
-- @param _string - The string you want to write
--
-- @author Dr_Cox1911
--
CoxisUtil.writeTXT = function(_modID, _filename, _createIfNull, _append, _string)
	local modFileWriter = getModFileWriter(_modID, _filename, _createIfNull, _append);
	modFileWriter:write(tostring(_string) .. "\r\n");
end

---
-- Prints a text to the console in a properly formatted fashion
--
-- @param _module - mod-identifier to distinguish it from the other prints
-- @param _string - text to display
--
-- @author Dr_Cox1911
--
CoxisUtil.printDebug = function(_module, _string)
	if _module ~= nil and _string ~= nil then
		print("..." .. tostring(_module) .. "..." .. tostring(_string));
	elseif _module == nil and _string ~= nil then
		print("...NO MODULE RECEIVED..." .. tostring(_string));
	else
		print("...ERROR IN DEBUG...");
	end
end


---
-- Shows a modal window that informs the player about something and only has
-- an okay button to be closed.
--
-- @param _text - The text to display on the modal
-- @param _centered - If set to true the modal will be centered (optional)
-- @param _width - The width of the window (optional)
-- @param _height - The height of the window (optional)
-- @param _func - The function that should be called when the button is clicked
--
-- @author RoboMat (I only added the function param)
--
CoxisUtil.okModal = function(_text, _centered, _width, _height, _posX, _posY, _func)
    local posX = _posX or 0;
    local posY = _posY or 0;
    local width = _width or 230;
    local height = _height or 120;
    local centered = _centered;
    local txt = _text;
	local func = _func or nil;
    local core = getCore();

    -- center the modal if necessary
    if centered then
        posX = core:getScreenWidth() * 0.5 - width * 0.5;
        posY = core:getScreenHeight() * 0.5 - height * 0.5;
    end

    local modal = ISModalDialog:new(posX, posY, width, height, txt, false, nil, func);
    modal:initialise();
    modal:addToUIManager();
end


---
-- Shows a modal window that informs the player about something and only has
-- an okay button to be closed (RichtText).
--
-- @param _text - The text to display on the modal
-- @param _centered - If set to true the modal will be centered (optional)
-- @param _width - The width of the window (optional)
-- @param _height - The height of the window (optional)
-- @param _func - The function that should be called when the button is clicked
--
-- @author Dr_Cox1911
--
CoxisUtil.okModalRichText = function(_text, _centered, _width, _height, _posX, _posY, _func)
    local posX = _posX or 0;
    local posY = _posY or 0;
    local width = _width or 230;
    local height = _height or 120;
    local centered = _centered;
    local txt = _text;
	local func = _func or nil;
    local core = getCore();

    -- center the modal if necessary
    if centered then
        posX = core:getScreenWidth() * 0.5 - width * 0.5;
        posY = core:getScreenHeight() * 0.5 - height * 0.5;
    end

    local modal = ISModalRichText:new(posX, posY, width, height, txt, false, nil, func);
    modal:initialise();
    modal:addToUIManager();
end


---
-- Checks if the table has the key.
--
-- @param _table - The table you want to be checked
-- @param _key - The key you want to know if it's part of the table
--
-- @return - the value of the key, nil if the key was not in the table
--
-- @author Dr_Cox1911
--
CoxisUtil.tableContainsKey = function(_table, _key)
	for key, value in pairs(_table) do
    if key == _key then
      return value
    end
  end
  return nil
end

CoxisUtil.parseFromINItoString = function(_inidata, _includeSections)
	local txt = "";
	for section, key in pairs(_inidata) do
		-- CoxisUtil.printDebug("CoxisUtil", "Processing section: " .. tostring(section));
		if _includeSections then
			txt = txt .. "[" .. tostring(section) .. "]\r\n";
		end
		for key, value in pairs(_inidata[section]) do
			-- CoxisUtil.printDebug("CoxisUtil", "Processing key: " .. tostring(key) .. " with value: " .. tostring(value));
			txt = txt .. tostring(key) .. "=" .. tostring(value) .. "\r\n";
		end
		txt = txt .. "\r\n";
	end
	return txt;
end

CoxisUtil.parseFromStringToINI = function(_text)
	local inidata = {};

	local splitText = nil;
	local section = "empty";
	splitText = luautils.split(_text, "\r\n");

	for number, line in ipairs(splitText) do
		CoxisUtil.printDebug("CoxisUtil", "Processing line: " .. tostring(line));
		if (luautils.stringStarts(line, "[")) then
				section = string.sub(line, 2, -2);
				inidata[section] = {};
				print("found a section: " .. section);
			end
			if (not luautils.stringStarts(line, "[") and not luautils.stringStarts(line, ";") and line ~= "") then
				local splitedLine = string.split(line, "=")
				local key = splitedLine[1]
				local value = splitedLine[2]--tonumber(splitedLine[2])
				print("found a key: " .. tostring(key) .. " value: " .. tostring(value));
				-- ignore obsolete bindings, override the default key
				inidata[section][key] = value;
			end
	end
	return inidata;
end
