require "ISUI/ISCollapsableWindow"

ISCoxisShopTeleport = ISCollapsableWindow:derive("ISCoxisShopTeleport");
ISCoxisShopTeleport.instance = {}

function ISCoxisShopTeleport:initialise()
	ISCollapsableWindow.initialise(self);
	self:create();
end

function ISCoxisShopTeleport:render()
	ISCollapsableWindow.render(self)
end

function ISCoxisShopTeleport:create()
	--X
	local labelX = ISLabel:new(20, 25, 20, "X:", 1, 1, 1, 0.8, UIFont.Small, true);
	self:addChild(labelX);
	self.textEntryX = ISTextEntryBox:new("", 60, 20, 60, 10, 10, 10);
    self.textEntryX.font = UIFont.Medium
    self.textEntryX:initialise();
    self.textEntryX:instantiate();
    self.textEntryX.backgroundColor = {r = 0,g = 0,b = 0,a = 0.5 };
    self.textEntryX.borderColor = {r = 1,g = 1,b = 1,a = 0.0};
    self.textEntryX:setHasFrame(true)
    self:addChild(self.textEntryX)
	local labelRealX = ISLabel:new(125, 25, 20, string.format("%.4f", getPlayer():getX()), 1, 1, 1, 0.8, UIFont.Small, true);
	self:addChild(labelRealX);
	--Y
	local labelY = ISLabel:new(20, 65, 20, "Y:", 1, 1, 1, 0.8, UIFont.Small, true);
	self:addChild(labelY);
	self.textEntryY = ISTextEntryBox:new("", 60, 60, 60, 10, 10, 10);
    self.textEntryY.font = UIFont.Medium
    self.textEntryY:initialise();
    self.textEntryY:instantiate();
    self.textEntryY.backgroundColor = {r = 0,g = 0,b = 0,a = 0.5 };
    self.textEntryY.borderColor = {r = 1,g = 1,b = 1,a = 0.0};
    self.textEntryY:setHasFrame(true)
    self:addChild(self.textEntryY)
	local labelRealY = ISLabel:new(125, 65, 20, string.format("%.4f", getPlayer():getY()), 1, 1, 1, 0.8, UIFont.Small, true);
	self:addChild(labelRealY);
	--Z
	local labelZ = ISLabel:new(20, 105, 20, "Z:", 1, 1, 1, 0.8, UIFont.Small, true);
	self:addChild(labelZ);
	self.textEntryZ = ISTextEntryBox:new("", 60, 100, 60, 10, 10, 10);
    self.textEntryZ.font = UIFont.Medium
    self.textEntryZ:initialise();
    self.textEntryZ:instantiate();
    self.textEntryZ.backgroundColor = {r = 0,g = 0,b = 0,a = 0.5 };
    self.textEntryZ.borderColor = {r = 1,g = 1,b = 1,a = 0.0};
    self.textEntryZ:setHasFrame(true);
    self:addChild(self.textEntryZ);
	local labelRealZ = ISLabel:new(125, 105, 20, string.format("%.4f", getPlayer():getZ()), 1, 1, 1, 0.8, UIFont.Small, true);
	self:addChild(labelRealZ);
	--Button
	self.TeleportButton = self:createButton(20, 140, "UI_CoxisShop_Teleport", self.onTeleportButtonClick, self.char, self.playerId);
end

function ISCoxisShopTeleport:createButton(x, y, _label, _function, player, playerId)
	local label = nil;
	label = getText(_label);
	local button = ISButton:new(x, y, 100, 25, label, self, _function);
	button:initialise();
	button.borderColor = {r=1, g=1, b=1, a=0.1};
	button.playerId = playerId;
	button.char = player;
	button:setFont(UIFont.Small);
	button:ignoreWidthChange();
	button:ignoreHeightChange();
	self:addChild(button);
	table.insert(self.buttons, button);
end

function ISCoxisShopTeleport:onTeleportButtonClick(button, x, y)
	if 
		self.textEntryX:getText() and
		self.textEntryX:getText() ~= "" and
		self.textEntryY:getText() and
		self.textEntryY:getText() ~= "" and
		self.textEntryZ:getText() and
		self.textEntryZ:getText() ~= ""
	then
		getPlayer():setX(tonumber(self.textEntryX:getText()));
		getPlayer():setY(tonumber(self.textEntryY:getText()));
		getPlayer():setZ(tonumber(self.textEntryZ:getText()));
		getPlayer():setLx(getPlayer():getX());
		getPlayer():setLy(getPlayer():getY());
		getPlayer():setLz(getPlayer():getZ());
		self:setVisible(false);
	end
end

function ISCoxisShopTeleport:new(x, y, width, height, player)
	local o = {};
	o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self);
	self.__index = self;
	o:setTitle(getText("UI_ISCoxisShopTeleport_WindowTitle"))
	o.playerId = player;
	o.buttons = {};
	ISCoxisShopTeleport.instance[player] = o;
	return o;
end