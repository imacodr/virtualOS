local module = {}

local HttpService = game:GetService("HttpService")

local FadeHandler = require(script.Parent.Utils.FadeHandler)
local Constants = require(script.Parent.Utils.Constants)
local DevSoftwareHandler = require(script.Parent.DevSoftwareHandler)
local LaunchService = require(script.Parent.LaunchSoftware)

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
	ui.System.Screen.SystemSetup.ImageLabel:TweenPosition(UDim2.new(0.433, 0,0.344, 0), "Out", "Bounce", 0.5, true)
	wait(3)
	ui.System.Screen.SystemSetup.ImageLabel:TweenSizeAndPosition(UDim2.new(0.402, 0,0.26, 0), UDim2.new(0.367, 0,0.36, 0))
	FadeHandler:FadeIn(ui.System.Screen.SystemSetup)

	local userId = player.UserId
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size420x420
	local content, isReady = game.Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

	ui.System.Screen.HomeScreen.UserPicture.Image = content
	self:LoadApps(player, ui, account)

	FadeHandler:FadeOut(ui.System.Screen.SystemSetup)
	FadeHandler:FadeIn(ui.System.Screen.HomeScreen)
	
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
		cloned.Visible = true
		cloned.MouseButton1Click:Connect(function()
			LaunchService:StartSoftware(player, ui, software)
		end)

	end
	
	DevSoftwareHandler:init(player, ui)

    

end

return module