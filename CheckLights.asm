;checkLights


  xdef CheckLights
  xref led_port, switches
  
CheckLights:

      

 ; checking the led1
      brset switches, $01, turn_1_on
      bra turn_1_off
  
      
turn_1_on:
      bset led_port, #$01
      bra next1
       
turn_1_off:
      bclr led_port, #$01
 
      
next1:

;checking the led2
      brset switches, $02, turn_2_on
      bra turn_2_off
  
      
turn_2_on:
      bset led_port, #$02
      bra next2
       
turn_2_off:
      bclr led_port, #$02
 
      
      
next2:

;checking the led3

      brset switches, $04, turn_3_on
      bra turn_3_off
  
      
turn_3_on:
      bset led_port, #$04
      bra next3
       
turn_3_off:
      bclr led_port, #$04
 
      
     
next3: 

  rts

  