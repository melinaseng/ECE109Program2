.ORIG x3000

        ; clear screen and any registers needed
        ; store starting coordinates before asking for prompt1

START 
        ; ask for prompt1 and echo, ignore invalid characters 

        LEA R0, PROMPT1
        PUTS
        GETC 

        ; -- Check to see if input is x --
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

LOADX
        ; load image x

LOADO
        ; load image o
        
        ; Check for user input again 
        GETC

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

UP 
        ; Move the image up 8 pixels 

LEFT
        ; Move the image left 8 pixels 

DOWN
        ; Move the image down 8 pixels 

RIGHT
        ; Move the image right 8 pixels 

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

CLEAR
        ; Clear the screen and restart the program from beginning 

QUIT 
        ; The simulator stops runner

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