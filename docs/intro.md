---
sidebar_position: 1
---
# Getting Started

## Usage Example
```lua
local SimpleFlare = require(path.to.SimpleFlare)

local att = Instance.new("Attachment")
att.WorldOrientation = Vector3.new(0, 0, 0)
att.WorldPosition = Vector3.new(0, 10, 20)
att.Parent = workspace.Terrain

local newFlare = SimpleFlare.new(att, nil, UDim2.new(10, 0, 10, 0))
print(newFlare.Dispose) -- false
newFlare:Destroy()
print(newFlare.Dispose) -- true
```

## Testing Instructions

- Put src/SimpleFlare.lua in ReplicatedStorage
- Put src/tests/ExampleFlare.lua in ReplicatedStorage
- Put src/tests/SimpleFlareTester.client.lua in StarterPlayerScripts

It should look like this: <br></br>
![image](../static/Directories.PNG)

After that just hit Play and see it in action. <br></br>
Note that the attachment is in `0, 10, 20` of workspace.