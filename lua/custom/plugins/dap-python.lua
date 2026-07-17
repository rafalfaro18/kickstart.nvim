-- Load the Python specific helper extension
vim.pack.add {
  "https://github.com/mfussenegger/nvim-dap-python",
}

local dap_python = require("dap-python")

-- Path to the python executable where debugpy is installed.
-- Change this if you use Mason, a global venv, or system python.
local debugpy_python_path = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

-- Fallback to system python if mason path does not exist
if vim.fn.executable(debugpy_python_path) ~= 1 then
  debugpy_python_path = "python3"
end

dap_python.setup(debugpy_python_path)

vim.keymap.set('n', '<leader>dpr', function() require('dap-python').test_method() end, { desc = "Debug Test Method" })
