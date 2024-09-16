require "ISUI/ISCollapsableWindow"

ISCoxisShopGet = ISCollapsableWindow:derive("ISCoxisShopGet");
ISCoxisShopGet.instance = {}

function ISCoxisShopGet:initialise()
	ISCollapsableWindow.initialise(self);
	self:create();
end

function ISCoxisShopGet:render()
	ISCollapsableWindow.render(self)
end

function ISCoxisShopGet:create()
	--itemInput
	self.itemInput = ISTextEntryBox:new("", 20, 40, 70, 10, 10, 10);
    self.itemInput.font = UIFont.Medium;
    self.itemInput:initialise();
    self.itemInput:instantiate();
    self.itemInput.backgroundColor = {r = 0,g = 0,b = 0,a = 0.5 };
    self.itemInput.borderColor = {r = 1,g = 1,b = 1,a = 0.0};
    self.itemInput:setHasFrame(true)
    self:addChild(self.itemInput)
	local labelHint = ISLabel:new(115, 45, 20, "Example: Base.Money", 1, 1, 1, 0.8, UIFont.Small, true);
	self:addChild(labelHint);
	--Button
	self.confirmButton = self:createButton(20, 140, "UI_CoxisShop_Confirm", self.onConfirmButtonClick, self.char, self.playerId);
end

function ISCoxisShopGet:createButton(x, y, _label, _function, player, playerId)
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

function ISCoxisShopGet:onConfirmButtonClick(button, x, y)
	getPlayer():getInventory():AddItem(self.itemInput:getText());
	self:setVisible(false);
end

function ISCoxisShopGet:new(x, y, width, height, player)
	local o = {};
	o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self);
	self.__index = self;
	o:setTitle(getText("UI_ISCoxisShopGet_WindowTitle"))
	o.playerId = player;
	o.buttons = {};
	ISCoxisShopGet.instance[player] = o;
	return o;
end