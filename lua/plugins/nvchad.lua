if false then
  return {}
end

return {
  {
    "nvim-mini/mini.indentscope",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "nvdash",
          "nvcheatsheet",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "kingavatar/nvchad-ui.nvim",
    branch = "v2.0",
    lazy = false,
    config = function()
      require("nvchad_ui").setup({
        lazyVim = true,
        statusline = { enabled = false },
        theme_toggle = { "tokyonight", "catppuccin" },
        nvdash = { load_on_startup = false },
      })

      -- rename nvchad
      vim.keymap.set("n", "<leader>cn", require("nvchad_ui.renamer").open, { desc = "nvchad Rename" })
    end,
  },
}
