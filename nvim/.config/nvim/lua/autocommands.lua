--
-- autocommands.lua
--

vim.cmd([[
" C/CPP files have different suffixes...
autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hh,*.hpp,*.cc,*.cxx
            \ set foldmethod=indent |

" INI style configuration files
autocmd BufNewFile,BufRead *.ini,*.conf,*.cfg,*.config
            \ set filetype=dosini |
            \ set spell |

" Latex editing
autocmd BufNewFile,BufRead *.tex,*.bib
            \ set spell |

autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown
            \ set filetype=markdown |
            \ set spell |

" Python sources: convert tabs to spaces
autocmd BufNewFile,BufRead *.py
            \ set expandtab |

" Meson build scripts: convert tabs to spaces
autocmd BufNewFile,BufRead meson.build
            \ set expandtab |
autocmd BufNewFile,BufRead meson_options.txt
            \ set expandtab |
            \ set spell |
]])
