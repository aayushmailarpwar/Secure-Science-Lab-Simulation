; If Fire occurs

  xdef FireRoutine
  xref stepper, stepper_ddr, switches, Stepper_Seq, step_count,led_port
  xref string8,display_string, door1, inFire, fireseconds,tensec
  xref onHome, tensecdone, doordisplay, songFlg, fireflag, sevenled
  xref ledcarbonflag
  
FireRoutine:

; init all the flags
     ;movb #$0,onHome
     movb #$1, inFire
     movb #$1, songFlg

; displays that door will close
       ldd #string8
       jsr display_string
       
;if ten seconds is done start the fire pump         
 tensecloop:
       ldaa fireseconds
       cmpa #0
       beq tensecloop
       bra startfirepump
       

;10sec before everyone leaves       
startfirepump:

       ; flag that ten seconds is done
       movb #$1,tensecdone 
       ; display the door
       ldd #door1
       jsr display_string
       ; work on the led stuff
       movb #$1, ledcarbonflag
        movb #$FF, led_port
     
       
      
     bra skipStepper
                    
     movb    #$1E,  stepper_ddr        ; Into Stepper ddr



startover:                        ; Start at the begin
        
        
; warm up include 1 clockwise and 1/2 counter clockwise     
warm_up:

       movb #$FF, led_port
       ldx     #Stepper_Seq+1         ;starting at the start
       ldy     #Stepper_Seq+4         ;startting at the end
       movb #$0,step_count
 
skipStepper:



      
      
Loop1:
 
       ldaa sevenled
       cmpa #$1
       beq half
       cmpa #$2
       beq zero
       bra end_fire
half:  
          
       movb #$0F, led_port
       bra Loop1
zero:
        
	    movb #$00, led_port
      bra Loop1
  
  
end_fire:
	    movb #$0, inFire
      movb #$0, songFlg
      movb #$0, tensecdone
      movb #$0, fireseconds
      movb #$0, fireflag 
      movb #$0, ledcarbonflag



  	      
	      rts
	      ;bra     startover               
          
     
     
        

                
                                
        ;bra wait
        
        
    	   
DELAY1: 

        PSHX
        LDX     #65000
LOOP1:   DEX
        BNE     LOOP1
        PULX
        RTS
        
        
	      	   
DELAY2: 

        PSHX
        LDX     #30000
LOOP2:   DEX
        BNE     LOOP2
        PULX
        RTS


    rts  