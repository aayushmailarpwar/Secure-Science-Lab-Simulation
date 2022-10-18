;Door Animation

  xdef DoorAnimation
  xref display_string
  xref door1, door2,door3,door4,door5,door6,door7,door8,door9
  xref doorseconds, doorcount
 
  
  DoorAnimation:
  
     
  
dooropening:
     movb #$0, doorcount
     ldaa doorseconds
     cmpa #1
     bne next1    
     ldd #door1
     jsr display_string
next1:
     
     ldaa doorseconds
     cmpa #2
     bne next2    
     ldd #door2
     jsr display_string
next2:

     ldaa doorseconds
     cmpa #3
     bne next3    
     ldd #door3
     jsr display_string
next3:
     ldaa doorseconds
     cmpa #4
     bne next4    
     ldd #door4
     jsr display_string
next4:

     ldaa doorseconds
     cmpa #4
     bne next4    
     ldd #door4
     jsr display_string

     
  
  rts