;DC routine


  xdef DC_routine
  xref counter_dc, t_on, pot_value, read_pot, switches, emerflag, dcCount
  xref fireflag
  
  
  DC_routine:
        pshd
        pshx
        
      
                
      
        ldx dcCount
        dex 
        stx dcCount
        bne skipDC
        movw #976,dcCount
        jsr read_pot
skipDC: ldd pot_value
        
        cpd #$10
        blo Cycle_100p
        cpd #$20
        blo Cycle_90p
        cpd #$30
        blo Cycle_80p
        cpd #$40
        blo Cycle_70p
        cpd #$50
        blo Cycle_60p
        cpd #$60
        blo Cycle_50p
        cpd #$70
        blo Cycle_40p
        cpd #$80
        blo Cycle_30p
        cpd #$90
        blo Cycle_20p
        cpd #$150
        blo Cycle_10p
        
            
Cycle_100p: 
        movb #10, t_on
        bra set_DC
Cycle_90p: 
        movb #9, t_on
        bra set_DC
Cycle_80p: 
        movb #8, t_on
        bra set_DC                
Cycle_70p: 
        movb #6, t_on
        bra set_DC
Cycle_60p: 
        movb #5, t_on
        bra set_DC                
Cycle_50p: 
        movb #4, t_on        
        bra set_DC
Cycle_40p: 
        movb #2, t_on        
        bra set_DC
Cycle_30p: 
        movb #1, t_on        
        bra set_DC
Cycle_20p: 
        movb #0, t_on        
        bra set_DC
Cycle_10p: 
        movb #0, t_on        
        bra set_DC

    ; If emergency occurs, stop the DC motor   
       ldaa emerflag
       cmpa #$1
       bne set_DC
       movb #10, t_on 
       bra set_DC
    ; If fire occurs, bring the DC to 100 % duty       
       ldaa fireflag
       cmpa #$1
       bne set_DC       
       movb #0, t_on                   
 
          
set_DC:
                        
        ldab counter_dc
        incb
        cmpb t_on
        bls setbit3
        cmpb #$10
        bls clearbit3
        movw #0, counter_dc
        bra end_jsr
        
setbit3:
        bset switches, #$08
        stab counter_dc
        bra end_jsr

clearbit3:
        bclr switches, #$08
        stab counter_dc
        bra end_jsr
  
end_jsr:

        pulx
        puld
        rts
  