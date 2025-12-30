local alpha = require('alpha')
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	
[[ Vestibulum ante haz leo id pretium      _,┌g%o costatol. ]],
[[ dapibus quis elit  mi metus      _.,,┌g`$$?' , molestie. ]],
[[ leo id pretium eleifend  ,d$$SSk, `?$$$$$i','  lobortis. ]],
[[ aliquet aliquet nunce. ,d$$$S$$$Sk, `?$7',' bibend amet. ]],
[[ placerat, acem tellu  j$$$º'º$$S$$$k,  ,'  per inceptos. ]],
[[ feugiat nulla porta  j$$$L º¸J$$$$$$S:   lorem volutpat. ]],
[[ varius at mauris ut .S$$$$$$$$$$$$$$?  imperdiets dolor. ]],
[[ ante ipsum vestibul iS$$$$$$$$$$$$$7  egestas porttitor. ]],
[[ quisque augue neque IS$$$$$$$$$$$I7  a augue amet lacus. ]],
[[ Sed dignissim sodos iS$$$$$$$$$$I?' mi molestie facilis. ]],
[[ tristique venenatis :iS$$$$$$$$$I  hac habitasse platea. ]],
[[ velit non fermentume ?IS$$$$$$$I: torquent noste congue. ]],
[[ Integer sollicitudins ?IS$$$$$Ii.  purus nibh tincidunt. ]],
[[ torto lacinia pharetra ?iS$$$$IIi.  pellentesque simpex. ]],
[[ condimentum eros ligula :IS$$$$$$Ii. ipsum vet ultricie. ]],
[[ Vivamus a lectuse arcuse :IS$$$SSII:  Proin vel elit ut. ]],
[[ Aenean porttitor massa ut :IS$$$$SSII:  Nullam nisi leo. ]],
[[ Aliquam vel rutrum egesta .IS$$$$$SIIi. Sed non dapibus. ]],
[[ Etiam eget arcu sit ametit IS$$$$$$SII: massa congue du. ]],
[[ Curabitur condimentum nec :IS$$$$$$$Ii: Maecenas dignis. ]],

}

dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", "󰍉  Find file", ":lua require('fzf-lua').files() <CR>"),
	dashboard.button("t", "  Browse cwd", ":NvimTreeOpen<CR>"),
	dashboard.button("r", "  Browse src", ":e ~/.local/src/<CR>"),
	dashboard.button("s", "󰯂  Browse scripts", ":e ~/scripts/<CR>"),
	dashboard.button("c", "  Config", ":e ~/.config/nvim/<CR>"),
	dashboard.button("m", "  Mappings", ":e ~/.config/nvim/lua/config/mappings.lua<CR>"),
	dashboard.button("p", "  Plugins", ":PlugInstall<CR>"),
	dashboard.button("q", "󰅙  Quit", ":q!<CR>"),
}

dashboard.section.footer.val = function()
  return vim.g.startup_time_ms or "[[  ]]"
end

dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
