local profile = os.getenv("NVIM_PROFILE") or "default"
-- local config_directory = vim.fn.stdpath("config")
-- local profile_path = Util.join_system_path(config_directory, "lua", profile)

if profile == "core" then
    print("NVIM_PROFILE cannot be \"core\" as it is preserved keyword")
end

local custom_module_status_ok, _ = pcall(require, profile)

if not custom_module_status_ok then
	print("Invalid profile path: " .. profile)
end
