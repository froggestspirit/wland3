farcall: MACRO
	ld a,[$C5FF]
	push af
	ld a,BANK(\1)
	ld [$C5FF],a
	ld [$2100],a
	call \1
	pop af
	ld [$C5FF],a
	ld [$2100],a
ENDM

farjump: MACRO
	ld a,[$C5FF]
	push af
	ld a,BANK(\1)
	ld [$C5FF],a
	ld [$2100],a
	jp \1
ENDM

dbw: MACRO
	db BANK(\1)
	dw \1
ENDM

sound_pointer: MACRO
	dw \1
	db BANK(\1)
	db 0
	db \2
	db \3
	db \4
	db 0	
ENDM

