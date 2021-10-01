#include "scripts/utils.lua"

binds = {
	Toggle_Pixelated = "p",
}

local bindBackup = deepcopy(binds)

bindOrder = {
	"Toggle_Pixelated",
}
		
bindNames = {
	Toggle_Pixelated = "Toggle Pixelated",
}

function resetKeybinds()
	binds = deepcopy(bindBackup)
end

function getFromBackup(id)
	return bindBackup[id]
end