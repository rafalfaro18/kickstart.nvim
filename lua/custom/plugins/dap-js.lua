local dap = require("dap")

-- 1. Locate the Mason installation path for the adapter script
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

-- 2. Define the Adapters (Using native modern Server mode with 127.0.0.1 bound last)
dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = "${port}",
  executable = {
    command = "node",
    args = { mason_path, "${port}", "127.0.0.1" },
  },
}

dap.adapters["pwa-chrome"] = {
  type = "server",
  host = "127.0.0.1",
  port = "${port}",
  executable = {
    command = "node",
    args = { mason_path, "${port}", "127.0.0.1" },
  },
}

-- 3. Define Configurations for JS/TS Filetypes
local js_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

for _, language in ipairs(js_filetypes) do
  dap.configurations[language] = {
    -- FRONTEND: Debug React/Vite/Next apps running in Google Chrome
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome (React Port 3000)",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      -- Google Chrome is the native fallback; no manual path helpers needed
      userDataDir = "${workspaceFolder}/.vscode/pwa-chrome-profile", 
      sourceMaps = true,
      protocol = "inspector",
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    -- BACKEND: Launch a single file directly with Node
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current Node File",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    -- BACKEND: Attach to an already running Node process (via --inspect)
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Node Process",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end
