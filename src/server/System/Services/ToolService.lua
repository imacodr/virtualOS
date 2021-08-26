local module = {}


function module:LoadTool(player, ui)
	local tool = script.Parent.Parent.Models.VirtualPad:Clone()
	tool.Parent = player.Backpack
    tool.Equipped:Connect(function()
wait(2)
        tool.Screen.Material = Enum.Material.Neon
        tool.Screen.Color = Color3.fromRGB(255,255,255)
        wait(0.5)
        ui.Enabled = true
	    ui.System:TweenPosition(UDim2.new(0.156, 0,0.224, 0), 0.3)
    end)
    
    tool.Unequipped:Connect(function()

            tool.Screen.Material = Enum.Material.SmoothPlastic
            tool.Screen.Color = Color3.fromRGB(27, 42, 53)
            ui.System:TweenPosition(UDim2.new(0.156, 0,1, 0), 0.3)
    end)

end

return module