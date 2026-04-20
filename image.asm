.ORIG x3000

        ; clear screen and any registers needed
        ; store starting coordinates before asking for prompt1

START 
        JSR CLEAR_SCREEN 
        ; load coordinates
        LD R0, STARTX
        STI R0, XCOORD
        LD R0, STARTY
        STI R0, YCOORD

        ; ask for prompt1 and echo, ignore invalid characters 
        
        LEA R0, PROMPT1
        PUTS
        GETC 
        BR CHECK 

CHECK   ; -- Check to see if input is x --
        LD R1, NEGX 
        NOT R2, R1
        ADD R2, R2, #1
        ADD R2, R0, R2
        BRz LOADX

        ; -- Check to see if input is o --
        LD R1, NEGO 
        NOT R2, R1
        ADD R2, R2, #1
        ADD R2, R0, R2
        BRz LOADO

        GETC
        BR CHECK ; Ignore invalid characters 

LOADX
        ; load image x
        OUT ; echo the valid input
        LD R3, IMAGEX
        BR REDRAW

LOADO
        ; load image o
        OUT ; echo the valid input 
        LD R3, IMAGEO
        BR REDRAW
        
       
MAIN_LOOP
        GETC ; Check for user input 

        ; -- wasd commands
        LD R4, NEGW
        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R0, R4
        BRz UP

        LD R4, NEGA
        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R0, R4
        BRz LEFT

        LD R4, NEGS
        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R0, R4
        BRz DOWN

        LD R4, NEGD
        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R0, R4
        BRz RIGHT

        ; cq commands 
        LD R4, NEGC
        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R0, R4
        BRz CLEAR

        LD R4, NEGQ
        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R0, R4
        BRz QUIT

        BR MAIN_LOOP

UP 
        ; Move the image up 8 pixels 
        LDI R0, YCOORD
        ADD R0, R0, #-8
        BRn DONTMOVE

        STI R0, YCOORD
        BR REDRAW

LEFT
        ; Move the image left 8 pixels 
        LDI R0, XCOORD
        ADD R0, R0, #-8
        BRn DONTMOVE
        STI R0, XCOORD
        BR REDRAW 

DOWN
        ; Move the image down 8 pixels 
        LDI R0, YCOORD
        ADD R0, R0, #8
        LD R1, MAXY
        NOT R2, R1
        ADD R2, R2, #1
        ADD R2, R0, R2

        BRp DONTMOVE

        STI R0, YCOORD
        BR REDRAW

RIGHT
        ; Move the image right 8 pixels 
        LDI R0, XCOORD
        ADD R0, R0, #8
        LD R1, MAXX
        NOT R2, R1
        ADD R2, R2, #1
        ADD R2, R0, R2
        BRp DONTMOVE
        STI R0, XCOORD
        BR REDRAW

       

CLEAR
        ; Clear the screen and restart the program from beginning 
        JSR CLEAR_SCREEN
        BR START 

QUIT 
        ; The simulator stops runner
        HALT

DRAW_IMAGE
        LD R4, SCREEN_BASE
        LDI R5, YCOORD
        AND R6, R6, #0

Y_LOOP
        ADD R6, R6, #128
        ADD R5, R5, #-1
        BRp Y_LOOP
        LDI R5, XCOORD
        ADD R6, R6, R5
        ADD R4, R4, R6

REDRAW
        JSR CLEAR_SCREEN
        JSR DRAW_IMAGE
        BR MAIN_LOOP

DONTMOVE
        ; Don't redraw the image if it is out of bounds
        BR MAIN_LOOP

CLEAR_SCREEN
        LD R1, SCREEN_START
        LD R2, SCREEN_END

CLEAR_LOOP
        AND R0, R0, #0
        STR R0, R1, #0
        ADD R1, R1, #1
        NOT R3, R1
        ADD R3, R3, #1
        ADD R3, R2, R3
        BRzp CLEAR_LOOP
        RET

SCREEN_BASE .FILL xC000
SCREEN_START .FILL xC000
SCREEN_END .FILL xFDFF
STARTX .FILL #54
STARTY .FILL #52
MAXX .FILL #108
MAXY .FILL #104 
XCOORD .FILL x4000
YCOORD .FILL x4001
IMAGEX .FILL xA000
IMAGEO .FILL xA200
NEGX .FILL x0078
NEGO .FILL x006F
NEGW .FILL x0077
NEGA .FILL x0061
NEGS .FILL x0073
NEGD .FILL x0064
NEGC .FILL x0063
NEGQ .FILL x0071
PROMPT1 .STRINGZ "Please enter x or o: "

.END