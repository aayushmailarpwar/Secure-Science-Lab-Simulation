; EmergencyRoutine


  xdef EmerRoutine
  xref led_port, display_string,string7, emerflag
  xref askPassword, passcorrect, HomeScreen
  xref blinkflag, bseconds, Keypad, key_pressed
  xref onHome, inEmer, songFlg,string3
  
  
EmerRoutine:
      psha
restart:
      movb #$1, songFlg
       ;exited Home      
      movb #$0, onHome
      ; in the routine
      movb #$1, inEmer
      
      movb #$FF, key_pressed
      ldd #string7
      jsr display_string
      
      jsr Keypad
      ldaa key_pressed
      cmpa #$F
      beq askPass
      bra restart

; ask for password, blink led and playsound
askPass:
        
        
continuepass:
        ldd #string3
        jsr display_string
        jsr askPassword
        ldaa passcorrect
        cmpa #$1
        beq goback 
        bra continuepass
        
;------if correct, go back to homescreen        
goback:

        
;reset the password
        movb #$0, passcorrect
; reset emergency flag        
        movb #$0, emerflag
        movb #$0, inEmer
        movb #$0, blinkflag              
        movb #$0, bseconds              
        movb #$0, songFlg
        pula

  rts  