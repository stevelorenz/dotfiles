"------------------------------------------------------------------
" Vim syntax file

" Language:  TDL (Cisco)
" Author:    Zuo Xiang (xianglinks@gmail.com)
"------------------------------------------------------------------

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax case match

syntax keyword tdlType s_int8 s_int16 s_int32 s_int64 u_int8 u_int16 u_int32 u_int64
syntax keyword tdlType char double float
syntax keyword tdlType ip_address oid tdl_vstring timestamp tdl_boolean vrf_name

syntax keyword tdlStatement bundle_def enum_def flag_def message_def module_def type_def table_def
syntax keyword tdlStatement list list_embed union


highlight def link tdlType Type
highlight def link tdlStatement Keyword

let b:current_syntax = 'tdl'
