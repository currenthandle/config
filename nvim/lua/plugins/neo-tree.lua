return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      event_handlers = {

        {
          event = "file_opened",
          handler = function(file_path)
            -- vim.notify("File opened: " .. file_path, vim.log.levels.INFO)
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      sort_function = function(a, b)
        if not a.name or not b.name then
          -- One of the items doesn't have a name, so we can't compare them based on names.
          -- You might decide to always return false in this case, or handle it differently.
          return false
        end

        -- vim.notify("Sorting: " .. a.name .. " with " .. b.name, vim.log.levels.INFO)

        local a_is_dot = a.name:sub(1, 1) == "."
        local b_is_dot = b.name:sub(1, 1) == "."

        if a_is_dot and not b_is_dot then
          return false
        elseif not a_is_dot and b_is_dot then
          return true
        else
          return a.name < b.name
        end
      end,
    })

    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
  end,
}
