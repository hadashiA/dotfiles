"============================================================================
"        File: incbufswitch.vim
" Description: Switch the buffer in the current window by incrementally typing
"              the name.
"      Author: Michael Denio (mike at imagine-sw.com)
"     Version: 1.1
"
"       Usage: (1) Define a normal key mapping to :IncBufSwitch or leave the
"                  default of <C-S>
"              (2) In normal mode, start typing the name of the buffer you want
"                  to switch to.
"              (3) Press <BS> if make an error
"              (4) Press <TAB> to find the next matching buffer
"              (5) Press either <CR> or <ESC> when you are done
"
" $Id: incbufswitch.vim,v 1.6 2003/06/24 13:13:39 mike Exp $
" 
"     History:
"     
" 2003/06/24 mjd Have <ESC> return user to originating buffer
" 2003/06/23 mjd Added <TAB> command to find next matching buffer
" 2003/06/18 mjd Created
"
"============================================================================


" Install command and default key mapping
if !exists(":IncBufSwitch")
  command IncBufSwitch :call <SID>IncBufferSwitch()
endif

if !hasmapto("<Plug>IncBufferSwitch")
    nmap <silent> <unique> <C-S> :IncBufSwitch<CR>
endif


"
" Switch to a buffer that matches the partial name we have thus far
" 
function! <SID>PartialBufSwitch(partialName, startBufNum)
    let lastBuffer = bufnr("$")
    let currentBuffer = a:startBufNum
    while currentBuffer <= lastBuffer
        if (bufexists(currentBuffer) != 0 && buflisted(currentBuffer))
            let filename = expand("#" . currentBuffer . ":t")
            if (match(filename, "^" . a:partialName) > -1)
                execute "silent buffer " currentBuffer
                redraw
                break
            endif
        endif
        let currentBuffer = currentBuffer + 1
    endwhile
    " Inform user if no buffer matches pattern (beep)
    if (currentBuffer > lastBuffer)
        execute "silent normal \<Esc>"
        return 0
    endif
    return currentBuffer
endfunction


"
" Perform an incremental buffer switch
"
function! <SID>IncBufferSwitch()
    let origBufNr = bufnr("%")
    echon "IncBufSwitch: "
    let partialBufName = ""
    let bufFound = 0
    let startBufNum = 1
    while 1 == 1
        let rawChar = getchar()
        let trySwitching = 0
        if rawChar == 13
            break
        endif
        if rawChar == 27 " <ESC>
            echon "\r                    "
            " return to original buffer if not already on it
            if bufnr("%") != origBufNr
                execute "silent buffer " origBufNr
            endif
            break
        endif
        if rawChar == "\<BS>"
            if strlen(partialBufName) > 0
                let partialBufName = strpart(partialBufName, 0, strlen(partialBufName) - 1)
                echon "\r                    "
                " if we found a buffer before typing the backspace revert back
                " to it
                if bufFound > 0
                    let trySwitching = 1
                endif
                let startBufNum = 1
            endif
        elseif rawChar == 9 " TAB -- find next matching buffer
            let trySwitching = 1
            let startBufNum = startBufNum + 1
        else
            let nextChar = nr2char(rawChar)
            let partialBufName = partialBufName . nextChar
            let trySwitching = 1
            let startBufNum = 1
        endif
        echon "\rIncBufSwitch: " . partialBufName
        if trySwitching == 1
            let startBufNum = s:PartialBufSwitch(partialBufName, startBufNum)
            if startBufNum > 0
                let bufFound = 1
            endif
        endif
    endwhile
endfunction
