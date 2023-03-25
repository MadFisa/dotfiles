lsp_out = require 'lsp'
navic = lsp_out["navic"]
-- configuration for hop
require'hop'.setup()
vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", {})
vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})
vim.api.nvim_set_keymap('', '<space>l', "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", {})
vim.api.nvim_set_keymap('', '<space>w', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('', '<space>/', "<cmd>lua require'hop'.hint_patterns()<cr>", {})

---------------------------------------------------------------------------------
-- configuration of theme;
require("catppuccin").setup({
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        mason=true,
        treesitter=true,
        hop = true,

        navic = {
        enabled = false,
        custom_bg = "NONE",
            },

        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                },
            }, 
        }
})
---------------------------------------------------------------------------------
-- configuration for lua line
require('lualine').setup({
    options = {
        theme = "catppuccin",
        globalstatus=true, --single status bar even if you have splits
    },
    sections = {
        lualine_c = {
            { 
              function()
                  return navic.get_location()
              end, 
              cond = function() 
                  return navic.is_available()
              end
            },
        }
    }
})

---------------------------------------------------------------------------------
--Load bufferline config
require("bufferline").setup{options = { mode = "tabs"},
      highlights = require("catppuccin.groups.integrations.bufferline").get()
  }

---------------------------------------------------------------------------------
--Various viewing options
--Show Indentations
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("space:⋅")
require("indent_blankline").setup {show_end_of_line = true,space_char_blankline = " ",}

---------------------------------------------------------------------------------
-- For neorg
require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.norg.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/notes",
                },
                default_workspace="notes"
            },
        },
    },
}
