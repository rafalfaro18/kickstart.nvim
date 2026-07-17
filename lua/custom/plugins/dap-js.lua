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

-- 3. Define Configurations for JS/TS/JSX/TSX Filetypes
local js_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

for _, language in ipairs(js_filetypes) do
  dap.configurations[language] = {
    -- NEXT.JS / FULL-STACK: Launches your dev server and attaches instantly.
    -- Use this to catch breakpoints inside Server Components (like app/page.tsx).
    {
      type = "pwa-node",
      request = "launch",
      name = "Next.js: Debug Server-Side / Full-Stack",
      runtimeExecutable = "npm",
      runtimeArgs = { "run", "dev" },
      cwd = "${workspaceFolder}",
      autoAttachChildProcesses = true,
      console = "integratedTerminal",
      sourceMaps = true,
    },
    -- FRONTEND CLIENT: For debugging Client Components ("use client") or standard React SPAs.
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome (Client Side Only)",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      userDataDir = "${workspaceFolder}/.vscode/pwa-chrome-profile",
      sourceMaps = true,
      protocol = "inspector",
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
      sourceMapPathOverrides = {
        ["webpack://_N_E/*"] = "${workspaceFolder}/*",
        ["webpack:///./*"] = "${workspaceFolder}/*",
        ["turbopack://[project]/*"] = "${workspaceFolder}/*",
      },
    },
    -- STANDALONE BACKEND: Launch a single file directly with Node
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current Node File",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    -- BACKEND ATTACH: Attach to an already running Node process (via --inspect or --inspect-brk)
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Node Process",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    -- DEFAULT NODE DEBUGGING PORT: node --inspect app.js
    -- OR FORCE PAUSING THE APP AT START: node --inspect-brk app.js
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Port 9229",
      address = "localhost",
      port = 9229,
      cwd = "${workspaceFolder}",
    },
  }
end
