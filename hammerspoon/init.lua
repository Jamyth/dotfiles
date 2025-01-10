local myAppChooser = require("./jamyth/myAppChooser")
local myWindowChooser = require("./jamyth/myWindowChooser")

hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "\\", function()
	hs.reload()
end)

-- Key-binding
local appChooserHotkeyModal = hs.hotkey.modal.new("cmd", "space")
local windowChooserHotkeyModal = hs.hotkey.modal.new(nil, nil)
local mw = hs.hotkey.modal.new(nil, nil)

hs.hotkey.bind(nil, "f13", function()
	mw:enter()
end)

appChooserHotkeyModal:bind("", "m", function()
	appChooserHotkeyModal:exit()
	mw:enter()
end)

myAppChooser.chooserSetup(appChooserHotkeyModal, windowChooserHotkeyModal)
myWindowChooser.windowChooserSetup(windowChooserHotkeyModal)
