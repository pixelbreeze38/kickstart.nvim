return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()

    -- Basic Harpoon keymaps
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():append()
    end, { desc = 'Harpoon: Add file' })

    vim.keymap.set('n', '<leader>o', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: Toggle quick menu' })

    vim.keymap.set('n', '<C-d>', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon: Select file 1' })

    vim.keymap.set('n', '<C-s>', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon: Select file 2' })

    vim.keymap.set('n', '<C-r>', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon: Select file 3' })

    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon: Select file 4' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon: Prev file' })

    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end, { desc = 'Harpoon: Next file' })

    -- Use Telescope as Harpoon UI (optional)
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = require('telescope.config').values.file_previewer {},
          sorter = require('telescope.config').values.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<leader>e', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Harpoon: Open in Telescope' })
  end,
}
