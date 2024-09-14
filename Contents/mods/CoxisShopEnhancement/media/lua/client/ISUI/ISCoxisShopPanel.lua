require "ISUI/ISPanelJoypad"
require "ISUI/ISLayoutManager"

ISCoxisShopPanel = ISPanelJoypad:derive("ISCoxisShopPanel");
ISCoxisShopList = ISScrollingListBox:derive("ISCoxisShopList");
ISCoxisScrollbar = ISScrollBar:derive("ISCoxisScrollbar");

CoxisShopUI = {};
CoxisShopUI.items = {};

function ISCoxisShopPanel:initialise()
	ISPanelJoypad.initialise(self);
	self:create();
end

function ISCoxisShopPanel:render()
	local y = 42;

	self:drawText(self.char:getDescriptor():getForename().." "..self.char:getDescriptor():getSurname(), 20, y, 1,1,1,1, UIFont.Medium);
	y = y + 25;
	self:drawText(getText('UI_CoxisShop_Px_Money', self.playerId, self.char:getModData().playerMoney), 20, y, 1,1,1,1, UIFont.Small);

end

function ISCoxisShopPanel:create()
	local y = 90;

	local label = ISLabel:new(16, y, 20, getText('UI_CoxisShop_AvailItems'), 1, 1, 1, 0.8, UIFont.Small, true);
	self:addChild(label);

	local rect = ISRect:new(16, y + 20, 390, 1, 0.6, 0.6, 0.6, 0.6);
	self:addChild(rect);

	self.CoxisShopList = ISCoxisShopList:new(16, y + 30, 390, 200, self.char, self.playerId, self);
	--self.CoxisShopList:addColumn("Items", 0);
    self.CoxisShopList:initialise()
    self.CoxisShopList:instantiate()
    self.CoxisShopList.itemheight = 22
	self.CoxisShopList.columns = {};
    self.CoxisShopList.font = UIFont.NewSmall
    self.CoxisShopList.drawBorder = true
    self:addChild(self.CoxisShopList)

	for itemType,value in pairs(self.items) do
		local item = ScriptManager.instance:getItem(itemType)
		self.CoxisShopList:addItem(item:getDisplayName() .. " (" .. tostring(value) .. ")", tostring(itemType) .. "|" .. tostring(value));
	end
	self.CoxisShopBuyButton = self:createButton(170, y-15, "UI_CoxisShop_BuyButton", "buy", self.onBuyMouseDown, self.char, self.playerId);
	self.CoxisShopSellButton = self:createButton(290, y-15, "UI_CoxisShop_SellButton", "sell", self.onSellMouseDown, self.char, self.playerId);
end

function ISCoxisShopPanel:createItemButton(x, y, itemType, cost)
	local item = ScriptManager.instance:getItem(itemType)
	local label = nil
	if item:getCount() > 1 then
		label = getText('UI_CoxisShop_ItemButton2', item:getDisplayName(), item:getCount(), cost)
	else
		label = getText('UI_CoxisShop_ItemButton', item:getDisplayName(), cost)
	end
	local button = ISButton:new(x, y, 100, 25, label, self, ISCoxisShopPanel.onOptionMouseDown);
	button:initialise();
	button.internal = "item";
	button.item = itemType;
	button.cost = cost;
	button.borderColor = {r=1, g=1, b=1, a=0.1};
	button:setFont(UIFont.Small);
	button:ignoreWidthChange();
	button:ignoreHeightChange();
	self:addChild(button);
	table.insert(self.buttons, button);
end

function ISCoxisShopPanel:createButton(x, y, _label, _internal, _function, player, playerId)
	local label = nil;
	label = getText(_label);
	local button = ISButton:new(x, y, 100, 25, label, self, _function);
	button:initialise();
	button.internal = _internal;
	button.borderColor = {r=1, g=1, b=1, a=0.1};
	button.playerId = playerId;
	button.char = player;
	button:setFont(UIFont.Small);
	button:ignoreWidthChange();
	button:ignoreHeightChange();
	self:addChild(button);
	table.insert(self.buttons, button);
end

function ISCoxisShopPanel:onBuyMouseDown(button, x, y)
	if button.internal == "buy" then
		local selectedItem = self.CoxisShopList.items[self.CoxisShopList.selected].item
		local splitstring = luautils.split(selectedItem, "|")
		if selectedItem ~= nil and self.char:getModData().playerMoney >= tonumber(splitstring[2]) then
			self.char:getModData().playerMoney = luautils.round(self.char:getModData().playerMoney - tonumber(splitstring[2]),0);
			self.char:getInventory():AddItem(splitstring[1]);
		end
	end
end

function ISCoxisShopPanel:onSellMouseDown(button, x, y)
	if button.internal == "sell" then
		local selectedItem = self.CoxisShopList.items[self.CoxisShopList.selected].item;
		local splitstring = luautils.split(selectedItem, "|");

		local item = self.char:getInventory():getFirstType(splitstring[1])
		if selectedItem ~= nil and item ~= nil then
			--判断所卖物品是否主手装备
			local primaryHandItem = self.char:getPrimaryHandItem();
			if primaryHandItem ~= nil and primaryHandItem == item then
				--是主手装备就清空手持
				self.char:removeFromHands(primaryHandItem);
			end
			--判断所卖物品是否副手装备
			local secondaryHandItem = self.char:getSecondaryHandItem();
			if secondaryHandItem ~= nil and secondaryHandItem == item then
				--是副手装备就清空手持
				self.char:removeFromHands(secondaryHandItem);
			end
			--判断所卖物品是否身上装备
			if self.char:isEquippedClothing(item) then
				--是身上装备就脱下来
				self.char:removeWornItem(item);
			end
			--10%价格出售
			self.char:getModData().playerMoney = luautils.round(self.char:getModData().playerMoney + tonumber(splitstring[2]) * 0.1,0);
			self.char:getInventory():Remove(item);
		end
	end
end

function ISCoxisShopPanel:new(x, y, width, height, player, _items)
	local o = {};
	o = ISPanelJoypad:new(x, y, width, height);
	o:noBackground();
	setmetatable(o, self);
    self.__index = self;
	o.char = getSpecificPlayer(player);
	o.playerId = player;
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	o.backgroundColor = {r=0, g=0, b=0, a=0.8};
	o.buttons = {};
	o.items = _items;
	o.CoxisShopList = nil;
   return o;
end

function ISCoxisShopList:new(x, y, width, height, player, playerId, parent)
	local o = {}
	--o.data = {}
	o = ISPanelJoypad:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	o.x = x;
	o.y = y;
	o:noBackground();
	o.backgroundColor = {r=0, g=0, b=0, a=0.8};
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=0.9};
	o.altBgColor = {r=0.2, g=0.3, b=0.2, a=0.1}
	o.listHeaderColor = {r=0.4, g=0.4, b=0.4, a=0.3};
	-- Since these were broken before, don't draw them by default
	o.altBgColor = nil
	o.drawBorder = false
	o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.font = UIFont.Large
	o.fontHgt = getTextManager():getFontFromEnum(o.font):getLineHeight()
	o.itemPadY = 7
	o.itemheight = o.fontHgt + o.itemPadY * 2;
	o.selected = 1;
    o.count = 0;
	o.itemheightoverride = {};
	o.items = {};
	o.columns = {};
	o.char = player;
	o.playerId = playerId;
	o.parent = parent;
	return o
end
