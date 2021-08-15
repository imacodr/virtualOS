local AppHandler = require(script.AppHandler)

game.Players.PlayerAdded:Connect(function(player)
	wait(3)
	repeat
		wait(4)
	until player and player.PlayerGui

    AppHandler:initOnStart(player, player.PlayerGui.PadSystem)

end)
