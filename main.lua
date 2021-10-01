#include "scripts/utils.lua"
#include "scripts/savedata.lua"
#include "scripts/menu.lua"
#include "datascripts/keybinds.lua"
#include "datascripts/inputList.lua"

toolName = "pixelated"
toolReadableName = "Pixelated"

local menu_disabled = false

resolution = 50
targetResolution = 50
gotoResSpeed = 10
local pixelsActive = false

local widthMax = 4
local heightMax = 2

local fovWPerRes = widthMax / resolution
local fovHPerRes = heightMax / resolution

function init()
	saveFileInit()
	menu_init()
	
	targetResolution = resolution
end

function tick(dt)
	if not menu_disabled then
		menu_tick(dt)
	end
	
	
	local isMenuOpenRightNow = isMenuOpen()
	
	if InputPressed(binds["Toggle_Pixelated"]) and not isMenuOpenRightNow then
		togglePixelated()
	end
	
	if pixelsActive and resolution ~= targetResolution then
		if resolution > targetResolution then
			resolution = resolution - dt * gotoResSpeed
			
			if resolution <= targetResolution then
				resolution = targetResolution
			end
		else
			resolution = resolution + dt * gotoResSpeed
			
			if resolution >= targetResolution then
				resolution = targetResolution
			end
		end
	else
		resolution = targetResolution
	end
end

function draw(dt)
	drawUI(dt)
	
	if pixelsActive then
		drawPixels()
	end
	
	menu_draw(dt)
end

-- UI Functions (excludes sound specific functions)

function drawUI(dt)
	
end

function drawPixels()
	local roundedRes = getRoundedResolution()
	
	local UiWidthPerPixel = math.ceil(UiWidth() / roundedRes)
	local UiHeightPerPixel = math.ceil(UiHeight() / roundedRes)
	
	widthMax = 4 / 50 * roundedRes
	heightMax = 2 / 50 * roundedRes

	fovWPerRes = widthMax / roundedRes
	fovHPerRes = heightMax / roundedRes
	
	for x = 0, roundedRes - 1 do
		for y = 0, roundedRes - 1 do
			drawAt(x, y, UiWidthPerPixel, UiHeightPerPixel)
		end
	end
end

function drawAt(x, y, pixelWidth, pixelHeight)
	UiPush()
		local roundedRes = getRoundedResolution()
	
		local rayOrigTransform = GetCameraTransform()
	
		local color = {0, 0.75, 1}
		
		local xDir = fovWPerRes * x - widthMax / 2
		local halfX = fovWPerRes * (roundedRes / 2) - widthMax / 2
		
		local yDir = fovHPerRes * (roundedRes - y) - heightMax / 2
		local halfY = fovHPerRes * (roundedRes / 2) - heightMax / 2
		
		xDir = xDir / 2
		yDir = yDir / 2
		
		halfX = halfX / 2
		halfY = halfY / 2
		
		local localRayDir = Vec(-halfX + xDir, -halfY + yDir, -1)
		local rayDir = VecDir(rayOrigTransform.pos, TransformToParentPoint(rayOrigTransform, localRayDir))
	
		local hit, hitPoint, distance, normal, shape = raycast(rayOrigTransform.pos, rayDir, 250, 0, true)
		
		if hit then
			local mat, r, g, b, a = GetShapeMaterialAtPosition(shape, hitPoint)
			
			local inWater = IsPointInWater(hitPoint)
			
			color[1] = r
			color[2] = g
			color[3] = b
			
			if inWater then
				color[3] = color[3] + 0.25
				
				if color[3] > 1 then 
					color[3] = 1
				end
			end
		end
		
		UiColor(color[1], color[2], color[3], 1)
		UiTranslate(x * pixelWidth, y * pixelHeight)
		UiRect(pixelWidth, pixelHeight)
	UiPop()
end
-- Creation Functions

-- Object handlers

-- Tool Functions

-- Particle Functions

-- Action functions

function togglePixelated()
	pixelsActive = not pixelsActive
end

function getRoundedResolution()
	return math.floor(resolution)
end

-- Sprite Functions

-- UI Sound Functions

-- Misc Functions