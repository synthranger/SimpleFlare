local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

assert(RunService:IsClient(), "This module only works on the Client!")

local DEFAULT_FLARE_IMAGE = "rbxassetid://1847258023"

local defaultFlare = Instance.new("BillboardGui")
defaultFlare.Name = "DefaultFlare"
defaultFlare.Active = true
defaultFlare.ClipsDescendants = true
defaultFlare.Size = UDim2.fromScale(5, 5)
defaultFlare.ResetOnSpawn = false
defaultFlare.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "ImageLabel"
imageLabel.Image = DEFAULT_FLARE_IMAGE
imageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
imageLabel.BackgroundTransparency = 1
imageLabel.Size = UDim2.fromScale(1, 1)
imageLabel.Parent = defaultFlare

export type SimpleFlare = {
	Dispose: boolean;
	OriginalSize: UDim2;
	Instance: typeof(defaultFlare);
}

local Flares: {SimpleFlare} = {}

--[=[
	@class SimpleFlare
]=]
--[=[
	A boolean that determines if the SimpleFlare object will be destroyed in the next renderstep frame.
	@prop Dispose boolean
	@within SimpleFlare
	@readonly
]=]
--[=[
	The BillboardGui that the SimpleFlare object renders.
	@prop Instance BillboardGui
	@within SimpleFlare
	@readonly
]=]
--[=[
	The base size of the flare that was passed in the `originalSize` argument of the SimpleFlare constuctor.
	You can set this property to anything you like.
	@prop OriginalSize UDim2
	@within SimpleFlare
]=]
local SimpleFlare = {}
SimpleFlare.__index = SimpleFlare

local function getLookVector(object: Part | Attachment): Vector3
	if object:IsA("Part") then
		return object.CFrame.LookVector
	elseif object:IsA("Attachment") then
		return object.WorldCFrame.LookVector
	end
end

--[=[
	Schedules the SimpleFlare to be destroyed in the next renderstep frame.
	@return void
]=]
function SimpleFlare:Destroy()
	self.Instance:Destroy()
end

--[=[
	Creates a SimpleFlare object.
	
	@param adornee Part | Attachment -- The adornee of the flare
	@param flareImageId string -- The imageId of the flare
	@param originalSize UDim2 -- The base size of the flare
	@return SimpleFlare
]=]
function SimpleFlare.new(adornee: Part | Attachment, flareImageId: string, originalSize: UDim2): SimpleFlare
	local self : SimpleFlare= setmetatable({
		Dispose = false;
		OriginalSize = originalSize or UDim2.new(1, 0, 1, 0);
		Instance = defaultFlare:Clone();
	}, SimpleFlare)
	
	self.Instance.Adornee = adornee
	self.Instance.ImageLabel.Image = flareImageId or DEFAULT_FLARE_IMAGE
	self.Instance.Destroying:Connect(function()
		self.Dispose = true
	end)
	
	self.Instance.Parent = LocalPlayer.PlayerGui
	
	task.defer(table.insert, Flares, self)
	return self
end

RunService:BindToRenderStep("UpdateSimpleFlare", Enum.RenderPriority.Last.Value, function(deltaTime)
	if #Flares > 0 then
		local camera = workspace.CurrentCamera
		local cameraLookVector = camera.CFrame.LookVector

		local offset = 0
		for index, flare in pairs(Flares) do
			if not flare.Dispose then
				if flare.Instance.Enabled and flare.Instance.Adornee ~= nil and 
					(flare.Instance.Adornee:IsA("Part") or flare.Instance.Adornee:IsA("Attachment")) then
					
					local adorneeLookVector = getLookVector(flare.Instance.Adornee)
					local dotProduct = math.clamp(-cameraLookVector:Dot(adorneeLookVector), 0, 1)
					flare.Instance.Size = UDim2.new(
						flare.OriginalSize.X.Scale * dotProduct, 0, 
						flare.OriginalSize.Y.Scale * dotProduct, 0
					)
				end
			else
				table.remove(Flares, index - offset)
				offset = offset + 1
			end
		end
	end
end)

return SimpleFlare