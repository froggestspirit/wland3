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

