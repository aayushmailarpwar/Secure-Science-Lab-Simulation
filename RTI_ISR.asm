;RTI_ISR

  xdef RTI_ISR
  xref crgflg, counter, seconds, fireflag, CheckLights
  xref switches, FireRoutine, fifteen, fseconds, cfifteen
  xref blinkflag, bseconds, cblink, emerflag, led_port
  xref DC_routine, DoorAnimation, port_p
  xref userentered
  xref doorcount,doorseconds, doors
  xref onHome, pushflag, inEmer
  xref inFire, fireseconds,firecounter,tensec
  xref ledcarbon,tensecdone,Playsound,songFlag, PlayTone,songFlg
  xref sevenled, ledcounter, ledcarbonflag, auto_flag, pressed_once 

RTI_ISR:
      
      
      jsr CheckLights
      
      jsr DC_routine


      brclr   songFlg,#$01,noSong     ;if songFlg set, song is playing, so call playton to play frequencies
      jsr     Playsound               ;changes notes
      jsr     PlayTone
noSong:      


;*******************************
;CHECK IF IN HOME
      ldaa onHome
      cmpa #$1
      beq UserInHome
      bra skipHome

UserInHome:        

;Always checks
;************ Checking lights at any point of the program
;************ Check for fire
      brset switches, $80, FireOccurs
      bra Nofire
           
FireOccurs:
      movb #$1, fireflag      
      bra continuefire
      
Nofire: 
      movb #$0, fireflag 
      
continuefire:


;autoshutoff
        brset switches, $20, Shutoff
        bra Noshutoff
           
Shutoff:
      movb #$1, auto_flag      
      bra continueauto
      
Noshutoff: 
      movb #$0, auto_flag 
      
continueauto:

;******** push button
      brclr port_p, $20, pushed
      bra nopush
pushed:
      ldaa pressed_once
      cmpa #$1
      beq nopush
      movb #$1, pushflag
      
nopush:
       ;movb #$0, pushflag

;************
        
      
skipHome:  
;**************************************
;NOT IN HOME




;**********************************
;CHECK if the doorroutine
      bra nodoors
      ldaa doors
      cmpa #$1
      beq doorroutine
      bra nodoors
doorroutine:
          
      
      ldx doorcount
      inx 
      stx doorcount
      cpx #1000
      lbne END_RTI
      
      movw #0, doorcount
      inc doorseconds
      
nodoors:
            
     

;**********************************
; CHECK IF WE're in fire routine
      ldaa inFire
      cmpa #$1
      bne skipFire
      bra Fire
      
Fire:
;only for tensec routine
      ldaa tensecdone
      cmpa #$1
      beq ledlights
      
      
;10sec counter for fire leaving
      ldx firecounter
      inx
      stx firecounter
      cpx #10000
      bne END_RTI
      movw #0,firecounter
      inc fireseconds
      bra skippedlights
      
ledlights:

      ldaa ledcarbonflag
      cmpa #$1
      bne skippedlights
        
      ldx ledcounter
      inx
      stx ledcounter
      cpx #7000
      bne END_RTI
      movw #0, ledcounter
      inc sevenled
 

        
skippedlights: 
        
skipFire:
  
 
 ;*****************
 ;STEPPER DELAY
 
              


                  
;*************Emergency blink

      ldaa inEmer
      cmpa #$1
      beq blinklights
      bra noblink
      
blinklights:
      movb #$00, led_port         
      bra blink_off_delay
blink_off_delay:
      
      ldx cblink
      inx
      stx cblink
      cpx #750
      lbne END_RTI
      movw #0, cblink
      movb #$FF, led_port         
      
noblink:                 
  
      
;************During emergency flag, DC should stop

     
      
      
      
;------------ fifteen second timer for control menu
      ldaa fifteen
      cmpa #$1
      bne nofifteen      
      
      ldx cfifteen
      inx 
      stx cfifteen
      cpx #15000
      bne END_RTI
      
      movw #0, cfifteen
      inc fseconds
      
nofifteen: 

;*********** DC motor should always be running except emergency



;Stepper delay
 
     ;Wall clock
     ldx counter
     inx
     stx counter
     cpx #1000
     bne END_RTI
     

END_RTI:

        bset crgflg, #$80
    rti