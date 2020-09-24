;
; Bootloader simples que demonstra o uso de pilhas
;

mov ah, 0x0e

; Inicializa a base da pilha um pouco após o local onde a BIOS
; inicia nosso setor de BOOT - sendo assim não corremos o risco de sobrescrever algo.
mov bp, 0x8000
mov sp, bp

; Adiciona alguns caracteres a pilha para que sejam retirados posteriormente.
; Note que os caracteres são inseridos como valores inteiros de 16-bit.
push 'A'
push 'B'
push 'C'

pop bx      ; Note que nós só podemos desempilhar valores de 16-bits, então desempilhamos bx
mov al, bl  ; e logo após movemos bl para al. Podendo printar seu valor (al)
int 0x10

pop bx      ; Desempilha o próximo valor
mov al, bl
int 0x10    ; Printa al

; Para provar que nossa pilha cresce para baixo a partir do bp
; buscamos o caractere em 0x8000 - 0x2 (ou seja, 16 bits)
; e printa al
mov al, [0x7ffe]
int 0x10

jmp $ ; Loop infinito

times 510-($-$$) db 0 ; Preenche o restante dos 512 bytes com 0
dw 0xaa55 ; Assinatura da BIOS