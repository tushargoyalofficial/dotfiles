require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local replace_word = require("nvchad.utils").replace_word

-- Dynamic terminal padding for st, Kitty, and Ghostty terminals
autocmd({ "VimEnter", "VimLeave" }, {
  callback = function(args)
    local term_program = vim.env.TERM_PROGRAM

    if term_program == "st" then
      -- For st terminal: Adjust borderpx in .Xresources
      local oldword = args.event == "VimEnter" and 20 or 0
      local newword = args.event == "VimEnter" and 0 or 20
      replace_word("st.borderpx: " .. oldword, "st.borderpx: " .. newword, "/home/siduck/dotfiles/.Xresources")
      vim.cmd "silent !xrdb -merge ~/dotfiles/.Xresources"
      vim.cmd "silent !kill -USR1 $(xprop -id $(xdotool getwindowfocus) | grep '_NET_WM_PID' | grep -oE '[[:digit:]]*$')"
    elseif term_program == "kitty" then
      -- For Kitty terminal: Use remote control to set spacing
      -- Kitty config: allow_remote_control yes
      local margin = args.event == "VimEnter" and 0 or 20
      local kitty_window_id = vim.env.KITTY_WINDOW_ID
      if kitty_window_id then
        local cmd = string.format("kitty @ --to %s set-spacing margin=%d", kitty_window_id, margin)
        vim.cmd("silent !" .. cmd)
      end
    elseif term_program == "ghostty" then
      -- For Ghostty terminal: Dynamic padding change is not supported
      print "Dynamic padding change is not supported for Ghostty terminal."
    end
  end,
})
