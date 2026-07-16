local dap = require("dap")

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
      "127.0.0.1", -- This second arg forces the JS script to bind precisely to IPv4 loopback
    },
  },
}

local js_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

for _, language in ipairs(js_filetypes) do
  dap.configurations[language] = {
    -- 1. Launch the current file locally
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    -- 2. Attach to an external running process (e.g., dev servers)
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Process",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end

