[BITS 16]; the real mode (default mode of bios) works in 16 bits
[ORG 0x7C00]; tell to nasm to load the program on this position in the memory

;;;;;;;;;;;;;
;  program  ;
;;;;;;;;;;;;;
set_video_mode:
	mov AX, 0x13; set video mode
	int 0x10

set_register_for_draw:
	mov AH, 0x0C; write pixel function
	mov AL, 0x0A; vga color green
	mov CX, 0 ; X position
	mov DX, 0 ; Y position

draw_green_screen:
	int 0x10 ; write pixel at CX position
	inc CX; increase cx 
	cmp CX, 64000; draw until cx reach 64000 (number of pixels)
	jne draw_green_screen
;;;;;;;;;;
;   end  ;
;;;;;;;;;;

TIMES 510 - ($ - $$) DB 0 ;fill 510 - (current address - start address) by 0
DW 0xAA55; set the magic bytes to boot this program
