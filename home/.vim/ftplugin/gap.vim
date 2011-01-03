" Vim ftplugin file
" Language:   GAP
" Maintainer: Trevor Bain 
" URL:        annosum.com 
" Version:    2010-12-03
" Plugin init {{{1
if exists("b:did_ftplugin")
	finish
endif

" Don't load any other
let b:did_ftplugin=1

if exists('s:doneFunctionDefinitions')
	call s:SetGapOptions()
	finish
endif

let s:doneFunctionDefinitions=1
" }}}

" Local settings {{{1
function s:SetGapOptions()
	if version >= 700
		setlocal omnifunc=gapcomplete#Complete
	endif

	" {{{2 Settings for folding
	if (exists("g:gapFold")) && g:gapFold
		setlocal foldmethod=expr
		setlocal foldexpr=GetGapFold(v:lnum)
		setlocal foldtext=GapFoldText()
		"setlocal fml=2
	endif
endfunction


" Define folding functions {{{1
if !exists("*GetGapFold")
	" Folding params {{{2
	" FIXME: Could these be shared between scripts?
	let s:GapFunEnd      = '^[^%]*\.\s*\(%.*\)\?$'
	let s:GapFunHead     = '^\a\w*(.*)\(\s+when\s+.*\)\?\s\+->\s*$'
	let s:GapBeginHead   = '^\a\w*(.*$'
	let s:GapEndHead     = '^\s\+[a-zA-Z-_{}\[\], ]\+)\(\s+when\s+.*\)\?\s\+->\s\(%.*\)\?*$'
	let s:GapBlankLine   = '^\s*\(%.*\)\?$'

	" Auxiliary fold functions {{{2 
	function s:GetNextNonBlank(lnum)
		let lnum = nextnonblank(a:lnum + 1)
		let line = getline(lnum)
		while line =~ s:GapBlankLine && 0 != lnum
			let lnum = nextnonblank(lnum + 1)
			let line = getline(lnum)
	   endwhile
	   return lnum
	endfunction

	function s:GetFunName(str)
		return matchstr(a:str, '^\a\w*(\@=')
	endfunction

	function s:GetFunArgs(str, lnum)
		let str = a:str
		let lnum = a:lnum
		while str !~ '->\s*\(%.*\)\?$'
			let lnum = s:GetNextNonBlank(lnum)
			if 0 == lnum " EOF
				return ""
			endif
			let str .= getline(lnum)
		endwhile
		return matchstr(str, 
			\ '\(^(\s*\)\@<=.*\(\s*)\(\s\+when\s\+.*\)\?\s\+->\s*\(%.*\)\?$\)\@=')
	endfunction

	function s:CountFunArgs(arguments)
		let pos = 0
		let ac = 0 " arg count
		let arguments = a:arguments
		
		" Change list / tuples into just one A(rgument)
		let gapTuple = '{\([A-Za-z_,|=\-\[\]]\|\s\)*}'
		let gapList  = '\[\([A-Za-z_,|=\-{}]\|\s\)*\]'

		" FIXME: Use searchpair?
		while arguments =~ gapTuple
			let arguments = substitute(arguments, gapTuple, "A", "g")
		endwhile
		" FIXME: Use searchpair?
		while arguments =~ gapList
			let arguments = substitute(arguments, gapList, "A", "g")
		endwhile
		
		let len = strlen(arguments)
		while pos < len && pos > -1
			let ac += 1
			let pos = matchend(arguments, ',\s*', pos)
		endwhile
		return ac
	endfunction

	" Main fold function {{{2
	function GetGapFold(lnum)
		let lnum = a:lnum
		let line = getline(lnum)

		" Function head gives fold level 1 {{{3
		if line=~ s:GapBeginHead
			while line !~ s:GapEndHead
				if 0 == lnum " EOF / BOF
					return '='
				endif
				if line =~ s:GapFunEnd
					return '='
				endif
				endif
				let lnum = s:GetNextNonBlank(lnum)
				let line = getline(lnum)
			endwhile 
			" check if prev line was really end of function
			let lnum = s:GetPrevNonBlank(a:lnum)
			if exists("g:gapFoldSplitFunction") && g:gapFoldSplitFunction
				if getline(lnum) !~ s:GapFunEnd
					return '='
				endif
			endif
			return '1>'
		endif

		" End of function (only on . not ;) gives fold level 0 {{{3
		if line =~ s:GapFunEnd
			return '<1'
		endif

		" Check if line below is a new function head {{{3
		" Only used if we want to split folds for different function heads
		" Ignores blank lines
		if exists("g:gapFoldSplitFunction") && g:gapFoldSplitFunction
			let lnum = s:GetNextNonBlank(lnum)

			if 0 == lnum " EOF
				return '<1'
			endif

			let line = getline(lnum)

			" End of prev function head (new function here), ending fold level 1
			if line =~ s:GapFunHead || line =~ s:GapBeginHead
				return '<1'
			endif
		endif
		
		" Otherwise use fold from previous line
		return '='
	endfunction

	" Gap fold description (foldtext function) {{{2
	function GapFoldText()
		let foldlen = v:foldend - v:foldstart
		if 1 < foldlen
			let lines = "lines"
		else
			let lines = "line"
		endif
		let line = getline(v:foldstart)
		let name = s:GetFunName(line)
		let arguments = s:GetFunArgs(strpart(line, strlen(name)), v:foldstart)
		let argcount = s:CountFunArgs(arguments)
		let retval = v:folddashes . " " . name . "/" . argcount
		let retval .= " (" . foldlen . " " . lines . ")"
		return retval
	endfunction " }}}
endif " }}}

call s:SetGapOptions()

" Skeletons {{{1
function GenServer()
	echo foo 
endfunction
" }}}

" vim: set foldmethod=marker:
