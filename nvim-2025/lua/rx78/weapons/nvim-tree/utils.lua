local M = {}

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#root-folder-label-shortener
-- turns "home/user/Document/proj-name/src/DirName
-- into "~/D/p-n/s/DName
-- useful when the project folder is deep nested
M.label_path = function (path)
    path = path:gsub(os.getenv 'HOME', '~', 1)
    return path:gsub('([a-zA-Z])[a-z0-9]+', '%1') ..
        (path:match '[a-zA-Z]([a-z0-9]*)$' or '')
end

return M
