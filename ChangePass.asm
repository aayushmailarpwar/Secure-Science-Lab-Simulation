;ChangePassword


  xdef ChangePass
  xref Keypad, key_pressed, display_string, changepass
  

;A to go right and B to go left   
ChangePass:


  pshd
restart:
            
      ldd #changepass
      jsr display_string
      
      

      movb #$FF,key_pressed
      jsr Keypad
      ldaa key_pressed
      cmpa #$A
      beq shut_off
      cmpa #$B
      beq end_rts
      bra restart

shut_off:
      ;jsr ChangeAuto
      bra restart

      
            
end_rts:      

       puld

  rts  