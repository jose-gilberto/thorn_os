mov ah, 0x0e ; Entra no modo TTY

mov al, [the_secret]
int 0x10 ; Nós ja vimos que isso não funciona certo?

mov bx, 0x7c0 ; Lembre-se o segmento é automaticamente << 4 para você
mov ds, bx
; OBS: a partir de agora todas as nossas referências de memória terão
; um offset pelo ds implicitamente
mov al, [the_secret]
int 0x10

mov al, [es:the_secret]
int 0x10  ; Não parece certo... atualmente es não é 0x000?

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
  db "X"

times 510 - ($-$$) db 0
dw 0xaa55