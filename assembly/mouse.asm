.MODEL SMALL
.CODE
ORG 100h

proses:
    jmp start

; Variabel untuk menyimpan koordinat lama kursor
oldX dw -1
oldY dw 0

start:
    ; Ubah ke mode grafik 320x200 dengan 256 warna
    mov ah, 00h
    mov al, 13h
    int 10h

    ; Reset status mouse
    mov ax, 0
    int 33h
    cmp ax, 0
    je stop ; Jika mouse tidak tersedia, keluar

    ; Tampilkan kursor mouse
    mov ax, 1
    int 33h

check_mouse_button:
    ; Baca status mouse (tombol dan posisi)
    mov ax, 3
    int 33h

    ; Sesuaikan posisi X (mode 13h memiliki nilai CX dua kali lipat)
    shr cx, 1

    ; Periksa jika tombol kiri mouse ditekan
    cmp bx, 1
    jne xor_cursor

    ; Gambar piksel dengan warna tertentu saat tombol ditekan
    mov al, 1010b ; Warna piksel (biru muda)
    jmp draw_pixel

xor_cursor:
    ; Hapus kursor lama dengan metode XOR
    cmp oldX, -1
    je not_required ; Jika tidak ada koordinat sebelumnya, lewati

    ; Simpan nilai CX dan DX
    push cx
    push dx

    ; Ambil nilai koordinat lama
    mov cx, oldX
    mov dx, oldY

    ; Ambil warna piksel lama
    mov ah, 0Dh
    int 10h

    ; XOR warna piksel
    xor al, 1111b
    mov ah, 0Ch ; Set warna piksel
    int 10h

    ; Kembalikan nilai CX dan DX
    pop dx
    pop cx

not_required:
    ; Ambil warna piksel saat ini
    mov ah, 0Dh
    int 10h

    ; XOR warna piksel
    xor al, 1111b
    mov oldX, cx ; Simpan koordinat X saat ini
    mov oldY, dx ; Simpan koordinat Y saat ini

draw_pixel:
    ; Gambar piksel pada posisi CX, DX dengan warna AL
    mov ah, 0Ch
    int 10h

check_esc_key:
    ; Periksa jika tombol ESC ditekan
    mov dl, 255
    mov ah, 6
    int 21h
    cmp al, 27 ; ESC memiliki kode ASCII 27
    jne check_mouse_button

stop:
    ; Kembali ke mode teks 80x25
    mov ax, 3
    int 10h

    ; Tampilkan kursor teks berbentuk kotak berkedip
    mov ah, 1
    mov ch, 0
    mov cl, 8
    int 10h

    ; Tampilkan pesan dan tunggu tombol ditekan
    mov dx, offset msg
    mov ah, 9
    int 21h
    mov ah, 0
    int 16h

    ; Keluar dari program
    ret

; Pesan teks untuk pengguna
msg db "Press any key.... $"

END proses
