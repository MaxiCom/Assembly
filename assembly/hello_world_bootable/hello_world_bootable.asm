[BITS 16]; the real mode (default mode of bios) works in 16 bits
[ORG 0x7C00]; tell to nasm to load the program on this position in the memory


;;;;;;;;;;;;;
;  program  ;
;;;;;;;;;;;;;
mov SI, HelloString; move the hellostring(first char) address to SI(source index)
call PrintString; call printString label

PrintString:
	next_character:
		mov AL, [SI]; move the current char of the SI address to AL
		inc SI; increment the address of SI(source index)

		or AL, AL; if AL = 0, the zero flag is activated so we exit 	
		jz exit_function

		call PrintCharacter; call print char
		jmp next_character; jmp to print next char
	exit_function:
		ret

PrintCharacter:
	mov AH, 0x0E; Set the bios function code(0x0E = write char in tty mode) in AH
	mov BH, 0x00
	mov BL, 0x07
	int 0x10; call bios interruption 0x10(video interrupt)
	ret
;;;;;;;;;;
;	end  ;
;;;;;;;;;;

HelloString db 'Hello world', 0 ;Set a string ended by a null char

TIMES 510 - ($ - $$) DB 0 ;fill 510 - (current address - start address) by 0
DW 0xAA55; set the magic bytes to boot this program
