;
; Bootloader simples feito para demonstrar endereçamento.
;

; Adicionando o offset o assembler vai saber qual o endereço que
; referênciamos nos labels
[org 0x7c00]

the_secret:
  db "X"

mov ah, 0x0e ; 

; Primeira tentativa
mov al, the_secret
int 0x10

; Segunda tentativa
mov al, [the_secret]
int 0x10

; Terceira tentativa
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Quarta tentativa
mov al, [0x7c1e]
int 0x10

jmp $ ; Loop infinito

times 510-($-$$) db 0
dw 0xaa55