--- @class KState
--- @field mode_buf table<string, number>
local KState = {}
KState.__index = KState
KState.mode_buf = {}

function KState.new()
    return setmetatable({}, KState)
end
--- @param char string
function KState:handle_on_key(char)
    local mode = vim.api.nvim_get_mode()
    if mode.mode == "n" and (char == "j" or char == "k") then
        self.mode_buf["g"] = (self.mode_buf["g"] or 1) - 1
    end
    self.mode_buf[char] = (self.mode_buf[char] or 0) + 1
end

return KState
