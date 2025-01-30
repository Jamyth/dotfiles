local Util = require("core.utils")

local profile = os.getenv("NVIM_PROFILE") or "default"
local profile_path = Util.join_system_path("lua", profile)

if Util.is_directory(profile_path) and profile ~= "core" then
	require(profile)
else
	print("Invalid profile path: " .. profile)
end
