;StartupScreen


  xdef StartupScreen
  
  xref string4,datestring0,datestring01,datestring02
  xref datestring1,datestring11,datestring12
  xref datestring2,datestring21,datestring22
  xref day0,day1,month0,month1,year0,year1
  xref time0,time1,time2,time3, timestring0, timestring1,timestring2,timestring3
  xref passstring0, passstring1,passstring2, passstring3
  xref pass0,pass1,pass2

  xref time_ ,date_ ,password_, display_string 
  xref Keypad, key_pressed, led_port
  

StartupScreen:
        pshd

WelcomeScreen:

        ldd #string4
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$F
        bne WelcomeScreen
; 1st number of month            
dateinput0:


        ldd #datestring0
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        
        cmpa #$00
        beq dateinput01
        cmpa #$01
        beq dateinput01
        bra dateinput0
; 2nd number of month                    
dateinput01:

        staa month0
continue01:        
        movb #$FF, key_pressed
        ldd #datestring01
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        
        cmpa #$00
        beq dateinput02
        cmpa #$01
        beq dateinput02
        cmpa #$02
        beq dateinput02
        cmpa #$03
        beq dateinput02
        cmpa #$04
        beq dateinput02
        cmpa #$05
        beq dateinput02
        cmpa #$06
        beq dateinput02
        cmpa #$07
        beq dateinput02
        cmpa #$08
        beq dateinput02
        cmpa #$09
        beq dateinput02
               
        bra continue01        
        
; yes, the months are done       
dateinput02:
        staa month1
continue02:
        movb #$FF, key_pressed

        ldd #datestring02
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$F
        beq dateinput03
        bra continue02 
        
;1 number of day         
dateinput03:
                  
        movb #$FF, key_pressed
        ldd #datestring1
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$1
        beq dateinput04
        ldaa key_pressed
        cmpa #$2
        beq dateinput04
        ldaa key_pressed
        cmpa #$3
        beq dateinput04
        bra dateinput03
        
;2 number of day        
dateinput04:
        staa day0
continue04:        
        movb #$FF, key_pressed
        ldd #datestring11
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$0
        beq dateinput05
        ldaa key_pressed
        cmpa #$1
        beq dateinput05
        ldaa key_pressed
        cmpa #$2
        beq dateinput05
        ldaa key_pressed
        cmpa #$3
        beq dateinput05
        ldaa key_pressed
        cmpa #$4
        beq dateinput05
        ldaa key_pressed
        cmpa #$5
        beq dateinput05
        ldaa key_pressed
        cmpa #$6
        beq dateinput05
        ldaa key_pressed
        cmpa #$7
        beq dateinput05
        ldaa key_pressed
        cmpa #$8
        beq dateinput05
        ldaa key_pressed
        cmpa #$9
        beq dateinput05
        bra continue04
        
; yes day is entered        
dateinput05:
        
        staa day1 
        
continue05:               
        movb #$FF, key_pressed
        ldd #datestring12
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$F
        beq dateinput06
        bra continue05

; 1st year
dateinput06:

        movb #$FF, key_pressed
        ldd #datestring2
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$2
        beq dateinput07
        bra dateinput06
        
; 2nd year
dateinput07:
        staa year0
continue07:        
        movb #$FF, key_pressed
        ldd #datestring21
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$1
        beq dateinput08
        bra continue07
        
; yes year is enter
dateinput08:
        staa year1
continue08:        
        movb #$FF, key_pressed
        ldd #datestring22
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$F
        beq timeinput01        
        bra continue08
        
timeinput01:
        movb #$FF, key_pressed
        ldd #timestring0
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$0
        beq timeinput02
        cmpa #$1
        beq timeinput02 
        cmpa #$2
        beq timeinput02         
        bra timeinput01
        
timeinput02:
        staa time0
continue09:        
        movb #$FF, key_pressed
        ldd #timestring1
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$0
        beq timeinput03
        cmpa #$1
        beq timeinput03 
        cmpa #$2
        beq timeinput03
        cmpa #$3
        beq timeinput03
        cmpa #$4
        beq timeinput03
        cmpa #$5
        beq timeinput03 
        cmpa #$6
        beq timeinput03 
        cmpa #$7
        beq timeinput03 
        cmpa #$8
        beq timeinput03 
        cmpa #$9
        beq timeinput03 
        bra continue09
        
timeinput03:                 
        staa time1
continue10:        
        movb #$FF, key_pressed
        ldd #timestring2
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$0
        beq timeinput04
        cmpa #$1
        beq timeinput04 
        cmpa #$2
        beq timeinput04
        cmpa #$3
        beq timeinput04
        cmpa #$4
        beq timeinput04
        cmpa #$5
        beq timeinput04
        bra continue10       
              
timeinput04:
        staa time2
continue11:         
        movb #$FF, key_pressed
        ldd #timestring3
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$0
        beq timeinput05
        cmpa #$1
        beq timeinput05 
        cmpa #$2
        beq timeinput05
        cmpa #$3
        beq timeinput05
        cmpa #$4
        beq timeinput05
        cmpa #$5
        beq timeinput05 
        cmpa #$6
        beq timeinput05 
        cmpa #$7
        beq timeinput05 
        cmpa #$8
        beq timeinput05 
        cmpa #$9
        beq timeinput05 
        bra continue11       
        
timeinput05:
        staa time3
       
continue12:        
        movb #$FF, key_pressed
        ldd #passstring0
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$FF
        bne passinput0
        bra continue12
        
passinput0:
        staa pass0
continue13:        
        movb #$FF, key_pressed
        ldd #passstring1
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$FF
        bne passinput1
        bra continue13
        
passinput1:
        staa pass1
continue14:        
        movb #$FF, key_pressed
        ldd #passstring2
        jsr display_string
        jsr Keypad
        ldaa key_pressed
        cmpa #$FF
        bne passinput2
        bra continue14
passinput2:
        staa pass2                
        
         
 end_rts:       
        puld
  rts  