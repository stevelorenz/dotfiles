" fold dosini
syn region dosiniSection start="^\[" end="\(\n\+\[\)\@=" contains=dosiniLabel,dosiniHeader,dosiniComment keepend fold
setlocal foldmethod=syntax
setlocal foldlevel=20
