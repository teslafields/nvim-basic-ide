local M = {
    "github/copilot.vim",
    tag = "v1.57.0",
    event = "BufEnter",
}

function M.config()
    vim.cmd("Copilot disable")
end

return M
