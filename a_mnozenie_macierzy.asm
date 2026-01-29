section .data
    msg db "Czas mnozenia: ", 0
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

    ; symulacja mnożenia 1000x1000
    xor edi, edi         ; i = 0
.i_loop:
    cmp edi, 1000
    jge .done

    xor esi, esi         ; j = 0
.j_loop:
    cmp esi, 1000
    jge .next_i

    xor ecx, ecx         ; k = 0
    xor eax, eax
.k_loop:
    cmp ecx, 1000
    jge .next_j

    add eax, 2           ; symulujemy A[i][k] * B[k][j] = 1*2
    inc ecx
    jmp .k_loop

.next_j:
    inc esi
    jmp .j_loop

.next_i:
    inc edi
    jmp .i_loop

.done:
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
    div ebx               ; eax = czas w milisekundach

    ; konwersja eax do ASCII
    mov edi, buf + 15
    mov byte [edi], 0
    mov ebx, eax
.ms_convert:
    xor edx, edx
    mov eax, ebx
    mov ecx, 10
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    mov ebx, eax
    test ebx, ebx
    jnz .ms_convert

    ; wypisz "Czas mnozenia: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    ; wypisz wynik
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

    ; zakończ program
    mov eax, 1
    xor ebx, ebx
    int 0x80