local api = require('nvim-tree.api')

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

local handle_node = function(callback)
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
        -- Expand or collapse folder
        api.node.open.edit()
    else
        callback(api.node)
    end

    -- refocus the tree if it was lost
    api.tree.focus()

end

M.vsplit_preview = function()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
        -- Expand or collapse folder
        api.node.open.edit()
    else
        api.node.open.vertical()
    end

    -- refocus the tree if it was lost
    api.tree.focus()
end

return M
