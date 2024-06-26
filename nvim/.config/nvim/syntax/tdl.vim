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

syntax region myComment start="/\*\*" end="\*/"
highlight link myComment Comment

syntax keyword tdlType s_int8 s_int16 s_int32 s_int64 u_int8 u_int16 u_int32 u_int64
syntax keyword tdlType double float
syntax keyword tdlType char tdl_vstring
syntax keyword tdlType calendar_time timestamp tdl_boolean
syntax keyword tdlType list list_embed union
syntax keyword tdlType oid

syntax keyword tdlStatement doc_tag embeds extension import key type
syntax keyword tdlStatement constant_def bundle_def enum_def flag_def message_def module_def
syntax keyword tdlStatement type_def table_def
syntax keyword tdlStatement message_dispatch table_dispatch
syntax keyword tdlStatement table_emulation

" GREEN
syntax keyword tdlStatement execution_context_def table_instance_def path_def
syntax keyword tdlStatement query_def directed_traversal default_def
syntax keyword tdlStatement validation_def

highlight def link tdlType Type
highlight def link tdlStatement Keyword

let b:current_syntax = 'tdl'
