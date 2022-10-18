;table.asm


  

       XDEF   table 

       XREF   data_value, table_data, tablenum 

 



 

table:    psha 

          pshb 

          pshx 

          pshy 

          ldx #table_data 

          ldy #0 








          

beginingloop: ldaa data_value 

          ldab x 

          cba 

          BEQ equal 

          cpy #15 

          BEQ finish 

          INX 

          INY 

          BRA beginingloop 

equal:    TFR Y,A 

          staa tablenum 

 

          BRA done 

finish:   ldaa $ff 

          staa tablenum 

           

           

done:      puly 

           pulx 

           pulb 

           pula 

 

      RTS 