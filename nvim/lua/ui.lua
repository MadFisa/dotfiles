-- Running lsp setup first so some of the things can be used for ui
lsp_out = require('lsp')
-- changin navic stuff for catpuccin
navic = lsp_out["navic"]
-- configuration for navigator.nvim
require('Navigator').setup()
vim.keymap.set({'n', 't'}, '<C-h>', '<CMD>NavigatorLeft<CR>')
vim.keymap.set({'n', 't'}, '<C-l>', '<CMD>NavigatorRight<CR>')
vim.keymap.set({'n', 't'}, '<C-k>', '<CMD>NavigatorUp<CR>')
vim.keymap.set({'n', 't'}, '<C-j>', '<CMD>NavigatorDown<CR>')
vim.keymap.set({'n', 't'}, '<C-p>', '<CMD>NavigatorPrevious<CR>')
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
--
-- Function for using gitsigns as diff source
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

require('lualine').setup({
    options = {
        theme = "catppuccin",
        globalstatus=true, --single status bar even if you have splits
    },
    sections = {
        lualine_a = {"mode", 'branch', },
        lualine_b = {{'diff', source = diff_source}, "filename",},
        lualine_c = {
      -- Funtion for navic
                      { 
                      function()
                          return navic.get_location()
                      end, 
                      cond = function() 
                          return navic.is_available()
                      end
                      ,
                        }
                    },
        lualine_y = {   {
                                function()
                                    local lsps = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
                                    local icon = require("nvim-web-devicons").get_icon_by_filetype(
                                            vim.api.nvim_buf_get_option(0, "filetype")
                                        )
                                    if lsps and #lsps > 0 then
                                        local names = {}
                                        for _, lsp in ipairs(lsps) do
                                            table.insert(names, lsp.name)
                                        end
                                        return string.format("%s %s", table.concat(names, ", "), icon)
                                    else
                                        return icon or ""
                                    end
                                end,
                                on_click = function()
                                    vim.api.nvim_command("LspInfo")
                                end,
                                --color = function()
                                    --local _, color = require("nvim-web-devicons").get_icon_cterm_color_by_filetype(
                                            --vim.api.nvim_buf_get_option(0, "filetype")
                                        --)
                                    --return { fg = color }
                                --end,
                            },
        },
        lualine_z = {
            'progress','location'
        },
        
    },
    winbar = {
      lualine_a = {},
      lualine_b = {{'filetype',icon_only=true},'filename',},
      lualine_c = {'diagnostics'
                },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },

    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {{'filetype',icon_only=true},'filename','diagnostics'},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    }

})

---------------------------------------------------------------------------------
----Load bufferline config
--require("bufferline").setup{options = { mode = "tabs"},
      --highlights = require("catppuccin.groups.integrations.bufferline").get()
  --}

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
