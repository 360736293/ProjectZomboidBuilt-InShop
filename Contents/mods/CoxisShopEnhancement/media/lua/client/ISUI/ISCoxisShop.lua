require "ISUI/ISCollapsableWindow"

ISCoxisShop = ISCollapsableWindow:derive("ISCoxisShop");
ISCoxisShop.instance = {}

function ISCoxisShop:initialise()
	ISCollapsableWindow.initialise(self);
end

function ISCoxisShop:createChildren()
	ISCollapsableWindow.createChildren(self);
	local th = self:titleBarHeight()
	local rh = self:resizeWidgetHeight()
	self.panel = ISTabPanel:new(0, th, self.width, self.height-th-rh);
	self.panel:initialise();
	self:addChild(self.panel);
	
	-- Tab with food stuff
	self.foodScreen = ISCoxisShopPanel:new(0, 8, 400, 400, self.playerId, self.settings["FOOD"]);
	self.foodScreen:initialise();
	self.panel:addView(getText('UI_CoxisShop_Food'), self.foodScreen);
	-------------------------
	
	-- Tab with various stuff
	self.itemScreen = ISCoxisShopPanel:new(0, 8, 400, 400, self.playerId, self.settings["VARIOUS"]);
	self.itemScreen:initialise();
	self.panel:addView(getText('UI_CoxisShop_Various'), self.itemScreen);
	-------------------------

	-- Tab with weapons stuff
	self.weaponsScreen = ISCoxisShopPanel:new(0, 8, 400, 400, self.playerId, self.settings["WEAPONS"]);
	self.weaponsScreen:initialise();
	self.panel:addView(getText('UI_CoxisShop_Weapons'), self.weaponsScreen);
	-------------------------

	-- Tab with medicines stuff
	self.medicinesScreen = ISCoxisShopPanel:new(0, 8, 400, 400, self.playerId, self.settings["MEDICINES"]);
	self.medicinesScreen:initialise();
	self.panel:addView(getText('UI_CoxisShop_Medicines'), self.medicinesScreen);
	-------------------------
	
	-- Tab with skills
	self.playerScreen = ISCoxisShopPanelSkills:new(0, 8, 400, 400, self.playerId, self.settings["SKILLS"]);
	self.playerScreen:initialise();
	self.panel:addView(getText('UI_CoxisShop_Player'), self.playerScreen);
	-------------------------

	-- Tab with specials
	self.specialsScreen = ISCoxisShopPanelSpecials:new(0, 8, 400, 400, self.playerId, self.settings["SPECIALS"]);
	self.specialsScreen:initialise();
	self.panel:addView(getText('UI_CoxisShop_Specials'), self.specialsScreen);
	-------------------------
end

function ISCoxisShop:render()
	ISCollapsableWindow.render(self)

	if JoypadState.players[self.playerId+1] then
		self:drawRectBorder(0, 0, self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
		self:drawRectBorder(1, 1, self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
	end
end

function ISCoxisShop:reloadButtons()
	self.foodScreen:reloadButtons();
	self.itemScreen:reloadButtons();
	self.weaponsScreen:reloadButtons();
	self.medicinesScreen:reloadButtons();
	self.playerScreen:reloadButtons();
	self.specialsScreen:reloadButtons();
end

function ISCoxisShop:onGainJoypadFocus(joypadData)
	ISCollapsableWindow.onGainJoypadFocus(self, joypadData)
	joypadData.focus = self.panel:getActiveView()
end

function ISCoxisShop:onJoypadDown(button, joypadData)
	if button == Joypad.LBumper or button == Joypad.RBumper then
		if #self.panel.viewList < 2 then return end
		local viewIndex
		for i,v in ipairs(self.panel.viewList) do
			if v.view == self.panel:getActiveView() then
				viewIndex = i
				break
			end
		end
		if button == Joypad.LBumper then
			if viewIndex == 1 then
				viewIndex = #self.panel.viewList
			else
				viewIndex = viewIndex - 1
			end
		end
		if button == Joypad.RBumper then
			if viewIndex == #self.panel.viewList then
				viewIndex = 1
			else
				viewIndex = viewIndex + 1
			end
		end
		self.panel:activateView(self.panel.viewList[viewIndex].name)
--		setJoypadFocus(self.playerId, self.panel:getActiveView())
		joypadData.focus = self.panel:getActiveView()
	end
end

function ISCoxisShop:new (x, y, width, height, player, settings)
	local o = {};
	o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self);
	self.__index = self;
--	o:noBackground();
	o:setTitle(getText("UI_ISCoxisShop_WindowTitle"))
	o.playerId = player;
	ISCoxisShop.instance[player] = o;
	o.settings = settings;
	return o;
end