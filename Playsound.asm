;Playsound


  xdef Playsound
  xref sound1, currNote, SendsChr, countersound
  
  
Playsound:

    pshx
    pshd
    ldx countersound
    dex
    stx countersound
    lbne nochange
    movw #500, countersound
    ldx #sound1        ; Sound we have defined in main
    
again:

    ldab currNote       ; index to current Note
    abx                 
    inc currNote        ; 
    ldaa 0,x            ; 
    bne notdone
    movb #0,currNote
    bra again 
    
notdone:
    psha 
    ldd #0
    jsr SendsChr
    leas 1,sp
nochange:
    

    puld
    pulx
    rts  