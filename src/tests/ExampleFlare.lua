-- Put this in ReplicatedStorage along with SimpleFlare to test
local SimpleFlare = require(game.ReplicatedStorage.SimpleFlare)

local ExampleFlare = {}

function ExampleFlare.new()
	local att = Instance.new("Attachment")
	att.WorldOrientation = Vector3.new(0, 0, 0)
	att.WorldPosition = Vector3.new(0, 10, 20)
	att.Parent = workspace.Terrain
	
	local self = SimpleFlare.new(att, nil, UDim2.new(10, 0, 10, 0))
	return self
end

return ExampleFlare