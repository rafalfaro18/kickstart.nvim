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

-- 2. Define configurations for Next.js (JS/TS)
for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  dap.configurations[language] = {
    -- Profile A: Server-Side (API Routes, SSR)
    -- Start the app like this: NODE_OPTIONS='--inspect' npm run dev
    {
      type = "pwa-node",
      request = "attach",
      name = "Next.js: Attach to Server Side",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      -- ADD THIS FIELD TO SKIP VOLTA/NPM/NODE INTERNAL SCRIPTS:
      skipFiles = {
        "<node_internals>/**",
        "**/node_modules/**",
        "**/@volta/**",
      },
    },
    -- Profile B: Client-Side (Browser Components)
    {
      type = "pwa-node",
      request = "launch",
      name = "Next.js: Debug Client Side (Chrome)",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
      -- ADD THIS FIELD TO SKIP BROWSER/NODE INTERNAL SCRIPTS:
      skipFiles = {
        "<node_internals>/**",
        "**/node_modules/**",
      },
    }
  }
end
