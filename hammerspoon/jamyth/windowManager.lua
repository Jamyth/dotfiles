local m = {}

m.init = function(hotkeyModal)
	local manager = {}
	manager.getFrame = function()
		local window = hs.focusedWindow()
		return window:frame()
	end
end

return m
