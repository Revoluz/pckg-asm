.MODEL SMALL
.CODE
ORG 100H
MULAI:
  JMP CETAK
  Hello DB 'Selamat Datang '
        DB 'DI BHS ASSEMBLY'
        DB '$'
CETAK :
  MOV AH,09H
  MOV DX,OFFSET Hello
  INT 21H
HABIS:
  INT 20h
END MULAI