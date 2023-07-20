--
-- autocommands.lua
--

local vim = vim

-- Create augroup
local function augroup(name)
	return vim.api.nvim_create_augroup("zz_" .. name, { clear = true })
end

-- Create autocommand
local autocmd = vim.api.nvim_create_autocmd

-- Check if need to reload the file
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Conventional vimscript configuration
vim.cmd([[

" INI-style configuration files
autocmd BufNewFile,BufRead *.ini,*.conf,*.cfg,*.config
			\ set filetype=dosini |
			\ set expandtab |
			\ set spell |

" Tex and other text files
autocmd BufNewFile,BufRead *.tex,*.bib,*.rst,*.txt,*.tmp
			\ set spell |

" Markdown files
autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown
			\ set filetype=markdown |
			\ set spell |

" CXX source files
autocmd BufNewFile,BufRead *.c,*.h
			\ set expandtab |

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

" IETF YANG models
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

" Programming Protocol-independent Packet Processors (P4) files
autocmd BufNewFile,BufRead *.p4
			\ set filetype=p4 |
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			\ set expandtab |

" Groovy and Jenkinsfiles
autocmd BufNewFile,BufRead *.groovy,Jenkinsfile*,jenkinsfile*
			\ set filetype=groovy |
			\ set expandtab |

" Haskell sources
autocmd BufNewFile,BufRead *.hs
			\ set expandtab |

]])
