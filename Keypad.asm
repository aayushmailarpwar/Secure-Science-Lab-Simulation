     XDEF   Keypad 

     XREF   keypad_port,delay, data_value, key_pressed ,row_data, table_data, led_port

Keypad:
     ; pshd
      ;pshx
      
      ldab #0
Step: cmpb #4
      beq Noinput
      ldx #row_data
      abx
      ldaa 0,x
      staa keypad_port
      jsr debouncing
      ldaa keypad_port
      staa data_value
      pshb
      jsr Table_Loop
      pulb
      incb
      bra Step
      
 
 Table_Loop:
      ldab #0
 
 Next:
      cmpb #16
      beq NotFound
      ldx #table_data
      abx
      ldaa 0,x
      cmpa data_value
      beq KeyPressCheck
      incb
      bra Next

KeyPressCheck:
      stab key_pressed      
KeyPressCheck2:
      ldab keypad_port
      jsr debouncing
      cmpb data_value
      beq KeyPressCheck2
      bra storeindex
      
Noinput:
      ;pulx
      ;puld
      rts
      
NotFound:

      ;pulx
      ;puld
      rts
      
storeindex: 
      
     ; pulx
      ;puld
      rts      
                  
      
      

; ------------- debouncing with a delay routine           
debouncing:
      pshy 
      ldy #2500
loop:
      dey
      bne loop
      puly
      rts
