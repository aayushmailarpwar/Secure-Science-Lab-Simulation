
            Include 'derivative.inc'

            xdef Entry, _Startup
            xdef  string0,string4,  time_, date_, pass_
            xdef disp, huns, tens, ones, quotient              
            xdef stepper, stepper_ddr, switches, Stepper_Seq, step_count  
            xdef string1,string2,string3,string8
            xdef table_data, row_data, key_pressed, data_value, keypad_port
            xdef led_port,val
            xdef crgflg, seconds, counter
            xdef fireflag, countersound
            xdef emerflag, string7
            xdef light1,light2,light3
            xdef passcorrect
            xdef fifteen,cfifteen,fseconds
            xdef blinkflag,cblink, bseconds
            xdef port_p
            xdef doorcount,doorseconds, doors
            xdef time0,time1, time2, time3
            xdef onHome, pushflag,inFire
            xdef counter_dc, t_on , dcCount, pressed_twice
            xdef day0,day1,month0,month1,year0,year1
            xdef datestring0,datestring01,datestring02
            xdef datestring1,datestring11,datestring12
            xdef datestring2,datestring21,datestring22
            xdef changedate,changetime,changepass, pressagain
            xdef time0,time1,time2,time3, timestring0, timestring1,timestring2,timestring3
            xdef door1, door2,door3,door4,door5,door6,door7,door8,door9
            xdef fulldate, inEmer
            xdef passstring0, passstring1,passstring2, passstring3
            xdef pass0,pass1,pass2
            xdef songFlg, auto_flag,pressed_once
            xdef inFire, fireseconds,firecounter, tensecdone,ledcarbonflag
            xdef currNote,sound1,sevenled, ledcounter 
            
            xref __SEG_END_SSTACK
            xref HomeScreen, ControlMenu, StartupScreen  
            xref FireRoutine, init_LCD, RTI_ISR , askPassword      
            xref HomeDisplay, DisplayTemp, EmerRoutine
            xref DoorAnimation, Playsound
            
          



; variable data section
my_variables: Section
            org     $700
; All the flags involved in the program             
auto_flag   ds.b    1
emerflag    ds.b    1
pushflag    ds.b    1            
fireflag    ds.b    1
disp  	    ds.b    33

; Pot values
huns        ds.b    2
tens        ds.b    2
ones        ds.b    2
quotient    ds.b    2

; Counters and flags connected to them
counter     ds.w    1
seconds     ds.b    1
fifteen     ds.b    1
cfifteen    ds.w    1
fseconds    ds.b    1
blinkflag   ds.b    1
bseconds    ds.b    1
cblink      ds.b    1
counter_dc  ds.w    1
t_on        ds.b    1
userenter   ds.b    1
val         ds.b    1
inEmer      ds.b    1
firecounter ds.w    1
fireseconds ds.b    1
tensec      ds.b    1
currNote    ds.b    1
songFlg     ds.b    1
countersound  ds.b  1
ledcarbonflag ds.b  1
pressed_once  ds.b   1
pressed_twice ds.b  1

; Input variables
time_       ds.b    1
date_       ds.b    1
pass_       ds.b    1
key_pressed ds.b    1
data_value  ds.b    1
step_count  ds.b    1
passcorrect ds.b    1
day0        ds.b    1
day1        ds.b    1
month0      ds.b    1
month1      ds.b    1
year0       ds.b    1
year1       ds.b    1
dcCount     ds.w    1
time0       ds.b    1
time1       ds.b    1
time2       ds.b    1
time3       ds.b    1
doors       ds.b    1
doorcount   ds.w    1
doorseconds ds.b    1
onHome      ds.b    1
inFire      ds.b    1
pass0       ds.b    1
pass1       ds.b    1
pass2       ds.b    1
tensecdone  ds.b    1
ledcounter  ds.w    1
sevenled    ds.b    1
fulldate    ds.b    1


; Constants
my_constants: section
switches        equ     $240
port_t_ddr      equ     $242
keypad_port     equ     $268
keypad_ddr      equ     $26A
keypad_psr      equ     $26D
keypad_pder     equ     $26C
port_p          equ     $258
led_port        equ     $248
led_ddr         equ     $24A  
stepper         equ     $258
stepper_ddr     equ     $25A
crgint          equ     $38
rtictl          equ     $3B
crgflg          equ     $37  

row_data        dc.b    $70, $B0, $D0, $E0
table_data      dc.b    $eb, $77, $7b, $7d, $b7, $bb, $bd, $d7, $db, $dd, $e7, $ed, $7e, $be, $de, $ee 
Stepper_Seq     dc.b    $FF,$0A,$12,$14,$0C,$FF

string0         dc.b    'HOMESCREEN,     press F   ',0
string1         dc.b    'Date Time Temp            ',0
string2         dc.b    'Control Menu  Press A or B          ',0
string3         dc.b    'ENTER           PASSWORD:           ',0
string4         dc.b    'Welcome.        Press F:            ',0
string7         dc.b    'EMERGENCY       SHUTDOWN            ',0
string8         dc.b    'FIRE ALERT:DOOR CLOSES IN 10 SECS   ',0
string9         dc.b    'AUTO SHUTOFF TURNED ON              ',0


datestring0     dc.b    'Enter the dates month:              ',0
datestring01    dc.b    'Enter the dates month: *            ',0
datestring02    dc.b    'Enter the dates month: **           ',0
                
datestring1     dc.b    'Enter the dates day:            ',0
datestring11    dc.b    'Enter the dates day: *          ',0
datestring12    dc.b    'Enter the dates day: **         ',0

datestring2     dc.b    'Enter the dates year:           ',0
datestring21    dc.b    'Enter the dates year: *         ',0
datestring22    dc.b    'Enter the dates year: **        ',0

timestring0     dc.b    'Enter the times 1st hr:         ',0
timestring1     dc.b    'Enter the times 2nd hr:         ',0
timestring2     dc.b    'Enter the times 1st min:        ',0
timestring3     dc.b    'Enter the times 2nd min:        ',0

passstring0     dc.b    'PASSWORD: _ _ _                ',0
passstring1     dc.b    'PASSWORD: * _ _                ',0
passstring2     dc.b    'PASSWORD: * * _                ',0
passstring3     dc.b    'PASSWORD: * * *                ',0
pressagain      dc.b    'PRESS PUSH AGAIN               ',0


sound1          dc.b      1,2,3
sound2          dc.b      2,3,4
sound3          dc.b      3,4,5
sound4          dc.b      5,6,7


changedate      dc.b    'Change Date?    Press F         ',0
changetime      dc.b    'Change Time?    Press F         ',0
changepass      dc.b    'Change Pass?    Press F         ',0


door1     dc.b     '00000000000000000000000000000000',0
door2     dc.b     '0000000  00000000000000  0000000',0
door3     dc.b     '000000    000000000000    000000',0
door4     dc.b     '00000      0000000000      00000',0
door5     dc.b     '0000        00000000        0000',0
door6     dc.b     '000          000000          000',0
door7     dc.b     '00            0000            00',0
door8     dc.b     '0              00              0',0
door9     dc.b     '                                ',0


light1    dc.b  1
light2    dc.b  1
light3    dc.b  1




; code section
MyCode:     Section
Entry:
_Startup:

        
        lds #__SEG_END_SSTACK
        bset led_ddr, #$FF            ; setting port_s_ddr with 1111 1111 
        bclr led_port, #$FF           ; setting port_s with 1111 1111
        
        movb #$40, rtictl
        movb #$80, crgint
        movb #$F0, keypad_ddr
        movb #$F0, keypad_psr   ;polarity selector
        movb #$0F, keypad_pder
        movb #$28, port_t_ddr        
        movw #976,dcCount
        
        clr step_count
        clr counter
        clr seconds
        clr time_
        clr date_
        clr pass_
        clr fireflag                 
        clr emerflag
        clr pushflag
        clr passcorrect
        clr auto_flag
        clr fifteen
        clr cfifteen
        clr fseconds
        clr blinkflag
        clr cblink
        clr day0
        clr day1
        clr month0
        clr month1
        clr year0
        clr year1
        clr time0
        clr time1
        clr time2
        clr time3
        clr doorcount
        clr doorseconds
        clr pass0
        clr pass1
        clr pass2
        clr firecounter
        clr fireseconds
        clr doors
        clr tensecdone
        clr ledcounter
        clr sevenled
        clr emerflag
        clr pressed_once        
        clr t_on
        clr bseconds              
        clr counter_dc
       
;                        
       jsr init_LCD
; this does not require the RTI
       
       jsr StartupScreen
       cli
; Clear bits for interrupts     
        
; My FSM is in my HomeScreen            
gohome:
         jsr HomeScreen

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
        
        end