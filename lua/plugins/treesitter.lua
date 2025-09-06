return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"julia",
					"rust",
					"make",
					"lua",
					"haskell",
					"c",
					"python",
					"zig",
					"comment",
					"html",
					"javascript",
					"janet_simple",
					"ini",
					"toml",
				},
				auto_install = true,
				ignore_install = {},
				modules = { "julia" },
				sync_install = true,
				highlight = {
					enable = true, -- false will disable the whole extension
				},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
				query_linter = {
					enable = true,
					use_virtual_text = true,
					lint_events = { "BufWrite", "CursorHold" },
				},
				yati = { enable = true },
				textobjects = {
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]]"] = { query = "@*.outer", desc = "Next start outer" },
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["[["] = { query = "@*.outer", desc = "Next end outer" },
						},
						goto_previous_start = {
							["]["] = { query = "@*.outer", desc = "Prev start outer" },
							["[s"] = { query = "@scope", query_group = "locals", desc = "Prev scope" },
							["[z"] = { query = "@fold", query_group = "folds", desc = "Prev fold" },
						},
						goto_previous_end = {
							["[]"] = { query = "@*.outer", desc = "Prev end outer" },
						},
						goto_next = {
							["]v"] = { query = { "@block*", "@call*" }, desc = "Next block or call" },
						},
						goto_previous = {
							["[v"] = { query = { "@block*", "@call*" }, desc = "Prev block or call" },
						},
					},
				},
			})
		end,
	},
}
