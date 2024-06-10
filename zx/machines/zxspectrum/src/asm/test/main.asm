	; Sample code to write some dots to the screen

	org 32768
	ld de, 16384
	ld a,  125

	ld b,  0	; wraps to 256

draw_loop:
	ld (de), a
	inc e
	djnz draw_loop

	ret

	end 32768
