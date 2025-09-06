return {

	{
		"numToStr/Comment.nvim",
		keys = {
			{
				"<leader>/",
				function()
					require("Comment.api").toggle.linewise.current()
				end,
				desc = "Toggle Comment",
			},
			{
				"<leader>/",
				"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
				desc = "Toggle Comment",
				mode = { "v" },
			},
		},
	},
}
