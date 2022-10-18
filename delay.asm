;delay.asm     

     xdef delay
     
     
     
     
     delay: 

        PSHX 

        LDX   #1000 

LOOP1:  DEX 

        BNE   LOOP1 

        PULX 

        RTS         
