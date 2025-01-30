local Util = require("core.utils")

local profile = os.getenv("NVIM_PROFILE") or "default"
local config_directory = vim.fn.stdpath("config")
local profile_path = Util.join_system_path(config_directory, "lua", profile)

-- Make sure the custom direct exists before loading
if Util.is_directory(profile_path) and profile ~= "core" then
	require(profile)
else
	print("Invalid profile path: " .. profile)
end
