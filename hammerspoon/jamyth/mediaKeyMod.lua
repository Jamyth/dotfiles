local m = {}
local hyper = hs.hotkey.modal.new()

m.hyperKeyBind = nil
m.hyperKeySingle = true

local function systemKeyEventGenerator(key)
	return {
		["d"] = hs.eventtap.event.newSystemKeyEvent(key, true),
		["u"] = hs.eventtap.event.newSystemKeyEvent(key, false),
	}
end

local soundUpKey = systemKeyEventGenerator("SOUND_UP")
local soundDownKey = systemKeyEventGenerator("SOUND_DOWN")
local playKey = systemKeyEventGenerator("PLAY")
local nextKey = systemKeyEventGenerator("NEXT")
local previousKey = systemKeyEventGenerator("PREVIOUS")
local muteKey = systemKeyEventGenerator("MTUE")

local function enterHyperMode()
	m.hyperKeySingle = true
	hyper:enter()
end

local function exitHyperMode()
	m.hyperKeyBind:disable()
	if m.hyperKeySingle == true then
		hs.eventtap.keyStroke({}, "\\")
	end
	m.hyperKeyBind:enable()
	hyper:exit()
end

local function hyperPressedWrap(fn)
	return function()
		m.hyperKeySingle = false
	end
end

local function sysKeyDownFn(key)
	return function()
		key.d:post()
	end
end

local function sysKeyUpFn(key)
	return function()
		key.u:post()
	end
end

m.hyperKeyBind = hs.hotkey.bind({}, "\\", enterHyperMode, exitHyperMode)

hyper.bind({})
