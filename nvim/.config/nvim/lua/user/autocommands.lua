--
-- autocommands.lua
--

local vim = vim

vim.cmd([[
" INI style configuration files
autocmd BufNewFile,BufRead *.ini,*.conf,*.cfg,*.config
			\ set filetype=dosini |
			\ set spell |

" Text files
autocmd BufNewFile,BufRead *.tex,*.bib,*.rst,*.txt
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
autocmd BufNewFile,BufRead meson_options.txt
			\ set expandtab |
			\ set spell |
]])
