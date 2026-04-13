.ORIG x3000


        ; clear screen and any registers needed
        ; store starting coordinates before asking for prompt1


START 
        ; ask for prompt1 and echo, ignore invalid characters 
        LEA R0, PROMPT1
        PUTS

        ; load in the correct file based off of the x or o input

        ; wasd commands

        ; cq commands 


NEGW .FILL x0077
NEGA .FILL x0061
NEGS .FILL x0073
NEGD .FILL x0064
NEGC .FILL x0063
NEGQ .FILL x0071
PROMPT1 .STRINGZ "Please enter x or o: "

.END