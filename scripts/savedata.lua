#include "datascripts/keybinds.lua"

moddataPrefix = "savegame.mod.pixelated"

function saveFileInit()
	saveVersion = GetInt(moddataPrefix .. "Version")
	
	binds["Toggle_Pixelated"] = GetString(moddataPrefix.. "TogglePixelatedKey")
	binds["Open_Menu"] = GetString(moddataPrefix.. "OpenMenuKey")
	
	resolution = GetInt(moddataPrefix.. "Resolution")
	
	if saveVersion < 1 or saveVersion == nil then
		saveVersion = 1
		SetInt(moddataPrefix .. "Version", saveVersion)
		
		binds["Toggle_Pixelated"] = getFromBackup("Toggle_Pixelated")
		SetString(moddataPrefix.. "TogglePixelatedKey", binds["Toggle_Pixelated"])
		
		binds["Open_Menu"] = getFromBackup("Open_Menu")
		SetString(moddataPrefix.. "OpenMenuKey", binds["Open_Menu"])
		
		resolution = 50
		SetInt(moddataPrefix.. "Resolution", resolution)
	end
end

function saveKeyBinds()
	SetString(moddataPrefix.. "TogglePixelatedKey", binds["Toggle_Pixelated"])
end

function saveFloatValues()
	SetFloat(moddataPrefix .. "Resolution", resolution)
end