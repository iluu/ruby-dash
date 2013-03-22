" Vim syntax file
" Language: Ruby Dash hackaton map
" Version:  1
" Copy this file to $VIM syntax (/usr/share/vim/vim73/syntax)
" Edit ~/.vimrc:
"    autocmd BufRead,BufNewFile *.map set filetype=map
"    syntax on


if exists("b:current_syntax")
	finish
endif

setlocal iskeyword+=:
syn case ignore

syn match mapBorder	"^x"
syn match ground	"^g"
syn match ruby		"^r"
syn match wall		"^w"
syn match player	"^p"
syn match ball		"^s"


highlight link mapBorder	Type
highlight link ground		Delimiter
highlight link ruby		    Constant
highlight link wall		    Typedef
highlight link player		Comment
highlight link ball		    Statement



let b:current_syntax = "rubydash"
