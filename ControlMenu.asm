;ControlMenu
;


  xdef ControlMenu
  xref  __SEG_END_SSTACK, string2, display_string, fireflag, FireRoutine
  xref fseconds, fifteen, led_port, Keypad, key_pressed
  xref ChangeDate, ChangeTime, ChangePass
  
  
  ControlMenu:
           pshd
           
 restart:          
           movb #$FF, key_pressed 
           ldd #string2
           pshx
           pshd
           jsr display_string
           puld
           pulx
           ; start the 15 second time
timer:
           movb #$1, fifteen
           ldaa fseconds
           cmpa #$0
           bne timeout
           bra withintime
           
; within the 15 seconds           
withintime:
          movb #$FF, key_pressed 
          jsr Keypad
          ldaa key_pressed         
          cmpa #$A
          beq date
          
          
; stayhere if no valid input                   
stayhere:
        bra restart

date:
        jsr ChangeDate
        ;after returning back from ChangeDate
        ; do everything again
        movb #$0, fifteen
        movb #$0, fseconds
        bra restart         
                
;--------if the 15 seconds are done           
timeout:

           ;----- reset the counters for timeout
           movb #$0, fifteen
           movb #$0, fseconds            
           
         puld
  rts