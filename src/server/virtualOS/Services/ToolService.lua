local module = {}

local AppHandler = require(script.Parent.Parent.AppHandler)

local started = false

function module:LoadTool(player, ui)
	local tool = script.Parent.Parent.Models.VirtualPad:Clone()
	tool.Parent = player.Backpack
    tool.TextureId = "rbxassetid://7364441788"
    tool.ToolTip = "VirtualPad | Powered by imacodr Inc"
    tool.GripForward = Vector3.new(-0.027, -0.682, 0.731)
    tool.GripPos = Vector3.new(-0.976, 0.274, -0.294)
    tool.GripRight = Vector3.new(-1, 0.018, -0.02)
    tool.GripUp = Vector3.new(0, 0.731, 0.683)
    tool.Equipped:Connect(function()
        if script.Parent.Parent:GetAttribute("firstStart") then
            if not started then
                started = true
                AppHandler:initOnStart(player, ui) 
            end
            script.Parent.Parent:SetAttribute("firstStart", false)
        end
        wait(1)
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