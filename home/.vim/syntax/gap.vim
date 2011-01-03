" Vim syntax file
" Language:   GAP
" Maintainer: Trevor Bain 
" URL:        annosum.com 
" Version:    2010-12-03

" Gap is case sensitive
syn case match

" Match groups {{{1
syn match gapStringModifier               /\\./ contained
syn match gapStringModifier               /\~\%(-\?[0-9*]\+\)\?\%(\.[0-9*]\+\..\?\)\?\%(c\|f\|e\|g\|s\|w\|p\|W\|P\|B\|X\|#\|b\|+\|n\|i\)/ contained
syn match gapModifier                     /\$\\\?./

syn match gapInteger                      /\<\%([0-9]\+#[0-9a-fA-F]\+\|[0-9]\+\)\>/
syn match gapFloat                        /\<[0-9]\+\.[0-9]\+\%(e-\?[0-9]\+\)\?\>/

syn keyword gapTodo                       TODO FIXME XXX contained
syn match gapComment                      /#.*$/ contains=@Spell,gapTodo

syn keyword gapRepeat                     for while
syn keyword gapKeyword                    in do od 
syn keyword gapKeyword                    local return

syn keyword gapConditional                case if of end

syn keyword gapBoolean                    true false

syn match gapOperator                     /\/\|*\|+\|-\|^/
syn match gapOperator                     /:=/
syn match gapOperator                     /=\|<\|>\|<>/

syn region gapString                      start=/"/ end=/"/ skip=/\\/ contains=@Spell,gapStringModifier

syn match gapVariable                     /\<[A-Z_]\w*\>/

syn match gapRecord                       /#\w\+/

syn match gapTuple                        /{\|}/
syn match gapList                         /\[\|\]/

syn match gapAttribute                    /^-\%(vsn\|author\|copyright\|compile\|deprecated\|module\|export\|import\|behaviour\) *(\@=/
syn match gapInclude                      /^-include\%(_lib\)\?\s*(\@=/
syn match gapRecordDef                    /^-record\s*(\@=/
syn match gapDefine                       /^-\%(define\|undef\)\s*(\@=/
syn match gapPreCondit                    /^-\%(ifdef\|ifndef\|else\|endif\)\%(\s*(\@=\)\?/

syn match gapType                         /^-\%(spec\|type\)[( ]\@=/

" BIFS
syn match gapBIF                          /\%([^:0-9A-Za-z_]\|\<gap:\)\@<=\%(abs\|apply\|atom_to_list\|binary_to_list\|binary_to_term\|check_process_code\|concat_binary\|date\|delete_module\|disconnect_node\|element\|erase\|exit\|float\|float_to_list\|garbage_collect\|get\|get_keys\|group_leader\|halt\|hd\|integer_to_list\|iolist_to_binary\|iolist_size\|length\|link\|list_to_atom\|list_to_binary\|list_to_existing_atom\|list_to_float\|list_to_integer\|list_to_pid\|list_to_tuple\|load_module\|make_ref\|monitor_node\|node\|nodes\|now\|open_port\|pid_to_list\|port_close\|port_command\|port_connect\|port_control\|pre_loaded\|process_flag\|process_info\|processes\|purge_module\|put\|register\|registered\|round\|self\|setelement\|size\|bit_size\|spawn\|spawn_link\|spawn_opt\|split_binary\|statistics\|term_to_binary\|throw\|time\|tl\|trunc\|tuple_to_list\|unlink\|unregister\|whereis\)\((\|\/[0-9]\)\@=/
syn match gapBIF                          /\<\%(gap:\)\@<=\%(append_element\|bump_reductions\|cancel_timer\|demonitor\|display\|error\|fault\|fun_info\|fun_to_list\|function_exported\|get_cookie\|get_stacktrace\|hash\|hibernate\|info\|is_builtin\|loaded\|localtime\|localtime_to_universaltime\|localtime_to_universaltime\|make_tuple\|md5\|md5_init\|md5_update\|memory\|monitor\|monitor_node\|phash\|phash2\|port_call\|port_info\|port_to_list\|ports\|process_display\|raise\|read_timer\|ref_to_list\|resume_process\|send\|send_after\|send_nosuspend\|set_cookie\|spawn_monitor\|start_timer\|suspend_process\|system_flag\|system_info\|system_monitor\|trace\|trace_delivered\|trace_info\|trace_pattern\|universaltime\|universaltime_to_localtime\|yield\)(\@=/
syn match gapGBIF                         /gap\(:\w\)\@=/
" }}}

" Link Gap stuff to Vim groups {{{1
hi link gapTodo           Todo
hi link gapString         String
hi link gapNoSpellString  String 
hi link gapModifier       SpecialChar
hi link gapStringModifier SpecialChar
hi link gapComment        Comment
hi link gapVariable       Identifier
"hi link gapFunction       Function
hi link gapRepeat         Repeat
hi link gapInclude        Include
hi link gapRecordDef      Keyword
hi link gapAttribute      Keyword
hi link gapKeyword        Keyword
hi link gapPreCondit      PreCondit
hi link gapPreProc        PreProc
hi link gapDelimiter      Delimiter
hi link gapOperator       Operator
hi link gapConditional    Conditional
hi link gapBoolean        Boolean
hi link gapRecord         Structure
hi link gapInteger        Number
hi link gapFloat          Number
hi link gapFloat          Number
hi link gapFloat          Number
hi link gapFloat          Number
hi link gapHex            Number
hi link gapBIF            Keyword
hi link gapFun            Keyword
hi link gapList           Delimiter
hi link gapTuple          Delimiter
hi link gapType           Type
" }}}

" Optional linkings {{{1
if exists("g:gapHighlightBif") && g:gapHighlightBif
	hi link gapGBIF           Keyword
endif
" }}}

let b:current_syntax = "gap"

" vim: set foldmethod=marker:
