if true then
  return {}
end

return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = false,
    config = true,
  },
  { "hrsh7th/vim-vsnip-integ" },
  { "hrsh7th/vim-vsnip" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp", branch = "main", lazy = false },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip", dependencies = "hrsh7th/vim-vsnip-integ" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "https://gitlab.com/ExpandingMan/cmp-latex", lazy = false },
      { "hrsh7th/cmp-calc" },
      { "lukas-reineke/cmp-rg" },
      { "windwp/nvim-autopairs", enabled = true },
      { "lukas-reineke/cmp-under-comparator" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-cmdline" },
      {
        "uga-rosa/cmp-dictionary",
        config = function()
          local dict = require("cmp_dictionary")
          dict.switcher({
            filepath = {
              ["*"] = { "/usr/share/dict/words" },
            },
            filetype = {
              markdown = {
                vim.fn.stdpath("config") .. "/" .. "dictionary/american-english",
                vim.fn.stdpath("config") .. "/" .. "dictionary/american-english-lowercase",
                vim.fn.stdpath("config") .. "/" .. "dictionary/american-english-titlecase",
                vim.fn.stdpath("config") .. "/" .. "dictionary/british-english",
                vim.fn.stdpath("config") .. "/" .. "dictionary/british-english-lowercase",
                vim.fn.stdpath("config") .. "/" .. "dictionary/british-english-titlecase",
              },
            },
          })
        end,
      },
    },
    lazy = true,
    config = function()
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if not cmp_status_ok then
        return
      end
      local status_ok, npairs = pcall(require, "nvim-autopairs")
      if not status_ok then
        return
      end
      local lspkind_ok, lsp_kind = pcall(require, "lspkind")
      if not lspkind_ok then
        return
      end
      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          julia = { "string", "argument_list" },
        },
      })
      local cmp_autopairs_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if not cmp_autopairs_status_ok then
        return
      end
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

      cmp.setup({
        window = {
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "vsnip" },
          { name = "buffer" },
          -- { name = "emoji", group_index = 2 },
          { name = "rg", group_index = 2, priority = 3 },
          { name = "calc" },
          { name = "latex_symbols", group_index = 2, priority = 98 },
          {
            name = "dictionary",
            keyword_length = 2,
            exact = 2,
            async = true,
            capacity = 10,
            debug = false,
            priority = 1,
            group_index = 2,
          },
          { name = "path" },
        }),
      })
    end,
  },
}
