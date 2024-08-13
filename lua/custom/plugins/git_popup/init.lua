return {
    "git_popup",
    dir = vim.fn.stdpath("config") .. "/lua/custom/plugins/git_popup",
    config = function()
        local git_popup = require('custom.plugins.git_popup.git_popup')
        vim.keymap.set('n', '<leader>g', git_popup.create_git_popup, { desc = 'Open Git Popup' })
    end,
}
