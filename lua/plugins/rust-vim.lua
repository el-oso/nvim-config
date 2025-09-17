return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    keys = {
      { "<leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", desc = "Debugger testables" },
    },
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
}
