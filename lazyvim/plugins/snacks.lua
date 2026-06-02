return {
	-- Configure Snacks to prefer the right side for the explorer source
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				sources = {
					explorer = {
						layout = { layout = { position = "right" } },
						hidden = true, -- Shows dotfiles like .env, .gitignore, .github
						ignored = true, -- Shows files ignored by .gitignore (like node_modules)
					},
				},
			},
		},
	},
}
