return {
	-- Configure Snacks to prefer the right side for the explorer source
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				sources = {
					explorer = {
						layout = { layout = { position = "right" } },
						hidden = true,
						ignored = true,
					},
				},
			},
		},
	},
}
