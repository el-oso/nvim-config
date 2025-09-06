return {
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		opts = {
			style = "deep",
			transparent = true,
			colors = {
				bg0 = "#000000",
			},
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			style = "moon",
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	-- {
	--   "olimorris/onedarkpro.nvim",
	--   priority = 1000, -- Ensure it loads first
	--   opts = {
	--     transparency = true, -- Use a transparent background?
	--     lualine_transparency = true, -- Center bar transparency?   transparency = true,
	--   },
	-- },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
