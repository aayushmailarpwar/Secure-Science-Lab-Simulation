;changeDate

  xdef ChangeDate
  xref led_port, Keypad, key_pressed, ChangeTime
  xref fifteen, fseconds, changedate, display_string
  
;A to go right and B to go left 

ChangeDate:
              
              pshd
restart: 
         
              
              ldd #changedate
              jsr display_string
               
              movb #$FF, key_pressed 
              jsr Keypad
              ldaa key_pressed  
              cmpa #$A
              beq time
              cmpa #$B
              beq end_rts
              bra restart
time:
              jsr ChangeTime
              bra restart
                         

end_rts:

              puld
          

rts  