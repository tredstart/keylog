local KState = require("keylog.state")

--- @class Keylog
--- @field state KState
local M = {}
M.__index = M
M.save_dir = ""
M.state = KState.new()

local keylog_g = vim.api.nvim_create_augroup(
    "tredstart_keylog",
    { clear = true }
)

--- @return Keylog
function M.new()
    local self = setmetatable({}, M)
    return self
end

--- @param save_dir string 
function M:setup(save_dir)
    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = keylog_g,
        callback = function(event)
            local path = save_dir .. "/sesh" .. os.time() .. ".log"
            local file = io.open(path, "w")
            if file ~= nil then
                file:write(vim.inspect(self.state.mode_buf))
                file:close()
            else
                print("no you're not")
            end
        end
    })

    vim.on_key(function(char) self.state:handle_on_key(char) end)
end

return M
