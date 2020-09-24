; Quando o computador inicia, a BIOS não sabe como carregar o S.O
; então essa tarefa é delegada ao setor de boot.

; Sendo assim, o setor de boot precisa sempre se encontrar em um
; local conhecido. Esse local é o primeiro setor do disco (cilindro 0,
; cabeçote 0, setor 0) e toma 512 bytes.

; Para ter certeza que o disco é bootável, a BIOS checa se os bytes
; 511 e 512 do setor de boot elegido contém os bytes 0xAA55.

; Loop infinito
loop:
  jmp loop

; Preenche com zeros os bytes faltantes para os 512.
; Devemos ter 512 bytes como tamanho.
times 510 - ($-$$) db 0

; Número mágico (assinatura do boot)
dw 0xaa55

; O resultado deve ser um loop inifito que causa uma mensagem que diz
; "Booting from hard disk..." e nada mais.