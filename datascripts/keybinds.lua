#include "scripts/utils.lua"

binds = {
	Toggle_Pixelated = "p",
	Open_Menu = "m",
}

local bindBackup = deepcopy(binds)

bindOrder = {
	"Toggle_Pixelated",
	"Open_Menu",
}
		
bindNames = {
	Toggle_Pixelated = "Toggle Pixelated",
	Open_Menu = "Open Menu",
}

function resetKeybinds()
	binds = deepcopy(bindBackup)
end

function getFromBackup(id)
	return bindBackup[id]
end