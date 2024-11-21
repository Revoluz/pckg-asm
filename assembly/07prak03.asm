.MODEL SMALL
.CODE
ORG 100h
tdata: 
    jmp proses
lusername db 13,10,'Username : $'
lpassword db 13,10,'Password : $'
lditerima db 13,10,'Diterima $'
lditolak db 13,10,'Ditolak $'
vusername db 23,?,23 dup(?)
vpassword db 23,?,23 dup(?)

proses:
    ; Tampilkan tulisan username
    mov ah,09h
    lea dx,lusername
    int 21h

    ; Input username
    mov ah,0ah
    lea dx,vusername
    int 21h

    ; Tampilkan tulisan password
    mov ah,09h
    lea dx,lpassword
    int 21h

    ; Input password
    mov ah,0ah
    lea dx,vpassword
    int 21h

    ; Bandingkan username dan password
    lea si,vusername
    lea di,vpassword
    cld
    mov cx,23
    rep cmpsb
    jne gagal ; Jika tidak cocok, lompat ke gagal

    ; Jika cocok, tampilkan teks diterima dengan warna hijau latar, putih teks
    mov ah,09h
    lea dx,lditerima
    int 21h

    ; Tampilkan dengan atribut hijau latar belakang
    mov ah,02h
    mov bh,0     ; Halaman video
    mov bl,20h   ; Atribut hijau latar, putih teks
    int 10h
    jmp exit

gagal:
    ; Jika gagal, tampilkan teks ditolak dengan warna putih latar, merah teks
    mov ah,09h
    lea dx,lditolak
    int 21h

    ; Tampilkan dengan atribut putih latar belakang
    mov ah,02h
    mov bh,0     ; Halaman video
    mov bl,4Fh   ; Atribut putih latar, merah teks
    int 10h
    jmp proses

exit:
    int 20h
END tdata

