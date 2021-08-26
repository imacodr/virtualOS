local module = {}

function module:StartSoftware(player, ui, software)
    ui.launch.Visible = true
    ui.launch.launchingLabel.Text = software.name
    ui.launch.creatorLabel.Text = "by "..software.creator

    wait(3)
    ui.System.Visible = false
    ui.launch:TweenSizeAndPosition(UDim2.new(0.678, 0,0.759, 0), UDim2.new(0.156, 0,0.121, 0))


end


return module