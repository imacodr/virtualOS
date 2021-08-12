local AppHandler = require(script.AppHandler)


game.Players.PlayerAdded:Connect(function(player)
    wait(4)
    AppHandler:initOnStart(player, player.PlayerGui.PadSystem)


end)
