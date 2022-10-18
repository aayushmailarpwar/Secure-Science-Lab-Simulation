;changeTime

  xdef ChangeTime
  xref key_pressed, led_port, ChangePass
  xref Keypad, display_string, changetime
  
;A to go right and B to go left - B will do nothing  
ChangeTime:
      pshd
restart:
            
      ldd #changetime
      jsr display_string
      
      

      movb #$FF,key_pressed
      jsr Keypad
      ldaa key_pressed  
      
      cmpa #$A
      beq pass
      cmpa #$B
      beq end_rts
      bra restart

pass:

      jsr ChangePass
      bra restart

      
            
end_rts:      

       puld
rts  