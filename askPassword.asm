;askPassword


  xdef askPassword
  xref string3, display_string, Keypad, key_pressed, passcorrect
  xref pass0,pass1,pass2
  
askPassword:
           psha

           ;ldd #string3      
           ;jsr display_string
           
onekey:
           movb     #$FF, key_pressed
           jsr Keypad
           ldaa key_pressed
           cmpa pass0
           beq twokey
           bra onekey
           
twokey:    
           movb #$FF, key_pressed
           jsr Keypad
           ldaa key_pressed
           cmpa pass1
           beq threekey
           bra twokey 
           
threekey:    
           movb #$FF, key_pressed
           jsr Keypad
           ldaa key_pressed
           cmpa pass2
           beq validate
           bra threekey                      
           


validate: 
          ldaa #$1
          staa passcorrect          
             


        pula
    rts  

