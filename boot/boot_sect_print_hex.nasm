; Recebendo a data no registrador dx
; Para os exemplos assumimos que dx = 0x1234
print_hex:
  pusha
  
  mov cx, 0

; Estratégia: pega o último caractere de dx, converte ele para ASCII
; Valores numéricos do ASCII: '0' (0x30) ate 9 (0x39), então só adicionamos 0x30 ao byte N
; Para caracteres não numéricos A-F: 'A' (0x41) ate 'F' (0x46) então adicionamos 0x40
; Então, movemos o byte ASCII para posição correta
hex_loop:
  cmp cx, 4 ; 4 loops
  je end

  ; 1. Converte o último caractere de dx para ASCII
  mov ax, dx ; Vamos utilizar ax como nosso registrador de trabalho
  and ax, 0x000f ; 0x1234 -> 0x0004 mascarando os 3 primeiros caracteres com 0
  add al, 0x30 ; adiciona 0x30 a N para converter em ASCII
  cmp al, 0x39 ; if > 9, adiciona 8 bytes a mais para representar o 'A' até o 'F'
  jle step2
  add al, 7 ; 'A' é ASCII 65 ao inves de 58, então 65-58 = 7

step2:
  ; 2. Pega a posição correta da string para colocar o caractere convertido em ASCII
  ; bx <- endereço base + tamanho da string - indice do caractere
  mov bx, HEX_OUT + 5 ; base + tamanho
  sub bx, cx ; nossa variavel de indice
  mov [bx], al ; Copia o caractere ASCII do reg al para o ponteiro do registrador bx
  ror dx, 4 ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

  ; incrementa o indice e entra em loop
  add cx, 1
  jmp hex_loop

end:
  ; Prepara o parametro e chama a função
  mov bx, HEX_OUT
  call print

  popa
  ret

HEX_OUT:
  db '0x0000', 0 ; Reserva memória para nossa string
