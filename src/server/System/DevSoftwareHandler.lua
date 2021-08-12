local module = {}

local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local baseURL = "http://localhost:3000/api"

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
	local url = baseURL .."/check-account/" .. userId


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

function init()
    local response = getAccount()

    print(response.data)
end

module.init = init

return module
