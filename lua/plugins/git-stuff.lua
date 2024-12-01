return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-rhubarb",
      "tpope/vim-obsession",
      "tpope/vim-unimpaired",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle line blame" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
    },
  },
}
