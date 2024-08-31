return {
  {
    "JuliaEditorSupport/julia-vim",
    lazy = false,
  },
  { "kdheepak/JuliaFormatter.vim" },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "kdheepak/nvim-dap-julia",
    },
    -- Part of the configuration is in the rust-vim.lua file
    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      require("dapui").setup()
      require("nvim-dap-julia").setup()
    end,
  },
}
