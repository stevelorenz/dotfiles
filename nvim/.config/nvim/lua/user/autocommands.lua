--
-- autocommands.lua
--

local vim = vim

vim.cmd([[
" INI style configuration files
autocmd BufNewFile,BufRead *.ini,*.conf,*.cfg,*.config
			\ set filetype=dosini |
			\ set expandtab |
			\ set spell |

" Tex and text files
autocmd BufNewFile,BufRead *.tex,*.bib,*.rst,*.txt,*.tmp
			\ set spell |

" Markdown files
autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown
			\ set filetype=markdown |
			\ set spell |

" Python source files
autocmd BufNewFile,BufRead *.py
			\ set expandtab |

" Meson build configuration files
autocmd BufNewFile,BufRead meson.build
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			\ set expandtab |
			\ set spell |
autocmd BufNewFile,BufRead meson_options.txt
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			\ set expandtab |
			\ set spell |

" YANG model (for networking)
autocmd BufNewFile,BufRead *.yang
			\ set filetype=yang |
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			\ set expandtab |

" TDL (for Cisco IOS-XE)
autocmd BufNewFile,BufRead *.tdl
			\ set filetype=tdl |
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			\ set expandtab |

" Protobuf files
autocmd BufNewFile,BufRead *.proto
			\ set filetype=proto |
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			\ set expandtab |

" P4 files (for networking)
autocmd BufNewFile,BufRead *.p4
			\ set filetype=p4 |
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			\ set expandtab |


" Jenkins file
autocmd BufNewFile,BufRead Jenkinsfile,jenkinsfile
			\ set filetype=groovy |
			\ set expandtab |

]])
