return {
	{
		"tpope/vim-fugitive",
		config = function()
			-- Alias :gst to :Git status
			vim.api.nvim_create_user_command("Gst", "Git status", {})

			-- Alias :gaa to :Git add .
			vim.api.nvim_create_user_command("Gaa", "Git add .", {})

			-- Alias :gcmsg to :Git commit -m
			vim.api.nvim_create_user_command("Gcmsg", "Git commit -m <args>", { nargs = "+" })

      vim.api.nvim_create_user_command("Gpush", "Git push", { nargs = "?" })

      -- Alias :gco to :Git checkout
      vim.api.nvim_create_user_command("Gco", "Git checkout <args>", { nargs = "?" })


      vim.api.nvim_create_user_command("Gdiff", "Git diff", { nargs = "?" })

      -- Alias :glog to :Git log
      vim.api.nvim_create_user_command("Glog", "Git log", { nargs = "?" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()

			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
			vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
		end,
	},
}
