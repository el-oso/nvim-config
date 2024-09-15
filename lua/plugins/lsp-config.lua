local Util = require("lazyvim.util")
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    opts = {
      inlay_hint = { enabled = true },
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- local config_path = vim.fn.stdpath("config")
      local lspconfig = require("lspconfig")

      local util = require("lspconfig.util")
      local julia_capabilities = capabilities

      julia_capabilities.textDocument.completion.completionItem.preselectSupport = true
      julia_capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
      julia_capabilities.textDocument.completion.completionItem.deprecatedSupport = true
      julia_capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
      julia_capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
      julia_capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
      julia_capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
      }
      julia_capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown" }
      julia_capabilities.textDocument.codeAction = {
        dynamicRegistration = true,
        codeActionLiteralSupport = {
          codeActionKind = {
            valueSet = (function()
              local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
              table.sort(res)
              return res
            end)(),
          },
        },
      }

      -- setup keymaps
      Util.lsp.on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        --@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
        return ret
      end

      -- disable virtual text (recommended for julia)
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
        update_in_insert = false,
      })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            hint = {
              enable = true, -- necessary
            },
          },
        },
        capabilities = capabilities,
      })

      lspconfig.julials.setup({
        on_new_config = function(new_config, workspace_dir)
          local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
          local project_dir = util.root_pattern("Project.toml")(workspace_dir) or util.find_git_ancestor(workspace_dir)

          if util.path.is_file(julia) then
            local notify = require("notify")
            notify("Project dir " .. project_dir)
            new_config.cmd[1] = julia
            new_config.cmd[2] = project_dir
            return new_config
          end
        end,
        capabilities = julia_capabilities,
        settings = {
          julia = {
            hint = {
              enable = true,
            },
            editor = "nvim",
            symbolCacheDownload = true,
            lint = {
              missingrefs = "all",
              iter = true,
              lazy = true,
              modname = true,
            },
          },
        },
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
