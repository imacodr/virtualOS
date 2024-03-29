local module = {}

local HttpService = game:GetService("HttpService")

local FadeHandler = require(script.Parent.Utils.FadeHandler)
local Constants = require(script.Parent.Utils.Constants)
local DevSoftwareHandler = require(script.Parent.DevSoftwareHandler)
local LaunchService = require(script.Parent.Services.LaunchService)

function getAccount(player)
	local url = Constants.APIUrl .."/check-account/" .. player.UserId


	local success,result = pcall(function()
		return HttpService:GetAsync(url, false)
	end)


	if success then
	local tablefy = HttpService:JSONDecode(result)
		return tablefy
	else
		return {ok = false}
	end
end


function module:initOnStart(player, ui)
	local account = getAccount(player)
	ui.Enabled = true
	ui.System:TweenPosition(UDim2.new(0.156, 0,0.224, 0), 0.3)
	ui.System.Screen.SystemSetup.ImageLabel:TweenPosition(UDim2.new(0.435, 0,0.342, 0), "Out", "Bounce", 0.5, true)
	wait(3)
	ui.System.Screen.SystemSetup.ImageLabel:TweenSizeAndPosition(UDim2.new(0.094, 0,0.208, 0), UDim2.new(0.373, 0,0.391, 0))

	ui.System.TurnOff.MouseButton1Click:Connect(function()
		player.Character.Humanoid:UnequipTools()
	end)
	FadeHandler:FadeIn(ui.System.Screen.SystemSetup)
	wait(3)
	
	local userId = player.UserId
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size420x420
	local content = game.Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
	
	ui.System.Screen.HomeScreen.UserPicture.Image = content
	ui.System.Screen.HomeScreen.UserPicture.MouseButton1Click:Connect(function()
		ui.System.Screen.HomeScreen.Visible = false
		ui.System.Screen.AccountSettings.Visible = true
	end)
	ui.System.Screen.AccountSettings.Close.MouseButton1Click:Connect(function()
		ui.System.Screen.HomeScreen.Visible = true
		ui.System.Screen.AccountSettings.Visible = false
	end)
	self:LoadApps(player, ui, account)
	
	FadeHandler:FadeOut(ui.System.Screen.SystemSetup)
	ui.System.Screen.HomeScreen.Visible = true

	
end

function module:LoadApps(player, ui, account)
	print("hey")
    local AppsPath = ui.System.Screen.HomeScreen.AppsFrame

	local SoftwareTemplate = ui.System.Screen.HomeScreen.App
	print(account.data.userSoftware)

	for _,software in ipairs(account.data.userSoftwares) do
		local cloned = SoftwareTemplate:Clone()
		cloned.Image = "rbxassetid://"..software.icon
		cloned.Parent = AppsPath
		cloned.Size = UDim2.new(0.191, 0,0.834, 0)
		cloned.AppName.Text = software.name
		cloned.BorderSizePixel = 0
		cloned.AppName.TextTransparency = 1
		cloned.Visible = true
		cloned.MouseButton1Click:Connect(function()
			LaunchService:StartSoftware(player, ui, software)
		end)

	end
	
	DevSoftwareHandler:init(player, ui)
end

return module