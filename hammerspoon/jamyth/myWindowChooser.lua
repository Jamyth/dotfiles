local m = {}

m.windowChooserSetup = function(hotkeyModal)
	local self = {}
	self.windowChooser = nil
	self.myWindowList = {}

	self.windowChooser = hs.chooser
		.new(function(info)
			if info ~= nil then
				info["id"]:focus()
			end
		end)
		:rows(0)
		:bgDark(true)
		:choices(function()
			local focusedApplication = hs.window.focusedWindow():application()
			local choices = {}
			for k, window in pairs(focusedApplication:allWindows()) do
				choices[k] = {
					["text"] = window:title(),
					["subText"] = focusedApplication:name(),
					["id"] = window,
					["image"] = hs.image.imageFromAppBundle(focusedApplication:bundleID()),
				}
			end
			self.myWindowList = choices
			self.windowChooser:rows(#choices + 4)
			return choices
		end)
		:queryChangedCallback(function(q)
			self.windowChooser:query(nil)
		end)
		:hideCallback(function()
			hotkeyModal:exit()
		end)

	hotkeyModal.entered = function()
		self.windowChooser:refreshChoicesCallback()
		self.windowChooser:show()
	end

	hotkeyModal.exited = function()
		self.windowChooser:hide()
	end

	for i = 1, 9, 1 do
		hotkeyModal:bind("", tostring(i), function()
			hotkeyModal:exit()
			self.myWindowList[i]["id"]:focus()
		end)
	end

	for i, name in ipairs({ "a", "s", "d", "f", "g" }) do
		hotkeyModal:bind("", name, function()
			hotkeyModal:exit()
			self.myWindowList[i]["id"]:focus()
		end)
	end

	hotkeyModal:bind("", "escape", function()
		hotkeyModal:exit()
	end)
end

return m
