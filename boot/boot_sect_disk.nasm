; Carrega os setores (dh) do drive (dl) no ES:BX
disk_load:
  pusha
  ; Leitura a partir do disco requer valores específicos de
  ; configurações em todos os registradores, então vamos
  ; sobrescrever nossos parâmetros de entrada do 'dx'.
  ; Vamos gravar isso na pilha para uso posterior.
  push dx

  mov ah, 0x02      ; ax <- int 0x13. 0x02 = 'leitura'
  mov al, dh        ; al <- numeros de setores a serem lidos
  mov cl, 0x02      ; cl <- setores
  ; 0x01 é o nosso setor de boot, 0x02 é o primeiro setor disponível.

  mov ch, 0x00      ; ch <- cilindro
  ; dl <- número do drive. Nosso caller inicializa ele como um parâmetro recebido da BIOS
  ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
  mov dh, 0x00

  ; [es:bx] <- ponteiro do buffer que aponta para os dados armazenados
  ; caller inicializa ele para nós, e é a posição inicial padrão int 13h.
  int 0x13
  jc disk_error

  pop dx
  cmp al, dh
  jne sectors_error
  popa
  ret

disk_error:
  mov bx, DISK_ERROR
  call print
  call print_nl
  mov dh, ah ; ah = código de erro, dl = drive de disco que dropou o erro
  call print_hex
  jmp disk_loop

sectors_error:
  mov bx, SECTORS_ERROR
  call print

disk_loop:
  jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0