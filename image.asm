.ORIG x3000


        ; clear screen and any registers needed
        ; store starting coordinates before asking for prompt1


START 
        ; ask for prompt1 and echo, ignore invalid characters 
        LEA R0, PROMPT1
        PUTS

        ; load in the correct file based off of the x or o input
        GETC
        LD R1, NEGX
        NOT R2, R1
        ADD R2, R2, #1
        ADD R2, R0, R2
        BRz LOADX

        LD R1, NEGO
        NOT R2, R1
        ADD R2, R2, #1
        ADD R2, R0, R2
        BRz LOADO

LOADX
        ; load image x

LOADO
        ; load image o

        ; wasd commands

        ; cq commands 


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