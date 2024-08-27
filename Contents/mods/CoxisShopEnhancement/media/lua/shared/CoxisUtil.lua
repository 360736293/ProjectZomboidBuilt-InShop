--[[
#########################################################################################################
#	@mod:		CoxisUtil - Basci utilities for Coxis mods                                              #
#	@author: 	Dr_Cox1911					                                                            #
#	@notes:		Many thanks to RJ�s LastStand code and all the other modders out there					#
#	@notes:													                                  			#
#	@link: 													       										#
#########################################################################################################
--]]

CoxisUtil = {};


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
