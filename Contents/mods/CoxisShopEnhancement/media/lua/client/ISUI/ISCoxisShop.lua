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

function ISCoxisShop:new(x, y, width, height, player, settings)
	local o = {};
	o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self);
	self.__index = self;
	o:setTitle(getText("UI_ISCoxisShop_WindowTitle"))
	o.playerId = player;
	ISCoxisShop.instance[player] = o;
	o.settings = settings;
	return o;
end