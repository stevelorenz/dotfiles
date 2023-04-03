--
-- autocommands.lua
--

local vim = vim
local autocmd = vim.api.nvim_create_autocmd

-- Remove whitespaces on save
autocmd("BufWritePre", {
	pattern = "",
	command = ":%s/\\s\\+$//e",
})

vim.cmd([[
" INI style configuration files
autocmd BufNewFile,BufRead *.ini,*.conf,*.cfg,*.config
			\ set filetype=dosini |
			\ set spell |

" Text files
autocmd BufNewFile,BufRead *.tex,*.bib,*.rst,*.txt,*.tmp
			\ set spell |

" Markdown files
autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown
			\ set filetype=markdown |
			\ set spell |

" Python source files
autocmd BufNewFile,BufRead *.py
			\ set expandtab |

" Meson build script files
autocmd BufNewFile,BufRead meson.build
			\ set expandtab |
			\ set spell |
autocmd BufNewFile,BufRead meson_options.txt
			\ set expandtab |
			\ set spell |

" YANG model (For networking)
autocmd BufNewFile,BufRead *.yang
			\ set filetype=yang |
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			\ set expandtab |
]])
