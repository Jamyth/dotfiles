local M = {}

M.join_system_path = function (...) 
	return table.concat({...}, "/"):gsub("//+", "/")
end

-- Note:
-- for dynamic config loading
-- we check if provided value is a directory
M.is_directory = function(path)
	local file = io.open(path, "r")
	if file then
		local _ok, _error, code = file:read(1)
		file:close()
		return code == 21
	end
	return false
end

return M
