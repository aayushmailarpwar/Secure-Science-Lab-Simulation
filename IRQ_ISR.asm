; IRQ - Basically Emergency Shutdown
; plays speaker
; DC shuts off
; LED blinks on and off
; create flags, jump out of IRQ and then execute


  xdef IRQ_ISR
  xref emerflag
  
  
IRQ_ISR:

      movb #$1, emerflag      

      rti  