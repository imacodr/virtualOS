local module = {}

local TS = game:GetService("TweenService")

function module:FadeOut(frame)
	for _,v in pairs(frame:GetDescendants()) do
		if (v:IsA("Frame") or v:IsA("TextBox")) then
		local tween = TS:Create(v, TweenInfo.new(1), {BackgroundTransparency = 1})
		tween:Play()
		end
		
		if (v:IsA("ImageLabel") or v:IsA("ImageButton")) then
			local tween = TS:Create(v, TweenInfo.new(1), {ImageTransparency = 1})
			tween:Play()
		end
		if (v:IsA("TextLabel")) then
			local tween = TS:Create(v, TweenInfo.new(1), {TextTransparency = 1})
			tween:Play()
		end
	end
	wait(4)
	frame.Visible = false
end

function module:FadeIn(frame)
	frame.Visible = true
	wait(1)
	for _,v in pairs(frame:GetDescendants()) do
		if (v:IsA("Frame") or v:IsA("TextBox")) then
			local tween = TS:Create(v, TweenInfo.new(1), {BackgroundTransparency = 0})
			tween:Play()
		end

		if (v:IsA("ImageLabel") or v:IsA("ImageButton")) then
			local tween = TS:Create(v, TweenInfo.new(1), {ImageTransparency = 0})
			tween:Play()
		end
		if (v:IsA("TextLabel")) then
			local tween = TS:Create(v, TweenInfo.new(1), {TextTransparency = 0})
			tween:Play()
		end
	end
end

return module
