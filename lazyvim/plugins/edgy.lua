return {
	-- Force Edgy to move the window from left to right
	{
		"folke/edgy.nvim",
		optional = true,
		opts = function(_, opts)
			-- Move Explorer to right
			opts.right = opts.right or {}

			-- Add Symbols/Outline to the right panel as well
			table.insert(opts.right, {
				title = "Outline",
				ft = "outline",
				pinned = true,
				open = "SymbolsOutline",
			})

			-- Add trouble to the bottom
			opts.bottom = opts.bottom or {}
			table.insert(opts.bottom, {
				title = "Trouble",
				ft = "trouble",
			})
		end,
	},
}
