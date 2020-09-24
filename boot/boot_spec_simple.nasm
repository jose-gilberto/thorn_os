; Quando o computador inicia, a BIOS não sabe como carregar o S.O
; então essa tarefa é delegada ao setor de boot.

; Sendo assim, o setor de boot precisa sempre se encontrar em um
; local conhecido. Esse local é o primeiro setor do disco (cilindro 0,
; cabeçote 0, setor 0) e toma 512 bytes.

; Para ter certeza que o disco é bootável, a BIOS checa se os bytes
; 511 e 512 do setor de boot elegido contém os bytes 0xAA55.

; Imprimindo algumas mensagem com o bootloader

mov ah, 0x0e ; TTY mode
mov al, 'H'
int 0x10 ; Chamada de sistema para imprimir na tela
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; Como o l está no registrador al podemos chamar a chamada de sistema novamente
mov al, 'o'
int 0x10

jmp $ ; Salta para o endereço atual => causando um loop infinito (end. atual => end. atual)

; Preenche com zeros os bytes faltantes para os 512.
; Devemos ter 512 bytes como tamanho.
times 510 - ($-$$) db 0

; Número mágico (assinatura do boot)
dw 0xaa55

; O Resultado agora vai ser uma mensagem de "Booting from hard disk" seguida
; de um Hello sendo impresso pelo bootloader.