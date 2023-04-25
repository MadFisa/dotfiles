-- Pull in the wezterm API
local wezterm = require 'wezterm'
-- This table will hold the configuration.
local config = {}
config.font = wezterm.font_with_fallback{ 'Fira Code', 'JetBrains Mono'}
-- MAke it look gooooood
config.harfbuzz_features = {"zero" , "ss01", "cv05", "cv01", "ss07"}

-- Keyboard stuff
config.use_ime = false
config.use_dead_keys = false
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end
-- This is for navigator.nvim for easy switching between wezterm and nvim panes.
local function isViProcess(pane) 
    -- get_foreground_process_name On Linux, macOS and Windows, 
    -- the process can be queried to determine this path. Other operating systems 
    -- (notably, FreeBSD and other unix systems) are not currently supported
    return pane:get_foreground_process_name():find('n?vim') ~= nil
    -- return pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
    if isViProcess(pane) then
        window:perform_action(
            -- This should match the keybinds you set in Neovim.
            wezterm.action.SendKey({ key = vim_direction, mods = 'CTRL' }),
            pane
        )
    else
        window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
    end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
    conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
    conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
    conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
    conditionalActivatePane(window, pane, 'Down', 'j')
end)
--- End of Nvim stuff

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  { key = 'a', mods = 'LEADER|CTRL', action = wezterm.action.SendString '\x01',},
-- key biding for splits
  { key = '|', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal{domain='CurrentPaneDomain'}},
  { key = '_', mods = 'LEADER|SHIFT', action = wezterm.action.SplitVertical{domain='CurrentPaneDomain'}},  
-- Changing the workspaces
  --{ key = 'n', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(1) },
  --{ key = 'p', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(-1) },
  { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "h", mods = "CTRL",         action=wezterm.action{ActivatePaneDirection="Left"}},
  { key = "j", mods = "CTRL",         action=wezterm.action{ActivatePaneDirection="Down"}},
  { key = "k", mods = "CTRL",         action=wezterm.action{ActivatePaneDirection="Up"}},
  { key = "l", mods = "CTRL",         action=wezterm.action{ActivatePaneDirection="Right"}},
  { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
  { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
  { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
  { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
  { key = "[", mods = "LEADER",       action=wezterm.action.ActivateCopyMode},
  { key = "p", mods = "LEADER",       action=wezterm.action.PasteFrom 'PrimarySelection'},
  { key = "w", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
  { key = "t", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
  { key = 'h', mods = 'CTRL',         action = wezterm.action.EmitEvent('ActivatePaneDirection-left') },
  { key = 'j', mods = 'CTRL',         action = wezterm.action.EmitEvent('ActivatePaneDirection-down') },
  { key = 'k', mods = 'CTRL',         action = wezterm.action.EmitEvent('ActivatePaneDirection-up') },
  { key = 'l', mods = 'CTRL',         action = wezterm.action.EmitEvent('ActivatePaneDirection-right') },
  { key = ':', mods = 'LEADER|SHIFT',  action = wezterm.action.ActivateCommandPalette,},
  { key = 'u', mods = 'LEADER|SHIFT', action = wezterm.action.CharSelect {copy_on_select = true, 
                                                                        copy_to = 'ClipboardAndPrimarySelection',
                                                                       },
  },
}

-- Lets configure some hyperlink
---- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- make task numbers clickable
-- the first matched regex group is captured in $1.
table.insert(config.hyperlink_rules, {
  regex = [[\b[tt](\d+)\b]],
  format = 'https://example.com/tasks/?t=$1',
})

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})

-- and finally, return the configuration to wezterm
return config

