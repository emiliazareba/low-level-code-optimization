%define ITERATIONS 1000000000

section .data
    base dd 3
    exponent dd 13

    msg db "Czas potegowania: ", 0
    msg_len equ $ - msg
    newline db 10
    ms_text db " ms", 0
    ms_len equ $ - ms_text

section .bss
    tv_start resd 2
    tv_end   resd 2
    buf resb 16

section .text
    global _start

_start:
    ; gettimeofday(&tv_start, 0)
    mov eax, 78
    mov ebx, tv_start
    xor ecx, ecx
    int 0x80

    ; wykonaj ITERATIONS razy szybkie potęgowanie
    mov esi, ITERATIONS

.loop:
    mov eax, 1
    mov ebx, [exponent]
    mov ecx, [base]

.pow_loop:
    test ebx, 1
    jz .skip
    imul eax, ecx        ; result *= base

.skip:
    imul ecx, ecx        ; base *= base
    shr ebx, 1
    cmp ebx, 0
    jne .pow_loop

    ; (ignorujemy wynik)
    dec esi
    jnz .loop

    ; gettimeofday(&tv_end, 0)
    mov eax, 78
    mov ebx, tv_end
    xor ecx, ecx
    int 0x80

    ; czas w mikrosekundach
    mov eax, [tv_end]
    sub eax, [tv_start]
    mov ebx, 1000000
    mul ebx
    mov ecx, eax
    mov eax, [tv_end+4]
    sub eax, [tv_start+4]
    add ecx, eax          ; ECX = czas w mikrosekundach

    ; przelicz na milisekundy
    mov eax, ecx
    xor edx, edx
    mov ebx, 1000
    div ebx               ; eax = czas w ms

    ; konwertuj eax → ASCII
    mov edi, buf + 15
    mov byte [edi], 0
    mov ebx, eax
.to_ascii:
    xor edx, edx
    mov eax, ebx
    mov ecx, 10
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    mov ebx, eax
    test ebx, ebx
    jnz .to_ascii

    ; wypisz "Czas potegowania: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    ; wypisz liczbe ms
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, buf + 15
    sub edx, edi
    int 0x80

    ; wypisz " ms"
    mov eax, 4
    mov ebx, 1
    mov ecx, ms_text
    mov edx, ms_len
    int 0x80

    ; nowa linia
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; zakończ
    mov eax, 1
    xor ebx, ebx
    int 0x80