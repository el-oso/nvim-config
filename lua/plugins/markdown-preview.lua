return {
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{
		"iamcco/markdown-preview.nvim",
		branch = "master",
		ft = { "markdown", "m" },
		build = "cd app && npx --yes yarn install && ./install.sh",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		config = function()
			HOME = vim.fn.getenv("HOME")
			--vim.g.mkdp_browser = HOME .. "/.local/bin/firefoxflatpak" -- change this to `/usr/bin/firefox` if not using flatpak
			vim.g.mkdp_browser = "xdg-open"
		end,
	},
}
