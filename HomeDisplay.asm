;Homedisplay


  xdef  HomeDisplay
  xref  display_string
  xref day0,day1,month0,month1,year0,year1
  xref fulldate
  
  HomeDisplay:
     
     ldd #fulldate
     jsr display_string
  
  rts
  