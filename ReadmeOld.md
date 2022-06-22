# SimpleFlare
A simple flare system. <br></br>
Possible uses are:
- Laser flares.
- Scope reflections.

### Demo:
<!--![image](assets/Demo.gif)-->

---
## Documentation <br></br>

### Types <br></br>
#### SimpleFlare
```lua
export type SimpleFlare = {
	Dispose: boolean;
	OriginalSize: UDim2;
	Instance: BillboardGui;
}
```

### Functions <br></br>
#### SimpleFlare.new
Constructs a new SimpleFlare object.
```lua
function SimpleFlare.new(adornee: Part | Attachment, flareImageId: string, originalSize: UDim2): SimpleFlare
```
<br></br>

#### SimpleFlare:Destroy
Destroys the SimpleFlare object.
```lua
function SimpleFlare:Destroy(): void
```

---
## Testing Instructions
- Put SimpleFlare.lua in ReplicatedStorage
- Put ExampleFlare.lua in ReplicatedStorage
- Put SimpleFlareTester.client.lua in StarterPlayerScripts

It should look like this: <br></br>
<!--![image](assets/Directories.PNG)-->

After that just hit Play and see it in action. <br></br>
Note that the attachment is in `0, 10, 20` of workspace.