local module = {}

local HttpService = game:GetService("HttpService")

local FadeHandler = require(script.Parent.Utils.FadeHandler)
local DevSoftwareHandler = require(script.Parent.DevSoftwareHandler)

local baseURL = "http://localhost:3000/api"

function getAccount(player)
	local url = baseURL .."/check-account/" .. player.UserId


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
	print("test")
	ui.System.Screen.SystemSetup.ImageLabel:TweenPosition(UDim2.new(0.433, 0,0.344, 0), "Out", "Bounce", 0.5, true)
	wait(3)
	ui.System.Screen.SystemSetup.ImageLabel:TweenSizeAndPosition(UDim2.new(0.402, 0,0.26, 0), UDim2.new(0.367, 0,0.36, 0))
	FadeHandler:FadeIn(ui.System.Screen.SystemSetup)
	self:LoadApps(player, ui)
	
end

function module:LoadApps(player, ui)
	print("hey")
	local account = getAccount(player)
	print(account)
    local AppsPath = ui.System.Screen.HomeScreen.AppsFrame
	
	DevSoftwareHandler.init()

    

end

return module