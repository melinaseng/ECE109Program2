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

CHECK   
        GETC

        ; -- Check to see if input is x --
        LD R1, NEGX 
        NOT R1, R1
        ADD R1, R1, #1
        ADD R2, R0, R1
        BRz LOADX

        ; -- Check to see if input is o --
        LD R1, NEGO 
        NOT R1, R1
        ADD R1, R1, #1
        ADD R2, R0, R1
        BRz LOADO

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
        LD R1, NEGW
        NOT R1, R1
        ADD R1, R1, #1
        ADD R2, R0, R1
        BRz UP

        LD R1, NEGA
        NOT R1, R1
        ADD R1, R1, #1
        ADD R2, R0, R1
        BRz LEFT

        LD R1, NEGS
        NOT R1, R1
        ADD R1, R1, #1
        ADD R2, R0, R1
        BRz DOWN

        LD R1, NEGD
        NOT R1, R1
        ADD R1, R1, #1
        ADD R2, R0, R1
        BRz RIGHT

        ; cq commands 
        LD R1, NEGC
        NOT R1, R1
        ADD R1, R1, #1
        ADD R2, R0, R1
        BRz CLEAR

        LD R1, NEGQ
        NOT R1, R1
        ADD R1, R1, #1
        ADD R2, R0, R1
        BRz QUIT

        BR MAIN_LOOP

UP 
        ; Move the image up 8 pixels 
        LDI R0, YCOORD
        ADD R0, R0, #-8
        BRzp STOREUPY
        AND R0, R0, #0
STOREUPY
        STI R0, YCOORD
        BR REDRAW

LEFT
        ; Move the image left 8 pixels 
        LDI R0, XCOORD
        ADD R0, R0, #-8
        BRzp STORELEFTX
        AND R0, R0, #0
STORELEFTX
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
        BRnz STOREDOWNY
        LD R0, MAXY
STOREDOWNY
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
        BRnz STORERIGHTX
        LD R0, MAXX
STORERIGHTX
        STI R0, XCOORD
        BR REDRAW


CLEAR
        ; Clear the screen and restart the program from beginning 
        BR START 

QUIT 
        ; The simulator stops runner
        HALT

REDRAW
        ST R3, SAVE_R3
        JSR CLEAR_SCREEN
        LD R3, SAVE_R3
        JSR DRAW_IMAGE
        BR MAIN_LOOP

DRAW_IMAGE
        ST R3, SAVE_R3
        ST R7, SAVE_R7

        LD R4, SCREEN_BASE
        LDI R5, YCOORD
        AND R6, R6, #0
        LD R7, WIDTHOFROW

Y_LOOP
        ADD R5, R5, #-1
        BRn Y_DONE
        ADD R6, R6, R7
        BR Y_LOOP
Y_DONE  
        LDI R5, XCOORD
        ADD R6, R6, R5
        ADD R4, R4, R6

        AND R5, R5, #0
        ADD R5, R5, #20

MOVEROW
        AND R6, R6, #0
        ADD R6, R6, #20

MOVECOL 
        LDR R0, R3, #0
        STR R0, R4, #0
        ADD R3, R3, #1
        ADD R4, R4, #1
        ADD R6, R6, #-1
        BRp MOVECOL

        ADD R4, R4, #108
        ADD R5, R5, #-1
        BRp MOVEROW

        LD R3, SAVE_R3
        LD R7, SAVE_R7
        RET 

CLEAR_SCREEN
        ST R0, SAVE_R0
        ST R1, SAVE_R1
        ST R2, SAVE_R2
        ST R4, SAVE_R4

        LD R1, SCREEN_START
        LD R2, SCREEN_END
        AND R0, R0, #0

CLEAR_LOOP
        STR R0, R1, #0
        ADD R1, R1, #1
        NOT R4, R1
        ADD R4, R4, #1
        ADD R4, R2, R4
        BRzp CLEAR_LOOP

        LD R0, SAVE_R0
        LD R1, SAVE_R1
        LD R2, SAVE_R2
        LD R3, SAVE_R3
        RET

SAVE_R0 .FILL #0
SAVE_R1 .FILL #0
SAVE_R2 .FILL #0
SAVE_R3 .FILL #0
SAVE_R4 .FILL #0
SAVE_R7 .FILL #0

SCREEN_BASE .FILL xC000
SCREEN_START .FILL xC000
SCREEN_END .FILL xFDFF
WIDTHOFROW .FILL #128

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