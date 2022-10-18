;DisplayTemp


  xdef DisplayTemp
  xref read_pot, pot_value
  xref disp, huns, tens, ones, quotient
  xref display_string
  xref day0,day1,month0,month1,year0,year1
  xref time0,time1,time2,time3
  xref led_port

  
  DisplayTemp:
  
           pshx
           pshd



           movb #' ',disp
           movb #' ',disp+1
           movb #'/',disp+2
           movb #' ',disp+3
           movb #' ',disp+4
           movb #'/',disp+5
           movb #'2',disp+6
           movb #'0',disp+7
           movb #' ',disp+8
           movb #' ',disp+9
           movb #' ',disp+10
           movb #' ',disp+11
           movb #' ',disp+12
           movb #' ',disp+13
           movb #' ',disp+14
           movb #' ',disp+15
           movb #' ',disp+16
           movb #' ',disp+17
           movb #' ',disp+18
           movb #':',disp+19
           movb #' ',disp+20
           movb #' ',disp+21
           movb #' ',disp+22
           movb #' ',disp+23
           movb #' ',disp+24
           movb #' ',disp+25
           movb #' ',disp+26
           movb #' ',disp+27
           movb #' ',disp+28
           movb #' ',disp+29
           movb #' ',disp+30
           movb #'F',disp+31
           movb #0,disp+32   

         
         
 
Read_:    jsr read_pot        ; read the pot
         
          ldd pot_value       ; loading the value in d
          ldx #100
          idiv
         
          std quotient
          tfr x,d
          addd #$0030          
          std huns
         
          ldd quotient
          ldx #10
          idiv
          std quotient
          tfr x,d
          addd #$0030
          std tens
         
          ldd quotient          
          addd #$0030
          std ones
         
          
         
          ldab month0
          addb #$0030
          stab disp
          
          ldab month1
          addb #$0030
          stab disp+1
          
          ldab day0
          addb #$0030
          stab disp+3
          
          ldab day1
          addb #$0030
          stab disp+4
          
          ldab year0
          addb #$0030
          stab disp+8
          
          ldab year1
          addb #$0030
          stab disp+9
          
          ldab time0
          addb #$0030
          stab disp+17
          
 
          ldab time1
          addb #$0030
          stab disp+18
          
          ldab time2
          addb #$0030
          stab disp+20   
          
          ldab time3
          addb #$0030
          stab disp+21
          
          
        
          ldab tens+1
          stab disp+28
         
          ldab ones+1
          stab disp+29
          
          ; so the values are only from 0 to 99
          ldd pot_value
          cpd #100
          blo no_mask_huns
          movb #'-',disp+28
          movb #'-',disp+29
      
no_mask_huns:
                    
          
     
         
          ldd #disp          ; loading eff address into d
          jsr display_string
         
          
  
          puld
          pulx
  rts