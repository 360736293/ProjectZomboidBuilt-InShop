require 'CoxisUtil'
require 'ISCoxisShop'

CoxisShop = {};
-- mod保存数据数组，存储每个玩家如金钱等数据
CoxisShop.modData = {};
-- 玩家UI界面对象数组
CoxisShop.upgradeScreen = {};
-- 配置内容数组
CoxisShop.settings = {};
-- 玩家临时金钱数组
CoxisShop.playerMoneyTemp = {};
-- 玩家临时死亡次数数组
CoxisShop.playerDeathCountTemp = {};
-- 玩家击杀僵尸数数组
CoxisShop.zombieKills = {};

-- **************************************************************************************
-- 初始化玩家金钱，死亡次数
-- **************************************************************************************
CoxisShop.InitPlayer = function()
	local player = getPlayer();
	local playerIndex = CoxisShop.getCurrentPlayerIndexNum();
	CoxisShop.modData[playerIndex] = player:getModData();

	-- 如果临时玩家金钱和临时玩家死亡次数不为空，说明是死亡后的重新初始化，要将二者数据保存下来，不然重启服务器后临时数据会丢失
	if CoxisShop.playerMoneyTemp[playerIndex] ~= nil and CoxisShop.playerDeathCountTemp[playerIndex] ~= nil then
		CoxisShop.modData[playerIndex].playerMoney = CoxisShop.playerMoneyTemp[playerIndex];
		CoxisShop.modData[playerIndex].playerDeathCount = CoxisShop.playerDeathCountTemp[playerIndex];
	end

	-- 从modData中读取玩家金钱和玩家死亡次数
	CoxisShop.playerMoneyTemp[playerIndex] = CoxisShop.modData[playerIndex].playerMoney;
	CoxisShop.playerDeathCountTemp[playerIndex] = CoxisShop.modData[playerIndex].playerDeathCount;

	if CoxisShop.playerDeathCountTemp[playerIndex] ~= nil and CoxisShop.playerDeathCountTemp[playerIndex] > 0 then
		-- 当前玩家死亡次数大于0则表示本次初始化是因为玩家死亡才进行的初始化，那么继承死亡前的金币数
		CoxisShop.modData[playerIndex].playerMoney = CoxisShop.playerMoneyTemp[playerIndex];
	else
		-- 刚创建角色的首次初始化
		CoxisShop.modData[playerIndex].playerMoney = CoxisShop.modData[playerIndex].playerMoney or tonumber(CoxisShop.settings["BASIC"]["initialMoney"]);
	end

	-- 从modData中读取玩家僵尸击杀数
	CoxisShop.zombieKills[playerIndex] = player:getZombieKills();
end


-- **************************************************************************************
-- 显示商店UI
-- **************************************************************************************
local function showUpgradeScreen(playerNum)
	if not CoxisShop.upgradeScreen[playerNum] then
		local x = getPlayerScreenLeft(playerNum);
		local y = getPlayerScreenTop(playerNum);
		-- 初始化UI界面对象
		CoxisShop.upgradeScreen[playerNum] = ISCoxisShop:new(x+70,y+50,620,408,playerNum, CoxisShop.settings);
		CoxisShop.upgradeScreen[playerNum]:initialise();
		CoxisShop.upgradeScreen[playerNum]:addToUIManager();
		-- 初始化为false，只有为false下面的判断才会setVisible为true
		CoxisShop.upgradeScreen[playerNum]:setVisible(false);
	else
		-- 初始化之后，每次开关面板都要重新加载技能面板更新技能列表
		ISCoxisShop.skillPannelInstance[playerNum]:reloadSkillItems();
	end
	-- 开关UI界面
	if CoxisShop.upgradeScreen[playerNum]:getIsVisible() then
		CoxisShop.upgradeScreen[playerNum]:setVisible(false);
	else
		CoxisShop.upgradeScreen[playerNum]:setVisible(true);
	end
end

-- **************************************************************************************
-- 当按键按下时触发
-- **************************************************************************************
CoxisShop.onKeyPressed = function(key)
	if key == getCore():getKey("OpenCoxisShop") then
		local player = getPlayer();
		if player:isAlive() then
			-- 显示商店UI
			showUpgradeScreen(CoxisShop.getCurrentPlayerIndexNum());
		end
	end
end

-- **************************************************************************************
-- 当玩家攻击结束时触发，判断玩家是否有击杀僵尸，有就加钱
-- **************************************************************************************
CoxisShop.onPlayerAttackFinished = function(player,handWeapon)
	local playerIndex = CoxisShop.getCurrentPlayerIndexNum();
	local playerNewKills = player:getZombieKills();
	local newCount = playerNewKills - CoxisShop.zombieKills[playerIndex];
	if playerNewKills > CoxisShop.zombieKills[playerIndex] then
		-- 说明该玩家有新的僵尸击杀，所以要给他加钱
		CoxisShop.modData[playerIndex].playerMoney = math.floor(CoxisShop.modData[playerIndex].playerMoney + (tonumber(CoxisShop.settings["BASIC"]["amount"])) * newCount);
		-- 更新击杀数
		CoxisShop.zombieKills[playerIndex] = playerNewKills;
	end
end

-- **************************************************************************************
-- 加载本地配置
-- **************************************************************************************
CoxisShop.LoadSettings = function()
	CoxisShop.settings = CoxisUtil.readLua("CoxisShopEnhancement", "media/lua/client/CoxisShopSettings.lua");
end

-- **************************************************************************************
-- 初始化，注册事件
-- **************************************************************************************
CoxisShop.init = function()
	-- 读取本地配置文件
	CoxisShop.LoadSettings(); 
	CoxisShop.InitPlayer();
	-- 监听键盘按键
	Events.OnKeyPressed.Add(CoxisShop.onKeyPressed);
	-- 当玩家状态更新时
	Events.OnPlayerAttackFinished.Add(CoxisShop.onPlayerAttackFinished);
end

-- **************************************************************************************
-- 玩家死亡时触发
-- **************************************************************************************
CoxisShop.prepareReInit = function()
	local playerIndex = CoxisShop.getCurrentPlayerIndexNum();
	-- 记录临时玩家金钱
	CoxisShop.playerMoneyTemp[playerIndex] = CoxisShop.modData[playerIndex].playerMoney;
	-- 临时玩家死亡次数加1
	if CoxisShop.playerDeathCountTemp[playerIndex] ~= nil then
		CoxisShop.playerDeathCountTemp[playerIndex] = CoxisShop.playerDeathCountTemp[playerIndex] + 1;
	else
		CoxisShop.playerDeathCountTemp[playerIndex] = 1;
	end
	-- 技能面板要初始化，所以将面板对象置空
	CoxisShop.upgradeScreen[playerIndex] = nil;
	-- 再次初始化玩家金钱，死亡次数
	Events.OnCreatePlayer.Add(CoxisShop.InitPlayer);
end

-- **************************************************************************************
-- 换日时触发，给予在线玩家日生存奖励
-- **************************************************************************************
CoxisShop.giveDailyMoney = function()
	for i = 0,getNumActivePlayers() - 1 do
		CoxisShop.modData[i].playerMoney = CoxisShop.modData[i].playerMoney + tonumber(CoxisShop.settings["BASIC"]["daily"]) + luautils.round(CoxisShop.modData[i].playerMoney * tonumber(CoxisShop.settings["BASIC"]["bonus"]),0);
	end
end

-- **************************************************************************************
-- 获取当前玩家索引号
-- return 当前玩家索引号
-- **************************************************************************************
CoxisShop.getCurrentPlayerIndexNum = function()
	local player = getPlayer();
	for i = 0,getNumActivePlayers() - 1 do
		local targetPlayer = getSpecificPlayer(i);
		if (player:getUsername() == targetPlayer:getUsername()) then
			return i;
		end
	end
end

-- **************************************************************************************
-- 注册事件
-- **************************************************************************************
Events.OnGameStart.Add(CoxisShop.init)
Events.EveryDays.Add(CoxisShop.giveDailyMoney)
Events.OnPlayerDeath.Add(CoxisShop.prepareReInit)
