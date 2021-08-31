local module = {}

local ToolService = require(script.Services.ToolService)

function initalize(settings) 
	game.Players.PlayerAdded:Connect(function(player)
		wait(3)
		repeat
			wait(4)
		until player and player.PlayerGui
	
		local clonedGui = script.Gui.PadSystem:Clone()
		clonedGui.Parent = player.PlayerGui
	
		script:SetAttribute("firstStart", true)
	
		print(script:GetAttributes())
	
	
		ToolService:LoadTool(player, player.PlayerGui.PadSystem)
	end)

end


module.initalize = initalize

return module