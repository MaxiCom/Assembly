[BITS 16]; the real mode (default mode of bios) works in 16 bits
[ORG 0x7C00]; tell to nasm to load the program on this position in the memory


;;;;;;;;;;;;;
;  program  ;
;;;;;;;;;;;;;
_start:
	call loop

loop:
	mov AH, 0x00; move the bios function code(0x00 of 0x16 interrupt is read keyboard) to AH
	int 0x16
	
	; WARNING: the first interrupt return the readed char to the AL register, the second interrupt need
	; to have the char to write in the AL register too, so it work automaticly in this case

	mov AH, 0x0E; move the bios function code(0x0E of 0x10 interrupt is write in tty mode) to AH
	mov BH, 0x00
	int 0x10
	jmp loop
;;;;;;;;;;
;   end  ;
;;;;;;;;;;


TIMES 510 - ($ - $$) DB 0 ;fill 510 - (current address - start address) by 0
DW 0xAA55; set the magic bytes to boot this program
