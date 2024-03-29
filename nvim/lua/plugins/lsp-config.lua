return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							features = { "ssr" },
						},
						procMacro = {
							ignored = {
								leptos_macro = {
									-- "component", -- Uncomment if needed
									"server",
								},
							},
						},
					},
				},
			})
			lspconfig.taplo.setup({
				capabilities = capabilities,
			})
			lspconfig.emmet_language_server.setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"css",
					"javascriptreact",
					"typescriptreact",
					"javascript",
					"typescript",
					"jsx",
					"tsx",
				},
			})
			-- lspconfig.emmet_ls.setup({
			-- 	capabilities = capabilities,
			-- 	filetypes = {
			-- 		"html",
			-- 		"css",
			-- 		"javascriptreact",
			-- 		"typescriptreact",
			-- 		"javascript",
			-- 		"typescript",
			-- 		"jsx",
			-- 		"tsx",
			-- 	},
			-- })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			-- vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})

			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		end,
	},
}
