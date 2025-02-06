local m = {}

m.chooserSetup = function(hotkeyModal, nestedHotkeyModal)
	local self = {}
	self.registeredWindows = {}
	self.chooser = nil
	self.window = nil

	local shortcuts = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";" }
	local storagePath = hs.fs.pathToAbsolute("~/.hammerspoon/jamyth/windowList.json")

	local function saveWindowList()
		local windowIds = {}
		for k, window in pairs(self.registeredWindows) do
			windowIds[k] = window:id()
		end
		local file = io.open(storagePath, "w")
		if file then
			file:write(hs.json.encode(windowIds))
			file:close()
		end
	end

	local function loadWindowList()
		local file = io.open(storagePath, "r")
		print(storagePath)

		if file then
			local content = file:read("*a")
			local windowIds = hs.json.decode(content) or {}
			file:close()

			for k, windowId in pairs(windowIds) do
				local window = hs.window.get(windowId)
				if window then
					self.registeredWindows[#self.registeredWindows + 1] = window
				end
			end
			self.chooser:rows(#self.registeredWindows + 1)
			self.chooser:refreshChoicesCallback()
		end
	end

	hotkeyModal.entered = function()
		if self.chooser:rows() > 0 then
			self.chooser:show()
		end
		self.window = hs.window.focusedWindow()
	end

	hotkeyModal.exited = function()
		self.chooser:query(nil)
		self.chooser:hide()
	end

	self.chooser = hs.chooser
		.new(function(info)
			if info ~= nil then
				info["id"]:focus()
			end
		end)
		:rows(0)
		:bgDark(true)
		:choices(function()
			local choices = {}
			for k, window in ipairs(self.registeredWindows) do
				local app = window:application()
				local shortcutKey = shortcuts[k]:upper()
				choices[k] = {
					["text"] = shortcutKey .. " " .. app:name(),
					["subText"] = window:title(),
					["id"] = window,
					["image"] = hs.image.imageFromAppBundle(app:bundleID()),
				}
				print(hs.inspect(window:frame()))
			end
			return choices
		end)
		:queryChangedCallback(function(q)
			self.chooser:query(nil)
		end)
		:hideCallback(function()
			hotkeyModal:exit()
		end)

	hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "'", function()
		local focusedWindow = hs.window.focusedWindow()
		self.registeredWindows[#self.registeredWindows + 1] = focusedWindow
		self.chooser:rows(#self.registeredWindows + 1)
		saveWindowList()
		self.chooser:refreshChoicesCallback()
	end)

	for i = 1, 9, 1 do
		hs.hotkey.bind({ "cmd", "alt", "ctrl" }, tostring(i), function()
			local focusedWindow = hs.window.focusedWindow()
			self.registeredWindows[i] = focusedWindow
			self.chooser:refreshChoicesCallback()
			saveWindowList()
		end)
	end

	for i, name in ipairs(shortcuts) do
		hotkeyModal:bind("", name, function()
			hotkeyModal:exit()
			self.registeredWindows[i]:focus()
			local windowFrame = self.registeredWindows[i]:frame()
			hs.mouse.absolutePosition(
				hs.geometry(windowFrame.x + (windowFrame.w / 2), windowFrame.y + (windowFrame.h / 2))
			)
		end)
	end

	hotkeyModal:bind("", "space", function()
		hotkeyModal:exit()
		local windowFrame = hs.window.focusedWindow():frame()
		hs.mouse.absolutePosition(hs.geometry(windowFrame.x + (windowFrame.w / 2), windowFrame.y + (windowFrame.h / 2)))
	end)

	hotkeyModal:bind("", "escape", function()
		hotkeyModal:exit()
	end)

	if nestedHotkeyModal ~= nil then
		hotkeyModal:bind("cmd", "space", function()
			hotkeyModal:exit()
			nestedHotkeyModal:enter()
		end)
	end

	hotkeyModal:bind("", "q", function()
		hotkeyModal:exit()
	end)

	hotkeyModal:bind("", "z", function()
		hotkeyModal:exit()
		self.registeredWindows = {}
		self.chooser:rows(#self.registeredWindows + 1)
		self.chooser:refreshChoicesCallback()
		saveWindowList()
	end)

	loadWindowList()
end

return m
