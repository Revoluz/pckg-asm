.MODEL SMALL
.CODE
ORG 100h
Satu:
JMP Dua
Kal1 DB 'Saya Lagi Belajar'
DB 'Bahasa Assembly $'
Kal2 DB 'Ternyata...'
DB 'Asik...'
DB '$'
Dua :
Mov AH,09h
Lea DX,Kal1
int 21h
Tiga :
Mov DX,
Offset Kal2 
int 21h
int 20h
End Satu
