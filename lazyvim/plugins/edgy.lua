return {
	{
		"folke/edgy.nvim",
		optional = true,
		opts = function(_, opts)
			opts.right = opts.right or {}

			-- 1. Tell Edgy to manage the Snacks Explorer on the right panel
			table.insert(opts.right, {
				title = "Snacks Explorer",
				ft = "snacks_picker_input", -- Input bar filetype
				filter = function(buf)
					return vim.b[buf].snacks_picker and vim.b[buf].snacks_picker.source.name == "explorer"
				end,
			})
			table.insert(opts.right, {
				title = "Explorer Files",
				ft = "snacks_picker_list", -- File list filetype
				filter = function(buf)
					return vim.b[buf].snacks_picker and vim.b[buf].snacks_picker.source.name == "explorer"
				end,
			})

			-- 2. Correctly catch and pin the Symbols Outline to the right panel
			table.insert(opts.right, {
				title = "Outline",
				ft = "Outline",
				pinned = true,
				open = "Outline",
			})

			-- 3. Keep Trouble at the bottom panel
			opts.bottom = opts.bottom or {}
			table.insert(opts.bottom, {
				title = "Trouble",
				ft = "trouble",
			})
		end,
	},
}
