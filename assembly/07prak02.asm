.MODEL SMALL
.CODE
ORG 100H
Proses:
  MOV AH,02H
  MOV DL,'A'
  MOV CX,10H
Ulang:
  INT 21H
  INC DL
  LOOP Ulang
INT 20H
  END Proses
