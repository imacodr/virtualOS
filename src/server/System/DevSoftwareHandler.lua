local module = {}

local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local Constants = require(script.Parent.Utils.Constants)
local LaunchService = require(script.Parent.LaunchSoftware)

local PlaceId = game.PlaceId
local PlaceInfo = MarketplaceService:GetProductInfo(PlaceId)

local group

local userId

if game.CreatorType == Enum.CreatorType.Group then
    group = game:GetService("GroupService"):GetGroupInfoAsync(PlaceInfo.Creator.CreatorTargetId)
    userId = group.Owner.Id
else
    userId = PlaceInfo.Creator.CreatorTargetId
end

function getAccount()
	local url = Constants.APIUrl .."/check-account/" .. userId
	
	
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
local response = getAccount()

function module:init(player, ui)
	local AppsPath = ui.System.Screen.HomeScreen.AppsFrame

	local SoftwareTemplate = ui.System.Screen.HomeScreen.App
	

	for _,software in ipairs(response.data.devSoftwares) do
		print(software.icon)
		
		
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

end

return module
