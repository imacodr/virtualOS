local module = {}

local FadeHandler = require(script.Parent.Parent.Utils.FadeHandler)

function module:StartSoftware(player, ui, software)
    local testModule
    
    ui.launch.Visible = true
    ui.launch.launchingLabel.Text = software.name
    ui.launch.creatorLabel.Text = "by "..software.creator
    
    wait(3)
    ui.System.Visible = false
    ui.launch:TweenSizeAndPosition(UDim2.new(0.678, 0,0.759, 0), UDim2.new(0.156, 0,0.121, 0))
    
    local suc, erm = pcall(function()
        testModule = require(software.require).initiate(player, ui.launch)
    end)

    print(testModule)
    if not suc then
        ui.error.errorMessage.Text = erm
        FadeHandler:FadeIn(ui.error)
        wait(6)
        FadeHandler:FadeOut(ui.error)
        ui.launch:TweenSizeAndPosition(UDim2.new(0.455, 0,0.438, 0), UDim2.new(0.271, 0,0.284, 0))
       
        ui.System.Visible = true
        ui.launch.Visible = false
    end

end


return module