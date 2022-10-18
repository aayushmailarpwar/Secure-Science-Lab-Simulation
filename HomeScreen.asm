;HomeScreen
;Now access has been granted and therefore all the routines can occur

  
    xdef HomeScreen
    xref display_string, string0, string3, Keypad, key_pressed, led_port
    xref onHome
    xref askPassword, passcorrect, ControlMenu, FireRoutine, fireflag, emerflag, EmerRoutine
    xref switches, port_p, DoorAnimation, HomeDisplay, DisplayTemp
    xref pushflag, auto_flag, pressed_once, pressagain, pressed_twice
    
    
HomeScreen:
           psha
restart:              
           
           ; flag for the RTI routines
           movb #$1,onHome 
           
          ; continuosly Display the LCD
           jsr DisplayTemp
          
                  
;*******************************************
          ; Checking for fire           
           ldaa fireflag
           cmpa #$1
           bne NoFire
           bset led_port,#$80
FireOccurs:
           jsr FireRoutine
           bra restart
           
NoFire: 

;*******************************************

; ---------- Checking for emergency
           ldaa emerflag
           cmpa #$1
           bne NoEmer
EmerOccurs:
           jsr EmerRoutine            
           bra restart
          
NoEmer: 

;*******************************************

;---------check for push button           
           ldaa pressed_twice
           cmpa #$1 
           beq NoPush
           ldaa pushflag
           cmpa #$1
           bne NoPush
PushOccurs:
           ;reset push flag
           movb #$0,passcorrect
           
askPass1:

           ldd #string3
           jsr display_string
           
           jsr askPassword
           ldaa passcorrect
           cmpa #$1
           beq press1
           bra askPass1
press1:
           movb #$1, pressed_once           
; wait for 2nd push           
press2:
          ldd #pressagain
          jsr display_string
          brclr port_p, $20, doorstuff
          bra press2
          
        
                                
           
doorstuff:
           movb #$0, pressed_once
           movb #$0, pushflag
           movb #$1, pressed_twice 
           bset led_port, #$FF           
                    
           ;jsr DoorAnimation
           lbra restart            
            
                 
 NoPush:
 ;*********************************
 ;    check AUTO SHUT OFF
 
      ldaa auto_flag
      cmpa #$1
      bne skipauto
      
      bset led_port, #$FF
      
             
skipauto:

      ;bclr led_port, #$FF
 
      
      
            
           
;******************************************* 
       
;         checking if input is F           
           jsr Keypad           
           ldaa key_pressed
           cmpa #$F
;          if F is pressed ask for password          
           beq askPass           
           
           lbra restart
           

; ------------ asks for the password and sets the flag
askPass:
        
        ldd #string3
        jsr display_string
        jsr askPassword
        ldaa passcorrect
        cmpa #$1
        beq gotocontrol
        bra askPass
        
        
gotocontrol:
;--------reset password flag
        movb #$0,passcorrect
        movb #$0, onHome
        jsr ControlMenu        
        lbra restart            

        
end_rts:
        ;reset onHome since it is leaving Home
        movb #$0,onHome 


        pula
         
  rts



    
    