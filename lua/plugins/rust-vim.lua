return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    keys = {
      { "<leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", desc = "Debugger testables" },
    },
    config = function()
      local mason_registry = require("mason-registry")
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      local cfg = require("rustaceanvim.config")

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
    keys = {
      { "<leader>dl", "<cmd>lua require'dap'.step_into()<CR>", desc = "Debugger step into" },
      { "<leader>dj", "<cmd>lua require'dap'.step_over()<CR>", desc = "Debugger step over" },
      { "<leader>dk", "<cmd>lua require'dap'.step_out()<CR>", desc = "Debugger step out" },
      { "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", desc = "Debugger continue" },
      { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Debugger toggle breakpoint" },
      {
        "<leader>dd",
        "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
        desc = "Debugger set conditional breakpoint",
      },
      { "<leader>de", "<cmd>lua require'dap'.terminate()<CR>", desc = "Debugger reset" },
      { "<leader>dr", "<cmd>lua require'dap'.run_last()<CR>", desc = "Debugger run last" },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = true,
          },
        },
      })
      require("cmp").setup.buffer({
        sources = { { name = "crates" } },
      })
    end,
  },
}
