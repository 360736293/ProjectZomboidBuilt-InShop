require "ISUI/ISPanelJoypad"
require "ISUI/ISLayoutManager"
require "Vehicles/ISUI/ISVehicleMechanics"
require 'CoxisShop'

ISCoxisShopPanelSpecials = ISPanelJoypad:derive("ISCoxisShopPanelSpecials");
ISCoxisShopList = ISScrollingListBox:derive("ISCoxisShopList");
ISCoxisScrollbar = ISScrollBar:derive("ISCoxisScrollbar");

CoxisShopUI = {};
CoxisShopUI.items = {};
-- 玩家传送UI界面对象数组
CoxisShop.teleportScreen = {};

--初始化面板
function ISCoxisShopPanelSpecials:initialise()
	ISPanelJoypad.initialise(self);
	self:create();
end

--渲染面板
function ISCoxisShopPanelSpecials:render()
	local y = 42;

	self:drawText(self.char:getDescriptor():getForename().." "..self.char:getDescriptor():getSurname(), 20, y, 1,1,1,1, UIFont.Medium);
	y = y + 25;
	self:drawText(getText('UI_CoxisShop_Px_Money', self.playerId, self.char:getModData().playerMoney), 20, y, 1,1,1,1, UIFont.Small);
end

--创建面板对象
function ISCoxisShopPanelSpecials:create()
	local y = 90;

	local label = ISLabel:new(16, y, 20, getText('UI_CoxisShop_AvailFuncs'), 1, 1, 1, 0.8, UIFont.Small, true);
	self:addChild(label);

	local rect = ISRect:new(16, y + 20, 390, 1, 0.6, 0.6, 0.6, 0.6);
	self:addChild(rect);

	self.CoxisShopList = ISCoxisShopList:new(16, y + 30, 390, 200, self.char, self.playerId, self);
    self.CoxisShopList:initialise()
    self.CoxisShopList:instantiate()
    self.CoxisShopList.itemheight = 22
    self.CoxisShopList.font = UIFont.NewSmall
    self.CoxisShopList.drawBorder = true
    self:addChild(self.CoxisShopList)

	--遍历特殊配置列表
	for functionString,value in pairs(self.items) do
		--获取语言表里面的特殊功能名
		local functionName = getText(functionString);
		--添加特殊商品
		self.CoxisShopList:addItem(functionName .. " (" .. value .. ")",functionString.. "|" .. value);
	end
	self.CoxisShopBuyButton = self:createButton(290, y-15, self.onBuyMouseDown, self.char, self.playerId);
end

--创建商店物品按钮
function ISCoxisShopPanelSpecials:createItemButton(x, y, itemType, cost)
	local item = ScriptManager.instance:getItem(itemType)
	local label = nil
	if item:getCount() > 1 then
		label = getText('UI_CoxisShop_ItemButton2', item:getDisplayName(), item:getCount(), cost)
	else
		label = getText('UI_CoxisShop_ItemButton', item:getDisplayName(), cost)
	end
	local button = ISButton:new(x, y, 100, 25, label, self, ISCoxisShopPanelSpecials.onOptionMouseDown);
	button:initialise();
	button.item = itemType;
	button.cost = cost;
	button.borderColor = {r=1, g=1, b=1, a=0.1};
	button:setFont(UIFont.Small);
	button:ignoreWidthChange();
	button:ignoreHeightChange();
	self:addChild(button);
	table.insert(self.buttons, button);
end

--创建购买按钮
function ISCoxisShopPanelSpecials:createButton(x, y, _function, player, playerId)
	local label = nil;
	label = getText('UI_CoxisShop_BuyButton')
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

--点击购买按钮
function ISCoxisShopPanelSpecials:onBuyMouseDown(button, x, y)
	local selectedFunction = self.CoxisShopList.items[self.CoxisShopList.selected].item
	--获取商品
	local splitstring = luautils.split(selectedFunction, "|");
	if selectedFunction ~= nil and self.char:getModData().playerMoney >= tonumber(splitstring[2]) then

		--治愈自己
		if(splitstring[1] == "UI_CoxisShop_Healing") then
			getPlayer():getBodyDamage():RestoreToFullHealth();
		end

		--修复右手装备耐久
		if(splitstring[1] == "UI_CoxisShop_Repairing") then
			getPlayer():getPrimaryHandItem():setCondition(getPlayer():getPrimaryHandItem():getConditionMax());
		end

		--获得车钥匙
		if(splitstring[1] == "UI_CoxisShop_GetKey") then
			sendClientCommand(getPlayer(), "vehicle", "getKey", { vehicle = getPlayer():getVehicle():getId() })
		end

		--修复车辆
		if(splitstring[1] == "UI_CoxisShop_Repair_Vehicle") then
			sendClientCommand(getPlayer(), "vehicle", "repair", { vehicle = getPlayer():getVehicle():getId() })
		end

		--复制右手装备
		if(splitstring[1] == "UI_CoxisShop_Copy_RH_Equipment") then
			local primaryHandItem = self.char:getPrimaryHandItem();
			if primaryHandItem ~= nil then
				self.char:getInventory():AddItem(primaryHandItem:getType());
			else
				return;
			end
		end

		--传送
		if(splitstring[1] == "UI_CoxisShop_Teleport") then
			--打开传送坐标面板
			CoxisShop.showTeleportScreen(CoxisShop.getCurrentPlayerIndexNum());
		end

		--在最后扣钱，避免功能未生效却把钱扣了
		self.char:getModData().playerMoney = luautils.round(self.char:getModData().playerMoney - tonumber(splitstring[2]),0);
	end
end

--显示传送面板UI
CoxisShop.showTeleportScreen = function(playerNum)
	if not CoxisShop.teleportScreen[playerNum] then
		local x = getPlayerScreenLeft(playerNum);
		local y = getPlayerScreenTop(playerNum);
		-- 初始化UI界面对象
		CoxisShop.teleportScreen[playerNum] = ISCoxisShopTeleport:new(x+215,y+180,270,185,playerNum);
		CoxisShop.teleportScreen[playerNum]:initialise();
		CoxisShop.teleportScreen[playerNum]:addToUIManager();
		-- 初始化为false，只有为false下面的判断才会setVisible为true
		CoxisShop.teleportScreen[playerNum]:setVisible(false);
	end

	-- 开关UI界面
	if CoxisShop.teleportScreen[playerNum]:getIsVisible() then
		CoxisShop.teleportScreen[playerNum]:setVisible(false)
	else
		CoxisShop.teleportScreen[playerNum]:setVisible(true)
	end
end

--实例化面板对象
function ISCoxisShopPanelSpecials:new(x, y, width, height, player, _items)
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
	o = ISPanelJoypad:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	o.x = x;
	o.y = y;
	o:noBackground();
	o.backgroundColor = {r=0, g=0, b=0, a=0.8};
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=0.9};
	o.altBgColor = {r=0.2, g=0.3, b=0.2, a=0.1}
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
	o.itemheightoverride = {}
	o.items = {}
	o.columns = {}
	o.char = player;
	o.playerId = playerId;
	o.parent = parent;
	return o
end
