local AppHandler = require(script.AppHandler)
local ToolService = require(script.Services.ToolService)

game.Players.PlayerAdded:Connect(function(player)
	wait(3)
	repeat
		wait(4)
	until player and player.PlayerGui


	ToolService:LoadTool(player, player.PlayerGui.PadSystem)
	
    AppHandler:initOnStart(player, player.PlayerGui.PadSystem)

end)
