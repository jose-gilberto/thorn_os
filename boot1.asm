; ***************************************
; boot1.asm
; - Um bootloader simples
;
; ***************************************

org 0x7c00                  ; O bootloader é carregado pela BIOS em 0x7C00

bits 16                     ; Ainda estamos em modo real de 16 bits

Start:

  cli                       ; Limpa todas as interrupções
  hlt                       ; Para o sistema

times 510 - ($-$$) db 0     ; Devemos ter 512 bytes. Limpa o resto dos bytes com 0

dw 0xAA55                   ; Assinatura do boot



