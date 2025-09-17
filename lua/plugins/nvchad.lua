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
    "bjarneo/lazyvim-cheatsheet.nvim",
    keys = {
      {
        "ch",
        function()
          require("lazyvim-cheatsheet").show()
        end,
        desc = "Show LazyVim Cheatsheet",
      },
    },
  },
}
