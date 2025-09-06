return {
	{
		"JuliaEditorSupport/julia-vim",
		lazy = false,
	},
	--[[   { "kdheepak/JuliaFormatter.vim" }, ]]
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
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters = {
				runic = {
					command = "julia",
					args = { "--startup-file=no", "--project=@runic", "-e", "using Runic; exit(Runic.main(ARGS))" },
				},
			},
			formatters_by_ft = {
				julia = { "runic" },
				lua = { "stylua" },
			},
			default_format_opts = {
				-- Increase the timeout in case Runic needs to precompile
				-- (e.g. after upgrading Julia and/or Runic).
				timeout_ms = 10000,
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end,
	},
}
