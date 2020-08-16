INCLUDE "macros.asm"

SECTION "bank00", ROM0

SECTION "rst00", ROM0[$00]
	jp Logged_0x015E
	db 0,0,0,0,0

SECTION "rst08", ROM0[$08]
	db 0,0,0,0,0,0,0,0

SECTION "rst10", ROM0[$10]
	db 0,0,0,0,0,0,0,0

SECTION "rst18", ROM0[$18]
	db 0,0,0,0,0,0,0,0

SECTION "rst20", ROM0[$20]
	db 0,0,0,0,0,0,0,0

SECTION "rst28", ROM0[$28]
JumpList::
	add a,a
	pop hl
	ld e,a
	ld d,$00
	add hl,de
	ld a,[hli]
	ld h,[hl]

SECTION "rst30", ROM0[$30]
	ld l,a
	jp hl
	db 0,0,0,0,0,0

SECTION "rst38", ROM0[$38]
	db 0,0,0,0,0,0,0,0

SECTION "vblankInt", ROM0[$40]
	jp Logged_0x0061
	db 0,0,0,0,0

SECTION "lcdstatInt", ROM0[$48]
	jp $C400
	db 0,0,0,0,0

SECTION "timerInt", ROM0[$50]
	reti
	db 0,0,0,0,0,0,0

SECTION "serialInt", ROM0[$58]
	reti
	db 0,0,0,0,0,0,0

SECTION "joypadInt", ROM0[$60]
	reti

Logged_0x0061:
	push af
	push bc
	push de
	push hl
	ld a,[$C092]
	and a
	jr z,Logged_0x0095
	ld a,[$C5FF]
	push af
	ld a,[$C08E]
	push af
	ld a,[$FF00+$70]
	push af
	ld a,[$FF00+$4F]
	push af
	call $C200
	pop af
	ld [$FF00+$4F],a
	pop af
	ld [$FF00+$70],a
	pop af
	ld [$C08E],a
	ld [$4100],a
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ld a,$01
	ld [$C091],a

Logged_0x0095:
	pop hl
	pop de
	pop bc
	pop af
	reti
	db 0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

SECTION "start", ROM0[$100]
	nop
	jp Init

SECTION "Header", ROM0[$134]
	db "WARIOLAND3",0,"AW8A";Title
	db $C0;CGB only
	db $30,$31;0x144 New Licensee Code
	db $00;SGB Flag
	db $1B;Cart Type
	db $06;ROM Size
	db $03;RAM Size
	db $01;Destination Code
	db $33;Old Licensee Code
	db $00;Version

SECTION "Home", ROM0[$150]

Init:
	and a
	cp $11
	ld a,$00
	jr nz,Logged_0x0158
	inc a

Logged_0x0158:
	ld [$FF00+$FE],a
	ld a,$00
	ld [$FF00+$FD],a

Logged_0x015E:
	xor a
	ld [$FF00+$FC],a

Logged_0x0161:
	di
	ld sp,$CFFF
	ld hl,sp+$00
	ld c,$00
	xor a

Logged_0x016A:
	ld [hld],a
	dec c
	jr nz,Logged_0x016A
	xor a
	ld [$FF00+$4F],a
	ld [$FF00+$70],a
	ld [$FF00+$56],a
	ld a,$80
	ld [$FF00+$40],a

Logged_0x0179:
	ld a,[$FF00+$44]
	cp $94
	jr nz,Logged_0x0179
	ld a,$03
	ld [$FF00+$40],a
	call Logged_0x1A64
	call Logged_0x1A40
	ld a,[$FF00+$FE]
	and a
	jr z,Logged_0x0195
	xor a
	ld [$FF00+$4F],a
	ld [$FF00+$70],a
	ld [$FF00+$56],a

Logged_0x0195:
	xor a
	ld hl,$C000
	ld bc,$0F00
	call Logged_0x0425
	call Logged_0x1A82
	xor a
	ld hl,$FE00
	ld bc,$0100
	call Logged_0x0425
	ld hl,$FF80
	ld b,$7C
	call Logged_0x0420
	call Logged_0x038F
	call Logged_0x03AD
	ld a,$01
	ld [$C5FF],a
	ld [$2100],a
	xor a
	ld [$3100],a
	xor a
	ld [$C08E],a
	ld [$4100],a
	xor a
	ld [$FF00+$0F],a
	ld [$FF00+$FF],a
	ld [$FF00+$42],a
	ld [$FF00+$43],a
	ld [$FF00+$41],a
	ld c,$E8
	ld b,$0E
	ld hl,$0418

Logged_0x01DF:
	ld a,[hli]
	ld [$FF00+c],a
	inc c
	dec b
	jr nz,Logged_0x01DF
	call Logged_0x0334
	call Logged_0x0A92
	xor a
	ld [$FF00+$0F],a
	ld a,$01
	ld [$FF00+$FF],a
	call Logged_0x0341
	ld a,$0A
	ld [$0000],a
	ld a,$7C
	ld [$FF00+$85],a
	ld a,$AD
	ld [$FF00+$8D],a
	ld a,$4C
	ld [$FF00+$8E],a
	call $FF80
	ei
	ld a,[$FF00+$FE]
	and a
	jr nz,Logged_0x021A
	ld a,$0B
	ld [$C09B],a
	xor a
	ld [$C09C],a
	jr Logged_0x021D

Logged_0x021A:
	call Logged_0x1690

Logged_0x021D:
	xor a
	ld [$C094],a
	call Logged_0x1AC0
	ld a,$80
	ld [$FF00+$40],a
	di
	call Logged_0x0FAE
	ei

Logged_0x022D:
	call Logged_0x03D8
	ld a,[$C09A]
	and a
	jr nz,Logged_0x024E
	ld a,[$C093]
	and $0F
	cp $0F
	jr nz,Logged_0x024E
	call Logged_0x1002
	ld bc,$0000
	call Logged_0x0FF4
	call Logged_0x0FBC
	jp Logged_0x015E

Logged_0x024E:
	call Logged_0x4000
	ld a,[$CED8]
	and a
	jr z,Logged_0x0266
	ld a,$34
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80

Logged_0x0266:
	ld a,[$CED9]
	and a
	jr z,Logged_0x026F
	call Logged_0x2A77

Logged_0x026F:
	ld a,$01
	ld [$C092],a
	db $76;halt
	nop

Logged_0x0276:
	ld a,[$C091]
	and a
	jr z,Logged_0x0276
	ld hl,$C08F
	inc [hl]
	xor a
	ld [$C092],a
	ld [$C091],a
	call Logged_0x0290
	jp Logged_0x022D

Unknown_0x028D:
	jp Logged_0x015E

Logged_0x0290:
	ld a,[$C090]
	and a
	ret nz
	ld hl,$FFB5
	ld a,[hli]
	cp $FF
	jr nz,Logged_0x02A2
	ld bc,$0000
	jr Logged_0x02A7

Logged_0x02A2:
	ld c,[hl]
	ld b,a
	or c
	jr z,Logged_0x02AD

Logged_0x02A7:
	xor a
	ld [hld],a
	ld [hl],a
	call Logged_0x0FCA

Logged_0x02AD:
	ld hl,$FFB1
	ld a,[hli]
	cp $FF
	jr nz,Logged_0x02C0
	ld bc,$0000
	xor a
	ld [hld],a
	ld [hl],a
	call Logged_0x0FE6
	jr Logged_0x02CB

Logged_0x02C0:
	ld c,[hl]
	ld b,a
	or c
	jr z,Logged_0x02CB
	xor a
	ld [hld],a
	ld [hl],a
	call Logged_0x1062

Logged_0x02CB:
	call Logged_0x0FBC
	ret

UnknownData_0x02CF:
INCBIN "baserom.gbc", $02CF, $0302 - $02CF

Logged_0x0302:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld hl,$D502
	ld a,[hl]
	and a
	jr z,Logged_0x032D
	ld a,[$C094]
	and $F0
	jr nz,Logged_0x032D
	ld a,[$C093]
	and $F0
	jr z,Logged_0x032D
	dec [hl]
	jr nz,Logged_0x0330
	ld b,a
	ld a,[$C094]
	or b
	ld [$C094],a
	ld a,$08
	jr Logged_0x032F

Logged_0x032D:
	ld a,$10

Logged_0x032F:
	ld [hl],a

Logged_0x0330:
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x0334:
	ld hl,$0340
	ld de,$C200
	ld b,$01
	call Logged_0x0466
	ret

LoggedData_0x0340:
INCBIN "baserom.gbc", $0340, $0341 - $0340

Logged_0x0341:
	ld a,$D9
	ld [$C400],a
	xor a
	ld [$FF00+$0F],a
	ld hl,$FFFF
	res 1,[hl]
	ld hl,$FF41
	res 6,[hl]
	ret

Logged_0x0354:
	ld hl,$0360
	ld de,$C200
	ld b,$10
	call Logged_0x0466
	ret

LoggedData_0x0360:
INCBIN "baserom.gbc", $0360, $0370 - $0360

Logged_0x0370:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x0370

Logged_0x0376:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x0376
	ret

Logged_0x037D:
	ld hl,$CC00
	ld b,$A0
	xor a
	call Logged_0x0420
	xor a
	ld [$C095],a
	ret

Logged_0x038B:
	ld a,$FF
	jr Logged_0x0391

Logged_0x038F:
	ld a,$7F

Logged_0x0391:
	ld d,a
	ld a,$01
	ld [$FF00+$4F],a
	ld hl,$9800
	ld bc,$0400
	xor a
	call Logged_0x0425
	ld [$FF00+$4F],a
	ld a,d
	ld hl,$9800
	ld bc,$0400
	call Logged_0x0425
	ret

Logged_0x03AD:
	ld a,$FF
	ld hl,$9C00
	ld bc,$0400
	call Logged_0x0425
	ret

Logged_0x03B9:
	ld a,[$C095]
	ld l,a
	ld h,$CC
	ld a,$A0
	sub l
	jr z,Logged_0x03D3
	jr c,Logged_0x03D3
	srl a
	srl a
	ld b,a
	xor a

Logged_0x03CC:
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	dec b
	jr nz,Logged_0x03CC

Logged_0x03D3:
	xor a
	ld [$C095],a
	ret

Logged_0x03D8:
	ld a,$20
	ld [$FF00+$00],a
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	cpl
	and $0F
	swap a
	ld b,a
	ld a,$10
	ld [$FF00+$00],a
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	cpl
	and $0F
	or b
	ld c,a
	ld a,[$C093]
	xor c
	and c
	ld [$C094],a
	ld a,c
	ld [$C093],a
	ld a,$30
	ld [$FF00+$00],a
	ret

LoggedData_0x0418:
INCBIN "baserom.gbc", $0418, $0420 - $0418

Logged_0x0420:
	ld [hli],a
	dec b
	jr nz,Logged_0x0420
	ret

Logged_0x0425:
	push af
	ld a,c
	and a
	jr z,Logged_0x042B
	inc b

Logged_0x042B:
	pop af

Logged_0x042C:
	ld [hli],a
	dec c
	jr nz,Logged_0x042C
	dec b
	jr nz,Logged_0x042C
	ret

Logged_0x0434:
	ld a,c
	and a
	jr z,Logged_0x0439
	inc b

Logged_0x0439:
	ld a,[hli]
	ld [de],a
	inc de
	dec c
	jr nz,Logged_0x0439
	dec b
	jr nz,Logged_0x0439
	ret

Logged_0x0443:
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld a,c
	and a
	jr z,Logged_0x0455
	inc b

Logged_0x0455:
	ld a,[hli]
	ld [de],a
	inc de
	dec c
	jr nz,Logged_0x0455
	dec b
	jr nz,Logged_0x0455
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x0466:
	ld a,[hli]
	ld [de],a
	inc de
	dec b
	jr nz,Logged_0x0466
	ret

Logged_0x046D:
	ld a,$01
	ld [$CED7],a
	jr Logged_0x047F

Logged_0x0474:
	ld a,$02
	ld [$CED7],a
	jr Logged_0x047F

Logged_0x047B:
	xor a
	ld [$CED7],a

Logged_0x047F:
	ld a,[$C187]
	cp $02
	jr nc,Logged_0x0499
	dec a
	jr z,Logged_0x0496
	ld a,$01
	ld [$C186],a
	call Logged_0x088D
	ld hl,$C187
	inc [hl]
	ret

Logged_0x0496:
	call Logged_0x08BF

Logged_0x0499:
	ld hl,$C183
	ld de,$C100
	ld b,$40

Logged_0x04A1:
	ld a,[de]
	and $1F
	ld [hli],a
	ld a,[de]
	and $E0
	rrca
	rrca
	rrca
	rrca
	rrca
	ld [hl],a
	inc e
	ld a,[de]
	and $03
	rlca
	rlca
	rlca
	or [hl]
	ld [hli],a
	ld a,[de]
	and $7C
	rrca
	rrca
	ld [hl],a
	inc [hl]
	ld a,[$CED7]
	and a
	jr z,Logged_0x04CA
	inc [hl]
	dec a
	jr z,Logged_0x04CA
	inc [hl]
	inc [hl]

Logged_0x04CA:
	ld a,[hl]
	cp $1F
	jr c,Logged_0x04D1
	ld [hl],$1F

Logged_0x04D1:
	dec l
	inc [hl]
	ld a,[$CED7]
	and a
	jr z,Logged_0x04DF
	inc [hl]
	dec a
	jr z,Logged_0x04DF
	inc [hl]
	inc [hl]

Logged_0x04DF:
	ld a,[hl]
	cp $1F
	jr c,Logged_0x04E6
	ld [hl],$1F

Logged_0x04E6:
	dec l
	inc [hl]
	ld a,[$CED7]
	and a
	jr z,Logged_0x04F4
	inc [hl]
	dec a
	jr z,Logged_0x04F4
	inc [hl]
	inc [hl]

Logged_0x04F4:
	ld a,[hl]
	cp $1F
	jr c,Logged_0x04FB
	ld [hl],$1F

Logged_0x04FB:
	ld a,[hli]
	ld c,a
	ld a,[hl]
	and $07
	rlca
	rlca
	rlca
	rlca
	rlca
	or c
	dec e
	ld [de],a
	ld a,[hli]
	and $18
	rrca
	rrca
	rrca
	ld c,a
	ld a,[hld]
	rlca
	rlca
	or c
	inc e
	ld [de],a
	inc e
	dec l
	dec b
	jr nz,Logged_0x04A1
	ld hl,$C187
	inc [hl]
	ld b,$21
	ld a,[$CED7]
	and a
	jr z,Logged_0x052D
	ld b,$12
	dec a
	jr z,Logged_0x052D
	ld b,$0A

Logged_0x052D:
	ld a,[hl]
	cp b
	ret c
	di
	ld hl,$C080
	ld b,$07
	ld de,$C200
	ld b,$03
	call Logged_0x0466
	ei
	xor a
	ld [$CED7],a
	ld [$C187],a
	ld [$C186],a
	ld hl,$C09C
	inc [hl]
	ret

UnknownData_0x054E:
INCBIN "baserom.gbc", $054E, $05DF - $054E

Logged_0x05DF:
	ld a,$01
	ld [$CED7],a
	jr Logged_0x05F1

Logged_0x05E6:
	ld a,$02
	ld [$CED7],a
	jr Logged_0x05F1

Logged_0x05ED:
	xor a
	ld [$CED7],a

Logged_0x05F1:
	ld a,[$C187]
	cp $02
	jr nc,Logged_0x060B
	dec a
	jr z,Logged_0x0608
	ld a,$01
	ld [$C186],a
	call Logged_0x088D
	ld hl,$C187
	inc [hl]
	ret

Logged_0x0608:
	call Logged_0x08BF

Logged_0x060B:
	ld hl,$C180
	ld de,$C000
	ld b,$40

Logged_0x0613:
	ld a,[de]
	and $1F
	ld [hli],a
	ld a,[de]
	and $E0
	rrca
	rrca
	rrca
	rrca
	rrca
	ld [hl],a
	inc e
	ld a,[de]
	and $03
	rlca
	rlca
	rlca
	or [hl]
	ld [hli],a
	ld a,[de]
	and $7C
	rrca
	rrca
	ld [hli],a
	dec e
	ld d,$C1
	ld a,[de]
	and $1F
	ld [hli],a
	ld a,[de]
	and $E0
	rrca
	rrca
	rrca
	rrca
	rrca
	ld [hl],a
	inc e
	ld a,[de]
	and $03
	rlca
	rlca
	rlca
	or [hl]
	ld [hli],a
	ld a,[de]
	and $7C
	rrca
	rrca
	ld [hl],a
	ld a,[$C182]
	ld c,a
	dec [hl]
	jr z,Logged_0x0665
	ld a,[$CED7]
	and a
	jr z,Logged_0x0665
	dec [hl]
	jr z,Logged_0x0665
	dec a
	jr z,Logged_0x0665
	dec [hl]
	jr z,Logged_0x0665
	dec [hl]

Logged_0x0665:
	ld a,[hl]
	cp c
	jr nc,Logged_0x066A
	ld [hl],c

Logged_0x066A:
	dec l
	ld a,[$C181]
	ld c,a
	dec [hl]
	jr z,Logged_0x0682
	ld a,[$CED7]
	and a
	jr z,Logged_0x0682
	dec [hl]
	jr z,Logged_0x0682
	dec a
	jr z,Logged_0x0682
	dec [hl]
	jr z,Logged_0x0682
	dec [hl]

Logged_0x0682:
	ld a,[hl]
	cp c
	jr nc,Logged_0x0687
	ld [hl],c

Logged_0x0687:
	dec l
	ld a,[$C180]
	ld c,a
	dec [hl]
	jr z,Logged_0x069F
	ld a,[$CED7]
	and a
	jr z,Logged_0x069F
	dec [hl]
	jr z,Logged_0x069F
	dec a
	jr z,Logged_0x069F
	dec [hl]
	jr z,Logged_0x069F
	dec [hl]

Logged_0x069F:
	ld a,[hl]
	cp c
	jr nc,Logged_0x06A4
	ld [hl],c

Logged_0x06A4:
	ld a,[hli]
	ld c,a
	ld a,[hl]
	and $07
	rlca
	rlca
	rlca
	rlca
	rlca
	or c
	dec e
	ld [de],a
	ld a,[hli]
	and $18
	rrca
	rrca
	rrca
	ld c,a
	ld a,[hld]
	rlca
	rlca
	or c
	inc e
	ld [de],a
	inc e
	ld d,$C0
	ld hl,$C180
	dec b
	jp nz,Logged_0x0613
	ld hl,$C187
	inc [hl]
	ld b,$21
	ld a,[$CED7]
	and a
	jr z,Logged_0x06DB
	ld b,$12
	dec a
	jr z,Logged_0x06DB
	ld b,$0A

Logged_0x06DB:
	ld a,[hl]
	cp b
	ret c
	di
	ld hl,$C080
	ld de,$C200
	ld b,$03
	call Logged_0x0466
	ei
	xor a
	ld [$CED7],a
	ld [$C187],a
	ld [$C186],a
	ld hl,$C09C
	inc [hl]
	ret

Logged_0x06FA:
	ld a,[$C187]
	cp $02
	jr nc,Logged_0x0714
	dec a
	jr z,Logged_0x0711
	ld a,$01
	ld [$C186],a
	call Logged_0x088D
	ld hl,$C187
	inc [hl]
	ret

Logged_0x0711:
	call Logged_0x08BF

Logged_0x0714:
	ld hl,$C180
	ld de,$C000
	ld b,$40

Logged_0x071C:
	ld a,[de]
	and $1F
	ld [hli],a
	ld a,[de]
	and $E0
	rlca
	rlca
	rlca
	ld [hl],a
	inc e
	ld a,[de]
	and $03
	rlca
	rlca
	rlca
	or [hl]
	ld [hli],a
	ld a,[de]
	and $7C
	rrca
	rrca
	ld [hli],a
	dec e
	ld d,$C1
	ld a,[de]
	and $1F
	ld [hli],a
	ld a,[de]
	and $E0
	rlca
	rlca
	rlca
	ld [hl],a
	inc e
	ld a,[de]
	and $03
	rlca
	rlca
	rlca
	or [hl]
	ld [hli],a
	ld a,[de]
	and $7C
	rrca
	rrca
	ld [hl],a
	ld a,[$C182]
	ld c,a
	cp [hl]
	jr z,Logged_0x0764
	jr nc,Logged_0x0761
	dec [hl]
	ld a,[hl]
	cp c
	jr Logged_0x0764

Logged_0x0761:
	inc [hl]
	ld a,[hl]
	cp c

Logged_0x0764:
	dec l
	ld a,[$C181]
	ld c,a
	cp [hl]
	jr z,Logged_0x0776
	jr nc,Logged_0x0773
	dec [hl]
	ld a,[hl]
	cp c
	jr Logged_0x0776

Logged_0x0773:
	inc [hl]
	ld a,[hl]
	cp c

Logged_0x0776:
	dec l
	ld a,[$C180]
	ld c,a
	cp [hl]
	jr z,Logged_0x0788
	jr nc,Logged_0x0785
	dec [hl]
	ld a,[hl]
	cp c
	jr Logged_0x0788

Logged_0x0785:
	inc [hl]
	ld a,[hl]
	cp c

Logged_0x0788:
	ld a,[hli]
	ld c,a
	ld a,[hl]
	and $07
	rrca
	rrca
	rrca
	or c
	dec e
	ld [de],a
	ld a,[hli]
	and $18
	rrca
	rrca
	rrca
	ld c,a
	ld a,[hld]
	rlca
	rlca
	or c
	inc e
	ld [de],a
	inc e
	ld d,$C0
	ld hl,$C180
	dec b
	jp nz,Logged_0x071C
	ld hl,$C187
	inc [hl]
	ld b,$21
	ld a,[hl]
	cp b
	ret c
	di
	ld hl,$C080
	ld de,$C200
	ld b,$03
	call Logged_0x0466
	ei
	xor a
	ld [$CED7],a
	ld [$C187],a
	ld [$C186],a
	ld hl,$C09C
	inc [hl]
	ret

UnknownData_0x07CF:
INCBIN "baserom.gbc", $07CF, $088D - $07CF

Logged_0x088D:
	di
	ld hl,$C200
	ld de,$C080
	ld b,$03
	call Logged_0x0466
	ld hl,$08A6
	ld de,$C200
	ld b,$03
	call Logged_0x0466
	ei
	ret

LoggedData_0x08A6:
INCBIN "baserom.gbc", $08A6, $08A9 - $08A6
	ld a,[$C083]
	ld [$FF00+$42],a
	ld a,[$C085]
	ld [$FF00+$43],a
	call Logged_0x1A9A
	call Logged_0x1AAD
	ld a,$CC
	call $FFE8
	ret

Logged_0x08BF:
	di
	ld hl,$08CD
	ld de,$C200
	ld b,$03
	call Logged_0x0466
	ei
	ret

LoggedData_0x08CD:
INCBIN "baserom.gbc", $08CD, $08D0 - $08CD
	ld a,[$C083]
	ld [$FF00+$42],a
	ld a,[$C085]
	ld [$FF00+$43],a
	call Logged_0x19F3
	call Logged_0x1A04
	ld a,$CC
	call $FFE8
	ret

Logged_0x08E6:
	ld a,[$FF00+$40]
	bit 7,a
	ret z
	ld a,[$FF00+$FF]
	ld [$C09E],a
	res 0,a
	ld [$FF00+$FF],a

Logged_0x08F4:
	ld a,[$FF00+$44]
	cp $91
	jr nz,Logged_0x08F4
	ld a,[$FF00+$40]
	and $7F
	ld [$FF00+$40],a
	xor a
	ld [$FF00+$0F],a
	ld a,[$C09E]
	ld [$FF00+$FF],a
	ret

Logged_0x0909:
	ld a,[hli]
	and a
	jr z,Logged_0x0927
	bit 7,a
	jr nz,Logged_0x091C
	ld d,a
	ld a,[hli]
	ld e,a

Logged_0x0914:
	ld a,e
	ld [bc],a
	inc bc
	dec d
	jr nz,Logged_0x0914
	jr Logged_0x0909

Logged_0x091C:
	and $7F
	ld d,a

Logged_0x091F:
	ld a,[hli]
	ld [bc],a
	inc bc
	dec d
	jr nz,Logged_0x091F
	jr Logged_0x0909

Logged_0x0927:
	ret

Logged_0x0928:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[$D506]
	ld c,a
	ld a,[$C187]
	or c
	jr nz,Logged_0x095E
	ld a,$01
	ld [$C186],a
	call Logged_0x09CB
	ld a,[$D506]
	xor $01
	ld [$D506],a
	ld a,$01
	ld [$D503],a
	ld a,[$D507]
	ld [$D504],a
	ld a,[$D508]
	ld [$D505],a

Logged_0x095A:
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x095E:
	ld a,[$D506]
	xor $01
	ld [$D506],a
	jr z,Logged_0x096D
	call Logged_0x09A3
	jr Logged_0x095A

Logged_0x096D:
	ld hl,$C187
	inc [hl]
	ld a,[hl]
	cp $11
	jr c,Logged_0x095A
	di
	ld hl,$C080
	ld de,$C200
	ld b,$03
	call Logged_0x0466
	ei
	xor a
	ld [$C187],a
	ld [$C186],a
	ld [$D506],a
	ld a,$FF
	ld [$FF00+$B1],a
	ld a,$00
	ld [$FF00+$B2],a
	ld a,$FF
	ld [$FF00+$B5],a
	ld a,$00
	ld [$FF00+$B6],a
	ld hl,$C09C
	inc [hl]
	jr Logged_0x095A

Logged_0x09A3:
	ld a,[$C187]
	cp $10
	ret nc
	ld hl,$D503
	ld a,[hl]
	add a,$02
	ld [hli],a
	ld a,[hl]
	add a,$20
	ld [hli],a
	ld a,[hl]
	adc a,$00
	cp $9C
	jr c,Logged_0x09BD
	sub $04

Logged_0x09BD:
	ld [hld],a
	ld a,[hl]
	dec a
	ld [hl],a
	and $1F
	cp $1F
	ret nz
	ld a,[hl]
	add a,$20
	ld [hl],a
	ret

Logged_0x09CB:
	di
	ld hl,$C200
	ld de,$C080
	ld b,$03
	call Logged_0x0466
	ld hl,$09E4
	ld de,$C200
	ld b,$03
	call Logged_0x0466
	ei
	ret

LoggedData_0x09E4:
INCBIN "baserom.gbc", $09E4, $09E7 - $09E4
	ld a,[$C083]
	ld [$FF00+$42],a
	ld a,[$C085]
	ld [$FF00+$43],a
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld de,$FFE0
	ld a,[$D506]
	and a
	jr z,Logged_0x0A49
	ld hl,$D503
	ld a,[hli]
	ld b,a
	ld c,a
	ld a,[hli]
	ld h,[hl]
	ld l,a

Logged_0x0A0A:
	ld a,$01
	ld [$FF00+$4F],a
	ld a,[hl]
	and $7F
	or $0F
	ld [hl],a
	xor a
	ld [$FF00+$4F],a
	ld [hl],$7F
	add hl,de
	ld a,h
	cp $98
	jr nc,Logged_0x0A22
	add a,$04
	ld h,a

Logged_0x0A22:
	dec b
	jr nz,Logged_0x0A0A
	ld b,c
	inc b

Logged_0x0A27:
	ld a,$01
	ld [$FF00+$4F],a
	ld a,[hl]
	and $7F
	or $0F
	ld [hl],a
	xor a
	ld [$FF00+$4F],a
	ld a,$7F
	ld [hli],a
	ld a,l
	and $1F
	jr nz,Logged_0x0A44
	ld a,l
	sub $20
	ld l,a
	ld a,h
	sbc a,$00
	ld h,a

Logged_0x0A44:
	dec b
	jr nz,Logged_0x0A27
	jr Logged_0x0A8E

Logged_0x0A49:
	ld hl,$D503
	ld a,[hli]
	ld b,a
	ld c,a
	ld a,[hli]
	ld h,[hl]
	ld l,a

Logged_0x0A52:
	ld a,$01
	ld [$FF00+$4F],a
	ld a,[hl]
	and $7F
	or $0F
	ld [hl],a
	xor a
	ld [$FF00+$4F],a
	ld a,$7F
	ld [hli],a
	ld a,l
	and $1F
	jr nz,Logged_0x0A6F
	ld a,l
	sub $20
	ld l,a
	ld a,h
	sbc a,$00
	ld h,a

Logged_0x0A6F:
	dec b
	jr nz,Logged_0x0A52
	ld b,c

Logged_0x0A73:
	ld a,$01
	ld [$FF00+$4F],a
	ld a,[hl]
	and $7F
	or $0F
	ld [hl],a
	xor a
	ld [$FF00+$4F],a
	ld [hl],$7F
	add hl,de
	ld a,h
	cp $98
	jr nc,Logged_0x0A8B
	add a,$04
	ld h,a

Logged_0x0A8B:
	dec b
	jr nz,Logged_0x0A73

Logged_0x0A8E:
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x0A92:
	ld hl,$0A9E
	ld de,$FF80
	ld b,$17
	call Logged_0x0466
	ret

LoggedData_0x0A9E:
INCBIN "baserom.gbc", $0A9E, $0AB5 - $0A9E

Logged_0x0AB5:
	ld a,[$CEEF]
	and $3C
	ret nz
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld a,[$C0AD]
	ld h,a
	ld a,[$C0AE]
	ld l,a
	call Logged_0x0AEE
	pop af
	ld [$C5FF],a
	ld [$2100],a
	pop af
	ld [$C08E],a
	ld [$4100],a
	ret

Logged_0x0AEE:
	ld c,$A0
	ld de,$A000

Logged_0x0AF3:
	ld a,[hli]
	and a
	ret z
	bit 7,a
	jr nz,Logged_0x0B23
	ld b,a
	ld a,[hli]
	ld [$C09F],a

Logged_0x0AFF:
	ld a,[$C09F]
	ld [de],a
	inc de
	ld a,e
	cp c
	jr z,Logged_0x0B0D

Logged_0x0B08:
	dec b
	jr nz,Logged_0x0AFF
	jr Logged_0x0AF3

Logged_0x0B0D:
	ld e,$00
	inc d
	ld a,d
	cp $C0
	jr nz,Logged_0x0B21
	ld d,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x0B21:
	jr Logged_0x0B08

Logged_0x0B23:
	and $7F
	ld b,a

Logged_0x0B26:
	ld a,[hli]
	ld [de],a
	inc de
	ld a,e
	cp c
	jr z,Logged_0x0B32

Logged_0x0B2D:
	dec b
	jr nz,Logged_0x0B26
	jr Logged_0x0AF3

Logged_0x0B32:
	ld e,$00
	inc d
	ld a,d
	cp $C0
	jr nz,Logged_0x0B2D
	ld d,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a
	jr Logged_0x0B2D

Logged_0x0B48:
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld a,[$C0AD]
	ld h,a
	ld a,[$C0AE]
	ld l,a
	call Logged_0x0B7B
	pop af
	ld [$C5FF],a
	ld [$2100],a
	pop af
	ld [$C08E],a
	ld [$4100],a
	ret

Logged_0x0B7B:
	ld a,$A0
	srl a
	add a,$B0
	dec a
	ld c,a
	ld de,$A0B0

Logged_0x0B86:
	ld a,[hli]
	and a
	ret z
	bit 7,a
	jr nz,Logged_0x0BB6
	ld b,a
	ld a,[hli]
	ld [$C09F],a

Logged_0x0B92:
	ld a,[$C09F]
	ld [de],a
	ld a,e
	cp c
	jr z,Logged_0x0BA0
	inc de

Logged_0x0B9B:
	dec b
	jr nz,Logged_0x0B92
	jr Logged_0x0B86

Logged_0x0BA0:
	ld e,$B0
	inc d
	ld a,d
	cp $C0
	jr nz,Logged_0x0BB4
	ld d,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x0BB4:
	jr Logged_0x0B9B

Logged_0x0BB6:
	and $7F
	ld b,a

Logged_0x0BB9:
	ld a,[hli]
	ld [de],a
	ld a,e
	cp c
	jr z,Logged_0x0BC5
	inc de

Logged_0x0BC0:
	dec b
	jr nz,Logged_0x0BB9
	jr Logged_0x0B86

Logged_0x0BC5:
	ld e,$B0
	inc d
	ld a,d
	cp $C0
	jr nz,Logged_0x0BC0
	ld d,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a
	jr Logged_0x0BC0

Logged_0x0BDB:
	ld a,[hli]
	ld d,a
	ld a,[hli]
	swap a
	and $0F
	ld b,a
	ld a,d
	and $0F
	swap a
	add a,b
	ld b,$01
	add a,$A0
	cp $C0
	jr c,Logged_0x0BFB
	inc b
	sub $20
	cp $C0
	jr c,Logged_0x0BFB
	inc b
	sub $20

Logged_0x0BFB:
	ld [$CCEA],a
	ld a,b
	ld [$CCE9],a
	ld a,[hli]
	ld d,a
	ld a,[hl]
	swap a
	and $0F
	ld l,a
	ld a,d
	and $0F
	swap a
	add a,l
	ld l,a
	ld [$CCEB],a
	ld a,[$CCEA]
	ld h,a
	ret

Logged_0x0C19:
	ld a,h
	sub $A0
	ld e,a
	ld d,$00
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	ld a,d
	and $03
	ld d,a
	ld a,l
	and $0F
	add a,a
	ld l,a
	ld h,$98
	add hl,de
	ld a,h
	ld [$CCF0],a
	ld a,l
	ld [$CCF1],a
	ret
	ld a,[$C1A0]
	and a
	jr nz,Logged_0x0C72
	xor a
	ld [$4100],a
	ld hl,$C0BC
	ld a,[$C083]
	add a,[hl]
	ld [$FF00+$42],a
	ld a,[$C085]
	ld [$FF00+$43],a
	ld a,$CC
	call $FFE8
	ld hl,$CE6A
	ld bc,$CE01
	jp $C210

Logged_0x0C72:
	ld hl,$C1A1
	ld a,[hli]
	ld [$2100],a
	ld c,$51
	ld a,[hli]
	ld [$FF00+c],a
	inc c
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+$4F],a
	inc c
	ld a,[hli]
	ld [$FF00+c],a
	inc c
	ld a,[hli]
	ld [$FF00+c],a
	inc c
	ld a,[hl]
	ld [$FF00+c],a
	xor a
	ld [$C1A0],a
	ld hl,$C0BC
	ld a,[$C083]
	add a,[hl]
	ld [$FF00+$42],a
	ld a,[$C085]
	ld [$FF00+$43],a
	ld a,$CC
	call $FFE8
	xor a
	ld [$CE00],a
	ld [$CE69],a
	ret
	ld a,$01
	ld [$FF00+$4F],a
	ld hl,$CE6A
	ld bc,$CE35
	jp $C800
	xor a
	ld [$CE00],a
	ld [$CE69],a
	ret

Logged_0x0CC0:
	ld a,[hli]
	ld d,a
	ld a,[hli]
	swap a
	and $0F
	ld c,a
	ld a,d
	and $0F
	swap a
	add a,c
	add a,$A0
	ld c,a
	ld [$CCED],a
	ld a,[hli]
	ld d,a
	ld a,[hl]
	swap a
	and $0F
	ld l,a
	ld a,d
	and $0F
	swap a
	add a,l
	srl a
	ld l,a
	ld a,$00
	adc a,$00
	xor $01
	ld [$CCEF],a
	ld b,a
	ld a,l
	add a,$B0
	ld l,a
	ld [$CCEE],a
	ld h,c
	ret

Logged_0x0CF8:
	push hl
	ld a,h
	sub $A0
	ld h,a
	and $F0
	swap a
	ld d,a
	ld a,[$CCEC]
	dec a
	add a,a
	add a,d
	ld [$FF00+$A8],a
	ld a,h
	and $0F
	swap a
	add a,$10
	ld [$FF00+$A9],a
	ld a,[$FF00+$A8]
	adc a,$00
	ld [$FF00+$A8],a
	ld a,b
	xor $01
	add a,a
	add a,a
	add a,a
	add a,a
	add a,$08
	ld d,a
	ld a,l
	sub $B0
	add a,a
	ld l,a
	and $F0
	swap a
	ld [$FF00+$AA],a
	ld a,l
	and $0F
	swap a
	add a,d
	ld [$FF00+$AB],a
	ld a,[$FF00+$AA]
	adc a,$00
	ld [$FF00+$AA],a
	pop hl
	ret

Logged_0x0D3E:
	ld a,h
	sub $A0
	ld d,a
	and $F0
	swap a
	ld b,a
	ld a,[$CCE9]
	dec a
	add a,a
	add a,b
	ld [$FF00+$A8],a
	ld a,d
	and $0F
	swap a
	add a,$10
	ld [$FF00+$A9],a
	ld a,[$FF00+$A8]
	adc a,$00
	ld [$FF00+$A8],a
	ld a,l
	sub $00
	ld e,a
	and $F0
	swap a
	ld [$FF00+$AA],a
	ld a,e
	and $0F
	swap a
	add a,$08
	ld [$FF00+$AB],a
	ld a,[$FF00+$AA]
	adc a,$00
	ld [$FF00+$AA],a
	ld a,l
	and $01
	xor $01
	ld b,a
	ld [$CCEF],a
	ret

Logged_0x0D81:
	ld a,l
	sub $B0
	add a,a
	ld l,a
	ld a,b
	xor $01
	add a,l
	ld l,a
	ret

Logged_0x0D8C:
	ld a,[$CCE9]
	ld [$CCEC],a
	ld b,$01
	ld a,l
	srl a
	jr nc,Logged_0x0D9A
	dec b

Logged_0x0D9A:
	add a,$B0
	ld l,a
	ret

Logged_0x0D9E:
	ld a,[$CA8E]
	cp $06
	jr nz,Logged_0x0DB1
	ld hl,$CA8D
	inc [hl]
	ld a,[hl]
	and $F2
	cp $F0
	jr z,Logged_0x0DB6
	ret

Logged_0x0DB1:
	ld a,[$CA8D]
	and a
	ret nz

Logged_0x0DB6:
	ld a,[$CA7E]
	ld [$C0AC],a
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld a,[$CA7F]
	ld h,a
	ld a,[$CA80]
	ld l,a
	ld a,[$CA87]
	ld [$C096],a
	ld a,[$CA88]
	ld [$C097],a
	ld a,[$CA65]
	ld [$C098],a
	ld a,[$CA66]
	ld [$C099],a
	call Logged_0x0DF4
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x0DF4:
	ld a,[$C098]
	ld d,$00
	add a,a
	ld e,a
	add hl,de
	ld a,[hli]
	ld e,a
	ld d,[hl]
	ld hl,$C097
	ld a,[hld]
	ld c,a
	ld a,[hld]
	ld b,a
	ld l,[hl]
	ld h,$CC

Logged_0x0E09:
	ld a,l
	cp $A0
	ret nc
	ld a,[de]
	cp $80
	ret z
	ld a,[de]
	add a,b
	ld [hli],a
	inc de
	ld a,[de]
	add a,c
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	push hl
	ld hl,$C099
	ld a,[de]
	xor [hl]
	pop hl
	ld [hli],a
	ld a,l
	ld [$C095],a
	inc de
	jr Logged_0x0E09

Logged_0x0E2B:
	ld a,[$D100]
	bit 1,a
	ret z

Logged_0x0E31:
	ld a,[$CCE9]
	dec a
	add a,a
	add a,a
	add a,a
	add a,a
	add a,a
	add a,h
	ld b,a
	ld c,l
	ld hl,$C18E
	ld a,[$C19E]
	ld e,a
	ld d,$00
	add hl,de
	ld a,b
	ld [hli],a
	ld [hl],c
	ld a,e
	add a,$02
	and $0F
	ld [$C19E],a
	ret
	ld a,[$CA81]
	ld d,a
	ld a,[$CA82]
	ld e,a
	xor a
	ld [$C1A8],a
	ld hl,$CA67
	ld a,[hl]
	sub $01
	ld [hli],a
	ret nc
	ld a,[hl]
	add a,e
	ld c,a
	ld a,d
	adc a,$00
	ld b,a
	ld a,[bc]
	cp $FF
	jr z,Logged_0x0E7E
	ld [$CA65],a
	ld a,[hl]
	add a,$02
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ret

Logged_0x0E7E:
	xor a
	ld [hld],a
	ld [hl],a
	ld a,$01
	ld [$C1A8],a
	ret

Unknown_0x0E87:
	jp Logged_0x015E

Logged_0x0E8A:
	ld d,$00
	ld a,[$CA06]
	add a,a
	ld e,a
	rl d
	ld hl,$40BE
	add hl,de
	ld a,[$C5FF]
	push af
	ld a,$30
	ld [$C5FF],a
	ld [$2100],a
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,h
	inc a
	jr z,Unknown_0x0E87
	ld a,[hli]
	ld [$C0AE],a
	ld a,[hli]
	ld [$C0AD],a
	ld a,[hl]
	ld [$C0AC],a
	push hl
	call Logged_0x0AB5
	pop hl
	ld a,[hli]
	ld [$C0AC],a
	ld a,[hli]
	ld [$C0AE],a
	ld a,[hl]
	ld [$C0AD],a
	pop af
	ld [$C5FF],a
	ld [$2100],a
	push hl
	ld a,[$CEEF]
	and $3C
	jr nz,Logged_0x0ED9
	call Logged_0x0B48

Logged_0x0ED9:
	pop hl
	ret

Logged_0x0EDB:
	ld d,$00
	ld a,[$CA06]
	add a,a
	ld e,a
	rl d
	ld hl,$40BE
	add hl,de
	ld a,[$C5FF]
	push af
	ld a,$30
	ld [$C5FF],a
	ld [$2100],a
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,h
	inc a
	jp z,Unknown_0x0E87
	ld a,[hli]
	ld [$C0AE],a
	ld a,[hli]
	ld [$C0AD],a
	ld a,[hl]
	ld [$C0AC],a
	pop af
	ld [$C5FF],a
	ld [$2100],a
	call Logged_0x0F13
	ret

Logged_0x0F13:
	ld a,[$CEEF]
	and $3C
	ret nz
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld a,[$C0AD]
	ld d,a
	ld a,[$C0AE]
	ld e,a
	call Logged_0x0F4C
	pop af
	ld [$C5FF],a
	ld [$2100],a
	pop af
	ld [$C08E],a
	ld [$4100],a
	ret

Logged_0x0F4C:
	ld c,$A0
	ld hl,$A000

Logged_0x0F51:
	ld a,[de]
	and a
	ret z
	bit 7,a
	jr nz,Logged_0x0F85
	ld b,a
	inc de
	ld a,[de]
	and $80
	ld [$C09F],a
	inc de

Logged_0x0F61:
	ld a,[$C09F]
	or [hl]
	ld [hli],a
	ld a,l
	cp c
	jr z,Logged_0x0F6F

Logged_0x0F6A:
	dec b
	jr nz,Logged_0x0F61
	jr Logged_0x0F51

Logged_0x0F6F:
	ld l,$00
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x0F83
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x0F83:
	jr Logged_0x0F6A

Logged_0x0F85:
	and $7F
	ld b,a
	inc de

Logged_0x0F89:
	ld a,[de]
	and $80
	or [hl]
	ld [hli],a
	inc de
	ld a,l
	cp c
	jr z,Logged_0x0F98

Logged_0x0F93:
	dec b
	jr nz,Logged_0x0F89
	jr Logged_0x0F51

Logged_0x0F98:
	ld l,$00
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x0F93
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a
	jr Logged_0x0F93

Logged_0x0FAE:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x3F00
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x0FBC:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x3F06
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x0FCA:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x3F0C
	pop af
	ld [$FF00+$70],a
	ret

UnknownData_0x0FD8:
INCBIN "baserom.gbc", $0FD8, $0FE6 - $0FD8

Logged_0x0FE6:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x3F18
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x0FF4:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x3F1E
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x1002:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x3F24
	pop af
	ld [$FF00+$70],a
	ret

UnknownData_0x1010:
INCBIN "baserom.gbc", $1010, $102C - $1010

Logged_0x102C:
	ld [$FF00+$AC],a
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[$FF00+$AC]
	call Logged_0x3F36
	pop af
	ld [$FF00+$70],a
	ret

UnknownData_0x103E:
INCBIN "baserom.gbc", $103E, $1062 - $103E

Logged_0x1062:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x3F48
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x1070:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$12
	ld [$FF00+$B6],a
	ret

Logged_0x1079:
	ld a,[$CA8E]
	cp $53
	call z,Logged_0x10A7
	xor a
	ld [$CA8C],a
	ld [$CA8E],a
	ld [$CA8F],a
	ld [$CA92],a
	ld [$CA93],a
	ld [$CA94],a
	ld [$CA8A],a
	ld [$CA90],a
	ld [$CA91],a
	ld [$CA9B],a
	ld [$CA8D],a
	ld [$CA9C],a
	ret

Logged_0x10A7:
	ld hl,$C000
	ld a,$80
	ld [$FF00+$68],a
	ld b,$08
	ld c,$69

Logged_0x10B2:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x10B2

Logged_0x10B8:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x10B8
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x10B2
	ld hl,$C058
	ld a,$98
	ld [$FF00+$6A],a
	ld b,$04
	ld c,$6B

Logged_0x10DC:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x10DC

Logged_0x10E2:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x10E2
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x10DC
	ret

UnknownData_0x10FC:
INCBIN "baserom.gbc", $10FC, $1146 - $10FC

Logged_0x1146:
	call Logged_0x114E
	ld a,c
	ld [$CA78],a
	ret

Logged_0x114E:
	ld a,[$CA61]
	dec a
	jr z,Logged_0x115B
	dec a
	jr z,Logged_0x115F
	ld c,$05
	jr Logged_0x1161

Logged_0x115B:
	ld c,$03
	jr Logged_0x1161

Logged_0x115F:
	ld c,$01

Logged_0x1161:
	ld a,[$CA62]
	cp $80
	ret nc
	inc c
	ret

Logged_0x1169:
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x117F
	call Logged_0x114E
	ld a,[$CA78]
	sub c
	jr z,Logged_0x117F
	jr c,Logged_0x117F
	jr Logged_0x11AE

Logged_0x117F:
	ret

UnknownData_0x1180:
INCBIN "baserom.gbc", $1180, $1197 - $1180

Logged_0x1197:
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x11AD
	call Logged_0x114E
	ld a,[$CA78]
	sub c
	jr c,Logged_0x11AB
	jr Logged_0x11AD

Logged_0x11AB:
	jr Logged_0x11D6

Logged_0x11AD:
	ret

Logged_0x11AE:
	ld a,c
	ld [$CA78],a
	cp $05
	jr z,Logged_0x11BA
	ld a,$80
	jr Logged_0x11BC

Logged_0x11BA:
	ld a,$68

Logged_0x11BC:
	ld [$C1A9],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E1
	ld [$FF00+$B6],a
	ld a,$08
	ld [$C1AA],a
	ld a,$01
	ld [$CA73],a
	xor a
	ld [$CAC8],a
	ret

Logged_0x11D6:
	ld a,c
	ld [$CA78],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E1
	ld [$FF00+$B6],a
	ld a,$04
	ld [$C1AA],a
	ld a,$01
	ld [$CA73],a
	ld a,$80
	ld [$C1A9],a
	xor a
	ld [$CAC8],a
	ret

Logged_0x11F6:
	xor a
	ld [$CA9A],a
	ld [$C1B1],a
	ld [$CED9],a
	ld [$CEE0],a
	ld [$CEE1],a
	ld [$CEE2],a
	ld [$CAC3],a
	ld [$C0E6],a
	inc a
	ld [$CA8A],a
	ld a,[$C0D7]
	bit 7,a
	ret nz
	ld hl,$C09C
	ld a,[$C0D7]
	bit 5,a
	jr z,Logged_0x1246
	inc [hl]
	ld a,$02
	ld [$FF00+$85],a
	ld a,$06
	ld [$FF00+$8D],a
	ld a,$4E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,h
	ld [$D508],a
	ld a,l
	ld [$D507],a
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x1246:
	inc [hl]
	inc [hl]
	ld a,$FF
	ld [$FF00+$B1],a
	ld a,$00
	ld [$FF00+$B2],a
	ld a,$FF
	ld [$FF00+$B5],a
	ld a,$00
	ld [$FF00+$B6],a
	ret

Logged_0x1259:
	ld a,[$C0C3]
	add a,b
	ld [$C0C3],a
	ld a,[$CA64]
	add a,b
	ld [$CA64],a
	ld a,[$CA63]
	adc a,$00
	ld [$CA63],a
	ret

Logged_0x1270:
	ld a,[$C0C3]
	sub b
	ld [$C0C3],a
	ld a,[$CA64]
	sub b
	ld [$CA64],a
	ld a,[$CA63]
	sbc a,$00
	ld [$CA63],a
	ret

Logged_0x1287:
	ld a,[$C0C2]
	add a,b
	ld [$C0C2],a

Logged_0x128E:
	ld a,[$CA62]
	add a,b
	ld [$CA62],a
	ld a,[$CA61]
	adc a,$00
	ld [$CA61],a
	ret

Logged_0x129E:
	ld a,[$C0C2]
	sub b
	ld [$C0C2],a

Logged_0x12A5:
	ld a,[$CA62]
	sub b
	ld [$CA62],a
	ld a,[$CA61]
	sbc a,$00
	ld [$CA61],a
	ret

Logged_0x12B5:
	ld a,[$CA97]
	and a
	ret nz
	ld a,b
	ld [$CA97],a
	xor a
	ld [$CA98],a
	ret

Logged_0x12C3:
	ld hl,$CCA0
	ld b,$42
	xor a
	call Logged_0x0420
	ret

Logged_0x12CD:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[$C083]
	ld [$D500],a
	ld a,[$C085]
	ld [$D501],a
	ld hl,$C000
	ld de,$D280
	ld b,$80
	call Logged_0x0466
	pop af
	ld [$FF00+$70],a
	xor a
	ld [$FF00+$4F],a
	ld a,[$FF00+$70]
	push af
	ld a,$04
	ld [$FF00+$70],a
	ld hl,$8000
	ld de,$D000
	ld bc,$1000
	call Logged_0x0434
	pop af
	ld [$FF00+$70],a
	ld a,[$FF00+$70]
	push af
	ld a,$05
	ld [$FF00+$70],a
	ld hl,$9000
	ld de,$D000
	ld bc,$1000
	call Logged_0x0434
	pop af
	ld [$FF00+$70],a
	ld a,$01
	ld [$FF00+$4F],a
	ld a,[$FF00+$70]
	push af
	ld a,$06
	ld [$FF00+$70],a
	ld hl,$8000
	ld de,$D000
	ld bc,$1000
	call Logged_0x0434
	pop af
	ld [$FF00+$70],a
	ld a,[$FF00+$70]
	push af
	ld a,$07
	ld [$FF00+$70],a
	ld hl,$9000
	ld de,$D000
	ld bc,$1000
	call Logged_0x0434
	pop af
	ld [$FF00+$70],a
	xor a
	ld [$FF00+$4F],a
	ret

Logged_0x1351:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[$D500]
	ld [$C083],a
	ld a,[$D501]
	ld [$C085],a
	ld hl,$D280
	ld de,$C000
	ld b,$80
	call Logged_0x0466
	pop af
	ld [$FF00+$70],a
	xor a
	ld [$FF00+$4F],a
	ld a,[$FF00+$70]
	push af
	ld a,$04
	ld [$FF00+$70],a
	ld hl,$D000
	ld de,$8000
	ld bc,$1000
	call Logged_0x0434
	pop af
	ld [$FF00+$70],a
	ld a,[$FF00+$70]
	push af
	ld a,$05
	ld [$FF00+$70],a
	ld hl,$D000
	ld de,$9000
	ld bc,$1000
	call Logged_0x0434
	pop af
	ld [$FF00+$70],a
	ld a,$01
	ld [$FF00+$4F],a
	ld a,[$FF00+$70]
	push af
	ld a,$06
	ld [$FF00+$70],a
	ld hl,$D000
	ld de,$8000
	ld bc,$1000
	call Logged_0x0434
	pop af
	ld [$FF00+$70],a
	ld a,[$FF00+$70]
	push af
	ld a,$07
	ld [$FF00+$70],a
	ld hl,$D000
	ld de,$9000
	ld bc,$1000
	call Logged_0x0434
	pop af
	ld [$FF00+$70],a
	xor a
	ld [$FF00+$4F],a
	ret

Logged_0x13D5:
	call Logged_0x08E6
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[$D50F]
	ld [$C1AC],a
	ld a,[$D510]
	ld [$C1AD],a
	pop af
	ld [$FF00+$70],a
	xor a
	ld [$C1AF],a
	ld [$C1AE],a
	ld a,$01
	ld [$CED8],a
	call Logged_0x1351
	ld a,[$C0D7]
	and $F0
	or $02
	ld [$C0D7],a
	ld a,$7C
	ld [$FF00+$85],a
	ld a,$69
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,$87
	ld [$FF00+$40],a

Logged_0x141A:
	ld hl,$C09B
	ld [hl],$02
	ld a,[$CED5]
	ld [$C09C],a
	ret

Logged_0x1426:
	ld hl,$CA3B
	set 7,[hl]

Logged_0x142B:
	ld a,$F0
	ld [$CEE3],a
	ld a,$01
	ld [$FF00+$85],a
	ld a,$1E
	ld [$FF00+$8D],a
	ld a,$46
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1440:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,$7C
	ld [$FF00+$85],a
	ld a,$7A
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x145A:
	xor a
	ld [$D514],a
	ld a,[hld]
	ld e,a
	ld a,[hld]
	ld d,a
	ld a,[hl]
	sub $01
	ld [hld],a
	ret nc
	ld a,[hl]
	add a,e
	ld c,a
	ld a,d
	adc a,$00
	ld b,a
	ld a,[bc]
	cp $FF
	jr z,Logged_0x147F
	dec l
	dec l
	ld [hli],a
	inc l
	ld a,[hl]
	add a,$02
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ret

Logged_0x147F:
	xor a
	ld [hli],a
	ld [hl],a
	ld a,$01
	ld [$D514],a
	ret

Logged_0x1488:
	ld a,[$CA74]
	dec a
	jr z,Logged_0x14AF
	dec a
	jr z,Logged_0x14AA
	dec a
	jr z,Logged_0x14A5
	dec a
	jr z,Logged_0x14A0
	dec a
	jr z,Logged_0x149B
	ret

Logged_0x149B:
	ld hl,$1947
	jr Logged_0x14B2

Logged_0x14A0:
	ld hl,$191F
	jr Logged_0x14B2

Logged_0x14A5:
	ld hl,$18CF
	jr Logged_0x14B2

Logged_0x14AA:
	ld hl,$18A7
	jr Logged_0x14B2

Logged_0x14AF:
	ld hl,$18F7

Logged_0x14B2:
	ld a,[$CA75]
	ld e,a
	ld d,$00
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x14CA
	ld a,[hl]
	cpl
	inc a
	ld b,a
	call Logged_0x129E
	ld hl,$CA75
	inc [hl]
	jr Logged_0x14DD

Logged_0x14CA:
	xor a
	ld [$CA76],a
	ld b,[hl]
	call Logged_0x1287
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $27
	jr c,Logged_0x14DD
	ld [hl],$27

Logged_0x14DD:
	ret

Logged_0x14DE:
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x14F5
	call Logged_0x114E
	ld a,[$CA78]
	sub c
	jr z,Logged_0x14F5
	jr c,Logged_0x14F5
	jp Logged_0x11AE

Logged_0x14F5:
	ret

Logged_0x14F6:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a

Logged_0x1501:
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x151D
	call Logged_0x114E
	ld a,[$CA78]
	sub c
	jr z,Logged_0x151D
	jr c,Logged_0x151A
	call Logged_0x11AE
	jr Logged_0x151D

Logged_0x151A:
	call Logged_0x11D6

Logged_0x151D:
	ret

Logged_0x151E:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x152A
	xor a
	ld [$CA86],a
	jr Logged_0x1554

Logged_0x152A:
	ld a,[$C189]
	bit 0,a
	jr z,Logged_0x1554

Logged_0x1531:
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x1554
	ld a,$04
	ld [$CA86],a
	jr Logged_0x1554

Logged_0x153F:
	ld a,[$CA69]
	and a
	jr z,Logged_0x154B
	xor a
	ld [$CA86],a
	jr Logged_0x1554

Logged_0x154B:
	ld a,[$C189]
	bit 1,a
	jr z,Logged_0x1554
	jr Logged_0x1531

Logged_0x1554:
	ld a,[$CA86]
	ld e,a
	ld d,$00
	ld hl,$196F
	add hl,de
	ld b,[hl]
	ld hl,$CA86
	ld a,[hl]
	cp $1B
	jr z,Unknown_0x1569
	inc [hl]
	ret

Unknown_0x1569:
	and $FC
	ld [hl],a
	ret

Unknown_0x156D:
	jp Logged_0x015E

Logged_0x1570:
	call Logged_0x1079
	ld a,$10
	ld [$CA8C],a
	jr Logged_0x157D

Logged_0x157A:
	call Logged_0x1079

Logged_0x157D:
	call Logged_0x161A
	ld hl,$4800
	call Logged_0x1AF6
	ld a,[$CA74]
	and a
	jr nz,Logged_0x159E
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x1070

Logged_0x159E:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x1070

Logged_0x15B0:
	ld a,[$CA7B]
	ld [$C1A1],a
	ld a,[$CA7C]
	ld [$C1A2],a
	ld a,[$CA7D]
	ld [$C1A3],a
	ld a,$80
	ld [$C1A5],a
	ld a,$00
	ld [$C1A6],a
	ld a,$00
	ld [$C1A4],a
	ld a,$7F
	ld [$C1A7],a
	ld a,$01
	ld [$C1A0],a
	ret

Logged_0x15DC:
	ld a,[$CA3D]
	bit 1,a
	jr nz,Logged_0x15FF
	ld a,[$CEE3]
	cp $F1
	jr z,Logged_0x15FF
	cp $F2
	jr z,Logged_0x15FF
	cp $F3
	jr z,Logged_0x15FF
	ld a,[$CA3D]
	and $01
	jr z,Logged_0x15FF
	ld a,[$CA39]
	dec a
	jr z,Logged_0x1610

Logged_0x15FF:
	ld a,[$C09C]
	ld [$CED5],a
	ld a,$04
	ld [$C09B],a
	ld a,$18
	ld [$C09C],a
	ret

Logged_0x1610:
	ld hl,$C09B
	ld [hl],$0D
	xor a
	ld [$C09C],a
	ret

Logged_0x161A:
	ld a,[$CAC3]
	and a
	jr nz,Logged_0x164D
	ld a,[$CA8E]
	and a
	jr nz,Logged_0x165D
	ld a,[$C5FF]
	push af
	ld a,$0F
	ld [$C5FF],a
	ld [$2100],a

Logged_0x1632:
	ld a,[$CA06]
	ld d,$00
	add a,a
	ld e,a
	rl d
	ld hl,$7E40
	add hl,de
	ld a,[hli]
	ld [$FF00+$B2],a
	ld a,[hl]
	ld [$FF00+$B1],a
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x164D:
	dec a
	ld d,$00
	add a,a
	ld e,a
	ld hl,$168A
	add hl,de
	ld a,[hli]
	ld [$FF00+$B2],a
	ld a,[hl]
	ld [$FF00+$B1],a
	ret

Logged_0x165D:
	ld a,[$CA8E]
	and $1F
	ld d,$00
	add a,a
	ld e,a
	rl d
	ld a,[$C5FF]
	push af
	ld a,$0F
	ld [$C5FF],a
	ld [$2100],a
	ld hl,$7E00
	add hl,de
	ld a,[hli]
	cp $FF
	jr z,Logged_0x1632
	ld [$FF00+$B2],a
	ld a,[hl]
	ld [$FF00+$B1],a
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

LoggedData_0x168A:
INCBIN "baserom.gbc", $168A, $1690 - $168A

Logged_0x1690:
	xor a
	ld [$C09B],a
	ld [$C09C],a
	ret

Unknown_0x1698:
	xor a
	ld hl,$A380
	ld b,$08
	call Logged_0x0420
	ld hl,$AB80
	ld b,$08
	call Logged_0x0420
	ld hl,$A000
	ld b,$08
	call Logged_0x0420
	ld hl,$A800
	ld b,$08
	call Logged_0x0420
	ld hl,$A400
	ld b,$08
	call Logged_0x0420
	ld hl,$AC00
	ld b,$08
	call Logged_0x0420
	ld a,$00
	ld [$FF00+$FD],a
	jp Logged_0x015E

Logged_0x16D0:
	ld hl,$C09B
	ld a,$07
	ld [hli],a
	ld [hl],$00
	ret

Logged_0x16D9:
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	sub $18
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	ld b,$0E
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1700:
	xor a
	ld [$C0DE],a
	ld a,[$CA71]
	cpl
	inc a
	sub $03
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$51
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DE]
	and a
	ret nz
	ld a,[$CA72]
	sub $03
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,c
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$51
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DE]
	and a
	ret

Logged_0x1762:
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1776
	ld a,[$CA86]
	cp $10
	jr c,Logged_0x1775
	ld a,$0C
	ld [$CA86],a

Logged_0x1775:
	ret

Logged_0x1776:
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x1782
	ld a,$04
	ld [$CA86],a

Logged_0x1782:
	ret

Logged_0x1783:
	ld a,$35
	ld [$FF00+$85],a
	ld a,$76
	ld [$FF00+$8D],a
	ld a,$48
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret

Logged_0x1795:
	ld a,$02
	ld b,$40
	ld d,$0F
	ld e,$0F
	call Logged_0x102C
	call Logged_0x0FBC
	ret

Logged_0x17A4:
	ld hl,$CA3E
	ld c,$03

Logged_0x17A9:
	ld b,$08
	ld a,[hli]

Logged_0x17AC:
	rrca
	jr nc,Logged_0x17BC
	dec b
	jr nz,Logged_0x17AC
	dec c
	jr nz,Logged_0x17A9
	ld a,[hl]
	rrca
	jr nc,Logged_0x17BC
	ld a,$01
	ret

Logged_0x17BC:
	xor a
	ret

Logged_0x17BE:
	ld a,[hli]
	add a,$10
	ld [$C096],a
	ld a,[hli]
	add a,$08
	ld [$C097],a
	ld a,[hli]
	ld [$C098],a
	ld a,[hl]
	ld [$C099],a
	ld a,[$C5FF]
	push af
	ld a,$2A
	ld [$C5FF],a
	ld [$2100],a
	ld hl,$6B5C
	call Logged_0x0DF4
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x17EC:
	ld a,[hli]
	add a,$10
	ld [$C096],a
	ld a,[hli]
	add a,$08
	ld [$C097],a
	ld a,[hli]
	ld [$C098],a
	ld a,[hl]
	ld [$C099],a
	ld a,[$D521]
	ld [$C0AC],a
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld a,[$D51E]
	ld h,a
	ld a,[$D51F]
	ld l,a
	call Logged_0x0DF4
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

UnknownData_0x1826:
INCBIN "baserom.gbc", $1826, $1827 - $1826

LoggedData_0x1827:
INCBIN "baserom.gbc", $1827, $1867 - $1827

UnknownData_0x1867:
INCBIN "baserom.gbc", $1867, $18A7 - $1867

LoggedData_0x18A7:
INCBIN "baserom.gbc", $18A7, $1987 - $18A7

UnknownData_0x1987:
INCBIN "baserom.gbc", $1987, $198B - $1987

LoggedData_0x198B:
INCBIN "baserom.gbc", $198B, $19F3 - $198B

Logged_0x19F3:
	ld hl,$C100
	ld a,$80
	ld [$FF00+$68],a
	ld b,$40
	ld c,$69

Logged_0x19FE:
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x19FE
	ret

Logged_0x1A04:
	ld hl,$C140
	ld a,$80
	ld [$FF00+$6A],a
	ld b,$40
	ld c,$6B

Logged_0x1A0F:
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x1A0F
	ret

Logged_0x1A15:
	ld de,$C000
	ld b,$40

Logged_0x1A1A:
	ld a,[hli]
	ld [de],a
	inc e
	dec b
	jr nz,Logged_0x1A1A
	ret

Logged_0x1A21:
	ld de,$C040
	ld b,$40

Logged_0x1A26:
	ld a,[hli]
	ld [de],a
	inc e
	dec b
	jr nz,Logged_0x1A26
	ret

Logged_0x1A2D:
	ld a,[hli]
	ld [de],a
	inc e
	dec b
	jr nz,Logged_0x1A2D
	ret

Logged_0x1A34:
	ld de,$C060
	ld b,$20

Logged_0x1A39:
	ld a,[hli]
	ld [de],a
	inc e
	dec b
	jr nz,Logged_0x1A39
	ret

Logged_0x1A40:
	ld a,[$FF00+$4D]
	bit 7,a
	ret nz
	ld a,$01
	ld [$FF00+$4D],a
	ld a,[$FF00+$FF]
	push af
	xor a
	ld [$FF00+$FF],a
	ld a,$30
	ld [$FF00+$00],a
	stop

Logged_0x1A55:
	ld a,[$FF00+$4D]
	bit 7,a
	jr z,Logged_0x1A55
	xor a
	ld [$FF00+$00],a
	ld [$FF00+$0F],a
	pop af
	ld [$FF00+$FF],a
	ret

Logged_0x1A64:
	ld a,[$FF00+$FE]
	and a
	ret z
	ld a,$01
	ld [$FF00+$4F],a
	xor a
	ld hl,$8000
	ld bc,$2000
	call Logged_0x0425
	xor a
	ld [$FF00+$4F],a
	ld hl,$8000
	ld bc,$2000
	jp Logged_0x0425

Logged_0x1A82:
	ld e,$01

Logged_0x1A84:
	ld a,e
	ld [$FF00+$70],a
	xor a
	ld hl,$D000
	ld bc,$1000
	call Logged_0x0425
	inc e
	bit 3,e
	jr z,Logged_0x1A84
	xor a
	ld [$FF00+$70],a
	ret

Logged_0x1A9A:
	xor a
	ld e,a
	ld hl,$C100
	ld b,$40
	ld c,$69

Logged_0x1AA3:
	ld a,e
	ld [$FF00+$68],a
	ld a,[$FF00+c]
	ld [hli],a
	inc e
	dec b
	jr nz,Logged_0x1AA3
	ret

Logged_0x1AAD:
	xor a
	ld e,a
	ld hl,$C140
	ld b,$40
	ld c,$6B

Logged_0x1AB6:
	ld a,e
	ld [$FF00+$6A],a
	ld a,[$FF00+c]
	ld [hli],a
	inc e
	dec b
	jr nz,Logged_0x1AB6
	ret

Logged_0x1AC0:
	ld hl,$1827
	ld a,$80
	ld [$FF00+$68],a
	ld b,$40
	ld c,$69

Logged_0x1ACB:
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x1ACB
	ret

Logged_0x1AD1:
	ld hl,$1827
	ld a,$80
	ld [$FF00+$6A],a
	ld b,$40
	ld c,$6B

Logged_0x1ADC:
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x1ADC
	ret

UnknownData_0x1AE2:
INCBIN "baserom.gbc", $1AE2, $1AF6 - $1AE2

Logged_0x1AF6:
	ld a,h
	ld [$CA79],a
	ld a,l
	ld [$CA7A],a
	ld a,[$C5FF]
	push af
	ld a,$03
	ld [$C5FF],a
	ld [$2100],a
	push hl
	ld de,$C040
	ld b,$10
	ld a,$03
	ld [$FF00+$85],a
	ld a,$2D
	ld [$FF00+$8D],a
	ld a,$1A
	ld [$FF00+$8E],a
	call $FF80
	pop hl
	ld a,$80
	ld [$FF00+$6A],a
	ld b,$02
	ld c,$6B

Logged_0x1B28:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x1B28

Logged_0x1B2E:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x1B2E
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x1B28
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x1B4F:
	ld a,[$FF00+$70]
	push af
	ld a,$02
	ld [$FF00+$70],a
	ld hl,$CED4
	ld a,[hl]
	and $7F
	dec a
	ld c,a
	ld b,$00
	ld hl,$D0F4
	add hl,bc
	ld a,[hl]
	sub $04
	add a,a
	add a,a
	add a,a
	ld e,a
	ld d,b
	ld hl,$6D65
	add hl,de
	ld a,[$C5FF]
	push af
	ld a,$26
	ld [$C5FF],a
	ld [$2100],a
	push hl
	ld de,$C060
	ld a,c
	add a,a
	add a,a
	add a,a
	ld c,a
	add a,e
	ld e,a
	ld b,$08
	ld a,$26
	ld [$FF00+$85],a
	ld a,$2D
	ld [$FF00+$8D],a
	ld a,$1A
	ld [$FF00+$8E],a
	call $FF80
	pop hl
	ld a,$A0
	or c
	ld [$FF00+$6A],a
	ld c,$6B

Logged_0x1BA0:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x1BA0

Logged_0x1BA6:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x1BA6
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	pop af
	ld [$C5FF],a
	ld [$2100],a
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x1BC7:
	ld a,[$FF00+$70]
	push af
	ld a,$02
	ld [$FF00+$70],a
	ld hl,$CED4
	ld a,[hl]
	and $7F
	dec a
	ld c,a
	ld b,$00
	ld hl,$D0F4
	add hl,bc
	ld a,[hl]
	sub $04
	add a,a
	add a,a
	add a,a
	ld e,a
	ld d,b
	ld hl,$6D65
	add hl,de
	ld a,[$C5FF]
	push af
	ld a,$26
	ld [$C5FF],a
	ld [$2100],a
	ld de,$C078
	ld b,$08
	ld a,$26
	ld [$FF00+$85],a
	ld a,$2D
	ld [$FF00+$8D],a
	ld a,$1A
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$C5FF],a
	ld [$2100],a
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x1C13:
	push bc
	push hl
	sla b
	sla b
	sla b
	call Logged_0x1A2D
	pop hl
	pop bc
	ld a,c
	add a,a
	add a,a
	add a,a
	or $80
	ld [$FF00+$6A],a
	ld c,$6B

Logged_0x1C2A:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x1C2A

Logged_0x1C30:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x1C30
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x1C2A
	ret

Logged_0x1C4A:
	ld hl,$C000
	ld a,$80
	ld [$FF00+$68],a
	ld b,$40
	ld c,$69

Logged_0x1C55:
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x1C55
	ret
	ld hl,$C040
	ld a,$80
	ld [$FF00+$6A],a
	ld b,$40
	ld c,$6B

Logged_0x1C66:
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x1C66
	ret

UnknownData_0x1C6C:
INCBIN "baserom.gbc", $1C6C, $2800 - $1C6C

Logged_0x2800:
	ld a,[$C0CA]
	add a,a
	ld e,a
	ld d,$00
	ld hl,$4000
	add hl,de
	ld a,[$C5FF]
	push af
	ld a,$32
	ld [$C5FF],a
	ld [$2100],a
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,h
	cp $FF
	jr z,Unknown_0x2859
	ld a,[$C0CA]
	cp $3F
	jr nc,Logged_0x2836
	ld de,$CD00
	ld b,$00
	call Logged_0x0466
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x2836:
	ld a,[$C5FF]
	push af
	ld a,$50
	ld [$C5FF],a
	ld [$2100],a
	ld de,$CD00
	ld b,$00
	call Logged_0x0466
	pop af
	ld [$C5FF],a
	ld [$2100],a
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Unknown_0x2859:
	jp Logged_0x015E

Logged_0x285C:
	ld a,$70
	ld [$CA5E],a
	ld a,$58
	ld [$CA5F],a
	sub $58
	cpl
	inc a
	add a,$58
	ld [$CA60],a
	ld a,[$C5FF]
	push af
	ld a,$30
	ld [$C5FF],a
	ld [$2100],a
	ld a,[$CA06]
	add a,a
	ld e,a
	ld d,$00
	rl d
	ld hl,$4319
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,h
	cp $FF
	jr nz,Logged_0x2893
	jp Logged_0x015E

Logged_0x2893:
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ld a,[$CA06]
	cp $64
	jr nc,Logged_0x28AF
	ld a,[$C5FF]
	push af
	ld a,$30
	ld [$C5FF],a
	ld [$2100],a
	jr Logged_0x28BB

Logged_0x28AF:
	ld a,[$C5FF]
	push af
	ld a,$31
	ld [$C5FF],a
	ld [$2100],a

Logged_0x28BB:
	ld a,[$C0A0]
	add a,a
	ld e,a
	ld d,$00
	add hl,de
	ld a,[hli]
	ld e,a
	ld h,[hl]
	ld l,e
	ld a,h
	cp $FF
	jr nz,Logged_0x28CF
	jp Logged_0x015E

Logged_0x28CF:
	ld a,[hli]
	ld [$C0A1],a
	ld a,[hl]
	swap a
	and $0F
	ld [$C0B7],a
	ld a,[hli]
	and $0F
	ld [$C0B6],a
	ld a,[hl]
	swap a
	and $0F
	ld [$C0B8],a
	ld a,[hli]
	and $0F
	ld [$C0B9],a
	ld a,[hli]
	ld [$C0BA],a
	ld a,[hli]
	ld [$C0C8],a
	push hl
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$19
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	pop hl
	ld a,[hli]
	ld [$C1AB],a
	push hl
	ld a,$30
	ld [$FF00+$85],a
	ld a,$78
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop hl
	ld a,[hli]
	ld [$C1B0],a
	push hl
	ld a,$30
	ld [$FF00+$85],a
	ld a,$95
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop hl
	ld a,[hl]
	ld [$C0C9],a
	ld a,$30
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ld a,[$C0B6]
	add a,a
	add a,a
	add a,a
	add a,a
	add a,$A0
	jr nz,Logged_0x2963
	ld a,$FF

Logged_0x2963:
	ld [$C0C4],a
	ld a,[$C0B7]
	add a,a
	add a,a
	add a,a
	add a,a
	add a,$A0
	ld [$C0C5],a
	ld a,[$C0B9]
	add a,a
	add a,a
	add a,a
	add a,$B0
	jr nz,Logged_0x297E
	ld a,$FF

Logged_0x297E:
	ld [$C0C7],a
	ld a,[$C0B8]
	add a,a
	add a,a
	add a,a
	add a,$B0
	ld [$C0C6],a
	ret

Logged_0x298D:
	ld a,[$C0CA]
	add a,a
	ld e,a
	ld d,$00
	ld hl,$490D
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[$C0CF]
	ld [$C0AC],a
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld de,$C600
	ld bc,$0200
	call Logged_0x0434
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x29BF:
	ld a,[$C0CB]
	add a,a
	ld e,a
	ld d,$00
	ld hl,$49D1
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[$C0D0]
	ld [$C0AC],a
	ld bc,$D300
	ld a,[$C0AC]
	ld [$FF00+$85],a
	ld a,$09
	ld [$FF00+$8D],a
	ld a,$09
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29E7:
	ld a,[$C0CC]
	add a,a
	ld e,a
	ld d,$00
	ld hl,$4A95
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[$C0D1]
	ld [$C0AC],a
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld de,$9000
	ld bc,$0800
	call Logged_0x0434
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x2A19:
	ld a,$01
	ld [$FF00+$4F],a
	ld a,[$C0CD]
	add a,a
	ld e,a
	ld d,$00
	ld hl,$4AF7
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[$C0D2]
	ld [$C0AC],a
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld de,$9000
	ld bc,$0800
	call Logged_0x0434
	pop af
	ld [$C5FF],a
	ld [$2100],a
	xor a
	ld [$FF00+$4F],a
	ret

Logged_0x2A52:
	ld a,[$C0CE]
	add a,a
	ld e,a
	ld d,$00
	ld hl,$4B1B
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[$C0D3]
	ld [$C0AC],a
	ld a,[$C0AC]
	ld [$FF00+$85],a
	ld a,$15
	ld [$FF00+$8D],a
	ld a,$1A
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A77:
	ld a,[$FF00+$44]
	cp $88
	jp nc,Logged_0x2B24
	ld a,[$C1B1]
	and a
	jp z,Logged_0x2B24
	ld b,a
	ld a,[$C1B5]
	inc a
	ld [$C1B5],a
	cp b
	jp c,Logged_0x2B24
	xor a
	ld [$C1B5],a
	ld a,[$C1B2]
	ld h,a
	ld a,[$C1B3]
	ld l,a
	ld a,[$C1B4]
	inc a
	cp $08
	jr c,Logged_0x2AA6
	xor a

Logged_0x2AA6:
	ld [$C1B4],a
	ld e,a
	ld d,$00
	add hl,de
	ld a,[$C5FF]
	push af
	ld a,$30
	ld [$C5FF],a
	ld [$2100],a
	ld d,$00
	ld a,[hl]
	add a,a
	ld e,a
	rl d
	ld hl,$4B1B
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ld a,[$C5FF]
	push af
	ld a,$33
	ld [$C5FF],a
	ld [$2100],a
	ld a,$80
	ld [$FF00+$68],a
	ld b,$05
	ld c,$69

Logged_0x2AE2:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x2AE2

Logged_0x2AE8:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x2AE8
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x2AE2

Logged_0x2B09:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x2B09

Logged_0x2B0F:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x2B0F
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hl]
	ld [$FF00+c],a
	pop af
	ld [$C5FF],a
	ld [$2100],a

Logged_0x2B24:
	ret

UnknownData_0x2B25:
INCBIN "baserom.gbc", $2B25, $2C00 - $2B25

Logged_0x2C00:
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	call Logged_0x0434
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x2C18:
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	call Logged_0x0909
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret
	ld a,h
	ld [$FF00+$51],a
	ld a,l
	ld [$FF00+$52],a
	ld a,[$DC11]
	ld [$FF00+$53],a
	ld a,[$DC12]
	ld [$FF00+$54],a
	ld a,[$DC13]
	ld [$FF00+$55],a
	ret
	ld de,$FF68
	ld c,$04
	jr Logged_0x2C52

UnknownData_0x2C4D:
INCBIN "baserom.gbc", $2C4D, $2C52 - $2C4D

Logged_0x2C52:
	ld a,$80
	ld [de],a
	inc e

Logged_0x2C56:
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	ld a,[hli]
	ld [de],a
	dec c
	jr nz,Logged_0x2C56
	ret

Logged_0x2C7A:
	ld c,$00
	ld a,[hl]
	sub $01
	ld [hli],a
	ret nc
	ld a,[hli]
	add a,e
	ld c,a
	ld a,d
	adc a,$00
	ld b,a
	ld a,[bc]
	cp $FF
	jr z,Logged_0x2C98
	inc bc
	ld [hld],a
	ld a,[hl]
	add a,$02
	ld [hld],a
	ld a,[bc]
	ld [hl],a
	ld c,$00
	ret

Logged_0x2C98:
	ld a,[hl]
	ld [$DC09],a
	ld a,[de]
	ld [hld],a
	inc de
	ld a,$02
	ld [hld],a
	ld a,[de]
	ld [hl],a
	ld c,$01
	ret

Logged_0x2CA7:
	ld a,[hli]
	ld [$C096],a
	ld a,[hli]
	ld [$C097],a
	ld a,[hli]
	ld [$C098],a
	ld a,[hl]
	ld [$C099],a
	ld a,[$DC17]
	ld h,a
	ld a,[$DC18]
	ld l,a
	call Logged_0x0DF4
	ret

Logged_0x2CC3:
	ld hl,$2D38
	ld a,[$DC84]
	ld b,$00
	ld c,a
	add hl,bc
	ld a,[hl]
	ld [$C0AC],a
	ld a,[$DC42]
	and a
	jr z,Logged_0x2CDB
	ld a,c
	add a,$0C
	ld c,a

Logged_0x2CDB:
	ld hl,$2D44
	ld b,$00
	sla c
	add hl,bc
	ld a,[hli]
	ld [$DC18],a
	ld a,[hl]
	ld [$DC17],a
	ld hl,$2D74
	add hl,bc
	ld a,[hli]
	ld d,[hl]
	ld e,a
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld hl,$DC85
	call Logged_0x2C7A
	ld a,c
	ld [$DC2A],a
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ld a,[$DC2A]
	and a
	call nz,Logged_0x1C8F37
	ld a,[$DC87]
	ld [$DC8A],a
	ld a,[$C5FF]
	push af
	ld a,[$C0AC]
	ld [$C5FF],a
	ld [$2100],a
	ld hl,$DC88
	call Logged_0x2CA7
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

LoggedData_0x2D38:
INCBIN "baserom.gbc", $2D38, $2D41 - $2D38

UnknownData_0x2D41:
INCBIN "baserom.gbc", $2D41, $2D42 - $2D41

LoggedData_0x2D42:
INCBIN "baserom.gbc", $2D42, $2D56 - $2D42

UnknownData_0x2D56:
INCBIN "baserom.gbc", $2D56, $2D58 - $2D56

LoggedData_0x2D58:
INCBIN "baserom.gbc", $2D58, $2D5E - $2D58

UnknownData_0x2D5E:
INCBIN "baserom.gbc", $2D5E, $2D6A - $2D5E

LoggedData_0x2D6A:
INCBIN "baserom.gbc", $2D6A, $2D6C - $2D6A

UnknownData_0x2D6C:
INCBIN "baserom.gbc", $2D6C, $2D74 - $2D6C

LoggedData_0x2D74:
INCBIN "baserom.gbc", $2D74, $2D86 - $2D74

UnknownData_0x2D86:
INCBIN "baserom.gbc", $2D86, $2D88 - $2D86

LoggedData_0x2D88:
INCBIN "baserom.gbc", $2D88, $2D8E - $2D88

UnknownData_0x2D8E:
INCBIN "baserom.gbc", $2D8E, $2D9A - $2D8E

LoggedData_0x2D9A:
INCBIN "baserom.gbc", $2D9A, $2D9C - $2D9A

UnknownData_0x2D9C:
INCBIN "baserom.gbc", $2D9C, $2DA4 - $2D9C

LoggedData_0x2DA4:
INCBIN "baserom.gbc", $2DA4, $2DAA - $2DA4

UnknownData_0x2DAA:
INCBIN "baserom.gbc", $2DAA, $2DB0 - $2DAA

LoggedData_0x2DB0:
INCBIN "baserom.gbc", $2DB0, $2DB5 - $2DB0

UnknownData_0x2DB5:
INCBIN "baserom.gbc", $2DB5, $3000 - $2DB5

Logged_0x3000:
	ld a,[$C5FF]
	push af
	ld a,[hl]
	swap a
	and $07
	or $60
	ld [$C5FF],a
	ld [$2100],a
	ld l,e
	ld a,[hli]
	ld [$C096],a
	ld a,[hli]
	ld [$C097],a
	ld a,[hli]
	ld [$C098],a
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[$C098]
	ld d,$00
	add a,a
	ld e,a
	add hl,de
	ld a,[hli]
	ld e,a
	ld d,[hl]
	ld hl,$C097
	ld a,[hld]
	ld c,a
	ld a,[hld]
	ld b,a
	ld l,[hl]
	ld h,$CC

Logged_0x3036:
	ld a,l
	cp $A0
	jr nc,Logged_0x3054
	ld a,[de]
	cp $80
	jr z,Logged_0x3054
	ld a,[de]
	add a,b
	ld [hli],a
	inc de
	ld a,[de]
	add a,c
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	ld a,l
	ld [$C095],a
	inc de
	jr Logged_0x3036

Logged_0x3054:
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x305C:
	ld a,[$D118]
	ld b,a
	ld hl,$D105
	ld a,[hl]
	sub b
	ld [hli],a
	ret nc
	dec [hl]
	ret

Logged_0x3069:
	ld a,[$D118]
	ld b,a
	ld hl,$D105
	ld a,[hl]
	add a,b
	ld [hli],a
	ret nc
	inc [hl]
	ret

Logged_0x3076:
	ld a,[$D118]
	ld b,a
	ld hl,$D103
	ld a,[hl]
	sub b
	ld [hli],a
	ret nc
	dec [hl]
	ret

Logged_0x3083:
	ld a,[$D118]
	ld b,a
	ld hl,$D103
	ld a,[hl]
	add a,b
	ld [hli],a
	ret nc
	inc [hl]
	ret

Logged_0x3090:
	ld hl,$D105
	ld a,[hl]
	sub $02
	ld [hli],a
	ret nc
	dec [hl]
	ret

Logged_0x309A:
	ld hl,$D105
	ld a,[hl]
	add a,$02
	ld [hli],a
	ret nc
	inc [hl]
	ret

Logged_0x30A4:
	ld hl,$D103
	ld a,[hl]
	add a,$02
	ld [hli],a
	ret nc
	inc [hl]
	ret

Logged_0x30AE:
	ld hl,$D103
	ld a,[hl]
	sub $02
	ld [hli],a
	ret nc
	dec [hl]
	ret

Logged_0x30B8:
	ld a,[$C08F]
	rra
	ret c

Logged_0x30BD:
	ld hl,$D105
	inc [hl]
	ret nz
	inc l
	inc [hl]
	ret

Logged_0x30C5:
	ld a,[$C08F]
	rra
	ret nc

Logged_0x30CA:
	ld hl,$D105
	ld a,[hl]
	sub $01
	ld [hli],a
	ret nc
	dec [hl]
	ret

Logged_0x30D4:
	ld a,[$C08F]
	rra
	ret c

Logged_0x30D9:
	ld hl,$D103
	inc [hl]
	ret nz
	inc l
	inc [hl]
	ret

Logged_0x30E1:
	ld a,[$C08F]
	rra
	ret nc

Logged_0x30E6:
	ld hl,$D103
	ld a,[hl]
	sub $01
	ld [hli],a
	ret nc
	dec [hl]
	ret

Logged_0x30F0:
	ld hl,$D112
	ld a,e
	ld [hli],a
	ld a,d
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ret

Logged_0x30FB:
	ld l,$1A
	ld a,[hl]
	and $0F
	dec a
	ret z
	dec [hl]
	ret

Logged_0x3104:
	ld hl,$D114
	ld a,[hld]
	sub $01
	ret nc
	ld a,[$C5FF]
	push af
	ld a,$1A
	ld [$C5FF],a
	ld [$2100],a
	dec l
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	inc l
	ld a,[hl]
	add a,e
	ld c,a
	ld a,d
	adc a,$00
	ld b,a
	ld a,[bc]
	cp $FF
	jr nz,Logged_0x312A
	ld a,[de]

Logged_0x312A:
	ld [$D10F],a
	jr Logged_0x316B

Logged_0x312F:
	ld hl,$D114
	ld a,[hl]
	sub $01
	ld [hld],a
	ret nc
	ld a,[$C5FF]
	push af
	ld a,$1A
	ld [$C5FF],a
	ld [$2100],a
	dec l
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	inc l
	ld a,[hl]
	add a,e
	ld c,a
	ld a,d
	adc a,$00
	ld b,a
	ld a,[bc]
	cp $FF
	jr z,Logged_0x3161
	ld [$D10F],a
	ld a,[hl]
	add a,$02
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	jr Logged_0x316B

Logged_0x3161:
	ld a,$02
	ld [hld],a
	ld a,[de]
	ld [$D10F],a
	inc de
	ld a,[de]
	ld [hl],a

Logged_0x316B:
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x3173:
	farjump Logged_0x62E57

Logged_0x3182:
	farjump Logged_0x62E6E

Logged_0x3191:
	farjump Logged_0x62E8F

Logged_0x31A0:
	farjump Logged_0x62EA5

Logged_0x31AF:
	farjump Logged_0x62F76

Logged_0x31BE:
	farjump Logged_0x62F8C

Logged_0x31CD:
	farjump Logged_0x62EAA

Logged_0x31DC:
	farjump Logged_0x62EC0

Logged_0x31EB:
	farjump Logged_0x62F91

Logged_0x31FA:
	farjump Logged_0x62FA7

Logged_0x3209:
	farjump Logged_0x62E74

Logged_0x3218:
	farjump Logged_0x62E8A

Logged_0x3227:
	farjump Logged_0x62F5B

Logged_0x3236:
	farjump Logged_0x62F71

Logged_0x3245:
	farjump Logged_0x62C9F

Logged_0x3254:
	farjump Logged_0x62D7D

Logged_0x3263:
	farjump Logged_0x6303F

Logged_0x3272:
	farjump Logged_0x63050

Logged_0x3281:
	farjump Logged_0x6305F

Logged_0x3290:
	farjump Logged_0x62A5B

Logged_0x329F:
	farjump Logged_0x629D0

Logged_0x32AE:
	farjump Logged_0x62AE5

Logged_0x32BD:
	farjump Logged_0x62BCE

Logged_0x32CC:
	farjump Logged_0x62CA8

Logged_0x32DB:
	farjump Logged_0x62D86

Logged_0x32EA:
	farjump Logged_0x628EA

Logged_0x32F9:
	farjump Logged_0x629A6

Logged_0x3308:
	farjump Logged_0x62908

Logged_0x3317:
	farjump Logged_0x62898

Logged_0x3326:
	farjump Logged_0x62840

Logged_0x3335:
	farjump Logged_0x61F54

Logged_0x3344:
	farjump Logged_0x620A6

Logged_0x3353:
	farjump Logged_0x621FB

Logged_0x3362:
	farjump Logged_0x622BD

Logged_0x3371:
	farjump Logged_0x62926

Logged_0x3380:
	farjump Logged_0x62382

Logged_0x338F:
	farjump Logged_0x6247B

Logged_0x339E:
	farjump Logged_0x62574

Logged_0x33AD:
	farjump Logged_0x62605

Logged_0x33BC:
	farjump Logged_0x626DA

Logged_0x33CB:
	farjump Logged_0x62768

Logged_0x33DA:
	farjump Logged_0x62BB9

Logged_0x33E9:
	farjump Logged_0x62AD0

Logged_0x33F8:
	farjump Logged_0x62892

Logged_0x3407:
	farjump Logged_0x6283A

Logged_0x3416:
	farcall Logged_0x642D9
	ret

Logged_0x342D:
	farcall Logged_0x6428A
	ret

Logged_0x3444:
	farcall Logged_0x632AC
	ret

Logged_0x345B:
	farcall Logged_0x63339
	ret

Logged_0x3472:
	farcall Logged_0x631A1
	ret

Logged_0x3489:
	farcall Logged_0x63268
	ret

Logged_0x34A0:
	farcall Logged_0x6328A
	ret

Logged_0x34B7:
	farcall Logged_0x631E8
	ret

Logged_0x34CE:
	farcall Logged_0x63247
	ret

Unknown_0x34E5:
	farcall Logged_0x6189D
	ret

Logged_0x34FC:
	farcall Logged_0x63209
	ret

Logged_0x3513:
	farcall Logged_0x19BC3
	ld a,b
	ret

Logged_0x352B:
	farcall Logged_0x19B7B
	ld a,b
	ret

Logged_0x3543:
	farcall Logged_0x19B51
	ld a,b
	ret

Logged_0x355B:
	farcall Logged_0x19B61
	ld a,b
	ret

Logged_0x3573:
	farcall Logged_0x19B69
	ld a,b
	ret

Logged_0x358B:
	farcall Logged_0x19B9B
	ld a,b
	ret

Logged_0x35A3:
	farcall Logged_0x19B8B
	ld a,b
	ret

Logged_0x35BB:
	ld a,c
	add a,a
	add a,a
	add a,a
	or $80
	ld [$FF00+$6A],a
	ld c,$6B

Logged_0x35C5:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x35C5

Logged_0x35CB:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x35CB
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x35C5
	ret

Logged_0x35E5:
	ld a,c
	add a,a
	add a,a
	add a,a
	or $80
	ld [$FF00+$68],a
	ld c,$69

Logged_0x35EF:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x35EF

Logged_0x35F5:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x35F5
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x35EF
	ret

Logged_0x360F:
	ld a,c
	add a,a
	add a,a
	add a,a
	or $80
	ld [$FF00+$6A],a
	ld c,$6B

Logged_0x3619:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x3619

Logged_0x361F:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x361F
	xor a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x3619
	ret

Logged_0x3632:
	ld a,c
	add a,a
	add a,a
	add a,a
	or $80
	ld [$FF00+$68],a
	ld c,$69

Logged_0x363C:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x363C

Logged_0x3642:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x3642
	xor a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x363C
	ret

Logged_0x3655:
	ld a,[$D100]
	and $20
	ret nz
	ld a,[$D109]
	ld b,a
	ld a,[$D10D]
	add a,$2D
	add a,b
	ld b,a
	ld a,[$CA87]
	add a,$2A
	cp b
	ret c
	ld a,$81
	ld [$D11C],a
	ret

UnknownData_0x3673:
INCBIN "baserom.gbc", $3673, $3A00 - $3673

Logged_0x3A00:
	ld a,[$C083]
	ld c,a
	ld a,[hli]
	sub c
	ld c,$10
	add a,c
	ld [$C096],a
	ld a,[$C085]
	ld c,a
	ld a,[hli]
	sub c
	ld c,$08
	add a,c
	ld [$C097],a
	ld a,[hli]
	ld [$C098],a
	ld a,[hl]
	ld [$C099],a
	ld h,d
	ld l,e

Logged_0x3A22:
	ld a,[$C5FF]
	push af
	ld a,b
	ld [$C5FF],a
	ld [$2100],a
	call Logged_0x0DF4
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x3A38:
	ld a,[hli]
	ld c,$10
	add a,c
	ld [$C096],a
	ld a,[hli]
	ld c,$08
	add a,c
	ld [$C097],a
	ld a,[hli]
	ld [$C098],a
	ld a,[hl]
	ld [$C099],a
	ld h,d
	ld l,e
	ld a,[$C5FF]
	push af
	ld a,b
	ld [$C5FF],a
	ld [$2100],a
	call Logged_0x0DF4
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x3A66:
	xor a
	ld [$D024],a
	ld a,[$C5FF]
	push af
	ld a,b
	ld [$C5FF],a
	ld [$2100],a
	ld a,[hl]
	sub $01
	ld [hli],a
	jr nc,Logged_0x3A92
	ld a,[hl]
	add a,e
	ld c,a
	ld a,d
	adc a,$00
	ld b,a
	ld a,[bc]
	cp $FF
	jr z,Logged_0x3AA2
	ld d,a
	ld a,[hl]

Logged_0x3A89:
	add a,$02
	ld [hld],a
	inc bc
	ld a,[bc]
	dec a
	ld [hld],a
	dec l
	ld [hl],d

Logged_0x3A92:
	ld a,$F8
	and l
	ld l,a
	ld b,h
	add a,$06
	ld c,a
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x3AA2:
	ld [$D024],a
	ld b,d
	ld c,e
	ld a,[de]
	ld d,a
	xor a
	jr Logged_0x3A89

Logged_0x3AAC:
	ld hl,$D000
	ld e,a
	srl e
	srl e
	srl e
	ld d,$00
	add hl,de
	ld e,$01
	bit 2,a
	jr z,Logged_0x3AC1
	swap e

Logged_0x3AC1:
	and $03
	ld d,a
	ld a,e
	jr z,Logged_0x3AD0
	rla
	dec d
	jr z,Logged_0x3AD0
	rla
	dec d
	jr z,Logged_0x3AD0
	rla

Logged_0x3AD0:
	ld d,a
	and [hl]
	ret z
	ld a,$01
	scf
	ret

Logged_0x3AD7:
	ld a,[hli]
	and $F8
	rlca
	rlca
	ld c,a
	and $0F
	ld b,a
	ld a,c
	and $F0
	ld c,a
	ld a,[hl]
	and $F8
	rlca
	swap a
	add a,c
	ld l,a
	ld [$D082],a
	ld a,b
	add a,$D5
	ld h,a
	ld [$D083],a
	ret

Logged_0x3AF7:
	ld a,$24
	ld hl,$CA46
	add a,[hl]
	ld [$D079],a
	xor a
	ld [$D0B0],a
	ld hl,$4000
	ld c,$00
	ld a,b
	swap a
	ld b,a
	add hl,bc
	ld a,d
	add a,a
	ld d,a
	ld e,$00
	add hl,de
	ld a,h
	ld [$D0B5],a
	ld a,l
	ld [$D0B6],a
	ld a,$15
	ld [$D0B7],a
	xor a
	ld [$D0B8],a
	ld a,$1F
	ld [$D0B9],a
	ret

Logged_0x3B2B:
	ld a,[$C5FF]
	push af
	ld a,b
	ld [$C5FF],a
	ld [$2100],a
	ld b,c
	call Logged_0x0466
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x3B42:
	ld a,[$C5FF]
	push af
	ld a,b
	ld [$C5FF],a
	ld [$2100],a
	ld b,c
	ld c,$00
	call Logged_0x0434
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x3B5B:
	ld a,[$C5FF]
	push af
	ld a,b
	ld [$C5FF],a
	ld [$2100],a
	ld bc,$0800
	ld de,$9000
	call Logged_0x0434
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x3B77:
	ld a,[$C5FF]
	push af
	ld a,b
	ld [$C5FF],a
	ld [$2100],a
	ld bc,$0240
	ld de,$9800
	call Logged_0x0434
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x3B93:
	ld [hld],a
	xor a
	ld [hld],a
	ld [hl],a
	ret

Logged_0x3B98:
	ld a,[$D011]
	and a
	jr nz,Logged_0x3BAB
	ld a,$00
	ld [$FF00+$B3],a
	ld [$FF00+$B1],a
	ld a,$21
	ld [$FF00+$B4],a
	ld [$FF00+$B2],a
	ret

Logged_0x3BAB:
	ld a,$00
	ld [$FF00+$B3],a
	ld [$FF00+$B1],a
	ld a,$22
	ld [$FF00+$B4],a
	ld [$FF00+$B2],a
	ret

Logged_0x3BB8:
	ld a,[$C5FF]
	push af
	ld a,b
	ld [$C5FF],a
	ld [$2100],a
	call Logged_0x1A15
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret

Logged_0x3BCE:
	ld a,[$C5FF]
	push af
	ld a,b
	ld [$C5FF],a
	ld [$2100],a
	call Logged_0x1A21
	pop af
	ld [$C5FF],a
	ld [$2100],a
	ret
	ld c,[hl]
	xor a
	ld [hli],a
	ld a,[hli]
	ld [$FF00+c],a
	inc c
	ld a,[hli]
	ld b,a
	ld a,[hli]
	ld l,[hl]
	ld h,a

Logged_0x3BEF:
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	ld a,[hli]
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x3BEF
	ret
	ld a,$01
	ld [$FF00+$4F],a
	ld hl,$D0B5
	ld a,[hli]
	ld c,$51
	ld [$FF00+c],a
	ld a,[hli]
	inc c
	ld [$FF00+c],a
	ld a,[hli]
	inc c
	ld [$FF00+c],a
	ld a,[hli]
	inc c
	ld [$FF00+c],a
	ld a,[hli]
	inc c
	ld [$FF00+c],a
	xor a
	ld [$D079],a
	ret

Logged_0x3C1F:
	call Logged_0x3C35
	sub e
	jr Logged_0x3C29

Logged_0x3C25:
	call Logged_0x3C35
	add a,e

Logged_0x3C29:
	ld [bc],a
	ld a,[hl]
	cp $80
	ret nz
	ld a,$07
	or c
	ld c,a
	xor a
	ld [bc],a
	ret

Logged_0x3C35:
	ld c,l
	ld b,h
	ld a,$07
	or l
	ld l,a
	ld a,[hl]
	inc [hl]
	add a,a
	ld l,a
	ld a,$00
	adc a,$00
	ld h,a
	add hl,de
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	ld a,[bc]
	add a,d
	ld [bc],a
	inc c
	ld a,[bc]
	ret

Logged_0x3C4F:
	add a,a
	ld e,a
	ld a,$00
	adc a,$00
	ld d,a
	add hl,de
	ret

Logged_0x3C58:
	call Logged_0x3C4F
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ret

Logged_0x3C5F:
	call Logged_0x3C4F
	ld a,[hli]
	ld d,[hl]
	ld e,a
	ret

Logged_0x3C66:
	call Logged_0x3C4F
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,c
	call Logged_0x3C4F
	ret

Logged_0x3C71:
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[hl]
	ret

Logged_0x3C76:
	xor a
	ld hl,$D0C0
	ld bc,$0010
	call Logged_0x0425
	ret

UnknownData_0x3C81:
INCBIN "baserom.gbc", $3C81, $3F00 - $3C81

Logged_0x3F00:
	call Logged_0x3F4E
	jp Logged_0x30000

Logged_0x3F06:
	call Logged_0x3F75
	jp Logged_0x3007A

Logged_0x3F0C:
	call Logged_0x3F62
	jp Logged_0x301B8

UnknownData_0x3F12:
INCBIN "baserom.gbc", $3F12, $3F18 - $3F12

Logged_0x3F18:
	call Logged_0x3F62
	jp Logged_0x302B8

Logged_0x3F1E:
	call Logged_0x3F62
	jp Logged_0x303C9

Logged_0x3F24:
	call Logged_0x3F62
	jp Logged_0x30416

UnknownData_0x3F2A:
INCBIN "baserom.gbc", $3F2A, $3F36 - $3F2A

Logged_0x3F36:
	call Logged_0x3F62
	jp Logged_0x3049E

UnknownData_0x3F3C:
INCBIN "baserom.gbc", $3F3C, $3F48 - $3F3C

Logged_0x3F48:
	call Logged_0x3F62
	jp Logged_0x302CE

Logged_0x3F4E:
	ld a,[$C5FF]
	ld [$D001],a

Logged_0x3F54:
	ld a,$0C

Logged_0x3F56:
	ld [$C5FF],a
	ld [$2000],a
	ret

Logged_0x3F5D:
	ld a,[$D001]
	jr Logged_0x3F56

Logged_0x3F62:
	ld hl,$D000
	bit 7,[hl]
	jr nz,Unknown_0x3F71

Logged_0x3F69:
	set 7,[hl]
	push af
	call Logged_0x3F4E
	pop af
	ret

Unknown_0x3F71:
	pop hl
	ld a,$FF
	ret

Logged_0x3F75:
	ld hl,$D000
	bit 7,[hl]
	jr z,Logged_0x3F69
	bit 6,[hl]
	jr nz,Unknown_0x3F71
	set 6,[hl]
	pop hl
	ld a,h
	ld [$D004],a
	ld a,l
	ld [$D003],a
	xor a
	ret

Logged_0x3F8D:
	ld hl,$D000
	bit 6,[hl]
	jr nz,Unknown_0x3F9B
	call Logged_0x3F5D
	res 7,[hl]
	xor a
	ret

Unknown_0x3F9B:
	ld a,[$D004]
	ld h,a
	ld a,[$D003]
	ld l,a
	push hl
	ld hl,$D000
	res 6,[hl]
	ret

Logged_0x3FAA:
	ld a,[$D026]
	call Logged_0x3F56
	ld a,[de]
	ld c,a
	jp Logged_0x3F54

Logged_0x3FB5:
	ld a,[$D026]
	call Logged_0x3F56
	ld a,[de]
	ld c,a
	inc de
	ld a,[de]
	ld b,a
	jp Logged_0x3F54

UnknownData_0x3FC3:
INCBIN "baserom.gbc", $3FC3, $4000 - $3FC3

SECTION "Bank01", ROMX, BANK[$01]

Logged_0x4000:
	ld a,[$C09B]
	rst JumpList
	dw Logged_0x402B
	dw Logged_0x4686
	dw Logged_0x46CC
	dw Logged_0x46DC
	dw Logged_0x46F6
	dw Logged_0x4710
	dw Logged_0x472A
	dw Logged_0x474C
	dw Logged_0x4766
	dw Logged_0x4776
	dw Logged_0x4790
	dw Unknown_0x47AA
	dw Logged_0x47FD
	dw Logged_0x4817
	dw Logged_0x4831
	dw Unknown_0x4028
	dw Unknown_0x4028
	dw Unknown_0x4028

Unknown_0x4028:
	jp Logged_0x015E

Logged_0x402B:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x4039
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x4039:
	ld a,[$C09C]
	rst JumpList
	dw Logged_0x047B
	dw Logged_0x405F
	dw Logged_0x05ED
	dw Logged_0x41CF
	dw Logged_0x42ED
	dw Logged_0x43B5
	dw Logged_0x44C3
	dw Logged_0x4508
	dw Logged_0x0474
	dw Logged_0x4640
	dw Logged_0x4670
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D

Logged_0x405F:
	call Logged_0x08E6
	call Logged_0x038F
	call Logged_0x037D
	call Logged_0x4917
	call Logged_0x4937
	call Logged_0x4951
	call Logged_0x49DB
	ld a,$04
	ld [$C083],a
	ld [$FF00+$42],a
	xor a
	ld [$C085],a
	ld [$FF00+$43],a
	ld a,[$CEEF]
	and a
	jr nz,Logged_0x40FC
	ld hl,$D515
	ld a,$40
	ld [hli],a
	ld a,$D0
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$2C
	ld [hli],a
	xor a
	ld [hld],a
	ld [$D522],a
	call Logged_0x145A
	ld hl,$D523
	ld a,$80
	ld [hli],a
	ld a,$50
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$6C
	ld [hli],a
	ld a,$E6
	ld [hl],a
	call Logged_0x145A
	ld hl,$D53B
	ld a,$10
	ld [hli],a
	ld a,$00
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$A1
	ld [hl],a
	call Logged_0x145A
	ld hl,$D547
	ld a,$08
	ld [hli],a
	ld a,$20
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$A4
	ld [hl],a
	call Logged_0x145A
	ld hl,$D53B
	call Logged_0x4B93
	ld hl,$D547
	call Logged_0x4B93
	ld a,$00
	ld [$D513],a
	jp Logged_0x41A8

Logged_0x40FC:
	ld hl,$D515
	ld a,$6C
	ld [hli],a
	ld a,$80
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$98
	ld [hli],a
	xor a
	ld [hld],a
	ld [$D522],a
	ld a,$01
	ld [$FF00+$4F],a
	ld hl,$9984
	ld de,$0020
	ld c,$02

Logged_0x4121:
	push hl
	ld b,$0B

Logged_0x4124:
	ld a,[hl]
	or $80
	ld [hli],a
	dec b
	jr nz,Logged_0x4124
	pop hl
	add hl,de
	push hl
	ld b,$0B

Logged_0x4130:
	ld a,[hl]
	or $80
	ld [hli],a
	dec b
	jr nz,Logged_0x4130
	pop hl
	add hl,de
	add hl,de
	add hl,de
	dec c
	jr nz,Logged_0x4121
	xor a
	ld [$FF00+$4F],a
	ld hl,$6B47
	ld de,$99C4
	push de
	ld b,$0C
	call Logged_0x0466
	pop de
	ld a,e
	add a,$20
	ld e,a
	ld a,d
	adc a,$00
	ld d,a
	ld b,$0C
	call Logged_0x0466
	ld hl,$D523
	ld a,$82
	ld [hli],a
	ld a,$50
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,[$CA3D]
	bit 1,a
	jr nz,Logged_0x4178
	ld a,$6C
	ld [hli],a
	ld a,$E9
	ld [hl],a
	jr Logged_0x417E

Logged_0x4178:
	ld a,$6D
	ld [hli],a
	ld a,$1E
	ld [hl],a

Logged_0x417E:
	call Logged_0x145A
	ld hl,$D52B
	ld a,$86
	ld [hli],a
	ld a,[$CA3D]
	bit 1,a
	jr nz,Logged_0x4192
	ld a,$44
	jr Logged_0x4194

Logged_0x4192:
	ld a,$40

Logged_0x4194:
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$6D
	ld [hli],a
	ld a,$1B
	ld [hl],a
	call Logged_0x145A
	ld a,$01
	ld [$D513],a

Logged_0x41A8:
	ld hl,$D533
	ld a,$24
	ld [hli],a
	ld a,$68
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$6D
	ld [hli],a
	ld a,$18
	ld [hl],a
	call Logged_0x145A
	ld a,$87
	ld [$FF00+$40],a
	xor a
	ld [$CEE5],a
	ld [$C08F],a
	ld hl,$C09C
	inc [hl]
	ret

Logged_0x41CF:
	ld a,[$CEEF]
	and a
	jp nz,Logged_0x44F0
	call Logged_0x4E5E
	call Logged_0x4D45
	ld a,[$D51D]
	dec a
	jr z,Logged_0x420A
	dec a
	jr z,Logged_0x4235
	dec a
	jr z,Logged_0x4250
	dec a
	jr z,Logged_0x4266
	dec a
	jp z,Logged_0x4294
	ld hl,$CEE5
	inc [hl]
	ld a,[hl]
	cp $B4
	jp c,Logged_0x42CC
	ld [hl],$00
	ld a,$00
	ld [$FF00+$B1],a
	ld a,$34
	ld [$FF00+$B2],a
	ld hl,$D51D
	inc [hl]
	jp Logged_0x42CC

Logged_0x420A:
	ld hl,$D516
	ld a,[hl]
	cp $48
	jr nc,Logged_0x4224
	cp $38
	jr nc,Logged_0x4225
	cp $30
	jr z,Logged_0x4229
	ld a,[$C08F]
	and $03
	jp nz,Logged_0x42CC
	jr Logged_0x4225

Logged_0x4224:
	dec [hl]

Logged_0x4225:
	dec [hl]
	jp Logged_0x42CC

Logged_0x4229:
	ld a,$30
	ld [$CEE5],a
	ld hl,$D51D
	inc [hl]
	jp Logged_0x42CC

Logged_0x4235:
	ld hl,$CEE5
	dec [hl]
	jp nz,Logged_0x42CC
	ld [hl],$03
	ld hl,$D519
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$A7
	ld [hl],a
	ld hl,$D51D
	inc [hl]
	jr Logged_0x42CC

Logged_0x4250:
	ld a,[$C08F]
	and $07
	jr nz,Logged_0x42CC
	ld hl,$D515
	inc [hl]
	ld a,[hl]
	cp $46
	jr nz,Logged_0x42CC
	ld hl,$D51D
	inc [hl]
	jr Logged_0x42CC

Logged_0x4266:
	ld a,[$C08F]
	and $07
	jr nz,Logged_0x42CC
	ld hl,$D515
	dec [hl]
	ld a,[hl]
	cp $40
	jr nz,Logged_0x42CC
	ld hl,$CEE5
	dec [hl]
	jr z,Logged_0x4282
	ld hl,$D51D
	dec [hl]
	jr Logged_0x42CC

Logged_0x4282:
	ld hl,$D519
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$2C
	ld [hl],a
	ld hl,$D51D
	inc [hl]
	jr Logged_0x42CC

Logged_0x4294:
	ld hl,$D516
	ld a,[hl]
	cp $C0
	jr z,Logged_0x42AA
	cp $38
	jr nc,Logged_0x42A7
	ld a,[$C08F]
	and $03
	jr nz,Logged_0x42CC

Logged_0x42A7:
	inc [hl]
	jr Logged_0x42CC

Logged_0x42AA:
	ld hl,$D515
	ld a,$10
	ld [hli],a
	ld a,$C0
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$3D
	ld [hli],a
	xor a
	ld [hl],a
	ld [$D522],a
	ld a,$1C
	ld [$CEE5],a
	ld hl,$C09C
	inc [hl]

Logged_0x42CC:
	call Logged_0x4CBB
	ld hl,$D51C
	call Logged_0x145A
	ld hl,$D515
	call Logged_0x4B93
	ld hl,$D53B
	call Logged_0x4B93
	ld hl,$D547
	call Logged_0x4B93
	call Logged_0x03B9
	jp Logged_0x4D07

Logged_0x42ED:
	call Logged_0x4D45
	call Logged_0x4EB1
	ld a,[$D51D]
	dec a
	jr z,Logged_0x4336
	dec a
	jr z,Logged_0x4357
	ld hl,$CEE5
	ld a,[hl]
	and a
	jr z,Logged_0x4307
	dec [hl]
	jp Logged_0x4394

Logged_0x4307:
	ld hl,$D516
	ld a,[hl]
	cp $40
	jr z,Logged_0x432B
	cp $48
	jr nc,Logged_0x431D
	ld a,[$C08F]
	and $03
	jp nz,Logged_0x4394
	jr Logged_0x4325

Logged_0x431D:
	ld a,[$C08F]
	and $01
	jp nz,Logged_0x4394

Logged_0x4325:
	ld hl,$D516
	dec [hl]
	jr Logged_0x4394

Logged_0x432B:
	ld a,$30
	ld [$CEE5],a
	ld hl,$D51D
	inc [hl]
	jr Logged_0x4394

Logged_0x4336:
	ld hl,$CEE5
	dec [hl]
	jr nz,Logged_0x4394
	ld hl,$D519
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$44
	ld [hli],a
	xor a
	ld [$D522],a
	ld a,$E0
	ld [$CEE5],a
	ld hl,$D51D
	inc [hl]
	jr Logged_0x4394

Logged_0x4357:
	ld a,[$D519]
	cp $18
	jr nz,Logged_0x436C
	ld a,[$D51A]
	and a
	jr nz,Logged_0x436C
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$23
	ld [$FF00+$B6],a

Logged_0x436C:
	ld hl,$CEE5
	dec [hl]
	jr nz,Logged_0x4394
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$F9
	ld [$FF00+$B6],a
	ld hl,$D519
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$65
	ld [hli],a
	xor a
	ld [hl],a
	ld [$D522],a
	ld a,$30
	ld [$CEE5],a
	ld hl,$C09C
	inc [hl]

Logged_0x4394:
	call Logged_0x4CBB
	ld hl,$D51C
	call Logged_0x145A
	ld hl,$D53B
	call Logged_0x4B93
	ld hl,$D515
	call Logged_0x4B93
	ld hl,$D547
	call Logged_0x4B93
	call Logged_0x03B9
	jp Logged_0x4D07

Logged_0x43B5:
	call Logged_0x4D45
	ld a,[$D51D]
	dec a
	jr z,Logged_0x43E7
	dec a
	jr z,Logged_0x440C
	dec a
	jr z,Logged_0x442F
	dec a
	jp z,Logged_0x445A
	ld a,[$D520]
	and a
	jp z,Logged_0x4497
	ld a,$02
	ld [$FF00+$B5],a
	ld a,$19
	ld [$FF00+$B6],a
	ld hl,$D519
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$72
	ld [hli],a
	inc [hl]
	jp Logged_0x4497

Logged_0x43E7:
	ld a,[$C08F]
	and $03
	jr nz,Logged_0x43F2
	ld hl,$D516
	inc [hl]

Logged_0x43F2:
	ld hl,$D515
	inc [hl]
	ld a,[hl]
	cp $10
	jp c,Logged_0x4497
	ld hl,$D519
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$7B
	ld [hli],a
	inc [hl]
	jp Logged_0x4497

Logged_0x440C:
	ld a,[$C08F]
	and $03
	jr nz,Logged_0x4417
	ld hl,$D516
	inc [hl]

Logged_0x4417:
	ld hl,$D515
	inc [hl]
	ld a,[hl]
	cp $30
	jr c,Logged_0x4497
	ld hl,$D519
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$84
	ld [hli],a
	inc [hl]
	jr Logged_0x4497

Logged_0x442F:
	ld a,[$C08F]
	and $03
	jr nz,Logged_0x443A
	ld hl,$D516
	inc [hl]

Logged_0x443A:
	ld hl,$D515
	inc [hl]
	ld a,[hl]
	cp $70
	jr c,Logged_0x4497
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$61
	ld [$FF00+$B6],a
	ld hl,$D519
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$8D
	ld [hli],a
	inc [hl]
	jr Logged_0x4497

Logged_0x445A:
	ld a,[$C088]
	cp $E0
	jr z,Logged_0x4466
	ld hl,$D516
	inc [hl]
	inc [hl]

Logged_0x4466:
	ld a,[$D520]
	and a
	jr z,Logged_0x449C
	ld hl,$D519
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$71
	ld [hli],a
	ld a,$98
	ld [hli],a
	xor a
	ld [hld],a
	ld [$CEE5],a
	ld hl,$5002
	call Logged_0x1A15
	ld hl,$5042
	call Logged_0x1A21
	ld a,$00
	ld [$FF00+$B1],a
	ld a,$33
	ld [$FF00+$B2],a
	ld hl,$C09C
	inc [hl]
	jr Logged_0x449C

Logged_0x4497:
	call Logged_0x4CBB
	jr Logged_0x449F

Logged_0x449C:
	call Logged_0x4CD0

Logged_0x449F:
	ld hl,$D51C
	call Logged_0x145A
	ld a,[$D514]
	ld [$D520],a
	ld hl,$D53B
	call Logged_0x4B93
	ld hl,$D515
	call Logged_0x4B93
	ld hl,$D547
	call Logged_0x4B93
	call Logged_0x03B9
	jp Logged_0x4D07

Logged_0x44C3:
	ld hl,$D51C
	call Logged_0x145A
	ld hl,$D515
	call Logged_0x4B93
	call Logged_0x03B9
	ld a,[$CEEF]
	and a
	jr nz,Logged_0x44F0
	ld hl,$CEE5
	ld a,[hl]
	cp $78
	jr nc,Logged_0x44E2
	inc [hl]
	ret

Logged_0x44E2:
	ld a,[$C08F]
	and $03
	call z,Logged_0x06FA
	ld a,[$C09C]
	cp $07
	ret nz

Logged_0x44F0:
	ld a,$00
	ld [$FF00+$B1],a
	ld a,$33
	ld [$FF00+$B2],a
	ld a,$08
	ld [$CEE6],a
	ld a,$44
	ld [$CEE5],a
	ld hl,$C09C
	ld [hl],$07
	ret

Logged_0x4508:
	ld hl,$D51C
	call Logged_0x145A
	ld hl,$D515
	call Logged_0x4B93
	ld hl,$D533
	call Logged_0x4B73
	call Logged_0x4BB3
	ld hl,$D523
	call Logged_0x4B73
	ld a,[$CEEF]
	and a
	jr z,Logged_0x453E
	ld a,[$C08F]
	and $07
	jr nz,Logged_0x4538
	ld a,[$D52E]
	xor $03
	ld [$D52E],a

Logged_0x4538:
	ld hl,$D52B
	call Logged_0x4B73

Logged_0x453E:
	call Logged_0x03B9
	ld hl,$D513
	bit 7,[hl]
	jr nz,Logged_0x4578
	ld a,[hl]
	cp $00
	jr z,Logged_0x455C
	cp $01
	jr z,Logged_0x455C
	ld a,$08
	ld [$CEE6],a
	ld a,$44
	ld [$CEE5],a
	ret

Logged_0x455C:
	ld hl,$CEE5
	ld a,[hl]
	sub $01
	ld [hli],a
	ld b,a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	or b
	ret nz
	xor a
	ld [hld],a
	ld [hl],a
	ld a,[$CA3C]
	or $40
	ld [$CA3C],a
	jp Logged_0x16D0

Logged_0x4578:
	ld hl,$D513
	ld a,[hl]
	and $0F
	cp $00
	jr z,Logged_0x45D6
	cp $01
	jr z,Logged_0x45ED
	cp $02
	jr z,Unknown_0x45B1
	cp $04
	jp z,Unknown_0x1698
	ld a,$86
	ld [$D52B],a
	ld a,$82
	ld [$D523],a
	ld a,[$CA3D]
	bit 1,a
	jr nz,Unknown_0x45AA
	ld a,$80
	ld [$CEE4],a
	ld bc,$6CE9
	jr Unknown_0x45AD

Unknown_0x45AA:
	ld bc,$6D1E

Unknown_0x45AD:
	ld a,$01
	jr Unknown_0x45C5

Unknown_0x45B1:
	ld a,$81
	ld [$CEE4],a
	ld a,$90
	ld [$D52B],a
	ld a,$78
	ld [$D523],a
	ld bc,$6CEC
	ld a,$03

Unknown_0x45C5:
	ld [$D513],a
	ld hl,$D527
	xor a
	ld [hli],a
	ld [hli],a
	ld a,b
	ld [hli],a
	ld a,c
	ld [hl],a
	call Logged_0x145A
	ret

Logged_0x45D6:
	ld a,$0E
	ld [$C09B],a
	xor a
	ld [$C09C],a
	ret

UnknownData_0x45E0:
INCBIN "baserom.gbc", $45E0, $45ED - $45E0

Logged_0x45ED:
	ld a,[$CA3D]
	bit 1,a
	jr nz,Logged_0x4607
	ld a,[$CEEF]
	and $3C
	jr nz,Logged_0x45FD
	jr Logged_0x461E

Logged_0x45FD:
	ld a,$02
	ld [$C09B],a
	xor a
	ld [$C09C],a
	ret

Logged_0x4607:
	call Logged_0x08E6
	call Logged_0x1AC0
	call Logged_0x1AD1
	ld a,$87
	ld [$FF00+$40],a
	ld hl,$C09C
	inc [hl]
	ret

Logged_0x4619:
	ld a,$FF
	ld [$CEE3],a

Logged_0x461E:
	ld a,$01
	ld [$C09B],a
	xor a
	ld [$C09C],a
	ret
	xor a
	ld [$C1AC],a
	ld [$C1AD],a
	ld [$C1AF],a
	ld [$C1AE],a
	xor a
	ld [$D50D],a
	ld hl,$CA3B
	set 7,[hl]
	jr Logged_0x461E

Logged_0x4640:
	call Logged_0x08E6
	call Logged_0x038F
	call Logged_0x037D
	call Logged_0x496B
	call Logged_0x1C4A
	call Logged_0x4972
	call Logged_0x49A1
	call Logged_0x0354
	xor a
	ld [$C083],a
	ld [$FF00+$42],a
	ld [$C085],a
	ld [$FF00+$43],a
	ld a,$87
	ld [$FF00+$40],a
	xor a
	ld [$CEE5],a
	ld hl,$C09C
	inc [hl]
	ret

Logged_0x4670:
	call Logged_0x4D7F
	ld a,[$C094]
	bit 0,a
	ret z
	call Logged_0x08E6
	call Logged_0x1AC0
	ld a,$87
	ld [$FF00+$40],a
	jp Logged_0x461E

Logged_0x4686:
	ld a,[$FF00+$70]
	push af
	ld a,$02
	ld [$FF00+$70],a
	ld a,$20
	ld [$FF00+$85],a
	ld a,$92
	ld [$FF00+$8D],a
	ld a,$43
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ld hl,$C09B
	ld a,[hl]
	cp $02
	ret nz
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E3
	ld [$FF00+$B6],a
	call Logged_0x4AE7
	ld a,[$CA06]
	cp $FF
	jr z,Logged_0x46BD
	cp $C8
	jr z,Logged_0x46C3
	ret

Logged_0x46BD:
	ld a,$0A
	ld [$C09B],a
	ret

Logged_0x46C3:
	ld a,$FF
	ld [$FF00+$B5],a
	ld a,$00
	ld [$FF00+$B6],a
	ret

Logged_0x46CC:
	ld a,$02
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x46DC:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,$35
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x46F6:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,$7C
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x4710:
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$72
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x472A:
	ld a,[$C09C]
	rst JumpList
	dw Logged_0x4732
	dw Logged_0x473C

Logged_0x4732:
	ld a,[$C08F]
	and $03
	ret nz
	call Logged_0x047B
	ret

Logged_0x473C:
	ld a,$01
	ld [$FF00+$85],a
	ld a,$28
	ld [$FF00+$8D],a
	ld a,$46
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x474C:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,$7E
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x4766:
	ld hl,$CEE5
	inc [hl]
	ld a,[hl]
	cp $64
	ret c
	ld [hl],$00
	ld a,$02
	ld [$C09B],a
	ret

Logged_0x4776:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,$58
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x4790:
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$72
	ld [$FF00+$85],a
	ld a,$70
	ld [$FF00+$8D],a
	ld a,$45
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ret

Unknown_0x47AA:
	ld a,[$C09C]
	rst JumpList
	dw Logged_0x047B
	dw Unknown_0x47BE
	dw Logged_0x05ED
	dw Unknown_0x47FC
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D

Unknown_0x47BE:
	call Logged_0x08E6
	call Logged_0x038B
	call Logged_0x037D
	ld a,$7C
	ld [$FF00+$85],a
	ld a,$01
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,$7C
	ld [$FF00+$85],a
	ld a,$0B
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x0354
	xor a
	ld [$C085],a
	ld [$FF00+$43],a
	ld [$C083],a
	ld [$FF00+$42],a
	ld a,$87
	ld [$FF00+$40],a
	ld hl,$C09C
	inc [hl]
	ret

Unknown_0x47FC:
	ret

Logged_0x47FD:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,$36
	ld [$FF00+$85],a
	ld a,$77
	ld [$FF00+$8D],a
	ld a,$72
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x4817:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,$37
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x4831:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x483F
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x483F:
	ld a,[$C09C]
	rst JumpList
	dw Logged_0x047B
	dw Logged_0x4857
	dw Logged_0x05ED
	dw Logged_0x48C9
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D

Logged_0x4857:
	call Logged_0x08E6
	call Logged_0x038F
	call Logged_0x037D
	ld a,$7C
	ld [$FF00+$85],a
	ld a,$19
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,$7C
	ld [$FF00+$85],a
	ld a,$F7
	ld [$FF00+$8D],a
	ld a,$48
	ld [$FF00+$8E],a
	call $FF80
	ld a,$7C
	ld [$FF00+$85],a
	ld a,$26
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x4DDF
	xor a
	ld [$C083],a
	ld [$FF00+$42],a
	ld [$C085],a
	ld [$FF00+$43],a
	ld a,$01
	ld [$CA46],a
	ld hl,$D523
	ld a,$46
	ld [hli],a
	ld a,$18
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$76
	ld [hli],a
	ld a,$B5
	ld [hl],a
	call Logged_0x145A
	ld hl,$D523
	call Logged_0x4E3E
	call Logged_0x03B9
	ld a,$87
	ld [$FF00+$40],a
	ld hl,$C09C
	inc [hl]
	ret

Logged_0x48C9:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x4619
	bit 7,a
	jr nz,Logged_0x48DB
	bit 6,a
	jr nz,Logged_0x48E8
	jr Logged_0x4907

Logged_0x48DB:
	ld a,[$CA46]
	and a
	ret z
	ld a,$56
	ld [$D523],a
	xor a
	jr Logged_0x48F7

Logged_0x48E8:
	ld a,[$CA46]
	dec a
	ret z
	ld hl,$D523
	ld a,$46
	ld [$D523],a
	ld a,$01

Logged_0x48F7:
	ld [$CA46],a
	add a,$80
	ld [$CEE4],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E2
	ld [$FF00+$B6],a

Logged_0x4907:
	ld hl,$D52A
	call Logged_0x145A
	ld hl,$D523
	call Logged_0x4E3E
	call Logged_0x03B9
	ret

Logged_0x4917:
	ld a,[$CEEF]
	and a
	jr nz,Logged_0x492A
	ld hl,$4F82
	call Logged_0x1A15
	ld hl,$4FC2
	call Logged_0x1A21
	ret

Logged_0x492A:
	ld hl,$5002
	call Logged_0x1A15
	ld hl,$5042
	call Logged_0x1A21
	ret

Logged_0x4937:
	ld a,$01
	ld [$FF00+$4F],a
	ld hl,$635C
	ld bc,$8000
	call Logged_0x0909
	xor a
	ld [$FF00+$4F],a
	ld hl,$5082
	ld bc,$8000
	call Logged_0x0909
	ret

Logged_0x4951:
	ld a,$01
	ld [$FF00+$4F],a
	ld hl,$6AE7
	ld bc,$9800
	call Logged_0x0909
	xor a
	ld [$FF00+$4F],a
	ld hl,$697A
	ld bc,$9800
	call Logged_0x0909
	ret

Logged_0x496B:
	ld hl,$71B0
	call Logged_0x1A15
	ret

Logged_0x4972:
	ld a,$01
	ld [$FF00+$4F],a
	ld a,$7C
	ld [$FF00+$85],a
	ld a,$F7
	ld [$FF00+$8D],a
	ld a,$48
	ld [$FF00+$8E],a
	call $FF80
	xor a
	ld [$FF00+$4F],a
	ld hl,$4F80
	ld de,$9000
	ld bc,$0800
	ld a,$2C
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$04
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x49A1:
	ld a,[$CA46]
	and a
	jr nz,Logged_0x49C1
	ld a,$01
	ld [$FF00+$4F],a
	ld hl,$7316
	ld bc,$9800
	call Logged_0x0909
	xor a
	ld [$FF00+$4F],a
	ld hl,$71F0
	ld bc,$9800
	call Logged_0x0909
	ret

Logged_0x49C1:
	ld a,$01
	ld [$FF00+$4F],a
	ld hl,$74E8
	ld bc,$9800
	call Logged_0x0909
	xor a
	ld [$FF00+$4F],a
	ld hl,$73E6
	ld bc,$9800
	call Logged_0x0909
	ret

Logged_0x49DB:
	ld hl,$49E7
	ld de,$C200
	ld b,$4C
	call Logged_0x0466
	ret

LoggedData_0x49E7:
INCBIN "baserom.gbc", $49E7, $4A33 - $49E7
	ld bc,$FFE0
	ld de,$0020
	ld a,[$CA04]
	and $0F
	add a,a
	add a,$A0
	ld [hl],a
	add hl,de
	inc a
	ld [hli],a
	add hl,bc
	ld a,[$CA05]
	swap a
	and $0F
	add a,a
	add a,$A0
	ld [hl],a
	add hl,de
	inc a
	ld [hli],a
	add hl,bc
	ld a,[$CA05]
	and $0F
	add a,a
	add a,$A0
	ld [hl],a
	add hl,de
	inc a
	ld [hli],a
	add hl,bc
	ret
	xor a
	ld [$CA5B],a
	ld a,[$FF00+$70]
	push af
	ld a,$02
	ld [$FF00+$70],a
	ld a,[$D00F]
	dec a
	call Logged_0x4A79
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x4A79:
	add a,a
	add a,a
	ld e,a
	ld d,$00
	ld hl,$198F
	add hl,de
	ld a,[hli]
	push hl
	call Logged_0x3AAC
	jr z,Logged_0x4A8E
	ld hl,$CA5B
	set 4,[hl]

Logged_0x4A8E:
	pop hl
	ld a,[hli]
	push hl
	call Logged_0x3AAC
	jr z,Logged_0x4A9B
	ld hl,$CA5B
	set 5,[hl]

Logged_0x4A9B:
	pop hl
	ld a,[hli]
	push hl
	call Logged_0x3AAC
	jr z,Logged_0x4AA8
	ld hl,$CA5B
	set 6,[hl]

Logged_0x4AA8:
	pop hl
	ld a,[hli]
	push hl
	call Logged_0x3AAC
	jr z,Logged_0x4AB5
	ld hl,$CA5B
	set 7,[hl]

Logged_0x4AB5:
	pop hl
	ret
	ld bc,$FFE0
	ld de,$0020
	ld a,[$CA39]
	and $0F
	add a,a
	add a,$A0
	ld [hl],a
	add hl,de
	inc a
	ld [hli],a
	add hl,bc
	ld a,[$CA3A]
	swap a
	and $0F
	add a,a
	add a,$A0
	ld [hl],a
	add hl,de
	inc a
	ld [hli],a
	add hl,bc
	ld a,[$CA3A]
	and $0F
	add a,a
	add a,$A0
	ld [hl],a
	add hl,de
	inc a
	ld [hli],a
	add hl,bc
	ret

Logged_0x4AE7:
	ld a,[$FF00+$70]
	push af
	ld a,$02
	ld [$FF00+$70],a
	ld a,[$D00F]
	and a
	jr z,Logged_0x4B66
	cp $1A
	jr z,Logged_0x4B6A
	dec a
	add a,a
	add a,a
	add a,a
	ld [$CA06],a
	ld e,a
	ld d,$00
	ld hl,$4EBA
	add hl,de
	ld a,[hli]
	push hl
	call Logged_0x3AAC
	pop hl
	ld c,a
	ld a,[hli]
	push hl
	call Logged_0x3AAC
	pop hl
	and c
	jr nz,Logged_0x4B49
	ld a,[hli]
	push hl
	call Logged_0x3AAC
	pop hl
	ld c,a
	ld a,[hli]
	push hl
	call Logged_0x3AAC
	pop hl
	and c
	jr nz,Logged_0x4B53
	ld a,[hli]
	push hl
	call Logged_0x3AAC
	pop hl
	ld c,a
	ld a,[hli]
	push hl
	call Logged_0x3AAC
	pop hl
	and c
	jr nz,Logged_0x4B5D

Logged_0x4B36:
	ld a,[$CA3B]
	and $01
	add a,a
	add a,a
	ld b,a
	ld a,[$CA06]
	or b
	ld [$CA06],a
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x4B49:
	ld a,[$CA06]
	add a,$03
	ld [$CA06],a
	jr Logged_0x4B36

Logged_0x4B53:
	ld a,[$CA06]
	add a,$02
	ld [$CA06],a
	jr Logged_0x4B36

Logged_0x4B5D:
	ld a,[$CA06]
	inc a
	ld [$CA06],a
	jr Logged_0x4B36

Logged_0x4B66:
	ld a,$C8
	jr Logged_0x4B6C

Logged_0x4B6A:
	ld a,$FF

Logged_0x4B6C:
	ld [$CA06],a
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x4B73:
	ld a,[$C083]
	ld b,a
	ld a,[hli]
	add a,$10
	sub b
	ld [$C096],a
	ld a,[hli]
	add a,$08
	ld [$C097],a
	ld a,[hli]
	ld [$C098],a
	ld a,[hl]
	ld [$C099],a
	ld hl,$6B5F
	call Logged_0x0DF4
	ret

Logged_0x4B93:
	ld a,[$C083]
	ld b,a
	ld a,[hli]
	add a,$10
	sub b
	ld [$C096],a
	ld a,[hli]
	add a,$08
	ld [$C097],a
	ld a,[hli]
	ld [$C098],a
	ld a,[hl]
	ld [$C099],a
	ld hl,$6D21
	call Logged_0x0DF4
	ret

Logged_0x4BB3:
	ld a,[$D513]
	bit 4,a
	jp nz,Logged_0x4C58
	bit 5,a
	jp nz,Unknown_0x4C81
	bit 6,a
	jp nz,Logged_0x4C96
	ld a,[$C094]
	bit 0,a
	jr nz,Logged_0x4BDD
	bit 7,a
	jr nz,Logged_0x4C08
	bit 6,a
	jr nz,Logged_0x4C15
	bit 4,a
	jr nz,Unknown_0x4C39
	bit 5,a
	jr nz,Unknown_0x4C29
	ret

Logged_0x4BDD:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E3
	ld [$FF00+$B6],a
	ld hl,$D513
	ld a,[hl]
	and $0F
	cp $03
	jr z,Unknown_0x4BFA
	cp $04
	jr z,Unknown_0x4C01
	set 6,[hl]
	xor a
	ld [$D527],a
	ret

Unknown_0x4BFA:
	ld bc,$6CF2
	ld a,$23
	jr Unknown_0x4C47

Unknown_0x4C01:
	ld bc,$6D05
	ld a,$24
	jr Unknown_0x4C47

Logged_0x4C08:
	ld a,[$D513]
	cp $01
	ret nz
	ld a,$12
	ld [$D513],a
	jr Logged_0x4C20

Logged_0x4C15:
	ld a,[$D513]
	cp $02
	ret nz
	ld a,$11
	ld [$D513],a

Logged_0x4C20:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E2
	ld [$FF00+$B6],a
	ret

Unknown_0x4C29:
	ld a,[$D513]
	cp $03
	ret nz
	call Logged_0x4C20
	ld bc,$6CEF
	ld a,$04
	jr Unknown_0x4C47

Unknown_0x4C39:
	ld a,[$D513]
	cp $04
	ret nz
	call Logged_0x4C20
	ld bc,$6CEC
	ld a,$03

Unknown_0x4C47:
	ld [$D513],a
	ld hl,$D527
	xor a
	ld [hli],a
	ld [hli],a
	ld a,b
	ld [hli],a
	ld a,c
	ld [hl],a
	call Logged_0x145A
	ret

Logged_0x4C58:
	ld a,[$D513]
	cp $12
	jr z,Logged_0x4C6E
	ld hl,$D523
	inc [hl]
	ld a,[hl]
	cp $82
	ret nz
	ld a,$86
	ld [$D52B],a
	jr Logged_0x4C7B

Logged_0x4C6E:
	ld hl,$D523
	dec [hl]
	ld a,[hl]
	cp $74
	ret nz
	ld a,$76
	ld [$D52B],a

Logged_0x4C7B:
	ld hl,$D513
	res 4,[hl]
	ret

Unknown_0x4C81:
	ld hl,$D52A
	call Logged_0x145A
	ld a,[$D514]
	and a
	ret z

Logged_0x4C8C:
	ld hl,$D513
	set 7,[hl]
	xor a
	ld [$D527],a
	ret

Logged_0x4C96:
	ld a,[$C08F]
	and $01
	ret nz
	ld hl,$D527
	ld a,[hl]
	cp $10
	jr z,Logged_0x4C8C
	inc [hl]
	and $03
	jr z,Logged_0x4CB2
	dec a
	jr z,Logged_0x4CAF
	dec a
	jr z,Logged_0x4CB6

Logged_0x4CAF:
	xor a
	jr Logged_0x4CB8

Logged_0x4CB2:
	ld a,$03
	jr Logged_0x4CB8

Logged_0x4CB6:
	ld a,$01

Logged_0x4CB8:
	dec l
	ld [hl],a
	ret

Logged_0x4CBB:
	ld a,[$C08F]
	and $03
	jr nz,Logged_0x4CC6
	ld hl,$C086
	dec [hl]

Logged_0x4CC6:
	ld hl,$C087
	dec [hl]
	ld hl,$C088
	dec [hl]
	dec [hl]
	ret

Logged_0x4CD0:
	ld a,[$C08F]
	and $03
	jr nz,Logged_0x4CE6
	ld hl,$C086
	ld a,[hl]
	and $1F
	jr nz,Logged_0x4CE5
	ld a,[$C085]
	ld [hl],a
	jr Logged_0x4CE6

Logged_0x4CE5:
	dec [hl]

Logged_0x4CE6:
	ld hl,$C087
	ld a,[hl]
	and $1F
	jr nz,Logged_0x4CF4
	ld a,[$C085]
	ld [hl],a
	jr Logged_0x4CF5

Logged_0x4CF4:
	dec [hl]

Logged_0x4CF5:
	ld hl,$C088
	ld a,[hl]
	cp $E0
	jr z,Logged_0x4CFF
	jr Logged_0x4D04

Logged_0x4CFF:
	ld a,$E0
	ld [hl],a
	jr Logged_0x4D06

Logged_0x4D04:
	dec [hl]
	dec [hl]

Logged_0x4D06:
	ret

Logged_0x4D07:
	ld a,[$CEEF]
	and a
	ret nz

Logged_0x4D0C:
	ld a,[$FF00+$44]
	cp $5B
	jr c,Logged_0x4D0C
	call Logged_0x0370
	ld a,[$C086]
	ld [$FF00+$43],a

Logged_0x4D1A:
	ld a,[$FF00+$44]
	cp $63
	jr c,Logged_0x4D1A
	call Logged_0x0370
	ld a,[$C087]
	ld [$FF00+$43],a

Logged_0x4D28:
	ld a,[$FF00+$44]
	cp $73
	jr c,Logged_0x4D28
	call Logged_0x0370
	ld a,[$C088]
	ld [$FF00+$43],a

Logged_0x4D36:
	ld a,[$FF00+$44]
	cp $83
	jr c,Logged_0x4D36
	call Logged_0x0370
	ld a,[$C085]
	ld [$FF00+$43],a
	ret

Logged_0x4D45:
	ld a,[$C08F]
	and $01
	jr z,Logged_0x4D66
	ld hl,$D548
	ld a,[hl]
	cp $B0
	jr c,Logged_0x4D65
	ld a,[$C09C]
	cp $05
	jr nc,Logged_0x4D66
	cp $04
	jr c,Logged_0x4D65
	ld a,[$D51D]
	and a
	jr nz,Logged_0x4D66

Logged_0x4D65:
	inc [hl]

Logged_0x4D66:
	ld hl,$D53C
	ld a,[hl]
	cp $B0
	jr c,Logged_0x4D7D
	ld a,[$C09C]
	cp $05
	ret nc
	cp $04
	jr c,Logged_0x4D7D
	ld a,[$D51D]
	and a
	ret nz

Logged_0x4D7D:
	inc [hl]
	ret

Logged_0x4D7F:
	ld a,[$CA46]
	and a
	ret nz

Unknown_0x4D84:
	ld a,[$FF00+$44]
	cp $2F
	jr c,Unknown_0x4D84
	call Logged_0x0370
	ld a,[$FF00+$42]
	add a,$07
	ld [$FF00+$42],a

Unknown_0x4D93:
	ld a,[$FF00+$44]
	cp $38
	jr c,Unknown_0x4D93
	call Logged_0x0370
	ld a,[$FF00+$42]
	add a,$07
	ld [$FF00+$42],a

Unknown_0x4DA2:
	ld a,[$FF00+$44]
	cp $41
	jr c,Unknown_0x4DA2
	call Logged_0x0370
	ld a,[$FF00+$42]
	add a,$07
	ld [$FF00+$42],a

Unknown_0x4DB1:
	ld a,[$FF00+$44]
	cp $5A
	jr c,Unknown_0x4DB1
	call Logged_0x0370
	ld a,[$FF00+$42]
	add a,$07
	ld [$FF00+$42],a

Unknown_0x4DC0:
	ld a,[$FF00+$44]
	cp $63
	jr c,Unknown_0x4DC0
	call Logged_0x0370
	ld a,[$FF00+$42]
	add a,$07
	ld [$FF00+$42],a

Unknown_0x4DCF:
	ld a,[$FF00+$44]
	cp $6C
	jr c,Unknown_0x4DCF
	call Logged_0x0370
	ld a,[$FF00+$42]
	add a,$07
	ld [$FF00+$42],a
	ret

Logged_0x4DDF:
	ld hl,$4DEB
	ld de,$C200
	ld b,$53
	call Logged_0x0466
	ret

LoggedData_0x4DEB:
INCBIN "baserom.gbc", $4DEB, $4E3E - $4DEB

Logged_0x4E3E:
	ld a,[$C083]
	ld b,a
	ld a,[hli]
	add a,$10
	sub b
	ld [$C096],a
	ld a,[hli]
	add a,$08
	ld [$C097],a
	ld a,[hli]
	ld [$C098],a
	ld a,[hl]
	ld [$C099],a
	ld hl,$75C3
	call Logged_0x0DF4
	ret

Logged_0x4E5E:
	ld a,[$D516]
	cp $A0
	jr nc,Logged_0x4E99
	cp $70
	jr nc,Logged_0x4E81
	ld a,[$D522]
	sub $01
	ld [$D522],a
	jr nc,Logged_0x4E80
	ld a,$0C
	ld [$D522],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$F6
	ld [$FF00+$B6],a

Logged_0x4E80:
	ret

Logged_0x4E81:
	ld a,[$D522]
	sub $01
	ld [$D522],a
	jr nc,Logged_0x4E98
	ld a,$0C
	ld [$D522],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$F7
	ld [$FF00+$B6],a

Logged_0x4E98:
	ret

Logged_0x4E99:
	ld a,[$D522]
	sub $01
	ld [$D522],a
	jr nc,Logged_0x4EB0
	ld a,$0C
	ld [$D522],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$F8
	ld [$FF00+$B6],a

Logged_0x4EB0:
	ret

Logged_0x4EB1:
	ld a,[$D516]
	cp $A0
	jr nc,Logged_0x4E99
	jr Logged_0x4E81

LoggedData_0x4EBA:
INCBIN "baserom.gbc", $4EBA, $4EC0 - $4EBA

UnknownData_0x4EC0:
INCBIN "baserom.gbc", $4EC0, $4EC2 - $4EC0

LoggedData_0x4EC2:
INCBIN "baserom.gbc", $4EC2, $4EC8 - $4EC2

UnknownData_0x4EC8:
INCBIN "baserom.gbc", $4EC8, $4ECA - $4EC8

LoggedData_0x4ECA:
INCBIN "baserom.gbc", $4ECA, $4ED0 - $4ECA

UnknownData_0x4ED0:
INCBIN "baserom.gbc", $4ED0, $4ED2 - $4ED0

LoggedData_0x4ED2:
INCBIN "baserom.gbc", $4ED2, $4ED8 - $4ED2

UnknownData_0x4ED8:
INCBIN "baserom.gbc", $4ED8, $4EDA - $4ED8

LoggedData_0x4EDA:
INCBIN "baserom.gbc", $4EDA, $4EE0 - $4EDA

UnknownData_0x4EE0:
INCBIN "baserom.gbc", $4EE0, $4EE2 - $4EE0

LoggedData_0x4EE2:
INCBIN "baserom.gbc", $4EE2, $4EE8 - $4EE2

UnknownData_0x4EE8:
INCBIN "baserom.gbc", $4EE8, $4EEA - $4EE8

LoggedData_0x4EEA:
INCBIN "baserom.gbc", $4EEA, $4EF0 - $4EEA

UnknownData_0x4EF0:
INCBIN "baserom.gbc", $4EF0, $4EF2 - $4EF0

LoggedData_0x4EF2:
INCBIN "baserom.gbc", $4EF2, $4EF8 - $4EF2

UnknownData_0x4EF8:
INCBIN "baserom.gbc", $4EF8, $4EFA - $4EF8

LoggedData_0x4EFA:
INCBIN "baserom.gbc", $4EFA, $4F00 - $4EFA

UnknownData_0x4F00:
INCBIN "baserom.gbc", $4F00, $4F02 - $4F00

LoggedData_0x4F02:
INCBIN "baserom.gbc", $4F02, $4F08 - $4F02

UnknownData_0x4F08:
INCBIN "baserom.gbc", $4F08, $4F0A - $4F08

LoggedData_0x4F0A:
INCBIN "baserom.gbc", $4F0A, $4F10 - $4F0A

UnknownData_0x4F10:
INCBIN "baserom.gbc", $4F10, $4F12 - $4F10

LoggedData_0x4F12:
INCBIN "baserom.gbc", $4F12, $4F18 - $4F12

UnknownData_0x4F18:
INCBIN "baserom.gbc", $4F18, $4F1A - $4F18

LoggedData_0x4F1A:
INCBIN "baserom.gbc", $4F1A, $4F20 - $4F1A

UnknownData_0x4F20:
INCBIN "baserom.gbc", $4F20, $4F22 - $4F20

LoggedData_0x4F22:
INCBIN "baserom.gbc", $4F22, $4F28 - $4F22

UnknownData_0x4F28:
INCBIN "baserom.gbc", $4F28, $4F2A - $4F28

LoggedData_0x4F2A:
INCBIN "baserom.gbc", $4F2A, $4F30 - $4F2A

UnknownData_0x4F30:
INCBIN "baserom.gbc", $4F30, $4F32 - $4F30

LoggedData_0x4F32:
INCBIN "baserom.gbc", $4F32, $4F38 - $4F32

UnknownData_0x4F38:
INCBIN "baserom.gbc", $4F38, $4F3A - $4F38

LoggedData_0x4F3A:
INCBIN "baserom.gbc", $4F3A, $4F40 - $4F3A

UnknownData_0x4F40:
INCBIN "baserom.gbc", $4F40, $4F42 - $4F40

LoggedData_0x4F42:
INCBIN "baserom.gbc", $4F42, $4F48 - $4F42

UnknownData_0x4F48:
INCBIN "baserom.gbc", $4F48, $4F4A - $4F48

LoggedData_0x4F4A:
INCBIN "baserom.gbc", $4F4A, $4F50 - $4F4A

UnknownData_0x4F50:
INCBIN "baserom.gbc", $4F50, $4F52 - $4F50

LoggedData_0x4F52:
INCBIN "baserom.gbc", $4F52, $4F58 - $4F52

UnknownData_0x4F58:
INCBIN "baserom.gbc", $4F58, $4F5A - $4F58

LoggedData_0x4F5A:
INCBIN "baserom.gbc", $4F5A, $4F60 - $4F5A

UnknownData_0x4F60:
INCBIN "baserom.gbc", $4F60, $4F62 - $4F60

LoggedData_0x4F62:
INCBIN "baserom.gbc", $4F62, $4F68 - $4F62

UnknownData_0x4F68:
INCBIN "baserom.gbc", $4F68, $4F6A - $4F68

LoggedData_0x4F6A:
INCBIN "baserom.gbc", $4F6A, $4F70 - $4F6A

UnknownData_0x4F70:
INCBIN "baserom.gbc", $4F70, $4F72 - $4F70

LoggedData_0x4F72:
INCBIN "baserom.gbc", $4F72, $4F78 - $4F72

UnknownData_0x4F78:
INCBIN "baserom.gbc", $4F78, $4F7A - $4F78

LoggedData_0x4F7A:
INCBIN "baserom.gbc", $4F7A, $4F80 - $4F7A

UnknownData_0x4F80:
INCBIN "baserom.gbc", $4F80, $4F82 - $4F80

LoggedData_0x4F82:
INCBIN "baserom.gbc", $4F82, $6B63 - $4F82

UnknownData_0x6B63:
INCBIN "baserom.gbc", $6B63, $6B6B - $6B63

LoggedData_0x6B6B:
INCBIN "baserom.gbc", $6B6B, $6BBF - $6B6B

UnknownData_0x6BBF:
INCBIN "baserom.gbc", $6BBF, $6C93 - $6BBF

LoggedData_0x6C93:
INCBIN "baserom.gbc", $6C93, $6CE8 - $6C93

UnknownData_0x6CE8:
INCBIN "baserom.gbc", $6CE8, $6CE9 - $6CE8

LoggedData_0x6CE9:
INCBIN "baserom.gbc", $6CE9, $6CEB - $6CE9

UnknownData_0x6CEB:
INCBIN "baserom.gbc", $6CEB, $6D18 - $6CEB

LoggedData_0x6D18:
INCBIN "baserom.gbc", $6D18, $6D1A - $6D18

UnknownData_0x6D1A:
INCBIN "baserom.gbc", $6D1A, $6D1B - $6D1A

LoggedData_0x6D1B:
INCBIN "baserom.gbc", $6D1B, $6D1D - $6D1B

UnknownData_0x6D1D:
INCBIN "baserom.gbc", $6D1D, $6D1E - $6D1D

LoggedData_0x6D1E:
INCBIN "baserom.gbc", $6D1E, $6D20 - $6D1E

UnknownData_0x6D20:
INCBIN "baserom.gbc", $6D20, $6D21 - $6D20

LoggedData_0x6D21:
INCBIN "baserom.gbc", $6D21, $6D45 - $6D21

UnknownData_0x6D45:
INCBIN "baserom.gbc", $6D45, $6D4B - $6D45

LoggedData_0x6D4B:
INCBIN "baserom.gbc", $6D4B, $6F9D - $6D4B

UnknownData_0x6F9D:
INCBIN "baserom.gbc", $6F9D, $6FDC - $6F9D

LoggedData_0x6FDC:
INCBIN "baserom.gbc", $6FDC, $7174 - $6FDC

UnknownData_0x7174:
INCBIN "baserom.gbc", $7174, $717B - $7174

LoggedData_0x717B:
INCBIN "baserom.gbc", $717B, $71A3 - $717B

UnknownData_0x71A3:
INCBIN "baserom.gbc", $71A3, $71A4 - $71A3

LoggedData_0x71A4:
INCBIN "baserom.gbc", $71A4, $71A6 - $71A4

UnknownData_0x71A6:
INCBIN "baserom.gbc", $71A6, $71A7 - $71A6

LoggedData_0x71A7:
INCBIN "baserom.gbc", $71A7, $71F0 - $71A7

UnknownData_0x71F0:
INCBIN "baserom.gbc", $71F0, $73E6 - $71F0

LoggedData_0x73E6:
INCBIN "baserom.gbc", $73E6, $76D7 - $73E6

UnknownData_0x76D7:
INCBIN "baserom.gbc", $76D7, $8000 - $76D7

SECTION "Bank02", ROMX, BANK[$02]
	ld a,[$C09C]
	rst JumpList
	dw Logged_0x047B
	dw Logged_0x8024
	dw Logged_0x05ED
	dw Logged_0x80AA
	dw Logged_0x0928
	dw Logged_0x047B
	dw Logged_0x846E
	dw Logged_0x861C
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D
	dw Unknown_0x028D

Logged_0x8024:
	call Logged_0x08E6
	call Logged_0x038F
	call Logged_0x037D
	call Logged_0x12C3
	xor a
	ld [$FF00+$42],a
	ld [$C083],a
	ld [$FF00+$43],a
	ld [$C085],a
	ld a,$03
	ld [$FF00+$85],a
	ld a,$E2
	ld [$FF00+$8D],a
	ld a,$51
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x8747
	call Logged_0x161A
	ld a,$01
	ld [$CED8],a
	xor a
	ld [$CEEF],a
	ld a,[$C08E]
	push af
	ld a,$00
	ld [$C08E],a
	ld [$4100],a
	xor a
	ld hl,$A000
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$A800
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	pop af
	ld [$C08E],a
	ld [$4100],a
	ld hl,$C09C
	inc [hl]
	ld a,[$CA06]
	cp $C8
	jr z,Logged_0x808B
	ld a,$87
	ld [$FF00+$40],a
	ret

Logged_0x808B:
	ld a,$36
	ld [$FF00+$85],a
	ld a,$1E
	ld [$FF00+$8D],a
	ld a,$74
	ld [$FF00+$8E],a
	call $FF80
	ld a,$88
	ld [$C08D],a
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	ld a,$E7
	ld [$FF00+$40],a
	ret

Logged_0x80AA:
	ld a,$01
	ld [$CED9],a
	ld a,$03
	ld [$FF00+$85],a
	ld a,$26
	ld [$FF00+$8D],a
	ld a,$4A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0BA]
	and $0F
	cp $01
	jp z,Logged_0x8331
	cp $00
	jp z,Logged_0x83D1
	ld a,[$C1AA]
	and a
	jr nz,Logged_0x80E7
	ld a,$01
	ld [$C0DA],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80

Logged_0x80E7:
	ld a,[$C0BA]
	cp $3C
	jr z,Logged_0x80FC
	ld a,[$CAC5]
	ld [$C083],a
	ld a,[$CAC7]
	ld [$C085],a
	jr Logged_0x8112

Logged_0x80FC:
	ld hl,$C0BC
	ld a,[$C089]
	add a,[hl]
	ld [$C083],a
	ld a,[$C08B]
	ld [$C085],a
	ld a,[$C08D]
	add a,[hl]
	ld [$FF00+$4A],a

Logged_0x8112:
	xor a
	ld [$C0DA],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$48
	ld [$FF00+$8D],a
	ld a,$53
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0xB8D3
	ld a,[$CA06]
	cp $C8
	jr nz,Logged_0x814F
	ld a,[$CA9B]
	cp $02
	jr nz,Logged_0x814F
	ld a,$06
	ld [$FF00+$85],a
	ld a,$9A
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80

Logged_0x814F:
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$01
	ld [$C0DA],a
	ld a,$08
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	xor a
	ld [$C0DA],a
	pop af
	ld [$FF00+$70],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$4E
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0x0D9E
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$D7
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0x03B9
	ld a,[$C1AA]
	and $0C
	jr z,Logged_0x8215
	ld a,[$C1A0]
	and a
	jr nz,Logged_0x8215
	xor a
	ld [$C0C2],a
	ld a,[$CA87]
	ld [$CA5E],a
	ld a,[$C1AA]
	bit 3,a
	jr nz,Logged_0x81E4
	ld b,$04
	ld a,[$C0C2]
	sub b
	ld [$C0C2],a
	ld a,[$C1A9]
	sub b
	ld [$C1A9],a
	jr nz,Logged_0x8209
	ld hl,$C1AA
	res 2,[hl]
	xor a
	ld [$CA73],a
	jr Logged_0x8209

Logged_0x81E4:
	ld b,$04
	ld a,[$C0C2]
	add a,b
	ld [$C0C2],a
	ld a,[$C1A9]
	sub b
	ld [$C1A9],a
	jr z,Logged_0x8200
	ld a,[$C0BD]
	dec a
	jr nz,Logged_0x8209
	xor a
	ld [$C1A9],a

Logged_0x8200:
	ld hl,$C1AA
	res 3,[hl]
	xor a
	ld [$CA73],a

Logged_0x8209:
	xor a
	ld [$C0BE],a
	ld [$C0BD],a
	call Logged_0xB915
	jr Logged_0x8229

Logged_0x8215:
	ld a,[$C0BA]
	cp $3C
	jr z,Logged_0x8227
	and $0F
	cp $0C
	jr z,Logged_0x8229
	call Logged_0xB9A6
	jr Logged_0x8229

Logged_0x8227:
	jr Logged_0x8247

Logged_0x8229:
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	call Logged_0x8ED9
	call Logged_0xBB85
	di
	call Logged_0xB681
	ei
	pop af
	ld [$C08E],a
	ld [$4100],a

Logged_0x8247:
	ld a,[$C09B]
	cp $02
	ret nz
	ld hl,$CED4
	ld a,[hl]
	and a
	jr z,Logged_0x82C6
	bit 7,a
	ret nz
	ld a,$01
	ld [$C09A],a
	xor a
	ld [$CA97],a
	ld [$C0BC],a
	ld [$C1AC],a
	ld [$C1B1],a
	ld [$CED8],a
	ld [$CED9],a
	ld [$CEE0],a
	ld [$CEE1],a
	ld [$CEE2],a
	ld [$CA9C],a
	ld hl,$CA3D
	ld a,[$CED4]
	cp $06
	jr z,Logged_0x829D
	cp $07
	jr z,Logged_0x82A4
	ld hl,$C09B
	inc [hl]
	xor a
	ld [$C09C],a
	ld a,[$CA3D]
	bit 1,a
	ret z
	ld a,$04
	ld [$C09C],a
	ret

Logged_0x829D:
	ld a,$F3
	ld [$CEE3],a
	jr Logged_0x82BA

Logged_0x82A4:
	ld a,[$CA39]
	dec a
	jr z,Unknown_0x82B1
	ld a,$F1
	ld [$CEE3],a
	jr Logged_0x82B8

Unknown_0x82B1:
	ld a,$F2
	ld [$CEE3],a
	set 1,[hl]

Logged_0x82B8:
	set 0,[hl]

Logged_0x82BA:
	set 2,[hl]
	ld hl,$C09B
	ld [hl],$06
	xor a
	ld [$C09C],a
	ret

Logged_0x82C6:
	ld a,[$CEDA]
	and a
	jr z,Logged_0x82D8
	ld a,[$C09C]
	ld [$CED5],a
	ld a,$07
	ld [$C09C],a
	ret

Logged_0x82D8:
	call Logged_0xBD3C
	ld a,[$C1AA]
	and a
	ret nz
	ld a,[$C0D7]
	and a
	ret nz
	ld a,[$C094]
	and $0C
	ret z
	ld a,[$CA8E]
	cp $53
	jr z,Unknown_0x82FF
	ld a,[$C0E6]
	and a
	jr nz,Unknown_0x82FF
	ld a,[$CA8E]
	cp $53
	jr nz,Logged_0x8308

Unknown_0x82FF:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E5
	ld [$FF00+$B6],a
	ret

Logged_0x8308:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E4
	ld [$FF00+$B6],a
	ld a,$FF
	ld [$FF00+$B1],a
	ld a,$00
	ld [$FF00+$B2],a
	xor a
	ld [$CED9],a
	ld a,$01
	ld [$CED6],a
	ld a,[$C09C]
	ld [$CED5],a
	ld a,$04
	ld [$C09B],a
	xor a
	ld [$C09C],a
	ret

Logged_0x8331:
	ld a,$01
	ld [$C0DA],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CAC5]
	ld [$C083],a
	ld a,[$CAC7]
	ld [$C085],a
	xor a
	ld [$C0DA],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$48
	ld [$FF00+$8D],a
	ld a,$53
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0xB8D3
	ld a,$01
	ld [$C0DA],a
	ld a,$08
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	xor a
	ld [$C0DA],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$4E
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0x0D9E
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$D7
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0x03B9
	xor a
	ld [$C0BE],a
	ld [$C0BD],a
	call Logged_0xB915
	call Logged_0xB9A6
	jp Logged_0x8229

Logged_0x83D1:
	ld a,$01
	ld [$C0DA],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CAC5]
	ld [$C083],a
	ld a,[$CAC7]
	ld [$C085],a
	xor a
	ld [$C0DA],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$48
	ld [$FF00+$8D],a
	ld a,$53
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0xB8D3
	ld a,$01
	ld [$C0DA],a
	ld a,$08
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	xor a
	ld [$C0DA],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$4E
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0x0D9E
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$D7
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0x03B9
	xor a
	ld [$C0BE],a
	ld [$C0BD],a
	call Logged_0xB915
	jp Logged_0x8229

Logged_0x846E:
	ld a,[$C0D7]
	and $0F
	cp $03
	jr nz,Logged_0x849D
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[$C1AC]
	ld [$D50F],a
	ld a,[$C1AD]
	ld [$D510],a
	pop af
	ld [$FF00+$70],a
	ld a,[$C09C]
	ld [$CED5],a
	ld hl,$C09B
	ld [hl],$05
	xor a
	ld [$C09C],a
	ret

Logged_0x849D:
	call Logged_0x08E6
	ld a,$19
	ld [$FF00+$85],a
	ld a,$87
	ld [$FF00+$8D],a
	ld a,$41
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$2A
	ld [$FF00+$8D],a
	ld a,$5F
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ld a,$00
	ld [$C08E],a
	ld [$4100],a
	ld a,[$C0D7]
	and $0F
	cp $07
	jr nz,Logged_0x84E2
	ld a,$01
	ld [$CA61],a
	xor a
	ld [$CA63],a

Logged_0x84E2:
	ld a,[$CA62]
	sub $10
	ld [$CA62],a
	ld a,[$CA61]
	sbc a,$00
	ld [$CA61],a
	ld b,a
	swap b
	ld a,[$CA63]
	or b
	ld [$CA6C],a
	ld hl,$CA61
	call Logged_0x8EC2
	xor a
	ld [$C1AA],a
	ld [$C1A9],a
	ld [$C0C2],a
	ld [$C0C3],a
	ld [$C0BE],a
	ld [$C0BD],a
	ld [$CA97],a
	ld [$C0BC],a
	ld a,[$C0A0]
	ld [$CA5D],a
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x285C
	pop af
	ld [$FF00+$70],a
	call Logged_0x038F
	call Logged_0x037D
	call Logged_0x12C3
	call Logged_0x8A41
	call Logged_0x8AD9
	call Logged_0x8C12
	ld a,[$C0D7]
	bit 6,a
	jr z,Logged_0x854A
	call Logged_0x0EDB

Logged_0x854A:
	xor a
	ld [$C0D7],a
	call Logged_0xBC5E
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	call Logged_0x8CD7
	pop af
	ld [$C08E],a
	ld [$4100],a
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	call Logged_0x896F
	pop af
	ld [$C08E],a
	ld [$4100],a
	call Logged_0xB8D3
	ld a,[$CA83]
	cp $2C
	jr nz,Logged_0x85A7
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$4D
	ld [$CA81],a
	ld a,$18
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x85A7:
	call Logged_0x161A
	xor a
	ld [$C0DA],a
	ld [$CA73],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$48
	ld [$FF00+$8D],a
	ld a,$53
	ld [$FF00+$8E],a
	call $FF80
	ld a,$18
	ld [$FF00+$85],a
	ld a,$48
	ld [$FF00+$8D],a
	ld a,$53
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$4E
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0x0D9E
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$D7
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	xor a
	ld [$CA8A],a
	ld a,$02
	ld [$C09C],a
	ld a,$87
	ld [$FF00+$40],a
	ret

Logged_0x861C:
	call Logged_0x867F
	ld a,$03
	ld [$FF00+$85],a
	ld a,$26
	ld [$FF00+$8D],a
	ld a,$4A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$4E
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0x0D9E
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$D7
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0x03B9
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	di
	call Logged_0xB681
	ei
	pop af
	ld [$C08E],a
	ld [$4100],a
	ret

Logged_0x867F:
	ld a,[$CEDA]
	and $0F
	add a,$10
	ld [$CEDA],a
	and $08
	ld [$CEDE],a

Logged_0x868E:
	ld a,[$CEDA]
	and $07
	dec a
	jr z,Logged_0x86C1
	dec a
	jr z,Logged_0x86D8
	dec a
	jr z,Logged_0x86EF
	ld a,[$CEDC]
	inc a
	ld h,a
	ld [$CCEA],a
	cp $C0
	ld a,[$CEDB]
	jr nz,Logged_0x86B5
	ld a,$A0
	ld h,a
	ld [$CCEA],a
	ld a,[$CEDB]
	inc a

Logged_0x86B5:
	ld [$CCE9],a
	ld a,[$CEDD]
	ld l,a
	ld [$CCEB],a
	jr Logged_0x8712

Logged_0x86C1:
	ld a,[$CEDB]
	ld [$CCE9],a
	ld a,[$CEDC]
	ld h,a
	ld [$CCEA],a
	ld a,[$CEDD]
	inc a
	ld l,a
	ld [$CCEB],a
	jr Logged_0x8712

Logged_0x86D8:
	ld a,[$CEDB]
	ld [$CCE9],a
	ld a,[$CEDD]
	dec a
	ld l,a
	ld [$CCEB],a
	ld a,[$CEDC]
	ld h,a
	ld [$CCEA],a
	jr Logged_0x8712

Logged_0x86EF:
	ld a,[$CEDC]
	dec a
	ld h,a
	ld [$CCEA],a
	cp $9F
	ld a,[$CEDB]
	jr nz,Logged_0x8708
	ld a,$BF
	ld h,a
	ld [$CCEA],a
	ld a,[$CEDB]
	dec a

Logged_0x8708:
	ld [$CCE9],a
	ld a,[$CEDD]
	ld l,a
	ld [$CCEB],a

Logged_0x8712:
	ld a,[$CEDA]
	and $F8
	ld [$CEDA],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CEDA]
	and $07
	jr nz,Logged_0x8733
	jp Logged_0x8739

Logged_0x8733:
	call Logged_0xBB85
	jp Logged_0x868E

Logged_0x8739:
	xor a
	ld [$CEDA],a
	ld [$CA73],a
	ld a,[$CED5]
	ld [$C09C],a
	ret

Logged_0x8747:
	xor a
	ld [$C0E6],a
	ld a,[$CEEF]
	and $3C
	jp nz,Logged_0x87E2
	xor a
	ld [$C0A0],a
	ld [$CA6C],a
	ld [$CA5D],a
	xor a
	ld [$CED4],a
	ld [$CA5C],a
	ld [$C1AA],a
	ld [$C1A9],a
	ld [$C0C2],a
	ld [$C0C3],a
	ld [$C0BE],a
	ld [$C0BD],a
	ld [$CA8A],a
	ld [$CA8C],a
	ld [$CAC1],a
	ld [$CA9D],a
	ld [$CA99],a
	ld [$CA66],a
	ld [$CA6A],a
	ld [$C0E2],a
	ld [$C0E3],a
	ld [$C0E4],a
	ld [$CAC3],a
	ld [$CA6D],a
	ld [$CA6E],a
	call Logged_0x1079
	ld [$CA8D],a
	ld [$CAC8],a
	ld [$CAC9],a
	ld [$CA97],a
	ld [$C0BC],a
	ld [$CA9C],a
	ld [$C1AC],a
	ld [$C1B1],a
	ld [$CED8],a
	ld [$CED9],a
	ld [$CEE0],a
	ld [$CEE1],a
	ld [$CEE2],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$10
	ld [$FF00+$8D],a
	ld a,$5F
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	jr Logged_0x87EB

Logged_0x87E2:
	ld a,[$CA5D]
	ld [$C0A0],a
	call Logged_0x15B0

Logged_0x87EB:
	call Logged_0x0E8A
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	call Logged_0x285C
	pop af
	ld [$FF00+$70],a
	ld a,[$CEEF]
	and $3C
	jr nz,Logged_0x883A
	call Logged_0x8A41
	ld a,$01
	ld [$CA69],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$4800
	ld a,h
	ld [$CA79],a
	ld a,l
	ld [$CA7A],a
	ld de,$C040
	ld b,$10
	ld a,$03
	ld [$FF00+$85],a
	ld a,$2D
	ld [$FF00+$8D],a
	ld a,$1A
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x8861

Logged_0x883A:
	ld a,[$CA79]
	ld h,a
	ld a,[$CA7A]
	ld l,a
	ld de,$C040
	ld b,$10
	ld a,$03
	ld [$FF00+$85],a
	ld a,$2D
	ld [$FF00+$8D],a
	ld a,$1A
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CAA1
	ld de,$C060
	ld b,$20
	call Logged_0x0466

Logged_0x8861:
	ld hl,$51FE
	ld de,$C050
	ld b,$08
	ld a,$03
	ld [$FF00+$85],a
	ld a,$2D
	ld [$FF00+$8D],a
	ld a,$1A
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x8AD9
	call Logged_0x8C12
	call Logged_0xB672
	call Logged_0xB681
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	call Logged_0x8CD7
	pop af
	ld [$C08E],a
	ld [$4100],a
	ld a,[$CEEF]
	and $3C
	jr nz,Logged_0x88B7
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	call Logged_0x896F
	pop af
	ld [$C08E],a
	ld [$4100],a

Logged_0x88B7:
	ld a,[$CA06]
	cp $C8
	jr nz,Logged_0x88DB
	xor a
	ld a,[$CAC5]
	ld [$C08A],a
	ld [$C089],a
	ld [$C083],a
	ld [$FF00+$42],a
	ld a,[$CAC7]
	ld [$C08C],a
	ld [$C08B],a
	ld [$C085],a
	ld [$FF00+$43],a

Logged_0x88DB:
	call Logged_0xB8D3
	xor a
	ld [$C0DA],a
	ld a,[$CEEF]
	and $3C
	jr nz,Logged_0x8917
	xor a
	ld [$CA73],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$48
	ld [$FF00+$8D],a
	ld a,$53
	ld [$FF00+$8E],a
	call $FF80
	ld a,$18
	ld [$FF00+$85],a
	ld a,$48
	ld [$FF00+$8D],a
	ld a,$53
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	jr Logged_0x8935

Logged_0x8917:
	ld a,$01
	ld [$CA73],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$48
	ld [$FF00+$8D],a
	ld a,$53
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a

Logged_0x8935:
	xor a
	ld [$CA73],a
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$4E
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	call Logged_0x0D9E
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$18
	ld [$FF00+$85],a
	ld a,$D7
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x896F:
	ld de,$C0A6
	ld hl,$FFAB
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hl],a
	call Logged_0x0CC0
	ld c,$01
	ld a,[$CCED]
	cp $C0
	jr c,Logged_0x8996
	inc c
	sub $20
	cp $C0
	jr c,Logged_0x8996
	inc c
	sub $20

Logged_0x8996:
	ld h,a
	ld a,c
	ld [$CCEC],a
	ld [$C08E],a
	ld [$4100],a
	ld a,$01
	ld [$CCEF],a
	ld b,a
	ld d,$10

Logged_0x89A9:
	ld e,$08

Logged_0x89AB:
	ld a,[hl]
	and $F0
	swap a
	call nz,Logged_0x89E2
	ld a,b
	xor $01
	ld b,a
	ld a,[hl]
	and $0F
	call nz,Logged_0x89E2
	inc l
	ld a,b
	xor $01
	ld b,a
	dec e
	jr nz,Logged_0x89AB
	ld a,l
	sub $08
	ld l,a
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x89DE
	ld h,$A0
	ld a,[$CCEC]
	inc a
	ld [$CCEC],a
	ld [$C08E],a
	ld [$4100],a

Logged_0x89DE:
	dec d
	jr nz,Logged_0x89A9
	ret

Logged_0x89E2:
	cp $0F
	ret nc
	ld c,a
	ld a,[$C0C7]
	dec a
	cp l
	ret c
	ld a,[$C0C6]
	cp l
	jr z,Logged_0x89F3
	ret nc

Logged_0x89F3:
	ld a,[$CCEC]
	dec a
	jr nz,Logged_0x8A08
	ld a,[$C0C4]
	dec a
	cp h
	ret c
	ld a,[$C0C5]
	cp h
	jr z,Logged_0x8A19
	ret nc
	jr Logged_0x8A19

Logged_0x8A08:
	ld a,[$C0C4]
	sub $20
	dec a
	cp h
	ret c
	ld a,[$C0C5]
	sub $20
	cp h
	jr z,Logged_0x8A19
	ret nc

Logged_0x8A19:
	push de
	push bc
	call Logged_0x0CF8
	push hl
	call Logged_0x0D81
	ld d,h
	ld e,l
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$19
	ld [$FF00+$85],a
	ld a,$E5
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	pop hl
	pop bc
	pop de
	ret

Logged_0x8A41:
	ld hl,$FFAB
	xor a
	ld [hld],a
	ld a,[$C0A1]
	and $0F
	ld [hld],a
	xor a
	ld [hld],a
	ld a,[$C0A1]
	and $F0
	swap a
	ld [hl],a
	call Logged_0x0CC0
	ld c,$01
	ld a,[$CCED]
	cp $C0
	jr c,Logged_0x8A6C
	inc c
	sub $20
	cp $C0
	jr c,Logged_0x8A6C
	inc c
	sub $20

Logged_0x8A6C:
	ld h,a
	ld a,c
	ld [$CCEC],a
	ld [$C08E],a
	ld [$4100],a

Logged_0x8A77:
	ld e,$08

Logged_0x8A79:
	ld a,[hl]
	and $F0
	swap a
	cp $0F
	jr nc,Logged_0x8AB0
	ld a,b
	xor $01
	ld b,a
	ld a,[hl]
	and $0F
	cp $0F
	jr nc,Logged_0x8AB0
	inc l
	ld a,b
	xor $01
	ld b,a
	dec e
	jr nz,Logged_0x8A79
	ld a,l
	sub $08
	ld l,a
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x8A77
	ld h,$A0
	ld a,[$CCEC]
	inc a
	ld [$CCEC],a
	ld [$C08E],a
	ld [$4100],a
	jr Logged_0x8A77

Logged_0x8AB0:
	ld c,a
	call Logged_0x0CF8
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x8AD8
	ld a,[$CEEF]
	and $3C
	jr nz,Logged_0x8AD8
	call Logged_0x1146

Logged_0x8AD8:
	ret

Logged_0x8AD9:
	xor a
	ld [$C0B5],a
	ld a,[$C0BA]
	and $0F
	cp $0C
	jr z,Logged_0x8AEA
	cp $00
	jr nz,Logged_0x8AF7

Logged_0x8AEA:
	ld a,[$CA63]
	ld [$CAC6],a
	ld a,$30
	ld [$CAC7],a
	jr Logged_0x8B69

Logged_0x8AF7:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x8B05
	ld a,[$CA60]
	sub $08
	ld b,a
	jr Logged_0x8B0B

Logged_0x8B05:
	ld a,[$CA5F]
	sub $08
	ld b,a

Logged_0x8B0B:
	ld a,[$CA64]
	sub b
	ld [$CAC7],a
	ld l,a
	ld a,[$CA63]
	sbc a,$00
	ld [$CAC6],a
	ld h,a
	ld a,[$C0BA]
	bit 5,a
	jr z,Logged_0x8B27
	ld de,$FFE0
	add hl,de

Logged_0x8B27:
	ld a,[$C0B8]
	ld b,a
	ld a,h
	bit 7,a
	jr nz,Logged_0x8B39
	cp b
	jr c,Logged_0x8B39
	jr nz,Logged_0x8B44
	ld a,l
	and a
	jr nz,Logged_0x8B44

Logged_0x8B39:
	ld a,b
	ld [$CAC6],a
	ld a,$01
	ld [$C0B5],a
	jr Logged_0x8B69

Logged_0x8B44:
	ld hl,$CAC6
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld de,$00A0
	ld a,[$C0BA]
	bit 4,a
	jr z,Logged_0x8B56
	ld e,$C0

Logged_0x8B56:
	add hl,de
	ld a,[$C0B9]
	ld b,a
	ld a,h
	cp b
	jr c,Logged_0x8B69
	ld a,b
	dec a
	ld [$CAC6],a
	ld a,$FF
	ld [$C0B5],a

Logged_0x8B69:
	ld a,[$CEEF]
	and $3C
	jr z,Logged_0x8B78
	ld a,[$C0BA]
	and $0F
	cp $08
	ret nc

Logged_0x8B78:
	xor a
	ld [$CAC8],a
	ld a,[$CA62]
	sub $60
	ld [$CAC5],a
	ld l,a
	ld a,[$CA61]
	sbc a,$00
	ld [$CAC4],a
	ld h,a
	ld a,[$C0BA]
	bit 6,a
	jr z,Logged_0x8B99
	ld de,$FFE0
	add hl,de

Logged_0x8B99:
	ld a,[$C0B7]
	ld b,a
	ld a,h
	bit 7,a
	jr nz,Logged_0x8BAB
	cp b
	jr c,Logged_0x8BAB
	jr nz,Logged_0x8BB5
	ld a,l
	and a
	jr nz,Logged_0x8BB5

Logged_0x8BAB:
	ld a,b
	ld [$CAC4],a
	ld a,$01
	ld [$CAC8],a
	ret

Logged_0x8BB5:
	ld hl,$CAC4
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld de,$0090
	ld a,[$C0BA]
	bit 7,a
	jr z,Logged_0x8BC7
	ld e,$B0

Logged_0x8BC7:
	add hl,de
	ld a,[$C0B6]
	ld b,a
	ld a,h
	cp b
	jr c,Logged_0x8BDB
	ld a,b
	dec a
	ld [$CAC4],a
	ld a,$FF
	ld [$CAC8],a
	ret

Logged_0x8BDB:
	ld a,[$C0BA]
	and $0F
	cp $08
	ret c
	ld a,[$CA62]
	cp $80
	jr nc,Logged_0x8C0C
	ld a,[$C0B7]
	ld b,a
	ld a,[$CA61]
	dec a
	ld [$CAC4],a
	cp b
	jr c,Logged_0x8BAB
	bit 7,a
	jr z,Logged_0x8C06
	xor a
	ld [$CAC4],a
	ld a,$01
	ld [$CAC8],a
	ret

Logged_0x8C06:
	ld a,$E8
	ld [$CAC5],a
	ret

Logged_0x8C0C:
	ld a,$68
	ld [$CAC5],a
	ret

Logged_0x8C12:
	ld a,[$CAC4]
	ld h,a
	ld a,[$CAC5]
	ld l,a
	ld a,[$CAC8]
	cp $01
	jr z,Logged_0x8C38
	cp $FF
	jr z,Logged_0x8C54
	ld a,l
	ld [$FF00+$42],a
	ld [$C083],a
	sub $18
	ld [$C0A4],a
	ld a,h
	sbc a,$00
	ld [$C0A3],a
	jr Logged_0x8C70

Logged_0x8C38:
	ld a,[$C0BA]
	bit 6,a
	ld a,$00
	jr z,Logged_0x8C43
	ld a,$20

Logged_0x8C43:
	ld [$CAC5],a
	ld [$FF00+$42],a
	ld [$C083],a
	ld [$C0A4],a
	ld a,h
	ld [$C0A3],a
	jr Logged_0x8C70

Logged_0x8C54:
	ld a,[$C0BA]
	bit 7,a
	ld a,$68
	jr z,Logged_0x8C5F
	ld a,$48

Logged_0x8C5F:
	ld [$CAC5],a
	ld [$FF00+$42],a
	ld [$C083],a
	sub $20
	ld [$C0A4],a
	ld a,h
	ld [$C0A3],a

Logged_0x8C70:
	ld a,[$CAC6]
	ld h,a
	ld a,[$CAC7]
	ld l,a
	ld a,[$C0B5]
	cp $01
	jr z,Logged_0x8C9F
	cp $FF
	jr z,Logged_0x8CBA
	ld a,l
	ld [$FF00+$43],a
	ld [$C085],a
	sub $10
	ld [$C0A6],a
	ld a,h
	sbc a,$00
	ld [$C0A5],a
	bit 7,a
	ret z
	xor a
	ld [$C0A6],a
	ld [$C0A5],a
	ret

Logged_0x8C9F:
	ld a,[$C0BA]
	bit 5,a
	ld a,$00
	jr z,Logged_0x8CAA
	ld a,$20

Logged_0x8CAA:
	ld [$CAC7],a
	ld [$FF00+$43],a
	ld [$C085],a
	ld [$C0A6],a
	ld a,h
	ld [$C0A5],a
	ret

Logged_0x8CBA:
	ld a,[$C0BA]
	bit 4,a
	ld a,$60
	jr z,Logged_0x8CC5
	ld a,$40

Logged_0x8CC5:
	ld [$CAC7],a
	ld [$FF00+$43],a
	ld [$C085],a
	sub $28
	ld [$C0A6],a
	ld a,h
	ld [$C0A5],a
	ret

Logged_0x8CD7:
	ld hl,$C0A3
	ld de,$C0A7
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$20
	ld [$C0A2],a

Logged_0x8CED:
	call Logged_0x8D69
	ld a,[$CCF0]
	ld d,a
	ld a,[$CCF1]
	ld e,a
	ld hl,$CE01
	ld b,$20

Logged_0x8CFD:
	ld a,[hli]
	ld [de],a
	ld a,e
	add a,$20
	ld e,a
	ld a,d
	adc a,$00
	ld d,a
	cp $9C
	jr nz,Logged_0x8D0D
	ld d,$98

Logged_0x8D0D:
	dec b
	jr nz,Logged_0x8CFD
	ld a,$01
	ld [$FF00+$4F],a
	ld a,[$CCF0]
	ld d,a
	ld a,[$CCF1]
	ld e,a
	ld hl,$CE35
	ld b,$20

Logged_0x8D21:
	ld a,[hli]
	ld [de],a
	ld a,e
	add a,$20
	ld e,a
	ld a,d
	adc a,$00
	ld d,a
	cp $9C
	jr nz,Logged_0x8D31
	ld d,$98

Logged_0x8D31:
	dec b
	jr nz,Logged_0x8D21
	xor a
	ld [$FF00+$4F],a
	xor a
	ld [$CE69],a
	ld [$CE00],a
	ld a,[$C0A6]
	add a,$08
	ld [$C0A6],a
	ld a,[$C0A5]
	adc a,$00
	ld [$C0A5],a
	ld a,[$C0A2]
	dec a
	ld [$C0A2],a
	jr nz,Logged_0x8CED
	ld hl,$C0A7
	ld de,$C0A3
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x8D69:
	call Logged_0x8E5B
	ld a,[$CE69]
	ld b,a
	ld de,$CE6A
	ld a,e
	add a,b
	ld e,a
	ld b,$20

Logged_0x8D78:
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	dec b
	jr nz,Logged_0x8D78
	ld a,[$CE69]
	add a,$40
	ld [$CE69],a
	ld hl,$C0A3
	call Logged_0x0BDB
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	ld a,[$C0A6]
	and $08
	jr z,Logged_0x8DD4
	push hl
	ld a,$08
	ld [$FF00+$85],a
	ld a,$51
	ld [$FF00+$8D],a
	ld a,$5F
	ld [$FF00+$8E],a
	call $FF80
	pop hl
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	ld a,$08
	ld [$FF00+$85],a
	ld a,$12
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x8DFD

Logged_0x8DD4:
	push hl
	ld a,$08
	ld [$FF00+$85],a
	ld a,$FC
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	pop hl
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	ld a,$08
	ld [$FF00+$85],a
	ld a,$BB
	ld [$FF00+$8D],a
	ld a,$61
	ld [$FF00+$8E],a
	call $FF80

Logged_0x8DFD:
	ld a,[$CE00]
	add a,$20
	ld [$CE00],a
	ret
	ld a,[$CA62]
	sub $18
	ld l,a
	ld a,[$CA61]
	sbc a,$00
	ld h,a
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	ld a,h
	and $03
	ld d,a
	ld e,l
	ld a,[$CA63]
	ld h,a
	ld a,[$CA64]
	ld l,a
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	ld a,l
	and $1F
	ld l,a
	ld h,$98
	add hl,de
	ld a,h
	ld [$CCF0],a
	ld a,l
	ld [$CCF1],a
	ret

Logged_0x8E5B:
	ld a,[$C0A3]
	ld h,a
	ld a,[$C0A4]
	ld l,a
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	ld a,h
	and $03
	ld d,a
	ld e,l
	ld a,[$C0A5]
	ld h,a
	ld a,[$C0A6]
	ld l,a
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	ld a,l
	and $1F
	ld l,a
	ld h,$98
	add hl,de
	ld a,h
	ld [$CCF0],a
	ld a,l
	ld [$CCF1],a
	ret

UnknownData_0x8EAC:
INCBIN "baserom.gbc", $8EAC, $8EC2 - $8EAC

Logged_0x8EC2:
	ld a,[hli]
	and a
	jr z,Logged_0x8ED3
	ld b,a
	inc hl
	ld a,[hl]
	ld c,$0A

Logged_0x8ECB:
	add a,c
	dec b
	jr nz,Logged_0x8ECB
	ld [$C0A0],a
	ret

Logged_0x8ED3:
	inc hl
	ld a,[hl]
	ld [$C0A0],a
	ret

Logged_0x8ED9:
	ld a,[$C0BB]
	and a
	ret z
	ld b,a
	and $03
	jr nz,Logged_0x8EEC

Logged_0x8EE3:
	bit 2,b
	jr nz,Logged_0x8F11
	bit 3,b
	jr nz,Logged_0x8EF6
	ret

Logged_0x8EEC:
	bit 0,b
	jr nz,Logged_0x8F2C
	bit 1,b
	jr nz,Logged_0x8F52
	jr Logged_0x8EE3

Logged_0x8EF6:
	call Logged_0x8F79
	call Logged_0x9085
	ld hl,$C0BB
	res 3,[hl]
	ld a,$03
	ld [$FF00+$85],a
	ld a,$86
	ld [$FF00+$8D],a
	ld a,$51
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x8F11:
	call Logged_0x8FB3
	call Logged_0x9085
	ld hl,$C0BB
	res 2,[hl]
	ld a,$03
	ld [$FF00+$85],a
	ld a,$86
	ld [$FF00+$8D],a
	ld a,$51
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x8F2C:
	call Logged_0x8FEC
	call Logged_0xA0E2
	ld hl,$C0BB
	res 0,[hl]
	ld a,$03
	ld [$FF00+$85],a
	ld a,$1A
	ld [$FF00+$8D],a
	ld a,$51
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0BB]
	bit 2,a
	jr nz,Logged_0x8F11
	bit 3,a
	jr nz,Logged_0x8EF6
	ret

Logged_0x8F52:
	call Logged_0x9039
	call Logged_0xA0E2
	ld hl,$C0BB
	res 1,[hl]
	ld a,$03
	ld [$FF00+$85],a
	ld a,$1A
	ld [$FF00+$8D],a
	ld a,$51
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0BB]
	bit 2,a
	jr nz,Logged_0x8F11
	bit 3,a
	jp nz,Logged_0x8EF6
	ret

Logged_0x8F79:
	ld hl,$CAC5
	ld a,[hld]
	and $F8
	ld e,a
	ld h,[hl]
	ld l,e
	ld de,$00A0
	add hl,de
	ld a,h
	cp $03
	jr c,Logged_0x8F8F
	ld hl,$02F8
	ld a,h

Logged_0x8F8F:
	ld [$C0A3],a
	ld a,l
	ld [$C0A4],a
	ld hl,$CAC7
	ld a,[hld]
	and $F8
	ld e,a
	ld h,[hl]
	ld l,e
	ld de,$FFF0
	add hl,de
	bit 7,h
	jr z,Logged_0x8FAA
	ld hl,$0000

Logged_0x8FAA:
	ld a,h
	ld [$C0A5],a
	ld a,l
	ld [$C0A6],a
	ret

Logged_0x8FB3:
	ld hl,$CAC5
	ld a,[hld]
	and $F8
	ld e,a
	ld h,[hl]
	ld l,e
	ld de,$FFF0
	add hl,de
	bit 7,h
	jr z,Logged_0x8FC7
	ld hl,$0000

Logged_0x8FC7:
	ld a,h
	ld [$C0A3],a
	ld a,l
	ld [$C0A4],a
	ld hl,$CAC7
	ld a,[hld]
	and $F8
	ld e,a
	ld h,[hl]
	ld l,e
	ld de,$FFF0
	add hl,de
	bit 7,h
	jr z,Logged_0x8FE3
	ld hl,$0000

Logged_0x8FE3:
	ld a,h
	ld [$C0A5],a
	ld a,l
	ld [$C0A6],a
	ret

Logged_0x8FEC:
	ld hl,$CAC5
	ld a,[hld]
	and $F8
	ld e,a
	ld h,[hl]
	ld l,e
	ld de,$FFF0
	add hl,de
	bit 7,h
	jr z,Logged_0x9002
	ld hl,$0000
	jr Logged_0x9013

Logged_0x9002:
	ld de,$00B8
	push hl
	add hl,de
	ld a,h
	cp $03
	jr c,Logged_0x9012
	pop hl
	ld hl,$0240
	jr Logged_0x9013

Logged_0x9012:
	pop hl

Logged_0x9013:
	ld a,h
	ld [$C0A3],a
	ld a,l
	ld [$C0A4],a
	ld hl,$CAC7
	ld a,[hld]
	and $F8
	ld e,a
	ld h,[hl]
	ld l,e
	ld de,$00B0
	add hl,de
	ld a,h
	cp $0A
	jr c,Logged_0x9031
	ld hl,$09F8
	ld a,h

Logged_0x9031:
	ld [$C0A5],a
	ld a,l
	ld [$C0A6],a
	ret

Logged_0x9039:
	ld hl,$CAC5
	ld a,[hld]
	and $F8
	ld e,a
	ld h,[hl]
	ld l,e
	ld de,$FFF0
	add hl,de
	bit 7,h
	jr z,Logged_0x904F
	ld hl,$0000
	jr Logged_0x9060

Logged_0x904F:
	ld de,$00B8
	push hl
	add hl,de
	ld a,h
	cp $03
	jr c,Logged_0x905F
	pop hl
	ld hl,$0240
	jr Logged_0x9060

Logged_0x905F:
	pop hl

Logged_0x9060:
	ld a,h
	ld [$C0A3],a
	ld a,l
	ld [$C0A4],a
	ld hl,$CAC7
	ld a,[hld]
	and $F8
	ld e,a
	ld h,[hl]
	ld l,e
	ld de,$FFF0
	add hl,de
	bit 7,h
	jr z,Logged_0x907C
	ld hl,$0000

Logged_0x907C:
	ld a,h
	ld [$C0A5],a
	ld a,l
	ld [$C0A6],a
	ret

Logged_0x9085:
	call Logged_0x8E5B
	ld a,[$CE69]
	ld b,a
	ld de,$CE6A
	ld a,e
	add a,b
	ld e,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	and $E0
	ld c,a
	inc e
	inc l
	ld a,l
	and $1F
	add a,c
	ld l,a
	ld a,[$CE69]
	add a,$32
	ld [$CE69],a
	ld hl,$C0A3
	call Logged_0x0BDB
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	ld a,[$C0A4]
	and $08
	jr z,Logged_0x923A
	push hl
	call Logged_0x9254
	pop hl
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	call Logged_0x9605
	jr Logged_0x924B

Logged_0x923A:
	push hl
	call Logged_0x99CA
	pop hl
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	call Logged_0x9D4C

Logged_0x924B:
	ld a,[$CE00]
	add a,$19
	ld [$CE00],a
	ret

Logged_0x9254:
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$CCE7],a
	ld a,$01
	add a,b
	ld [$CCE8],a
	ld a,[$C0A6]
	and $08
	jp nz,Logged_0x9438
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	ld a,[hl]
	ld [de],a
	pop hl
	ret

Logged_0x9438:
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	inc a
	ld [$CCE8],a
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ret

Logged_0x9605:
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$C0B3],a
	ld a,$35
	add a,b
	ld [$C0B4],a
	ld a,[$C0A6]
	and $08
	jp nz,Logged_0x97F3
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	ld a,[hl]
	ld [de],a
	pop hl
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x97F3:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	inc a
	ld [$C0B4],a
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x99CA:
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$CCE7],a
	ld a,$01
	add a,b
	ld [$CCE8],a
	ld a,[$C0A6]
	and $08
	jp nz,Logged_0x9B94
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	ld a,[hl]
	ld [de],a
	pop hl
	ret

Logged_0x9B94:
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	inc a
	ld [$CCE8],a
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ret

Logged_0x9D4C:
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$C0B3],a
	ld a,$35
	add a,b
	ld [$C0B4],a
	ld a,[$C0A6]
	and $08
	jp nz,Logged_0x9F20
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	ld a,[hl]
	ld [de],a
	pop hl
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x9F20:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	inc a
	ld [$C0B4],a
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hli]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	pop af
	ld [$FF00+$70],a
	ret

Logged_0xA0E2:
	call Logged_0x8E5B
	ld a,[$CE69]
	ld b,a
	ld de,$CE6A
	ld a,e
	add a,b
	ld e,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	push de
	ld de,$0020
	add hl,de
	pop de
	ld a,h
	and $FB
	ld h,a
	ld a,[$CE69]
	add a,$2E
	ld [$CE69],a
	ld hl,$C0A3
	call Logged_0x0BDB
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	ld a,[$C0A6]
	and $08
	jr z,Logged_0xA290
	push hl
	call Logged_0xA2AA
	pop hl
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	call Logged_0xA79E
	jr Logged_0xA2A1

Logged_0xA290:
	push hl
	call Logged_0xACA6
	pop hl
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	call Logged_0xB182

Logged_0xA2A1:
	ld a,[$CE00]
	add a,$17
	ld [$CE00],a
	ret

Logged_0xA2AA:
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$CCE7],a
	ld a,$01
	add a,b
	ld [$CCE8],a
	ld a,[$C0A4]
	and $08
	jp nz,Logged_0xA52F
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA2F7
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA2F7:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA32D
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA32D:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA363
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA363:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA399
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA399:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA3CF
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA3CF:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA405
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA405:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA43B
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA43B:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA471
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA471:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA4A7
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA4A7:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA4DD
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA4DD:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA513
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA513:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	ld a,[hl]
	ld [de],a
	pop hl
	ret

Logged_0xA52F:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	inc a
	ld [$CCE8],a
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA562
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA562:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA598
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA598:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA5CE
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA5CE:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA604
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA604:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA63A
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA63A:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA670
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA670:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA6A6
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA6A6:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA6DC
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA6DC:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA712
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA712:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA748
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA748:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA77E
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA77E:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ret

Logged_0xA79E:
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$C0B3],a
	ld a,$35
	add a,b
	ld [$C0B4],a
	ld a,[$C0A4]
	and $08
	jp nz,Logged_0xAA2D
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA7F2
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA7F2:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA828
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA828:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA85E
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA85E:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA894
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA894:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA8CA
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA8CA:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA900
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA900:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA936
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA936:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA96C
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA96C:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA9A2
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA9A2:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xA9D8
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xA9D8:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAA0E
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAA0E:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	ld a,[hl]
	ld [de],a
	pop hl
	pop af
	ld [$FF00+$70],a
	ret

Logged_0xAA2D:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	inc a
	ld [$C0B4],a
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAA67
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAA67:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAA9D
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAA9D:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAAD3
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAAD3:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAB09
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAB09:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAB3F
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAB3F:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAB75
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAB75:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xABAB
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xABAB:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xABE1
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xABE1:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAC17
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAC17:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAC4D
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAC4D:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAC83
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAC83:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	pop af
	ld [$FF00+$70],a
	ret

Logged_0xACA6:
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$CCE7],a
	ld a,$01
	add a,b
	ld [$CCE8],a
	ld a,[$C0A4]
	and $08
	jp nz,Logged_0xAF1F
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xACF2
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xACF2:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAD27
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAD27:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAD5C
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAD5C:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAD91
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAD91:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xADC6
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xADC6:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xADFB
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xADFB:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAE30
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAE30:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAE65
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAE65:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAE9A
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAE9A:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAECF
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAECF:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAF04
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAF04:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	ld a,[hl]
	ld [de],a
	pop hl
	ret

Logged_0xAF1F:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	inc a
	ld [$CCE8],a
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAF51
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAF51:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAF86
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAF86:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAFBB
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAFBB:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xAFF0
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xAFF0:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB025
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB025:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB05A
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB05A:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB08F
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB08F:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB0C4
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB0C4:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB0F9
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB0F9:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB12E
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB12E:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB163
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB163:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	ret

Logged_0xB182:
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$C0B3],a
	ld a,$35
	add a,b
	ld [$C0B4],a
	ld a,[$C0A4]
	and $08
	jp nz,Logged_0xB405
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB1D5
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB1D5:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB20A
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB20A:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB23F
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB23F:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB274
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB274:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB2A9
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB2A9:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB2DE
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB2DE:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB313
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB313:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB348
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB348:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB37D
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB37D:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB3B2
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB3B2:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB3E7
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB3E7:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	ld a,[hl]
	ld [de],a
	pop hl
	pop af
	ld [$FF00+$70],a
	ret

Logged_0xB405:
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	inc a
	ld [$C0B4],a
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB43E
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB43E:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB473
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB473:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB4A8
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB4A8:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB4DD
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB4DD:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB512
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB512:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB547
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB547:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB57C
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB57C:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB5B1
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB5B1:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB5E6
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB5E6:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB61B
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB61B:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xB650
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0xB650:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	pop af
	ld [$FF00+$70],a
	ret

Logged_0xB672:
	ld hl,$767E
	ld de,$C200
	ld b,$03
	call Logged_0x0466
	ret

LoggedData_0xB67E:
INCBIN "baserom.gbc", $B67E, $B681 - $B67E

Logged_0xB681:
	ld hl,$C210
	ld a,[$CE00]
	and a
	jr z,Logged_0xB6CB
	ld c,a

Logged_0xB68B:
	ld a,$2A
	ld [hli],a
	ld a,$57
	ld [hli],a
	ld a,$2A
	ld [hli],a
	ld a,$5F
	ld [hli],a
	ld a,$0A
	ld [hli],a
	ld a,$12
	ld [hli],a
	ld a,$0C
	ld [hli],a
	dec c
	jr nz,Logged_0xB68B
	ld a,$C3
	ld [hli],a
	ld a,$AB
	ld [hli],a
	ld a,$0C
	ld [hl],a
	ld a,[$CE00]
	ld c,a
	ld hl,$C800

Logged_0xB6B3:
	ld a,$2A
	ld [hli],a
	ld a,$57
	ld [hli],a
	ld a,$2A
	ld [hli],a
	ld a,$5F
	ld [hli],a
	ld a,$0A
	ld [hli],a
	ld a,$12
	ld [hli],a
	ld a,$0C
	ld [hli],a
	dec c
	jr nz,Logged_0xB6B3

Logged_0xB6CB:
	ld a,$C3
	ld [hli],a
	ld a,$B8
	ld [hli],a
	ld a,$0C
	ld [hl],a
	ret

Logged_0xB6D5:
	xor a
	ld [$C0C0],a
	ld a,[$C0B9]
	dec a
	ld c,a
	ld a,[$CAC7]
	add a,b
	ld [$CAC7],a
	ld a,[$CAC6]
	adc a,$00
	ld [$CAC6],a
	ld a,[$C0BA]
	bit 4,a
	ld b,$60
	jr z,Logged_0xB6F8
	ld b,$40

Logged_0xB6F8:
	ld a,[$CAC6]
	cp c
	jr c,Logged_0xB70E
	ld a,[$CAC7]
	cp b
	jr c,Logged_0xB70E
	ld a,b
	ld [$CAC7],a
	ld a,$01
	ld [$C0C0],a
	ret

Logged_0xB70E:
	ld a,[$C0B8]
	ld c,a
	ld a,[$CA63]
	cp c
	ret nz
	ld a,[$CA69]
	and a
	jr nz,Logged_0xB722
	ld a,[$CA60]
	jr Logged_0xB725

Logged_0xB722:
	ld a,[$CA5F]

Logged_0xB725:
	sub $08
	ld c,a
	ld a,[$C0BA]
	bit 5,a
	jr z,Logged_0xB733
	ld a,c
	add a,$20
	ld c,a

Logged_0xB733:
	ld a,[$CA64]
	cp c
	ret nc
	ld a,[$C0BA]
	bit 5,a
	ld a,$00
	jr z,Logged_0xB743
	ld a,$20

Logged_0xB743:
	ld [$CAC7],a
	ld a,$02
	ld [$C0C0],a
	ret

Logged_0xB74C:
	xor a
	ld [$C0BF],a
	ld a,[$C0B8]
	ld c,a
	ld a,[$CAC7]
	sub b
	ld [$CAC7],a
	ld a,[$CAC6]
	sbc a,$00
	ld [$CAC6],a
	ld a,[$CAC7]
	add a,$10
	ld l,a
	ld a,[$CAC6]
	adc a,$00
	cp c
	jr nz,Logged_0xB790
	ld a,[$C0BA]
	bit 5,a
	ld b,$10
	jr z,Logged_0xB77C
	ld b,$30

Logged_0xB77C:
	ld a,l
	cp b
	jr nc,Logged_0xB790
	ld a,c
	ld [$CAC6],a
	ld a,b
	sub $10
	ld [$CAC7],a
	ld a,$01
	ld [$C0BF],a
	ret

Logged_0xB790:
	ld a,[$C0B9]
	dec a
	ld c,a
	ld a,[$CA63]
	cp c
	ret nz
	ld a,[$CA69]
	and a
	jr nz,Logged_0xB7A5
	ld a,[$CA60]
	jr Logged_0xB7A8

Logged_0xB7A5:
	ld a,[$CA5F]

Logged_0xB7A8:
	ld c,a
	ld a,$A8
	sub c
	ld c,a
	xor a
	sub c
	ld c,a
	ld a,[$C0BA]
	bit 4,a
	jr z,Logged_0xB7BB
	ld a,c
	sub $20
	ld c,a

Logged_0xB7BB:
	ld a,[$CA64]
	cp c
	ret c
	ld a,$02
	ld [$C0BF],a
	ld a,[$C0B9]
	dec a
	ld [$CAC6],a
	ld a,[$C0BA]
	bit 4,a
	ld a,$60
	jr z,Logged_0xB7D7
	ld a,$40

Logged_0xB7D7:
	ld [$CAC7],a
	ret

Logged_0xB7DB:
	ld a,[$C0B6]
	dec a
	ld c,a
	ld a,[$CAC5]
	add a,b
	ld [$CAC5],a
	ld a,[$CAC4]
	adc a,$00
	ld [$CAC4],a
	cp c
	jr c,Logged_0xB80D
	ld a,[$C0BA]
	bit 7,a
	ld b,$68
	jr z,Logged_0xB7FD
	ld b,$48

Logged_0xB7FD:
	ld a,[$CAC5]
	cp b
	jr c,Logged_0xB80D
	ld a,b
	ld [$CAC5],a
	ld a,$01
	ld [$C0BD],a
	ret

Logged_0xB80D:
	ld a,[$C0BA]
	and $0F
	cp $08
	ret nc
	ld a,[$C0B7]
	ld c,a
	ld a,[$CA61]
	cp c
	jr c,Logged_0xB836
	ret nz
	ld a,[$CA5E]
	sub $10
	ld c,a
	ld a,[$C0BA]
	bit 6,a
	jr z,Logged_0xB831
	ld a,c
	add a,$20
	ld c,a

Logged_0xB831:
	ld a,[$CA62]
	cp c
	ret nc

Logged_0xB836:
	ld a,[$C0BA]
	bit 6,a
	ld a,$00
	jr z,Logged_0xB841
	ld a,$20

Logged_0xB841:
	ld [$CAC5],a
	ld a,[$C0B7]
	ld [$CAC4],a
	ld a,$02
	ld [$C0BD],a
	ret

Logged_0xB850:
	ld a,[$C0B7]
	ld c,a
	ld a,[$CAC5]
	sub b
	ld [$CAC5],a
	ld a,[$CAC4]
	sbc a,$00
	ld [$CAC4],a
	ld a,[$C0BA]
	bit 6,a
	ld b,$10
	jr z,Logged_0xB86E
	ld b,$30

Logged_0xB86E:
	ld a,[$CAC5]
	add a,$10
	ld l,a
	ld a,[$CAC4]
	adc a,$00
	cp c
	jr c,Logged_0xB882
	jr nz,Logged_0xB892
	ld a,l
	cp b
	jr nc,Logged_0xB892

Logged_0xB882:
	ld a,c
	ld [$CAC4],a
	ld a,b
	sub $10
	ld [$CAC5],a
	ld a,$01
	ld [$C0BE],a
	ret

Logged_0xB892:
	ld a,[$C0BA]
	and $0F
	cp $08
	ret nc
	ld a,[$C0B6]
	dec a
	ld c,a
	ld a,[$CA61]
	cp c
	ret nz
	ld a,[$CA5E]
	ld c,a
	ld a,$A0
	sub c
	ld c,a
	xor a
	sub c
	ld c,a
	ld a,[$C0BA]
	bit 7,a
	jr z,Logged_0xB8BA
	ld a,c
	sub $20
	ld c,a

Logged_0xB8BA:
	ld a,[$CA62]
	cp c
	ret c
	ld a,$02
	ld [$C0BE],a
	ld a,[$C0BA]
	bit 7,a
	ld a,$68
	jr z,Logged_0xB8CF
	ld a,$48

Logged_0xB8CF:
	ld [$CAC5],a
	ret

Logged_0xB8D3:
	ld a,[$C0BA]
	cp $3C
	jr z,Logged_0xB8F5
	ld a,[$C083]
	ld b,a
	ld a,[$CA62]
	add a,$10
	sub b
	ld [$CA87],a
	ld a,[$C085]
	ld b,a
	ld a,[$CA64]
	add a,$08
	sub b
	ld [$CA88],a
	ret

Logged_0xB8F5:
	ld a,[$C0BC]
	ld c,a
	ld a,[$C08A]
	add a,c
	ld b,a
	ld a,[$CA62]
	add a,$10
	sub b
	ld [$CA87],a
	ld a,[$C08C]
	ld b,a
	ld a,[$CA64]
	add a,$08
	sub b
	ld [$CA88],a
	ret

Logged_0xB915:
	ld a,[$C0C2]
	ld b,a
	and a
	jr z,Logged_0xB964
	xor a
	ld [$C0D4],a
	bit 7,b
	jr nz,Logged_0xB941
	ld hl,$CA87
	ld a,[$CA5E]
	cp [hl]
	jr nc,Logged_0xB92E
	inc b

Logged_0xB92E:
	call Logged_0xB7DB
	ld a,[$C0BD]
	and a
	jr nz,Logged_0xB93C
	ld hl,$C0BB
	set 3,[hl]

Logged_0xB93C:
	xor a
	ld [$C0C2],a
	ret

Logged_0xB941:
	ld a,b
	cpl
	inc a
	ld b,a
	ld hl,$CA87
	ld a,[$CA5E]
	cp [hl]
	jr c,Logged_0xB951
	jr z,Logged_0xB951
	inc b

Logged_0xB951:
	call Logged_0xB850
	ld a,[$C0BE]
	and a
	jr nz,Logged_0xB95F
	ld hl,$C0BB
	set 2,[hl]

Logged_0xB95F:
	xor a
	ld [$C0C2],a
	ret

Logged_0xB964:
	ld a,[$C0DB]
	and a
	ret nz
	ld a,[$CA75]
	and a
	ret nz
	ld a,[$CA83]
	cp $4C
	ret z
	cp $3A
	jr c,Logged_0xB97B
	cp $3F
	ret c

Logged_0xB97B:
	ld a,[$C0D4]
	inc a
	ld [$C0D4],a
	dec a
	ret z
	ld hl,$CA87
	ld a,[$CA5E]
	sub [hl]
	jr nc,Logged_0xB98F
	cpl
	inc a

Logged_0xB98F:
	ld b,a
	ld a,[$C189]
	and a
	jr nz,Logged_0xB99C
	ld a,b
	cp $08
	ret c
	ld b,$07

Logged_0xB99C:
	ld a,[$CA5E]
	cp [hl]
	jr c,Logged_0xB92E
	ret z
	jp Logged_0xB951

Logged_0xB9A6:
	ld a,[$C0C3]
	ld b,a
	and a
	jr z,Logged_0xBA13
	xor a
	ld [$C0D5],a
	bit 7,b
	jr nz,Logged_0xB9E2
	ld hl,$CA88
	ld a,[$CA69]
	and a
	jr nz,Logged_0xB9C3
	ld a,[$CA60]
	jr Logged_0xB9C6

Logged_0xB9C3:
	ld a,[$CA5F]

Logged_0xB9C6:
	cp [hl]
	jr z,Logged_0xB9CF
	jr c,Logged_0xB9CE
	dec b
	jr Logged_0xB9CF

Logged_0xB9CE:
	inc b

Logged_0xB9CF:
	call Logged_0xB6D5
	ld a,[$C0C0]
	and a
	jr nz,Logged_0xB9DD
	ld hl,$C0BB
	set 0,[hl]

Logged_0xB9DD:
	xor a
	ld [$C0C3],a
	ret

Logged_0xB9E2:
	ld a,b
	cpl
	inc a
	ld b,a
	ld hl,$CA88
	ld a,[$CA69]
	and a
	jr nz,Logged_0xB9F4
	ld a,[$CA60]
	jr Logged_0xB9F7

Logged_0xB9F4:
	ld a,[$CA5F]

Logged_0xB9F7:
	cp [hl]
	jr z,Logged_0xBA00
	jr c,Logged_0xB9FF
	inc b
	jr Logged_0xBA00

Logged_0xB9FF:
	dec b

Logged_0xBA00:
	call Logged_0xB74C
	ld a,[$C0BF]
	and a
	jr nz,Logged_0xBA0E
	ld hl,$C0BB
	set 1,[hl]

Logged_0xBA0E:
	xor a
	ld [$C0C3],a
	ret

Logged_0xBA13:
	ld a,[$CA8E]
	cp $42
	jr nz,Logged_0xBA1F
	ld a,[$CA74]
	and a
	ret nz

Logged_0xBA1F:
	ld a,[$C0D5]
	inc a
	ld [$C0D5],a
	dec a
	ret z
	ld b,$01
	ld hl,$CA88
	ld a,[$CA69]
	and a
	jr nz,Logged_0xBA38
	ld a,[$CA60]
	jr Logged_0xBA3B

Logged_0xBA38:
	ld a,[$CA5F]

Logged_0xBA3B:
	cp [hl]
	jr c,Logged_0xB9CF
	ret z
	jp Logged_0xBA00
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	push de
	push hl
	ld c,$01
	ld a,[hld]
	cp $C0
	jr c,Logged_0xBA68
	inc c
	sub $20
	cp $C0
	jr c,Logged_0xBA68
	inc c
	sub $20

Logged_0xBA68:
	ld l,[hl]
	ld h,a
	ld a,c
	ld [$CCE9],a
	call Logged_0x0D8C
	ld a,[$CCEC]
	ld [$C08E],a
	ld [$4100],a
	bit 0,b
	jr z,Logged_0xBA85
	swap e
	ld a,[hl]
	and $0F
	jr Logged_0xBA88

Logged_0xBA85:
	ld a,[hl]
	and $F0

Logged_0xBA88:
	or e
	ld [hl],a
	pop hl
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	ld c,$01
	ld a,[hld]
	cp $C0
	jr c,Logged_0xBAAF
	inc c
	sub $20
	cp $C0
	jr c,Logged_0xBAAF
	inc c
	sub $20

Logged_0xBAAF:
	ld d,a
	ld a,[hld]
	ld e,a
	ld a,c
	ld [$C08E],a
	ld [$4100],a
	ld a,[de]
	or $80
	ld [de],a
	pop af
	ld [$C08E],a
	ld [$4100],a
	pop af
	ld [$FF00+$70],a
	ld a,c
	ld [$CCE9],a
	ld h,d
	ld l,e
	call Logged_0x0D3E
	pop de
	ld c,e
	ld d,h
	ld e,l
	ld a,$19
	ld [$FF00+$85],a
	ld a,$E5
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$C08E],a
	ld [$4100],a
	pop af
	ld [$FF00+$70],a
	ret
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	ld c,$01
	ld a,[hld]
	cp $C0
	jr c,Logged_0xBB12
	inc c
	sub $20
	cp $C0
	jr c,Logged_0xBB12
	inc c
	sub $20

Logged_0xBB12:
	ld d,a
	ld a,[hld]
	ld e,a
	xor a
	ld [hl],a
	ld a,c
	ld [$C08E],a
	ld [$4100],a
	ld a,[de]
	or $80
	ld [de],a
	pop af
	ld [$C08E],a
	ld [$4100],a
	pop af
	ld [$FF00+$70],a
	ret
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	ld c,$01
	ld a,[hld]
	cp $C0
	jr c,Logged_0xBB51
	inc c
	sub $20
	cp $C0
	jr c,Logged_0xBB51
	inc c
	sub $20

Logged_0xBB51:
	ld l,[hl]
	ld h,a
	ld a,c
	ld [$CCE9],a
	call Logged_0x0D8C
	ld a,[$CCEC]
	ld [$C08E],a
	ld [$4100],a
	bit 0,b
	jr z,Logged_0xBB76
	ld a,[hl]
	and $0F
	ld [hl],a
	pop af
	ld [$C08E],a
	ld [$4100],a
	pop af
	ld [$FF00+$70],a
	ret

Logged_0xBB76:
	ld a,[hl]
	and $F0
	ld [hl],a
	pop af
	ld [$C08E],a
	ld [$4100],a
	pop af
	ld [$FF00+$70],a
	ret

Logged_0xBB85:
	ld a,[$C1A0]
	and a
	ret nz
	ld b,$01
	ld a,[$C19F]
	ld e,a
	ld d,$00
	ld hl,$C18E
	add hl,de
	ld a,[hli]
	and a
	ret z
	ld l,[hl]
	cp $C0
	jr c,Logged_0xBBA8
	inc b
	sub $20
	cp $C0
	jr c,Logged_0xBBA8
	inc b
	sub $20

Logged_0xBBA8:
	ld h,a
	ld a,b
	ld [$CCE9],a
	ld [$C08E],a
	ld [$4100],a
	push hl
	call Logged_0x0C19
	ld a,[$CE69]
	ld b,a
	ld de,$CE6A
	ld a,e
	add a,b
	ld e,a
	ld a,h
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	ld a,h
	ld [de],a
	inc e
	ld a,l
	and $E0
	ld c,a
	ld a,l
	inc a
	and $1F
	add a,c
	ld [de],a
	inc e
	ld bc,$0020
	add hl,bc
	ld a,h
	and $FB
	ld h,a
	ld [de],a
	inc e
	ld a,l
	ld [de],a
	inc e
	ld a,h
	ld [de],a
	inc e
	ld a,l
	and $E0
	ld c,a
	ld a,l
	inc a
	and $1F
	add a,c
	ld [de],a
	ld a,[$CE69]
	add a,$08
	ld [$CE69],a
	pop hl
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	push de
	ld hl,$C600
	add hl,de
	ld a,[$CE00]
	ld e,a
	ld d,$CE
	ld a,$01
	add a,e
	ld e,a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	pop de
	ld hl,$D300
	add hl,de
	ld a,[$CE00]
	ld e,a
	ld d,$CE
	ld a,$35
	add a,e
	ld e,a
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hli]
	ld [de],a
	inc e
	ld a,[hl]
	ld [de],a
	ld a,[$CE00]
	add a,$04
	ld [$CE00],a
	ld a,[$C19F]
	ld e,a
	ld d,$00
	ld hl,$C18E
	add hl,de
	xor a
	ld [hli],a
	ld [hl],a
	ld a,e
	add a,$02
	and $0F
	ld [$C19F],a
	pop af
	ld [$FF00+$70],a
	ret

Logged_0xBC5E:
	ld a,[$CA6A]
	and a
	ret z
	xor a
	ld [$CA6A],a
	ld a,[$CA6B]
	cp $68
	jr z,Logged_0xBCD5
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	ld hl,$A000

Logged_0xBC7D:
	ld a,[hli]
	and $7F
	cp $60
	jr c,Logged_0xBC8D
	cp $68
	jr nc,Logged_0xBC8D
	dec l
	ld a,[hl]
	add a,$08
	ld [hli],a

Logged_0xBC8D:
	ld a,l
	cp $A0
	jr c,Logged_0xBC7D
	ld l,$00
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xBC7D
	pop af
	ld [$C08E],a
	ld [$4100],a
	ld a,[$C08E]
	push af
	ld a,$02
	ld [$C08E],a
	ld [$4100],a
	ld hl,$A000

Logged_0xBCB0:
	ld a,[hli]
	and $7F
	cp $60
	jr c,Logged_0xBCC0
	cp $68
	jr nc,Logged_0xBCC0
	dec l
	ld a,[hl]
	add a,$08
	ld [hli],a

Logged_0xBCC0:
	ld a,l
	cp $A0
	jr c,Logged_0xBCB0
	ld l,$00
	inc h
	ld a,h
	cp $B0
	jr nz,Logged_0xBCB0
	pop af
	ld [$C08E],a
	ld [$4100],a
	ret

Logged_0xBCD5:
	ld a,[$C08E]
	push af
	ld a,$01
	ld [$C08E],a
	ld [$4100],a
	ld hl,$A000

Logged_0xBCE4:
	ld a,[hli]
	and $7F
	cp $68
	jr c,Logged_0xBCF4
	cp $70
	jr nc,Logged_0xBCF4
	dec l
	ld a,[hl]
	sub $08
	ld [hli],a

Logged_0xBCF4:
	ld a,l
	cp $A0
	jr c,Logged_0xBCE4
	ld l,$00
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xBCE4
	pop af
	ld [$C08E],a
	ld [$4100],a
	ld a,[$C08E]
	push af
	ld a,$02
	ld [$C08E],a
	ld [$4100],a
	ld hl,$A000

Logged_0xBD17:
	ld a,[hli]
	and $7F
	cp $68
	jr c,Logged_0xBD27
	cp $70
	jr nc,Logged_0xBD27
	dec l
	ld a,[hl]
	sub $08
	ld [hli],a

Logged_0xBD27:
	ld a,l
	cp $A0
	jr c,Logged_0xBD17
	ld l,$00
	inc h
	ld a,h
	cp $B0
	jr nz,Logged_0xBD17
	pop af
	ld [$C08E],a
	ld [$4100],a
	ret

Logged_0xBD3C:
	ld a,[$CA3D]
	bit 1,a
	ret z
	ld a,[$CED4]
	and a
	ret nz
	ld a,[$C0E4]
	add a,$01
	daa
	ld [$C0E4],a
	cp $60
	ret c
	xor a
	ld [$C0E4],a
	ld a,[$C0E3]
	add a,$01
	daa
	ld [$C0E3],a
	cp $60
	ret c
	xor a
	ld [$C0E3],a
	ld a,[$C0E2]
	add a,$01
	daa
	ld [$C0E2],a
	cp $60
	ret c
	ld a,$59
	ld [$C0E2],a
	ld [$C0E3],a
	ret

UnknownData_0xBD7C:
INCBIN "baserom.gbc", $BD7C, $C000 - $BD7C

SECTION "Bank03", ROMX, BANK[$03]

LoggedData_0xC000:
INCBIN "baserom.gbc", $C000, $C880 - $C000

UnknownData_0xC880:
INCBIN "baserom.gbc", $C880, $C890 - $C880

LoggedData_0xC890:
INCBIN "baserom.gbc", $C890, $C930 - $C890

UnknownData_0xC930:
INCBIN "baserom.gbc", $C930, $C950 - $C930

LoggedData_0xC950:
INCBIN "baserom.gbc", $C950, $C960 - $C950

UnknownData_0xC960:
INCBIN "baserom.gbc", $C960, $C980 - $C960

LoggedData_0xC980:
INCBIN "baserom.gbc", $C980, $C9F0 - $C980
	call Logged_0xCE3E
	ld a,[$CCE1]
	add a,a
	add a,a
	add a,a
	add a,a
	ld e,a
	ld d,$00
	ld a,[$CCE1]
	inc a
	and $03
	ld [$CCE1],a
	ld hl,$CCA0
	add hl,de
	ld a,[hl]
	and a
	jr nz,Logged_0xCA15
	ld a,[$CCE0]
	inc a
	ld [$CCE0],a

Logged_0xCA15:
	ld [hl],b
	inc l
	xor a
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$AA]
	ld [hli],a
	ld a,[$FF00+$AB]
	ld [hli],a
	ret
	ld a,[$CCE0]
	and a
	ret z
	ld hl,$CCA0
	ld a,[hl]
	and a
	jr z,Logged_0xCA35
	call Logged_0xCA54

Logged_0xCA35:
	ld hl,$CCB0
	ld a,[hl]
	and a
	jr z,Logged_0xCA3F
	call Logged_0xCA54

Logged_0xCA3F:
	ld hl,$CCC0
	ld a,[hl]
	and a
	jr z,Logged_0xCA49
	call Logged_0xCA54

Logged_0xCA49:
	ld hl,$CCD0
	ld a,[hl]
	and a
	jr z,Logged_0xCA53
	call Logged_0xCA54

Logged_0xCA53:
	ret

Logged_0xCA54:
	ld b,h
	ld c,l
	ld a,[hl]
	rst JumpList
	dw Unknown_0xCA86
	dw Logged_0xCA87
	dw Logged_0xCAB8
	dw Logged_0xCAE1
	dw Logged_0xCB0A
	dw Logged_0xCB33
	dw Logged_0xCB82
	dw Logged_0xCBD1
	dw Logged_0xCBFA
	dw Logged_0xCC23
	dw Logged_0xCC4C
	dw Logged_0xCC99
	dw Logged_0xCCC2
	dw Logged_0xCCEB
	dw Logged_0xCD09
	dw Logged_0xCD3D
	dw Logged_0xCD66
	dw Logged_0xCDAF
	dw Logged_0xCDF8
	dw Unknown_0xCA86
	dw Unknown_0xCA86
	dw Unknown_0xCA86
	dw Unknown_0xCA86

Unknown_0xCA86:
	ret

Logged_0xCA87:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCAA3
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$05
	ld [$FF00+$B6],a
	dec c
	jr Logged_0xCAA8

Logged_0xCAA3:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCAA8:
	call Logged_0xCFF6
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCAB8:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCACC
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCAD1

Logged_0xCACC:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCAD1:
	call Logged_0xD016
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCAE1:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCAF5
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCAFA

Logged_0xCAF5:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCAFA:
	call Logged_0xD076
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCB0A:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCB1E
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCB23

Logged_0xCB1E:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCB23:
	call Logged_0xCFD5
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCB33:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCB47
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCB71

Logged_0xCB47:
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub $0C
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $0C
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	inc c
	ld a,[$FF00+$A8]
	ld [bc],a
	inc c
	ld a,[$FF00+$A9]
	ld [bc],a
	inc c
	ld a,[$FF00+$AA]
	ld [bc],a
	inc c
	ld a,[$FF00+$AB]
	ld [bc],a
	inc c

Logged_0xCB71:
	call Logged_0xCFD5
	pop bc
	ld a,[$CA83]
	cp $27
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCB82:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCB96
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCBC0

Logged_0xCB96:
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,$0C
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $0C
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	inc c
	ld a,[$FF00+$A8]
	ld [bc],a
	inc c
	ld a,[$FF00+$A9]
	ld [bc],a
	inc c
	ld a,[$FF00+$AA]
	ld [bc],a
	inc c
	ld a,[$FF00+$AB]
	ld [bc],a
	inc c

Logged_0xCBC0:
	call Logged_0xCFD5
	pop bc
	ld a,[$CA83]
	cp $27
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCBD1:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCBE5
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCBEA

Logged_0xCBE5:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCBEA:
	call Logged_0xD036
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCBFA:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCC0E
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCC13

Logged_0xCC0E:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCC13:
	call Logged_0xD056
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCC23:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCC37
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCC3C

Logged_0xCC37:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCC3C:
	call Logged_0xCE75
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCC4C:
	ld a,[$CA83]
	cp $92
	jr nz,Logged_0xCC92
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCC67
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCC89

Logged_0xCC67:
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	inc c
	ld a,[$FF00+$A8]
	ld [bc],a
	inc c
	ld a,[$FF00+$A9]
	ld [bc],a
	inc c
	ld a,[$FF00+$AA]
	ld [bc],a
	inc c
	ld a,[$FF00+$AB]
	ld [bc],a
	inc c

Logged_0xCC89:
	call Logged_0xCF67
	pop bc
	ld a,[$CCE6]
	and a
	ret z

Logged_0xCC92:
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCC99:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCCAD
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCCB2

Logged_0xCCAD:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCCB2:
	call Logged_0xCF46
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCCC2:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCCD6
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCCDB

Logged_0xCCD6:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCCDB:
	call Logged_0xCFA9
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCCEB:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCCFF
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCD04

Logged_0xCCFF:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCD04:
	call Logged_0xCF25
	pop bc
	ret

Logged_0xCD09:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCD1D
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCD2C

Logged_0xCD1D:
	inc c
	inc c
	ld a,[bc]
	sub $02
	ld [bc],a
	dec c
	ld a,[bc]
	sbc a,$00
	ld [bc],a
	inc c
	inc c
	inc c
	inc c

Logged_0xCD2C:
	call Logged_0xCF04
	pop bc
	ld a,[$C096]
	cp $C0
	ret c
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCD3D:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCD51
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCD56

Logged_0xCD51:
	inc c
	inc c
	inc c
	inc c
	inc c

Logged_0xCD56:
	call Logged_0xCF88
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCD66:
	ld a,[$CA83]
	cp $E5
	jr z,Logged_0xCDA8
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCD81
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCDA3

Logged_0xCD81:
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	inc c
	ld a,[$FF00+$A8]
	ld [bc],a
	inc c
	ld a,[$FF00+$A9]
	ld [bc],a
	inc c
	ld a,[$FF00+$AA]
	ld [bc],a
	inc c
	ld a,[$FF00+$AB]
	ld [bc],a
	inc c

Logged_0xCDA3:
	call Logged_0xCEA1
	pop bc
	ret

Logged_0xCDA8:
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCDAF:
	ld a,[$CA83]
	cp $E5
	jr z,Logged_0xCDF1
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCDCA
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCDEC

Logged_0xCDCA:
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	inc c
	ld a,[$FF00+$A8]
	ld [bc],a
	inc c
	ld a,[$FF00+$A9]
	ld [bc],a
	inc c
	ld a,[$FF00+$AA]
	ld [bc],a
	inc c
	ld a,[$FF00+$AB]
	ld [bc],a
	inc c

Logged_0xCDEC:
	call Logged_0xCEC2
	pop bc
	ret

Logged_0xCDF1:
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCDF8:
	push bc
	inc c
	ld a,[bc]
	and a
	jr nz,Logged_0xCE0C
	inc a
	ld [bc],a
	inc c
	inc c
	inc c
	inc c
	inc c
	xor a
	ld [bc],a
	inc c
	ld [bc],a
	dec c
	jr Logged_0xCE2E

Logged_0xCE0C:
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	inc c
	ld a,[$FF00+$A8]
	ld [bc],a
	inc c
	ld a,[$FF00+$A9]
	ld [bc],a
	inc c
	ld a,[$FF00+$AA]
	ld [bc],a
	inc c
	ld a,[$FF00+$AB]
	ld [bc],a
	inc c

Logged_0xCE2E:
	call Logged_0xCEE3
	pop bc
	ld a,[$CCE6]
	and a
	ret z
	xor a
	ld [bc],a
	ld hl,$CCE0
	dec [hl]
	ret

Logged_0xCE3E:
	ld a,h
	sub $A0
	ld h,a
	and $F0
	swap a
	ld d,a
	ld a,[$CCE9]
	dec a
	add a,a
	add a,d
	ld [$FF00+$A8],a
	ld a,h
	and $0F
	swap a
	add a,$10
	ld [$FF00+$A9],a
	ld a,[$FF00+$A8]
	adc a,$00
	ld [$FF00+$A8],a
	ld a,l
	and $F0
	swap a
	ld [$FF00+$AA],a
	ld a,l
	and $0F
	swap a
	add a,$08
	ld [$FF00+$AB],a
	ld a,[$FF00+$AA]
	adc a,$00
	ld [$FF00+$AA],a
	ret

Logged_0xCE75:
	ld h,b
	ld l,c
	ld a,[$CA69]
	and a
	jr nz,Logged_0xCE82
	ld de,$5502
	jr Logged_0xCE85

Logged_0xCE82:
	ld de,$550B

Logged_0xCE85:
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$520E
	jp Logged_0xD094

Logged_0xCEA1:
	ld h,b
	ld l,c
	ld de,$58E7
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$580D
	jp Logged_0xD094

Logged_0xCEC2:
	ld h,b
	ld l,c
	ld de,$58F4
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$580D
	jp Logged_0xD094

Logged_0xCEE3:
	ld h,b
	ld l,c
	ld de,$5901
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$580D
	jp Logged_0xD094

Logged_0xCF04:
	ld h,b
	ld l,c
	ld de,$57B4
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$5763
	jp Logged_0xD094

Logged_0xCF25:
	ld h,b
	ld l,c
	ld de,$575A
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$5716
	jp Logged_0xD094

Logged_0xCF46:
	ld h,b
	ld l,c
	ld de,$5622
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$55AE
	jp Logged_0xD094

Logged_0xCF67:
	ld h,b
	ld l,c
	ld de,$5591
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$5532
	jp Logged_0xD094

Logged_0xCF88:
	ld h,b
	ld l,c
	ld de,$5806
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$57BD
	jp Logged_0xD094

Logged_0xCFA9:
	ld h,b
	ld l,c
	ld a,[$CA69]
	and a
	jr nz,Logged_0xCFB6
	ld de,$56FD
	jr Logged_0xCFB9

Logged_0xCFB6:
	ld de,$56E4

Logged_0xCFB9:
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$562B
	jp Logged_0xD094

Logged_0xCFD5:
	ld h,b
	ld l,c
	ld de,$54C5
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$520E
	jp Logged_0xD094

Logged_0xCFF6:
	ld h,b
	ld l,c
	ld de,$549A
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$520E
	jr Logged_0xD094

Logged_0xD016:
	ld h,b
	ld l,c
	ld de,$5525
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$520E
	jr Logged_0xD094

Logged_0xD036:
	ld h,b
	ld l,c
	ld de,$54F3
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$520E
	jr Logged_0xD094

Logged_0xD056:
	ld h,b
	ld l,c
	ld de,$54EA
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$520E
	jr Logged_0xD094

Logged_0xD076:
	ld h,b
	ld l,c
	ld de,$54BA
	call Logged_0xD0EF
	ld a,[hld]
	ld [$CCE4],a
	dec l
	dec l
	ld a,[hld]
	ld [$CCE3],a
	dec l
	ld a,[hld]
	ld [$CCE2],a
	xor a
	ld [$CCE5],a
	ld hl,$520E

Logged_0xD094:
	ld a,[$C0BA]
	cp $3C
	jr z,Logged_0xD0C5
	ld a,[$C083]
	ld b,a
	ld a,[$CCE2]
	add a,$10
	sub b
	ld [$C096],a
	ld a,[$C085]
	ld b,a
	ld a,[$CCE3]
	add a,$08
	sub b
	ld [$C097],a
	ld a,[$CCE4]
	ld [$C098],a
	ld a,[$CCE5]
	ld [$C099],a
	call Logged_0x0DF4
	ret

Logged_0xD0C5:
	ld a,[$CAC5]
	ld b,a
	ld a,[$CCE2]
	add a,$10
	sub b
	ld [$C096],a
	ld a,[$CAC7]
	ld b,a
	ld a,[$CCE3]
	add a,$08
	sub b
	ld [$C097],a
	ld a,[$CCE4]
	ld [$C098],a
	ld a,[$CCE5]
	ld [$C099],a
	call Logged_0x0DF4
	ret

Logged_0xD0EF:
	xor a
	ld [$CCE6],a
	ld a,[hl]
	sub $01
	ld [hli],a
	jr nc,Logged_0xD10D
	ld a,[hli]
	add a,e
	ld c,a
	ld a,d
	adc a,$00
	ld b,a
	ld a,[bc]
	cp $FF
	jr z,Logged_0xD10F
	ld [hld],a
	ld a,[hl]
	add a,$02
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hli],a

Logged_0xD10D:
	inc hl
	ret

Logged_0xD10F:
	dec hl
	xor a
	ld [hld],a
	ld [hli],a
	inc hl
	ld a,$01
	ld [$CCE6],a
	ret
	ld a,[$CED4]
	and a
	ret nz
	ld hl,$C0A3
	call Logged_0x0BDB
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	call Logged_0xD132
	ret

Logged_0xD132:
	ld e,$0C

Logged_0xD134:
	bit 7,[hl]
	jr z,Logged_0xD16D
	push hl
	call Logged_0x0D8C
	ld a,[hl]
	bit 0,b
	jr z,Logged_0xD143
	swap a

Logged_0xD143:
	and $0F
	ld c,a
	pop hl
	jr z,Logged_0xD16D
	push de
	push bc
	call Logged_0x0D3E
	ld d,h
	ld e,l
	push hl
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$19
	ld [$FF00+$85],a
	ld a,$E5
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	pop hl
	pop bc
	pop de

Logged_0xD16D:
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0xD182
	ld h,$A0
	ld a,[$CCE9]
	inc a
	ld [$CCE9],a
	ld [$C08E],a
	ld [$4100],a

Logged_0xD182:
	dec e
	jr nz,Logged_0xD134
	ret
	ld a,[$CED4]
	and a
	ret nz
	ld hl,$C0A3
	call Logged_0x0BDB
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	call Logged_0xD19E
	ret

Logged_0xD19E:
	ld e,$0D

Logged_0xD1A0:
	bit 7,[hl]
	jr z,Logged_0xD1D9
	push hl
	call Logged_0x0D8C
	ld a,[hl]
	bit 0,b
	jr z,Logged_0xD1AF
	swap a

Logged_0xD1AF:
	and $0F
	ld c,a
	pop hl
	jr z,Logged_0xD1D9
	push de
	push bc
	call Logged_0x0D3E
	ld d,h
	ld e,l
	push hl
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$19
	ld [$FF00+$85],a
	ld a,$E5
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	pop af
	ld [$FF00+$70],a
	pop hl
	pop bc
	pop de

Logged_0xD1D9:
	ld a,b
	xor $01
	ld b,a
	inc l
	dec e
	jr nz,Logged_0xD1A0
	ret
	ld hl,$4000
	ld de,$8800
	ld bc,$0800
	call Logged_0x0434
	ld a,$26
	ld [$FF00+$85],a
	ld a,$90
	ld [$FF00+$8D],a
	ld a,$6A
	ld [$FF00+$8E],a
	call $FF80
	ret

LoggedData_0xD1FE:
INCBIN "baserom.gbc", $D1FE, $D206 - $D1FE

UnknownData_0xD206:
INCBIN "baserom.gbc", $D206, $D20E - $D206

LoggedData_0xD20E:
INCBIN "baserom.gbc", $D20E, $D236 - $D20E

UnknownData_0xD236:
INCBIN "baserom.gbc", $D236, $D24E - $D236

LoggedData_0xD24E:
INCBIN "baserom.gbc", $D24E, $D26C - $D24E

UnknownData_0xD26C:
INCBIN "baserom.gbc", $D26C, $D278 - $D26C

LoggedData_0xD278:
INCBIN "baserom.gbc", $D278, $D34A - $D278

UnknownData_0xD34A:
INCBIN "baserom.gbc", $D34A, $D386 - $D34A

LoggedData_0xD386:
INCBIN "baserom.gbc", $D386, $D3F1 - $D386

UnknownData_0xD3F1:
INCBIN "baserom.gbc", $D3F1, $D437 - $D3F1

LoggedData_0xD437:
INCBIN "baserom.gbc", $D437, $D4CE - $D437

UnknownData_0xD4CE:
INCBIN "baserom.gbc", $D4CE, $D4EA - $D4CE

LoggedData_0xD4EA:
INCBIN "baserom.gbc", $D4EA, $D514 - $D4EA

UnknownData_0xD514:
INCBIN "baserom.gbc", $D514, $D525 - $D514

LoggedData_0xD525:
INCBIN "baserom.gbc", $D525, $D912 - $D525

UnknownData_0xD912:
INCBIN "baserom.gbc", $D912, $10000 - $D912

SECTION "Bank04", ROMX, BANK[$04]

LoggedData_0x10000:
INCBIN "baserom.gbc", $10000, $10800 - $10000

UnknownData_0x10800:
INCBIN "baserom.gbc", $10800, $14000 - $10800

SECTION "Bank05", ROMX, BANK[$05]

LoggedData_0x14000:
INCBIN "baserom.gbc", $14000, $14002 - $14000

UnknownData_0x14002:
INCBIN "baserom.gbc", $14002, $14008 - $14002

LoggedData_0x14008:
INCBIN "baserom.gbc", $14008, $1400A - $14008

UnknownData_0x1400A:
INCBIN "baserom.gbc", $1400A, $1401C - $1400A

LoggedData_0x1401C:
INCBIN "baserom.gbc", $1401C, $14024 - $1401C

UnknownData_0x14024:
INCBIN "baserom.gbc", $14024, $14028 - $14024

LoggedData_0x14028:
INCBIN "baserom.gbc", $14028, $14041 - $14028

UnknownData_0x14041:
INCBIN "baserom.gbc", $14041, $1408C - $14041

LoggedData_0x1408C:
INCBIN "baserom.gbc", $1408C, $140A5 - $1408C

UnknownData_0x140A5:
INCBIN "baserom.gbc", $140A5, $14186 - $140A5

LoggedData_0x14186:
INCBIN "baserom.gbc", $14186, $141EA - $14186

UnknownData_0x141EA:
INCBIN "baserom.gbc", $141EA, $14252 - $141EA

LoggedData_0x14252:
INCBIN "baserom.gbc", $14252, $1427C - $14252

UnknownData_0x1427C:
INCBIN "baserom.gbc", $1427C, $1429C - $1427C

LoggedData_0x1429C:
INCBIN "baserom.gbc", $1429C, $142BC - $1429C

UnknownData_0x142BC:
INCBIN "baserom.gbc", $142BC, $142DC - $142BC

LoggedData_0x142DC:
INCBIN "baserom.gbc", $142DC, $142E4 - $142DC

UnknownData_0x142E4:
INCBIN "baserom.gbc", $142E4, $142E8 - $142E4

LoggedData_0x142E8:
INCBIN "baserom.gbc", $142E8, $143B4 - $142E8

UnknownData_0x143B4:
INCBIN "baserom.gbc", $143B4, $14584 - $143B4

LoggedData_0x14584:
INCBIN "baserom.gbc", $14584, $14714 - $14584

UnknownData_0x14714:
INCBIN "baserom.gbc", $14714, $148E4 - $14714

LoggedData_0x148E4:
INCBIN "baserom.gbc", $148E4, $14948 - $148E4

UnknownData_0x14948:
INCBIN "baserom.gbc", $14948, $14982 - $14948

LoggedData_0x14982:
INCBIN "baserom.gbc", $14982, $149D6 - $14982

UnknownData_0x149D6:
INCBIN "baserom.gbc", $149D6, $149FE - $149D6

LoggedData_0x149FE:
INCBIN "baserom.gbc", $149FE, $14A3E - $149FE

UnknownData_0x14A3E:
INCBIN "baserom.gbc", $14A3E, $14A6C - $14A3E

LoggedData_0x14A6C:
INCBIN "baserom.gbc", $14A6C, $14A78 - $14A6C

UnknownData_0x14A78:
INCBIN "baserom.gbc", $14A78, $14A79 - $14A78

LoggedData_0x14A79:
INCBIN "baserom.gbc", $14A79, $14A7B - $14A79

UnknownData_0x14A7B:
INCBIN "baserom.gbc", $14A7B, $14A82 - $14A7B

LoggedData_0x14A82:
INCBIN "baserom.gbc", $14A82, $14CE1 - $14A82

UnknownData_0x14CE1:
INCBIN "baserom.gbc", $14CE1, $14CF6 - $14CE1

LoggedData_0x14CF6:
INCBIN "baserom.gbc", $14CF6, $15278 - $14CF6

UnknownData_0x15278:
INCBIN "baserom.gbc", $15278, $1527A - $15278

LoggedData_0x1527A:
INCBIN "baserom.gbc", $1527A, $15496 - $1527A

UnknownData_0x15496:
INCBIN "baserom.gbc", $15496, $154BB - $15496

LoggedData_0x154BB:
INCBIN "baserom.gbc", $154BB, $15568 - $154BB

UnknownData_0x15568:
INCBIN "baserom.gbc", $15568, $15569 - $15568

LoggedData_0x15569:
INCBIN "baserom.gbc", $15569, $155A8 - $15569

UnknownData_0x155A8:
INCBIN "baserom.gbc", $155A8, $155AB - $155A8

LoggedData_0x155AB:
INCBIN "baserom.gbc", $155AB, $155B0 - $155AB

UnknownData_0x155B0:
INCBIN "baserom.gbc", $155B0, $155BE - $155B0

LoggedData_0x155BE:
INCBIN "baserom.gbc", $155BE, $155E0 - $155BE

UnknownData_0x155E0:
INCBIN "baserom.gbc", $155E0, $155EC - $155E0

LoggedData_0x155EC:
INCBIN "baserom.gbc", $155EC, $1571A - $155EC

UnknownData_0x1571A:
INCBIN "baserom.gbc", $1571A, $157B8 - $1571A

LoggedData_0x157B8:
INCBIN "baserom.gbc", $157B8, $15903 - $157B8

UnknownData_0x15903:
INCBIN "baserom.gbc", $15903, $15924 - $15903

LoggedData_0x15924:
INCBIN "baserom.gbc", $15924, $15985 - $15924

UnknownData_0x15985:
INCBIN "baserom.gbc", $15985, $15987 - $15985

LoggedData_0x15987:
INCBIN "baserom.gbc", $15987, $1599F - $15987

UnknownData_0x1599F:
INCBIN "baserom.gbc", $1599F, $159AB - $1599F

LoggedData_0x159AB:
INCBIN "baserom.gbc", $159AB, $159B3 - $159AB

UnknownData_0x159B3:
INCBIN "baserom.gbc", $159B3, $159B7 - $159B3

LoggedData_0x159B7:
INCBIN "baserom.gbc", $159B7, $159C1 - $159B7

UnknownData_0x159C1:
INCBIN "baserom.gbc", $159C1, $159C3 - $159C1

LoggedData_0x159C3:
INCBIN "baserom.gbc", $159C3, $15C27 - $159C3

UnknownData_0x15C27:
INCBIN "baserom.gbc", $15C27, $15C40 - $15C27

LoggedData_0x15C40:
INCBIN "baserom.gbc", $15C40, $15D6C - $15C40

UnknownData_0x15D6C:
INCBIN "baserom.gbc", $15D6C, $15E02 - $15D6C

LoggedData_0x15E02:
INCBIN "baserom.gbc", $15E02, $15E66 - $15E02

UnknownData_0x15E66:
INCBIN "baserom.gbc", $15E66, $15E98 - $15E66

LoggedData_0x15E98:
INCBIN "baserom.gbc", $15E98, $15F21 - $15E98

UnknownData_0x15F21:
INCBIN "baserom.gbc", $15F21, $15F3A - $15F21

LoggedData_0x15F3A:
INCBIN "baserom.gbc", $15F3A, $15FDF - $15F3A

UnknownData_0x15FDF:
INCBIN "baserom.gbc", $15FDF, $15FF2 - $15FDF

LoggedData_0x15FF2:
INCBIN "baserom.gbc", $15FF2, $16002 - $15FF2

UnknownData_0x16002:
INCBIN "baserom.gbc", $16002, $16009 - $16002

LoggedData_0x16009:
INCBIN "baserom.gbc", $16009, $16019 - $16009

UnknownData_0x16019:
INCBIN "baserom.gbc", $16019, $1604E - $16019

LoggedData_0x1604E:
INCBIN "baserom.gbc", $1604E, $16060 - $1604E

UnknownData_0x16060:
INCBIN "baserom.gbc", $16060, $16063 - $16060

LoggedData_0x16063:
INCBIN "baserom.gbc", $16063, $1642E - $16063

UnknownData_0x1642E:
INCBIN "baserom.gbc", $1642E, $1642F - $1642E

LoggedData_0x1642F:
INCBIN "baserom.gbc", $1642F, $16462 - $1642F

UnknownData_0x16462:
INCBIN "baserom.gbc", $16462, $16472 - $16462

LoggedData_0x16472:
INCBIN "baserom.gbc", $16472, $1656E - $16472

UnknownData_0x1656E:
INCBIN "baserom.gbc", $1656E, $1665E - $1656E

LoggedData_0x1665E:
INCBIN "baserom.gbc", $1665E, $16732 - $1665E

UnknownData_0x16732:
INCBIN "baserom.gbc", $16732, $1673C - $16732

LoggedData_0x1673C:
INCBIN "baserom.gbc", $1673C, $16EBB - $1673C

UnknownData_0x16EBB:
INCBIN "baserom.gbc", $16EBB, $16EBD - $16EBB

LoggedData_0x16EBD:
INCBIN "baserom.gbc", $16EBD, $1701C - $16EBD

UnknownData_0x1701C:
INCBIN "baserom.gbc", $1701C, $17031 - $1701C

LoggedData_0x17031:
INCBIN "baserom.gbc", $17031, $17192 - $17031

UnknownData_0x17192:
INCBIN "baserom.gbc", $17192, $17193 - $17192

LoggedData_0x17193:
INCBIN "baserom.gbc", $17193, $171BF - $17193

UnknownData_0x171BF:
INCBIN "baserom.gbc", $171BF, $171C0 - $171BF

LoggedData_0x171C0:
INCBIN "baserom.gbc", $171C0, $1781E - $171C0

UnknownData_0x1781E:
INCBIN "baserom.gbc", $1781E, $1781F - $1781E

LoggedData_0x1781F:
INCBIN "baserom.gbc", $1781F, $17821 - $1781F

UnknownData_0x17821:
INCBIN "baserom.gbc", $17821, $17822 - $17821

LoggedData_0x17822:
INCBIN "baserom.gbc", $17822, $17884 - $17822

UnknownData_0x17884:
INCBIN "baserom.gbc", $17884, $17887 - $17884

LoggedData_0x17887:
INCBIN "baserom.gbc", $17887, $17E59 - $17887

UnknownData_0x17E59:
INCBIN "baserom.gbc", $17E59, $18000 - $17E59

SECTION "Bank06", ROMX, BANK[$06]

Logged_0x18000:
	xor a
	ld [$C0DD],a
	ld a,[$CCE9]
	ld [$C08E],a
	ld [$4100],a
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	add a,a
	ld e,a
	ld d,$00
	ld hl,$CD00
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

Logged_0x18020:
	xor a
	ld [$C08E],a
	ld [$4100],a
	xor a
	ld [$C0D8],a
	ld [$C0D9],a
	ld [$C18D],a
	ret

Logged_0x18032:
	xor a
	ld [$C08E],a
	ld [$4100],a
	xor a
	ld [$C0D8],a
	ld [$C0D9],a
	ld a,[$C0DA]
	and a
	jr z,Logged_0x18058
	ld a,[$C189]
	and a
	jr z,Logged_0x18058
	ld a,[$C0D6]
	bit 4,a
	jr z,Logged_0x18058
	xor a
	ld [$C18D],a
	ret

Logged_0x18058:
	ld a,[$FF00+$A9]
	and $F0
	ld [$FF00+$A9],a
	ld a,$01
	ld [$C18D],a
	ret

Logged_0x18064:
	xor a
	ld [$C08E],a
	ld [$4100],a
	xor a
	ld [$C0D8],a
	ld [$C0D9],a
	ld a,$10
	ld [$C18D],a
	ret

UnknownData_0x18078:
INCBIN "baserom.gbc", $18078, $1808C - $18078

Logged_0x1808C:
	xor a
	ld [$C08E],a
	ld [$4100],a
	xor a
	ld [$C0D8],a
	ld [$C0D9],a
	xor a
	ld [$C18D],a
	ret
	ld a,[$C0D6]
	bit 0,a
	jp z,Logged_0x18020
	ld a,[$FF00+$A9]
	add a,$10
	ld [$FF00+$A9],a
	ld a,[$FF00+$A8]
	adc a,$00
	ld [$FF00+$A8],a
	jr Logged_0x180F7
	ld a,[$C0DA]
	and a
	jr z,Logged_0x180C3
	ld a,[$CA83]
	cp $08
	jp z,Logged_0x18032

Logged_0x180C3:
	ld a,[$C0D6]
	and $03
	jp z,Logged_0x18020
	ld a,[$FF00+$A9]
	sub $10
	ld [$FF00+$A9],a
	ld a,[$FF00+$A8]
	sbc a,$00
	ld [$FF00+$A8],a
	jr Logged_0x180F7
	ld a,[$C0D6]
	and $03
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 1,a
	jr z,Logged_0x180F7
	ld a,[$FF00+$A9]
	and $0F
	ld b,a
	ld a,[$FF00+$AB]
	and $0F
	add a,b
	cp $10
	jp c,Logged_0x18020

Logged_0x180F7:
	ld a,[$FF00+$AB]
	and $0F
	ld c,a
	ld a,$10
	sub c
	ld c,a
	ld a,[$FF00+$A9]
	and $F0
	add a,c
	ld [$FF00+$A9],a
	ld a,[$FF00+$A8]
	adc a,$00
	ld [$FF00+$A8],a
	ld a,[$C0D6]
	and $03
	jr z,Logged_0x18126
	ld a,[$C0DA]
	and a
	jr nz,Logged_0x18121
	ld a,$11
	ld [$C18C],a
	jr Logged_0x18126

Logged_0x18121:
	ld a,$11
	ld [$C189],a

Logged_0x18126:
	jp Logged_0x18064
	ld a,[$C0D6]
	bit 0,a
	jp z,Logged_0x18020
	ld a,[$FF00+$A9]
	add a,$10
	ld [$FF00+$A9],a
	ld a,[$FF00+$A8]
	adc a,$00
	ld [$FF00+$A8],a
	jr Logged_0x1817C
	ld a,[$C0DA]
	and a
	jr z,Logged_0x1814D
	ld a,[$CA83]
	cp $08
	jp z,Logged_0x18032

Logged_0x1814D:
	ld a,[$C0D6]
	and $03
	jp z,Logged_0x18020
	ld a,[$FF00+$A9]
	sub $10
	ld [$FF00+$A9],a
	ld a,[$FF00+$A8]
	sbc a,$00
	ld [$FF00+$A8],a
	jr Logged_0x1817C
	ld a,[$C0D6]
	and $03
	jp z,Logged_0x18020
	bit 1,a
	jr z,Logged_0x1817C
	ld a,[$FF00+$A9]
	and $0F
	ld b,a
	ld a,[$FF00+$AB]
	and $0F
	cp b
	jp nc,Logged_0x18020

Logged_0x1817C:
	ld a,[$C0D6]
	and $03
	jr z,Logged_0x181A9
	ld a,[$FF00+$AB]
	and $0F
	inc a
	inc a
	ld c,a
	ld a,[$FF00+$A9]
	and $F0
	add a,c
	ld [$FF00+$A9],a
	ld a,[$FF00+$A8]
	adc a,$00
	ld [$FF00+$A8],a
	ld a,[$C0DA]
	and a
	jr nz,Logged_0x181A4
	ld a,$12
	ld [$C18C],a
	jr Logged_0x181A9

Logged_0x181A4:
	ld a,$12
	ld [$C189],a

Logged_0x181A9:
	jp Logged_0x18064

Logged_0x181AC:
	ld a,$01
	ld [$C0DD],a
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x18020
	ld a,$01
	ld [$C0DB],a
	jp Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x181AC
	ld a,$01
	ld [$CEE0],a
	jp Logged_0x181AC
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x181AC
	ld a,$04
	ld [$CEE0],a
	jp Logged_0x181AC
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x181AC
	ld a,$02
	ld [$CEE0],a
	jp Logged_0x181AC
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x181AC
	ld a,$08
	ld [$CEE0],a
	jp Logged_0x181AC

Logged_0x18208:
	ld a,$01
	ld [$C1CA],a
	ld a,[$C0D6]
	bit 0,a
	jr nz,Logged_0x18228
	bit 2,a
	jr nz,Logged_0x18228
	and $B8
	jp nz,Logged_0x18020
	ld a,[$FF00+$A9]
	and $0F
	cp $05
	jr c,Logged_0x18228
	jp Logged_0x18020

Logged_0x18228:
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA83]
	cp $8B
	jp z,Logged_0x18020
	cp $8C
	jp z,Logged_0x18020
	jp Logged_0x18032
	ld a,[$C0D6]
	bit 1,a
	jr nz,Logged_0x18257
	ld a,[$FF00+$A9]
	and $0E
	jp nz,Logged_0x181AC
	ld a,[$C0D6]
	and $05
	jr nz,Logged_0x1825A
	jp Logged_0x181AC

Logged_0x18257:
	jp Logged_0x18208

Logged_0x1825A:
	ld a,$01
	ld [$C0DD],a
	jp Logged_0x18032
	ld a,[$C0DA]
	and a
	jp nz,Logged_0x18020
	ld a,$01
	ld [$C1CA],a
	ld a,[$C0D6]
	bit 0,a
	jp nz,Logged_0x18032
	bit 2,a
	jp nz,Logged_0x18032
	and $B8
	jp nz,Logged_0x18020
	ld a,[$FF00+$A9]
	and $0F
	cp $05
	jp c,Logged_0x18032
	jp Logged_0x18020
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$C0D6]
	and $28
	jp z,Logged_0x18032
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	ld [$CA6B],a
	xor $08
	ld [hl],a
	call Logged_0x0E31
	ld a,[$CA6A]
	xor $01
	ld [$CA6A],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$2F
	ld [$FF00+$B6],a
	ld b,$10
	call Logged_0x12B5
	jp Logged_0x18032
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jr nz,Logged_0x182D4
	jp Logged_0x18020

Logged_0x182D4:
	ld a,$01
	ld [$C1C7],a
	jp Logged_0x1808C
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	jr Logged_0x182EC
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18208

Logged_0x182EC:
	ld a,[$C0D6]
	bit 7,a
	jr nz,Logged_0x182F6
	jp Logged_0x18208

Logged_0x182F6:
	ld a,$02
	ld [$C1C7],a
	jp Logged_0x1808C
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x18020
	ld a,$01
	ld [$C1C7],a
	ld a,$45
	ld [$C0D7],a
	jp Logged_0x18020

UnknownData_0x1831A:
INCBIN "baserom.gbc", $1831A, $18336 - $1831A
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$CA8C]
	and a
	jp nz,Logged_0x18020
	ld a,[$CA94]
	cp $02
	jp z,Logged_0x18020
	ld a,[$CA83]
	cp $15
	jp z,Logged_0x18020
	cp $16
	jp z,Logged_0x18020
	ld a,[$CA69]
	and a
	jr nz,Logged_0x18366
	ld a,$01
	ld [$CA69],a
	jr Logged_0x1836B

Logged_0x18366:
	ld a,$00
	ld [$CA69],a

Logged_0x1836B:
	ld a,[$CA94]
	and a
	jr nz,Logged_0x18383
	ld a,$08
	ld [$FF00+$85],a
	ld a,$F9
	ld [$FF00+$8D],a
	ld a,$46
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x18020

Logged_0x18383:
	cp $01
	jr z,Logged_0x1838A
	jp Logged_0x18020

Logged_0x1838A:
	ld a,$08
	ld [$FF00+$85],a
	ld a,$EB
	ld [$FF00+$8D],a
	ld a,$46
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x18020
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8C]
	and a
	jp nz,Logged_0x18032
	ld a,[$CA94]
	cp $02
	jp z,Logged_0x18032
	ld a,[$CA83]
	cp $15
	jp z,Logged_0x18032
	cp $16
	jp z,Logged_0x18032
	ld a,[$CA69]
	and a
	jr nz,Logged_0x183CC
	ld a,$01
	ld [$CA69],a
	jr Logged_0x183D1

Logged_0x183CC:
	ld a,$00
	ld [$CA69],a

Logged_0x183D1:
	ld a,[$CA94]
	and a
	jr nz,Unknown_0x183E9
	ld a,$08
	ld [$FF00+$85],a
	ld a,$F9
	ld [$FF00+$8D],a
	ld a,$46
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x18032

Unknown_0x183E9:
	cp $01
	jr z,Unknown_0x183F0
	jp Logged_0x18032

Unknown_0x183F0:
	ld a,$08
	ld [$FF00+$85],a
	ld a,$EB
	ld [$FF00+$8D],a
	ld a,$46
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x18032
	ld a,[$C0DA]
	and a
	jp z,Logged_0x181AC
	ld a,[$CA8C]
	and a
	jp nz,Logged_0x181AC
	ld a,[$CA83]
	cp $10
	jp z,Logged_0x181AC
	ld a,$08
	ld [$FF00+$85],a
	ld a,$0D
	ld [$FF00+$8D],a
	ld a,$48
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x181AC
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA83]
	cp $00
	jr z,Logged_0x1843D
	cp $1F
	jp nz,Logged_0x18032

Logged_0x1843D:
	ld a,[$C0D6]
	and $01
	jp z,Logged_0x18032
	ld a,[$C093]
	bit 7,a
	jp z,Logged_0x18032
	ld a,[$CA64]
	and $F0
	add a,$18
	ld [$CA64],a
	ld a,[$CA63]
	adc a,$00
	ld [$CA63],a
	jr Logged_0x1848E
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA83]
	cp $00
	jr z,Logged_0x18474
	cp $1F
	jp nz,Logged_0x18032

Logged_0x18474:
	ld a,[$C0D6]
	and $01
	jp z,Logged_0x18032
	ld a,[$C093]
	bit 7,a
	jp z,Logged_0x18032
	ld a,[$CA64]
	and $F0
	add a,$08
	ld [$CA64],a

Logged_0x1848E:
	ld a,$C1
	ld [$C0D7],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$30
	ld [$FF00+$B6],a
	ld a,$17
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA8B],a
	ld [$CA96],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$4A
	ld [$CA7F],a
	ld a,$82
	ld [$CA80],a
	ld a,$4C
	ld [$CA81],a
	ld a,$F6
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x18032
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA83]
	cp $04
	jr z,Logged_0x1850F
	cp $21
	jp nz,Logged_0x18032

Logged_0x1850F:
	ld a,[$C0D6]
	and $20
	jp z,Logged_0x18032
	ld a,[$C093]
	bit 6,a
	jp z,Logged_0x18032
	ld a,[$CA64]
	and $F0
	add a,$18
	ld [$CA64],a
	ld a,[$CA63]
	adc a,$00
	ld [$CA63],a
	jr Logged_0x18560
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA83]
	cp $04
	jr z,Logged_0x18546
	cp $21
	jp nz,Logged_0x18032

Logged_0x18546:
	ld a,[$C0D6]
	and $20
	jp z,Logged_0x18032
	ld a,[$C093]
	bit 6,a
	jp z,Logged_0x18032
	ld a,[$CA64]
	and $F0
	add a,$08
	ld [$CA64],a

Logged_0x18560:
	ld a,$C1
	ld [$C0D7],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$30
	ld [$FF00+$B6],a
	ld a,$18
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA8B],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$4A
	ld [$CA7F],a
	ld a,$82
	ld [$CA80],a
	ld a,$4C
	ld [$CA81],a
	ld a,$F6
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x18032
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x18020
	ld a,[$C094]
	bit 6,a
	jp z,Logged_0x18020
	ld a,[$CA83]
	cp $00
	jr z,Logged_0x185F2
	cp $30
	jr z,Logged_0x185F2
	cp $1F
	jp nz,Logged_0x18020

Logged_0x185F2:
	ld a,$E2
	ld [$C0D7],a
	jp Logged_0x18676
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x18020
	ld a,[$C094]
	bit 6,a
	jp z,Logged_0x18020
	ld a,[$CA83]
	cp $00
	jr z,Logged_0x1861D
	cp $1F
	jp nz,Logged_0x18020

Logged_0x1861D:
	ld a,$E3
	ld [$C0D7],a
	jr Logged_0x18676

UnknownData_0x18624:
INCBIN "baserom.gbc", $18624, $18676 - $18624

Logged_0x18676:
	ld a,[$CA64]
	and $F0
	add a,$08
	ld [$CA64],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E6
	ld [$FF00+$B6],a
	ld a,$2C
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA8B],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$4A
	ld [$CA7F],a
	ld a,$82
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x186DD
	ld a,$4D
	ld [$CA81],a
	ld a,$0B
	ld [$CA82],a
	jr Logged_0x186E7

Logged_0x186DD:
	ld a,$4D
	ld [$CA81],a
	ld a,$10
	ld [$CA82],a

Logged_0x186E7:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x18020
	ld a,[$C0DA]
	and a
	jp z,Logged_0x181AC
	ld a,[$CA8E]
	cp $06
	jr z,Logged_0x1870B
	and a
	jp nz,Logged_0x181AC

Logged_0x1870B:
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x181AC
	ld a,$01
	ld [$C0DB],a
	ld a,[$C094]
	bit 6,a
	jr z,Logged_0x18724
	ld a,$66
	ld [$C0D7],a

Logged_0x18724:
	jp Logged_0x18020
	ld a,[$C0DA]
	and a
	jp z,Logged_0x181AC
	ld a,[$CA8E]
	cp $06
	jr z,Logged_0x18739
	and a
	jp nz,Logged_0x181AC

Logged_0x18739:
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x181AC
	ld a,$01
	ld [$C0DB],a
	ld a,[$C094]
	bit 6,a
	jr z,Logged_0x18752
	ld a,$26
	ld [$C0D7],a

Logged_0x18752:
	jp Logged_0x18020

UnknownData_0x18755:
INCBIN "baserom.gbc", $18755, $1877E - $18755
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C094]
	bit 6,a
	jp z,Logged_0x18020
	ld a,[$CA8E]
	and a
	jp nz,Logged_0x18020
	ld a,[$CA83]
	cp $00
	jr z,Logged_0x187A4
	cp $30
	jr z,Logged_0x187A4
	cp $1F
	jp nz,Logged_0x18020

Logged_0x187A4:
	xor a
	ld [$CA9A],a
	ld a,$05
	ld [$CED4],a
	jp Logged_0x18020
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x18020
	ld a,$44
	ld [$C0D7],a
	jp Logged_0x18020

UnknownData_0x187C7:
INCBIN "baserom.gbc", $187C7, $187DE - $187C7
	ld a,[$C0DA]
	and a
	jp z,Logged_0x181AC
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x181AC
	ld a,$44
	ld [$C0D7],a
	jp Logged_0x181AC

UnknownData_0x187F5:
INCBIN "baserom.gbc", $187F5, $1880C - $187F5
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$CA8E]
	cp $06
	jp nz,Logged_0x18020
	call Logged_0x157A
	jp Logged_0x18020
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$CA8E]
	cp $48
	jr z,Logged_0x1883A
	cp $4B
	jp nz,Logged_0x18020
	call Logged_0x157A
	jp Logged_0x18020

Logged_0x1883A:
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$71
	ld [$FF00+$8D],a
	ld a,$5E
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x18020
	ld a,$01
	ld [$C0DD],a
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x18020
	ld a,$01
	ld [$CAA0],a
	jp Logged_0x18020
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$CA8E]
	cp $4B
	jp nz,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x18032
	ld a,[$CA64]
	and $08
	jr nz,Unknown_0x1889E
	ld a,[$CA72]
	ld b,a
	ld a,[$CA64]
	and $F0
	sub b
	ld [$CA64],a
	ld a,[$CA63]
	sbc a,$00
	ld [$CA63],a
	jp Logged_0x18032

Unknown_0x1889E:
	ld a,[$CA71]
	ld b,a
	ld a,$10
	sub b
	ld b,a
	ld a,[$CA64]
	and $F0
	add a,b
	ld [$CA64],a
	ld a,[$CA63]
	adc a,$00
	ld [$CA63],a
	jp Logged_0x18032
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	jp Logged_0x18020
	ld a,$01
	ld [$C0DD],a
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jp z,Logged_0x18020
	ld a,$02
	ld [$C0DB],a
	jp Logged_0x18020
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	and $47
	jp nz,Logged_0x18020
	ld a,[$CA8C]
	and a
	jp nz,Logged_0x18020
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x18020
	ld a,$C1
	ld [$CA8E],a
	ld a,$01
	ld [$CA8F],a
	ld a,$02
	ld [$CA93],a
	ld a,$02
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld a,$02
	ld [$CA90],a
	ld a,$58
	ld [$CA91],a
	call Logged_0x161A
	ld a,$08
	ld [$FF00+$85],a
	ld a,$CF
	ld [$FF00+$8D],a
	ld a,$4E
	ld [$FF00+$8E],a
	call $FF80
	ret
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jr nz,Logged_0x18945
	jp Logged_0x18020

Logged_0x18945:
	ld a,$01
	ld [$C1C8],a
	jp Logged_0x1808C
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$C0D6]
	bit 7,a
	jr nz,Logged_0x1895E
	jp Logged_0x18020

Logged_0x1895E:
	ld a,[$CA8C]
	and a
	jp nz,Logged_0x18020
	ld a,$01
	ld [$C1C9],a
	ld a,[$CA8E]
	and a
	jp nz,Logged_0x18020
	ld a,$12
	ld [$CA8E],a
	ld a,$02
	ld [$CA93],a
	ld a,$01
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$A6
	ld [$FF00+$8D],a
	ld a,$50
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x18020
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$C0D6]
	and $01
	jp z,Logged_0x18032
	ld a,$01
	ld [$C0DE],a
	jp Logged_0x18032
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18208
	ld a,[$C0D6]
	and $01
	jp z,Logged_0x18208
	ld a,$01
	ld [$C0DE],a
	jp Logged_0x18208
	ld a,[$C1B4]
	cp $07
	jr z,Logged_0x189D1
	cp $04
	jp nc,Logged_0x18020

Logged_0x189D1:
	jp Logged_0x18208
	ld a,[$C1B4]
	cp $03
	jp c,Logged_0x18020
	jp Logged_0x18208
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	ld a,[$CA8E]
	cp $42
	jp z,Logged_0x18020
	jp Logged_0x18032
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18020
	jp Logged_0x18208
	ld b,$78
	jr Logged_0x18A19
	ld b,$79
	jr Logged_0x18A19
	ld b,$7A
	jr Logged_0x18A19
	ld b,$7B
	jr Logged_0x18A19
	ld b,$7C
	jr Logged_0x18A19

UnknownData_0x18A0F:
INCBIN "baserom.gbc", $18A0F, $18A19 - $18A0F

Logged_0x18A19:
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Logged_0x18A36
	bit 5,a
	jr nz,Logged_0x18A45
	bit 3,a
	jr nz,Logged_0x18A45
	and $42
	jr nz,Logged_0x18A5C
	jp Logged_0x18032

Logged_0x18A36:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x18A5C
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x18A5C
	jp Logged_0x18032

Logged_0x18A45:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x18A5C
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x18A5C
	jp Logged_0x18032

Logged_0x18A5C:
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	and $80
	or b
	ld [hl],a
	push hl
	call Logged_0x0E31
	pop hl
	call Logged_0x19690
	ld a,[$CA9D]
	and a
	jp nz,Logged_0x18020
	ld a,[$CA8E]
	cp $84
	jp z,Logged_0x18020
	ld a,[$CA96]
	and a
	jr nz,Unknown_0x18A8F
	ld a,[$CA3C]
	cp $05
	jp c,Logged_0x18032
	jp Logged_0x18020

Unknown_0x18A8F:
	ld a,[$CA3C]
	cp $06
	jp c,Logged_0x18032
	jp Logged_0x18020

UnknownData_0x18A9A:
INCBIN "baserom.gbc", $18A9A, $18AA6 - $18A9A
	ld b,$78
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18AD6
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $50
	jp nz,Logged_0x18032
	ld a,[$CA8F]
	cp $01
	jp c,Logged_0x18032
	ld a,$01
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x18AD6:
	or $01
	ld [$CEDA],a
	jp Logged_0x18F32

UnknownData_0x18ADE:
INCBIN "baserom.gbc", $18ADE, $18AEA - $18ADE
	ld b,$78
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18B17
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $50
	jp nz,Logged_0x18032
	ld a,[$CA8F]
	cp $01
	jp c,Logged_0x18032
	ld a,$03
	ld [$CEDA],a

Logged_0x18B17:
	or $03
	ld [$CEDA],a
	jp Logged_0x18F32

UnknownData_0x18B1F:
INCBIN "baserom.gbc", $18B1F, $18B23 - $18B1F
	ld b,$7A
	jr Logged_0x18B2D

UnknownData_0x18B27:
INCBIN "baserom.gbc", $18B27, $18B2B - $18B27
	ld b,$78

Logged_0x18B2D:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18B5B
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $50
	jp nz,Logged_0x18032
	ld a,[$CA8F]
	cp $01
	jp c,Logged_0x18032
	ld a,$02
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x18B5B:
	or $02
	ld [$CEDA],a
	jp Logged_0x18F32

UnknownData_0x18B63:
INCBIN "baserom.gbc", $18B63, $18B67 - $18B63
	ld b,$7A
	jr Logged_0x18B71

UnknownData_0x18B6B:
INCBIN "baserom.gbc", $18B6B, $18B6F - $18B6B
	ld b,$78

Logged_0x18B71:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18B9F
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $50
	jp nz,Logged_0x18032
	ld a,[$CA8F]
	cp $01
	jp c,Logged_0x18032
	ld a,$04
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x18B9F:
	or $04
	ld [$CEDA],a
	jp Logged_0x18F32

UnknownData_0x18BA7:
INCBIN "baserom.gbc", $18BA7, $18BB3 - $18BA7
	ld b,$78
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18BE3
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $50
	jp nz,Logged_0x18032
	ld a,[$CA8F]
	cp $03
	jp nz,Logged_0x18032
	ld a,$01
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x18BE3:
	or $01
	ld [$CEDA],a
	jp Logged_0x18F32

UnknownData_0x18BEB:
INCBIN "baserom.gbc", $18BEB, $18BF7 - $18BEB
	ld b,$78
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18C24
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $50
	jp nz,Logged_0x18032
	ld a,[$CA8F]
	cp $03
	jp nz,Logged_0x18032
	ld a,$03
	ld [$CEDA],a

Logged_0x18C24:
	or $03
	ld [$CEDA],a
	jp Logged_0x18F32

UnknownData_0x18C2C:
INCBIN "baserom.gbc", $18C2C, $18C30 - $18C2C
	ld b,$7A
	jr Logged_0x18C3A

UnknownData_0x18C34:
INCBIN "baserom.gbc", $18C34, $18C38 - $18C34
	ld b,$78

Logged_0x18C3A:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18C68
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $50
	jp nz,Logged_0x18032
	ld a,[$CA8F]
	cp $03
	jp nz,Logged_0x18032
	ld a,$02
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x18C68:
	or $02
	ld [$CEDA],a
	jp Logged_0x18F32

UnknownData_0x18C70:
INCBIN "baserom.gbc", $18C70, $18C74 - $18C70
	ld b,$7A
	jr Logged_0x18C7E

UnknownData_0x18C78:
INCBIN "baserom.gbc", $18C78, $18C7C - $18C78
	ld b,$78

Logged_0x18C7E:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18CAC
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $50
	jp nz,Logged_0x18032
	ld a,[$CA8F]
	cp $03
	jp nz,Logged_0x18032
	ld a,$04
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x18CAC:
	or $04
	ld [$CEDA],a
	jp Logged_0x18F32
	ld b,$78
	jr Logged_0x18CD2
	ld b,$79
	jr Logged_0x18CD2
	ld b,$7A
	jr Logged_0x18CD2
	ld b,$7B
	jr Logged_0x18CD2
	ld b,$7C
	jr Logged_0x18CD2
	ld b,$7D
	jr Logged_0x18CD2
	ld b,$7E
	jr Logged_0x18CD2
	ld b,$7F

Logged_0x18CD2:
	ld a,[$C0D9]
	cp $02
	jp z,Logged_0x19423
	cp $03
	jp z,Logged_0x18020
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Logged_0x18CFC
	bit 5,a
	jr nz,Logged_0x18D0B
	bit 3,a
	jr nz,Logged_0x18D0B
	and $42
	jr nz,Logged_0x18D22
	jp Logged_0x18032

Logged_0x18CFC:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x18D22
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x18D22
	jp Logged_0x18032

Logged_0x18D0B:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x18D22
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x18D22
	jp Logged_0x18032

Logged_0x18D22:
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	and $80
	or b
	ld [hl],a
	push hl
	call Logged_0x0E31
	pop hl
	call Logged_0x19609
	ld a,[$CA9D]
	and a
	jp nz,Logged_0x18020
	ld a,[$CA8E]
	cp $84
	jp z,Logged_0x18020
	ld a,[$CA96]
	and a
	jr nz,Logged_0x18D55
	ld a,[$CA3C]
	cp $05
	jp c,Logged_0x18032
	jp Logged_0x18020

Logged_0x18D55:
	ld a,[$CA3C]
	cp $06
	jp c,Logged_0x18032
	jp Logged_0x18020
	ld b,$78
	jr Logged_0x18D7E
	ld b,$79
	jr Logged_0x18D7E
	ld b,$7A
	jr Logged_0x18D7E
	ld b,$7B
	jr Logged_0x18D7E
	ld b,$7C
	jr Logged_0x18D7E
	ld b,$7D
	jr Logged_0x18D7E
	ld b,$7E
	jr Logged_0x18D7E
	ld b,$7F

Logged_0x18D7E:
	ld a,[$C0D9]
	cp $02
	jp z,Logged_0x19423
	cp $03
	jp z,Logged_0x18020
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $84
	jr z,Logged_0x18DB7
	ld a,[$CA3C]
	cp $05
	jp c,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Logged_0x18DCB
	bit 5,a
	jr nz,Logged_0x18DDA
	bit 3,a
	jr nz,Logged_0x18DDA
	and $42
	jr nz,Logged_0x18DC1
	jp Logged_0x18032

Logged_0x18DB7:
	ld a,[$C0D6]
	and $42
	jr nz,Logged_0x18DF1
	jp Logged_0x18032

Logged_0x18DC1:
	ld a,[$CA3C]
	cp $06
	jr nc,Logged_0x18DF1
	jp Logged_0x18032

Logged_0x18DCB:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x18DF1
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x18DF1
	jp Logged_0x18032

Logged_0x18DDA:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x18DF1
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x18DF1
	jp Logged_0x18032

Logged_0x18DF1:
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	and $80
	or b
	ld [hl],a
	push hl
	call Logged_0x0E31
	pop hl
	call Logged_0x19609
	ld a,[$CA9D]
	and a
	jp nz,Logged_0x18020
	jp Logged_0x18032
	ld b,$79
	jr Logged_0x18E2C

UnknownData_0x18E12:
INCBIN "baserom.gbc", $18E12, $18E1A - $18E12
	ld b,$7C
	jr Logged_0x18E2C

UnknownData_0x18E1E:
INCBIN "baserom.gbc", $18E1E, $18E26 - $18E1E
	ld b,$7F
	jr Logged_0x18E2C
	ld b,$78

Logged_0x18E2C:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18E92
	ld a,[$C0D9]
	cp $03
	jp z,Logged_0x18020
	cp $02
	jr z,Unknown_0x18E9A
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Logged_0x18E64
	bit 5,a
	jr nz,Logged_0x18E73
	bit 3,a
	jr nz,Logged_0x18E73
	and $42
	jr nz,Logged_0x18E8A
	jp Logged_0x18032

Logged_0x18E64:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x18E8A
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x18E8A
	jp Logged_0x18032

Logged_0x18E73:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x18E8A
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x18E8A
	jp Logged_0x18032

Logged_0x18E8A:
	ld a,$01
	ld [$CEDA],a
	jp Logged_0x19086

Logged_0x18E92:
	or $01
	ld [$CEDA],a
	jp Logged_0x18F32

Unknown_0x18E9A:
	ld a,$01
	ld [$CEDA],a
	jp Logged_0x18F32
	ld b,$79
	jr Logged_0x18EC0

UnknownData_0x18EA6:
INCBIN "baserom.gbc", $18EA6, $18EAE - $18EA6
	ld b,$7C
	jr Logged_0x18EC0

UnknownData_0x18EB2:
INCBIN "baserom.gbc", $18EB2, $18EBE - $18EB2
	ld b,$78

Logged_0x18EC0:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18F26
	ld a,[$C0D9]
	cp $03
	jp z,Logged_0x18020
	cp $02
	jr z,Unknown_0x18F2D
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Logged_0x18EF8
	bit 5,a
	jr nz,Logged_0x18F07
	bit 3,a
	jr nz,Logged_0x18F07
	and $42
	jr nz,Logged_0x18F1E
	jp Logged_0x18032

Logged_0x18EF8:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x18F1E
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x18F1E
	jp Logged_0x18032

Logged_0x18F07:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x18F1E
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x18F1E
	jp Logged_0x18032

Logged_0x18F1E:
	ld a,$03
	ld [$CEDA],a
	jp Logged_0x19086

Logged_0x18F26:
	or $03
	ld [$CEDA],a
	jr Logged_0x18F32

Unknown_0x18F2D:
	ld a,$03
	ld [$CEDA],a

Logged_0x18F32:
	ld a,[$C08E]
	ld [$CEDB],a
	ld hl,$CCEA
	ld a,[hli]
	ld [$CEDC],a
	ld d,a
	ld a,[hl]
	ld [$CEDD],a
	ld e,a
	ld a,[de]
	ld [$CEDF],a
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	and $80
	or b
	ld [hl],a
	push hl
	call Logged_0x0E31
	pop hl
	call Logged_0x19609
	jp Logged_0x18020
	ld b,$79
	jr Logged_0x18F7D

UnknownData_0x18F63:
INCBIN "baserom.gbc", $18F63, $18F6B - $18F63
	ld b,$7C
	jr Logged_0x18F7D

UnknownData_0x18F6F:
INCBIN "baserom.gbc", $18F6F, $18F7B - $18F6F
	ld b,$78

Logged_0x18F7D:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x18FE3
	ld a,[$C0D9]
	cp $03
	jp z,Logged_0x18020
	cp $02
	jr z,Unknown_0x18FEB
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Logged_0x18FB5
	bit 5,a
	jr nz,Unknown_0x18FC4
	bit 3,a
	jr nz,Unknown_0x18FC4
	and $42
	jr nz,Logged_0x18FDB
	jp Logged_0x18032

Logged_0x18FB5:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x18FDB
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x18FDB
	jp Logged_0x18032

Unknown_0x18FC4:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x18FDB
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x18FDB
	jp Logged_0x18032

Logged_0x18FDB:
	ld a,$02
	ld [$CEDA],a
	jp Logged_0x19086

Logged_0x18FE3:
	or $02
	ld [$CEDA],a
	jp Logged_0x18F32

Unknown_0x18FEB:
	ld a,$02
	ld [$CEDA],a
	jp Logged_0x18F32
	ld b,$79
	jr Logged_0x19011

UnknownData_0x18FF7:
INCBIN "baserom.gbc", $18FF7, $18FFF - $18FF7
	ld b,$7C
	jr Logged_0x19011

UnknownData_0x19003:
INCBIN "baserom.gbc", $19003, $19007 - $19003
	ld b,$7E
	jr Logged_0x19011

UnknownData_0x1900B:
INCBIN "baserom.gbc", $1900B, $1900F - $1900B
	ld b,$78

Logged_0x19011:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x19076
	ld a,[$C0D9]
	cp $03
	jp z,Logged_0x18020
	cp $02
	jr z,Unknown_0x1907E
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Logged_0x19049
	bit 5,a
	jr nz,Unknown_0x19058
	bit 3,a
	jr nz,Unknown_0x19058
	and $42
	jr nz,Logged_0x1906F
	jp Logged_0x18032

Logged_0x19049:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x1906F
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x1906F
	jp Logged_0x18032

Unknown_0x19058:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x1906F
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x1906F
	jp Logged_0x18032

Logged_0x1906F:
	ld a,$04
	ld [$CEDA],a
	jr Logged_0x19086

Logged_0x19076:
	or $04
	ld [$CEDA],a
	jp Logged_0x18F32

Unknown_0x1907E:
	ld a,$04
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x19086:
	ld a,[$C08E]
	ld [$CEDB],a
	ld hl,$CCEA
	ld a,[hli]
	ld [$CEDC],a
	ld d,a
	ld a,[hl]
	ld [$CEDD],a
	ld e,a
	ld a,[de]
	ld [$CEDF],a
	ld a,$01
	ld [$CA73],a
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	and $80
	or b
	ld [hl],a
	push hl
	call Logged_0x0E31
	pop hl
	call Logged_0x19609
	ld a,[$CA9D]
	and a
	jp nz,Logged_0x18020
	ld a,[$CA8E]
	cp $84
	jp z,Logged_0x18020
	ld a,[$CA96]
	and a
	jr nz,Logged_0x190D5
	ld a,[$CA3C]
	cp $05
	jp c,Logged_0x18032
	jp Logged_0x18020

Logged_0x190D5:
	ld a,[$CA3C]
	cp $06
	jp c,Logged_0x18032
	jp Logged_0x18020

UnknownData_0x190E0:
INCBIN "baserom.gbc", $190E0, $190E4 - $190E0
	ld b,$7A
	jr Logged_0x190FE
	ld b,$7B
	jr Logged_0x190FE

UnknownData_0x190EC:
INCBIN "baserom.gbc", $190EC, $190FC - $190EC
	ld b,$78

Logged_0x190FE:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18032
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x19185
	ld a,[$C0D9]
	cp $03
	jp z,Logged_0x18020
	cp $02
	jr z,Unknown_0x1918D
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $84
	jr z,Unknown_0x19145
	ld a,[$CA3C]
	cp $05
	jp c,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Logged_0x1914F
	bit 5,a
	jr nz,Logged_0x1915E
	bit 3,a
	jr nz,Logged_0x1915E
	and $42
	jr nz,Unknown_0x19175
	jp Logged_0x18032

Unknown_0x19145:
	ld a,[$C0D6]
	and $42
	jr nz,Logged_0x1917D
	jp Logged_0x18032

Logged_0x1914F:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x1917D
	ld a,[$CA9D]
	and a
	jr nz,Unknown_0x19175
	jp Logged_0x18032

Logged_0x1915E:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x1917D
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x1917D
	jp Logged_0x18032

Unknown_0x19175:
	ld a,[$CA3C]
	cp $06
	jp c,Logged_0x18032

Logged_0x1917D:
	ld a,$01
	ld [$CEDA],a
	jp Logged_0x193DC

Logged_0x19185:
	or $01
	ld [$CEDA],a
	jp Logged_0x19246

Unknown_0x1918D:
	ld a,$01
	ld [$CEDA],a
	jp Logged_0x19246

UnknownData_0x19195:
INCBIN "baserom.gbc", $19195, $19199 - $19195
	ld b,$7A
	jr Logged_0x191B3
	ld b,$7B
	jr Logged_0x191B3

UnknownData_0x191A1:
INCBIN "baserom.gbc", $191A1, $191B1 - $191A1
	ld b,$78

Logged_0x191B3:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18032
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x1923A
	ld a,[$C0D9]
	cp $03
	jp z,Logged_0x18020
	cp $02
	jr z,Unknown_0x19241
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $84
	jr z,Unknown_0x191FA
	ld a,[$CA3C]
	cp $05
	jp c,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Logged_0x19204
	bit 5,a
	jr nz,Logged_0x19213
	bit 3,a
	jr nz,Logged_0x19213
	and $42
	jr nz,Unknown_0x1922A
	jp Logged_0x18032

Unknown_0x191FA:
	ld a,[$C0D6]
	and $42
	jr nz,Logged_0x19232
	jp Logged_0x18032

Logged_0x19204:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x19232
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x19232
	jp Logged_0x18032

Logged_0x19213:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x19232
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x19232
	jp Logged_0x18032

Unknown_0x1922A:
	ld a,[$CA3C]
	cp $06
	jp c,Logged_0x18032

Logged_0x19232:
	ld a,$03
	ld [$CEDA],a
	jp Logged_0x193DC

Logged_0x1923A:
	or $03
	ld [$CEDA],a
	jr Logged_0x19246

Unknown_0x19241:
	ld a,$03
	ld [$CEDA],a

Logged_0x19246:
	ld a,[$C08E]
	ld [$CEDB],a
	ld hl,$CCEA
	ld a,[hli]
	ld [$CEDC],a
	ld d,a
	ld a,[hl]
	ld [$CEDD],a
	ld e,a
	ld a,[de]
	ld [$CEDF],a
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	and $80
	or b
	ld [hl],a
	push hl
	call Logged_0x0E31
	pop hl
	call Logged_0x19609
	jp Logged_0x18020

UnknownData_0x19273:
INCBIN "baserom.gbc", $19273, $19277 - $19273
	ld b,$7A
	jr Logged_0x19291
	ld b,$7B
	jr Logged_0x19291

UnknownData_0x1927F:
INCBIN "baserom.gbc", $1927F, $1928F - $1927F
	ld b,$78

Logged_0x19291:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18032
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x19318
	ld a,[$C0D9]
	cp $03
	jp z,Logged_0x18020
	cp $02
	jr z,Unknown_0x19320
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $84
	jr z,Unknown_0x192D8
	ld a,[$CA3C]
	cp $05
	jp c,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Logged_0x192E2
	bit 5,a
	jr nz,Unknown_0x192F1
	bit 3,a
	jr nz,Unknown_0x192F1
	and $42
	jr nz,Logged_0x19308
	jp Logged_0x18032

Unknown_0x192D8:
	ld a,[$C0D6]
	and $42
	jr nz,Logged_0x19310
	jp Logged_0x18032

Logged_0x192E2:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x19310
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x19310
	jp Logged_0x18032

Unknown_0x192F1:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x19310
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x19310
	jp Logged_0x18032

Logged_0x19308:
	ld a,[$CA3C]
	cp $06
	jp c,Logged_0x18032

Logged_0x19310:
	ld a,$02
	ld [$CEDA],a
	jp Logged_0x193DC

Logged_0x19318:
	or $02
	ld [$CEDA],a
	jp Logged_0x19246

Unknown_0x19320:
	ld a,$02
	ld [$CEDA],a
	jp Logged_0x19246

UnknownData_0x19328:
INCBIN "baserom.gbc", $19328, $1932C - $19328
	ld b,$7A
	jr Logged_0x19346
	ld b,$7B
	jr Logged_0x19346

UnknownData_0x19334:
INCBIN "baserom.gbc", $19334, $19344 - $19334
	ld b,$78

Logged_0x19346:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18032
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x193CC
	ld a,[$C0D9]
	cp $03
	jp z,Logged_0x18020
	cp $02
	jr z,Unknown_0x193D4
	ld a,[$C0D8]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $84
	jr z,Unknown_0x1938D
	ld a,[$CA3C]
	cp $05
	jp c,Logged_0x18032
	ld a,[$C0D6]
	bit 4,a
	jr nz,Unknown_0x19397
	bit 5,a
	jr nz,Unknown_0x193A6
	bit 3,a
	jr nz,Unknown_0x193A6
	and $42
	jr nz,Logged_0x193BD
	jp Logged_0x18032

Unknown_0x1938D:
	ld a,[$C0D6]
	and $42
	jr nz,Logged_0x193C5
	jp Logged_0x18032

Unknown_0x19397:
	ld a,[$CA89]
	and a
	jr nz,Logged_0x193C5
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x193C5
	jp Logged_0x18032

Unknown_0x193A6:
	ld a,[$CA3C]
	cp $03
	jp c,Logged_0x18032
	ld a,[$CA74]
	and a
	jr nz,Logged_0x193C5
	ld a,[$CA6D]
	and a
	jr nz,Logged_0x193C5
	jp Logged_0x18032

Logged_0x193BD:
	ld a,[$CA3C]
	cp $06
	jp c,Logged_0x18032

Logged_0x193C5:
	ld a,$04
	ld [$CEDA],a
	jr Logged_0x193DC

Logged_0x193CC:
	or $04
	ld [$CEDA],a
	jp Logged_0x19246

Unknown_0x193D4:
	ld a,$04
	ld [$CEDA],a
	jp Logged_0x19246

Logged_0x193DC:
	ld a,[$C08E]
	ld [$CEDB],a
	ld hl,$CCEA
	ld a,[hli]
	ld [$CEDC],a
	ld d,a
	ld a,[hl]
	ld [$CEDD],a
	ld e,a
	ld a,[de]
	ld [$CEDF],a
	ld a,$01
	ld [$CA73],a
	jp Logged_0x18DF1
	ld b,$78
	jr Logged_0x19419
	ld b,$79
	jr Logged_0x19419
	ld b,$7A
	jr Logged_0x19419
	ld b,$7B
	jr Logged_0x19419
	ld b,$7C
	jr Logged_0x19419
	ld b,$7D
	jr Logged_0x19419

UnknownData_0x19413:
INCBIN "baserom.gbc", $19413, $19419 - $19413

Logged_0x19419:
	ld a,[$C0D9]
	cp $01
	jr z,Logged_0x19423
	jp Logged_0x18032

Logged_0x19423:
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	and $80
	or b
	ld [hl],a
	push hl
	call Logged_0x0E2B
	pop hl
	ld a,[$D100]
	bit 1,a
	jr z,Logged_0x19440
	call Logged_0x19609
	jp Logged_0x18020

Logged_0x19440:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$05
	ld [$FF00+$B6],a
	jp Logged_0x18020
	ld b,$78
	jr Logged_0x19469
	ld b,$79
	jr Logged_0x19469
	ld b,$7A
	jr Logged_0x19469
	ld b,$7B
	jr Logged_0x19469

UnknownData_0x1945B:
INCBIN "baserom.gbc", $1945B, $1945F - $1945B
	ld b,$7D
	jr Logged_0x19469
	ld b,$7E
	jr Logged_0x19469

UnknownData_0x19467:
INCBIN "baserom.gbc", $19467, $19469 - $19467

Logged_0x19469:
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $C1
	jr nz,Logged_0x1947E
	ld a,[$CA8F]
	cp $02
	jr nc,Logged_0x19481

Logged_0x1947E:
	jp Logged_0x18032

Logged_0x19481:
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	and $80
	or b
	ld [hl],a
	push hl
	call Logged_0x0E31
	pop hl
	call Logged_0x19609
	jp Logged_0x18020
	ld b,$78
	jr Logged_0x194B5
	ld b,$79
	jr Logged_0x194B5
	ld b,$7A
	jr Logged_0x194B5
	ld b,$7B
	jr Logged_0x194B5

UnknownData_0x194A7:
INCBIN "baserom.gbc", $194A7, $194B5 - $194A7

Logged_0x194B5:
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $84
	jp nz,Logged_0x18032
	ld a,[$C0D6]
	and $42
	jr nz,Logged_0x194CE
	jp Logged_0x18032

Logged_0x194CE:
	ld hl,$CCEA
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld a,[hl]
	and $80
	or b
	ld [hl],a
	push hl
	call Logged_0x0E31
	pop hl
	call Logged_0x19609
	jp Logged_0x18032

UnknownData_0x194E4:
INCBIN "baserom.gbc", $194E4, $19518 - $194E4
	ld b,$7A
	jr Logged_0x19522

UnknownData_0x1951C:
INCBIN "baserom.gbc", $1951C, $19520 - $1951C
	ld b,$78

Logged_0x19522:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x1954A
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $C3
	jr z,Logged_0x19542
	jp Logged_0x18032

Logged_0x19542:
	ld a,$01
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x1954A:
	or $01
	ld [$CEDA],a
	jp Logged_0x18F32
	ld b,$79
	jr Logged_0x19560
	ld b,$7A
	jr Logged_0x19560

UnknownData_0x1955A:
INCBIN "baserom.gbc", $1955A, $1955E - $1955A
	ld b,$78

Logged_0x19560:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x19585
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $C3
	jr z,Logged_0x19580
	jp Logged_0x18032

Logged_0x19580:
	ld a,$03
	ld [$CEDA],a

Logged_0x19585:
	or $03
	ld [$CEDA],a
	jp Logged_0x18F32
	ld b,$79
	jr Logged_0x1959B

UnknownData_0x19591:
INCBIN "baserom.gbc", $19591, $19599 - $19591
	ld b,$78

Logged_0x1959B:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x195C3
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $C3
	jr z,Unknown_0x195BB
	jp Logged_0x18032

Unknown_0x195BB:
	ld a,$02
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x195C3:
	or $02
	ld [$CEDA],a
	jp Logged_0x18F32
	ld b,$79
	jr Logged_0x195D9

UnknownData_0x195CF:
INCBIN "baserom.gbc", $195CF, $195D7 - $195CF
	ld b,$78

Logged_0x195D9:
	ld a,[$CEDA]
	and $07
	jp nz,Logged_0x18020
	ld a,[$CEDA]
	and $F8
	jr nz,Logged_0x19601
	ld a,[$C0DA]
	and a
	jp z,Logged_0x18032
	ld a,[$CA8E]
	cp $C3
	jr z,Unknown_0x195F9
	jp Logged_0x18032

Unknown_0x195F9:
	ld a,$04
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x19601:
	or $04
	ld [$CEDA],a
	jp Logged_0x18F32

Logged_0x19609:
	ld a,[$FF00+$A8]
	ld [$FF00+$AD],a
	ld a,[$FF00+$A9]
	ld [$FF00+$AE],a
	ld a,[$FF00+$AA]
	ld [$FF00+$AF],a
	ld a,[$FF00+$AB]
	ld [$FF00+$B0],a
	ld b,$01
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F0
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$FF00+$04]
	and $03
	jr nz,Logged_0x1967F
	ld a,[$CAC2]
	and a
	jr nz,Logged_0x1967F
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,$64
	ld [$CAC2],a
	ld hl,$D101
	ld de,$FFA0
	ld b,$06
	call Logged_0x0466
	ld hl,$D101
	xor a
	ld [hli],a
	ld [hli],a
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$FF00+$AB]
	ld [hli],a
	ld a,[$FF00+$AA]
	ld [hli],a
	ld bc,$4E5A
	ld a,$19
	ld [$FF00+$85],a
	ld a,$8A
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$FFA0
	ld de,$D101
	ld b,$06
	call Logged_0x0466
	pop af
	ld [$FF00+$70],a

Logged_0x1967F:
	ld a,[$FF00+$AD]
	ld [$FF00+$A8],a
	ld a,[$FF00+$AE]
	ld [$FF00+$A9],a
	ld a,[$FF00+$AF]
	ld [$FF00+$AA],a
	ld a,[$FF00+$B0]
	ld [$FF00+$AB],a
	ret

Logged_0x19690:
	ld a,[$FF00+$A8]
	ld [$FF00+$AD],a
	ld a,[$FF00+$A9]
	ld [$FF00+$AE],a
	ld a,[$FF00+$AA]
	ld [$FF00+$AF],a
	ld a,[$FF00+$AB]
	ld [$FF00+$B0],a
	ld b,$01
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F0
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld hl,$D101
	ld de,$FFA0
	ld b,$06
	call Logged_0x0466
	ld hl,$D101
	xor a
	ld [hli],a
	ld [hli],a
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$FF00+$AB]
	ld [hli],a
	ld a,[$FF00+$AA]
	ld [hli],a
	ld bc,$4E6D
	ld a,$19
	ld [$FF00+$85],a
	ld a,$8A
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$FFA0
	ld de,$D101
	ld b,$06
	call Logged_0x0466
	pop af
	ld [$FF00+$70],a
	ld a,[$FF00+$AD]
	ld [$FF00+$A8],a
	ld a,[$FF00+$AE]
	ld [$FF00+$A9],a
	ld a,[$FF00+$AF]
	ld [$FF00+$AA],a
	ld a,[$FF00+$B0]
	ld [$FF00+$AB],a
	ret
	ld a,$01
	ld [$C0DA],a
	call Logged_0x19741
	xor a
	ld [$C0DA],a
	ret
	ld a,$01
	ld [$C0DA],a
	call Logged_0x197B1
	xor a
	ld [$C0DA],a
	ret
	ld a,$01
	ld [$C0DA],a
	call Logged_0x199E9
	xor a
	ld [$C0DA],a
	ld a,b
	and a
	jp nz,Logged_0x14F6
	jp Logged_0x14DE
	ld a,$01
	ld [$C0D8],a
	ld a,[$CA69]
	and a
	jr z,Logged_0x197B6
	jr Logged_0x19746

Logged_0x19741:
	ld a,$01
	ld [$C0D8],a

Logged_0x19746:
	ld a,[$CA8E]
	cp $42
	jr z,Logged_0x19774
	ld a,[$CA72]
	sub $01
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,c
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[$CA70]
	cpl
	inc a
	add a,$07
	ld c,a
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	jr Logged_0x19799

Logged_0x19774:
	ld a,[$CA72]
	sub $01
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,c
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[$CA70]
	cpl
	inc a
	add a,$01
	ld c,a
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a

Logged_0x19799:
	ld a,[$FF00+$A9]
	and $F0
	ld [$C0DC],a
	call Logged_0x19BC3
	and $0F
	jp z,Logged_0x19832
	ld a,[$CA89]
	and a
	jp nz,Logged_0x19823
	ld a,b
	ret

Logged_0x197B1:
	ld a,$01
	ld [$C0D8],a

Logged_0x197B6:
	ld a,[$CA8E]
	cp $42
	jr z,Logged_0x197E6
	ld a,[$CA71]
	cpl
	inc a
	sub $01
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[$CA70]
	cpl
	inc a
	add a,$07
	ld c,a
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	jr Logged_0x1980D

Logged_0x197E6:
	ld a,[$CA71]
	cpl
	inc a
	sub $01
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[$CA70]
	cpl
	inc a
	add a,$01
	ld c,a
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a

Logged_0x1980D:
	ld a,[$FF00+$A9]
	and $F0
	ld [$C0DC],a
	call Logged_0x19BC3
	and $0F
	jr z,Logged_0x19832
	ld a,[$CA89]
	and a
	jr nz,Logged_0x19823
	ld a,b
	ret

Logged_0x19823:
	ld a,$01
	ld [$C0D8],a
	call Logged_0x19BD3
	ld a,$01
	ld [$C18D],a
	ld b,a
	ret

Logged_0x19832:
	ld a,[$CA8B]
	and a
	jp nz,Logged_0x198C1
	ld a,[$CA6F]
	ld b,a
	ld a,[$CA62]
	add a,b
	add a,$02
	and $F0
	ld b,a
	ld a,[$C0DC]
	cp b
	jp z,Logged_0x198C1
	ld a,$01
	ld [$C0D8],a
	call Logged_0x19BD3
	and $0F
	ret z
	ld a,[$CA74]
	and a
	jp nz,Logged_0x198C0
	ld a,[$CA89]
	and a
	jr nz,Logged_0x198C0
	ld a,[$C0DB]
	and a
	jr nz,Logged_0x198C0
	ld a,[$CA8B]
	and a
	jr nz,Logged_0x198C0
	ld a,[$CAC9]
	and a
	jr nz,Logged_0x198C0
	ld a,[$CA8E]
	and a
	jr nz,Logged_0x198C0
	ld a,[$CAA0]
	and a
	jr nz,Logged_0x198C0
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x198AA
	bit 5,a
	jr nz,Logged_0x19894
	ld a,[$CA69]
	and a
	jr nz,Logged_0x198AA

Logged_0x19894:
	ld b,$02
	call Logged_0x1270
	ld a,$07
	ld [$FF00+$85],a
	ld a,$55
	ld [$FF00+$8D],a
	ld a,$68
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x198C1

Logged_0x198AA:
	ld b,$02
	call Logged_0x1259
	ld a,$07
	ld [$FF00+$85],a
	ld a,$55
	ld [$FF00+$8D],a
	ld a,$68
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x198C1

Logged_0x198C0:
	ret

Logged_0x198C1:
	xor a
	ld [$C18D],a
	ld b,a
	ret

Logged_0x198C7:
	xor a
	ld [$C189],a
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	call Logged_0x19B51
	ret
	ld a,$01
	ld [$CED3],a
	call Logged_0x198C7
	and a
	ret nz
	xor a
	ld [$CED3],a
	ld a,[$CA71]
	cpl
	inc a
	sub $03
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	call Logged_0x19B8B
	and a
	ret nz
	ld a,[$CA72]
	sub $03
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,c
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	call Logged_0x19B8B
	and a
	ret nz
	ld a,[$CAC9]
	and a
	ret z
	ld b,a
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$01
	ret

Logged_0x19942:
	ld a,[$CA8E]
	cp $07
	jr z,Logged_0x1994E
	ld a,$01
	ld [$C0D8],a

Logged_0x1994E:
	ld a,[$CA6F]
	cpl
	inc a
	add a,$02
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	call Logged_0x19BEB
	ret
	ld a,$01
	ld [$CED2],a
	call Logged_0x19942
	and a
	ret nz
	xor a
	ld [$CED2],a
	ld a,[$CA8E]
	cp $07
	jr z,Logged_0x19988
	ld a,$01
	ld [$C0D8],a

Logged_0x19988:
	ld a,[$CA71]
	cpl
	inc a
	sub $03
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[$CA6F]
	cpl
	inc a
	add a,$02
	ld c,a
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	call Logged_0x19B9B
	and a
	ret nz
	ld a,[$CA8E]
	cp $07
	jr z,Logged_0x199C0
	ld a,$01
	ld [$C0D8],a

Logged_0x199C0:
	ld a,[$CA72]
	sub $03
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,c
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[$CA6F]
	cpl
	inc a
	add a,$02
	ld c,a
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	call Logged_0x19B9B
	ret

Logged_0x199E9:
	call Logged_0x19A53
	and a
	ret nz
	ld a,[$CA96]
	and a
	jr z,Logged_0x199F9
	ld a,$01
	ld [$C0D8],a

Logged_0x199F9:
	ld a,[$CA71]
	cpl
	inc a
	sub $03
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	call Logged_0x19BFB
	and a
	ret nz
	ld a,[$CAC9]
	and a
	jr z,Logged_0x19A22
	ld b,a
	ret

Logged_0x19A22:
	ld a,[$CA96]
	and a
	jr z,Logged_0x19A2D
	ld a,$01
	ld [$C0D8],a

Logged_0x19A2D:
	ld a,[$CA72]
	sub $03
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,c
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	call Logged_0x19BFB
	and a
	ret nz
	ld a,[$CAC9]
	and a
	ret z
	ld b,a
	ret

Logged_0x19A53:
	xor a
	ld [$C189],a
	ld a,[$CA96]
	and a
	jr z,Logged_0x19A62
	ld a,$01
	ld [$C0D8],a

Logged_0x19A62:
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	call Logged_0x19B7B
	ret
	xor a
	ld [$C1CA],a
	ld a,[$CA71]
	cpl
	inc a
	sub $03
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub c
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	call Logged_0x19B3A
	and a
	jr z,Logged_0x19AA2
	ld a,[$C1CA]
	and a
	ret z

Logged_0x19AA2:
	xor a
	ld [$C1CA],a
	ld a,[$CA72]
	sub $03
	ld c,a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,c
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	call Logged_0x19B3A
	and a
	jr z,Logged_0x19AC7
	ret

Logged_0x19AC7:
	ld a,$01
	ld [$C1CA],a
	ret
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	sub $0C
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	jr Logged_0x19B3A
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	sub $1A
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	jr Logged_0x19B3A
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	sub $18
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	jr Logged_0x19B3A
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	jr Logged_0x19B3A
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	sub $04
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a

Logged_0x19B3A:
	xor a
	ld [$C0DB],a
	ld [$C1C7],a
	ld [$C0D7],a
	ld [$CAA0],a
	ld [$C1C8],a
	ld [$C1C9],a
	call Logged_0x19C0B
	ret

Logged_0x19B51:
	ld hl,$FFA8
	call Logged_0x0BDB
	ld a,$01
	ld [$C0D6],a

Logged_0x19B5C:
	call Logged_0x18000
	ld b,a
	ret

Logged_0x19B61:
	call Logged_0x19B71
	ld a,[hl]
	inc a
	ret z
	jr Logged_0x19B5C

Logged_0x19B69:
	call Logged_0x19B76
	ld a,[hl]
	and a
	ret z
	jr Logged_0x19B5C

Logged_0x19B71:
	ld hl,$CCEB
	dec [hl]
	ret

Logged_0x19B76:
	ld hl,$CCEB
	inc [hl]
	ret

Logged_0x19B7B:
	ld hl,$FFA8
	call Logged_0x0BDB
	ld a,$02
	ld [$C0D6],a
	call Logged_0x18000
	ld b,a
	ret

Logged_0x19B8B:
	ld hl,$FFA8
	call Logged_0x0BDB
	ld a,$04
	ld [$C0D6],a
	call Logged_0x18000
	ld b,a
	ret

Logged_0x19B9B:
	ld hl,$FFA8
	call Logged_0x0BDB
	ld a,$08
	ld [$C0D6],a
	call Logged_0x18000
	ld b,a
	ret

UnknownData_0x19BAB:
INCBIN "baserom.gbc", $19BAB, $19BC3 - $19BAB

Logged_0x19BC3:
	ld hl,$FFA8
	call Logged_0x0BDB
	ld a,$10
	ld [$C0D6],a

Logged_0x19BCE:
	call Logged_0x18000
	ld b,a
	ret

Logged_0x19BD3:
	ld hl,$CCEA
	dec [hl]
	ld a,[hl]
	cp $9F
	jr nz,Logged_0x19BE6
	ld a,[$CCE9]
	dec a
	ld [$CCE9],a
	ld a,$BF
	ld [hl],a

Logged_0x19BE6:
	ld a,[hli]
	ld l,[hl]
	ld h,a
	jr Logged_0x19BCE

Logged_0x19BEB:
	ld hl,$FFA8
	call Logged_0x0BDB
	ld a,$20
	ld [$C0D6],a
	call Logged_0x18000
	ld b,a
	ret

Logged_0x19BFB:
	ld hl,$FFA8
	call Logged_0x0BDB
	ld a,$40
	ld [$C0D6],a
	call Logged_0x18000
	ld b,a
	ret

Logged_0x19C0B:
	ld hl,$FFA8
	call Logged_0x0BDB
	ld a,$80
	ld [$C0D6],a
	call Logged_0x18000
	ld b,a
	ret
	ld a,[$CA83]
	sub $30
	rst JumpList
	dw Logged_0x19CE7
	dw Logged_0x19EF1
	dw Logged_0x1A046
	dw Logged_0x1A077
	dw Unknown_0x1A0B4
	dw Logged_0x1A17E
	dw Logged_0x1A1C5
	dw Unknown_0x1A296
	dw Unknown_0x1A2D6
	dw Unknown_0x1A394
	dw Logged_0x1A436
	dw Logged_0x1A51D
	dw Logged_0x1A55C
	dw Logged_0x1A617
	dw Logged_0x1A6B6
	dw Logged_0x1A7D6
	dw Logged_0x1A89E
	dw Logged_0x1A8FF
	dw Logged_0x1A980
	dw Logged_0x1A9E9
	dw Logged_0x1AA5C
	dw Logged_0x1AAC9
	dw Logged_0x1AB44
	dw Logged_0x1A8FF
	dw Logged_0x1A980
	dw Logged_0x1ABB1
	dw Logged_0x1ABF4
	dw Unknown_0x1AC73
	dw Logged_0x1AD7D
	dw Logged_0x1ADFB
	dw Logged_0x1AED0
	dw Logged_0x1AF98
	dw Logged_0x1B00F
	dw Logged_0x1B0A9
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	ld a,$30
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA89],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$40
	ld [$CA7F],a
	ld a,$00
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	ld [$CA85],a
	and a
	jr nz,Logged_0x19CCD
	ld a,$42
	ld [$CA81],a
	ld a,$52
	ld [$CA82],a
	jr Logged_0x19CD7

Logged_0x19CCD:
	ld a,$42
	ld [$CA81],a
	ld a,$5F
	ld [$CA82],a

Logged_0x19CD7:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x19CE7:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA85]
	cp $04
	jp nc,Logged_0x19DB6
	cp $02
	jr nc,Logged_0x19D62
	ld b,a
	ld a,[$C093]
	and $30
	jp z,Logged_0x19DB6
	rlca
	rlca
	rlca
	and $01
	cp b
	jp nz,Logged_0x19DB6
	xor $01
	add a,$02
	ld [$CA85],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$4A
	ld [$CA7F],a
	ld a,$82
	ld [$CA80],a
	ld a,[$CA85]
	and $01
	jr nz,Logged_0x19D56
	ld a,$4C
	ld [$CA81],a
	ld a,$BE
	ld [$CA82],a
	jr Logged_0x19DAF

Logged_0x19D56:
	ld a,$4C
	ld [$CA81],a
	ld a,$C5
	ld [$CA82],a
	jr Logged_0x19DAF

Logged_0x19D62:
	ld b,a
	ld a,[$C1A8]
	and a
	jr z,Logged_0x19DB6
	ld a,b
	add a,$02
	ld [$CA85],a
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	ld a,[$CA85]
	and $01
	jr nz,Logged_0x19DA3
	ld a,$49
	ld [$CA81],a
	ld a,$B4
	ld [$CA82],a
	jr Logged_0x19DAF

Logged_0x19DA3:
	ld a,$49
	ld [$CA81],a
	ld a,$C5
	ld [$CA82],a
	jr Logged_0x19DAF

Logged_0x19DAF:
	xor a
	ld [$CA67],a
	ld [$CA68],a

Logged_0x19DB6:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C094]
	bit 0,a
	jr z,Logged_0x19DDC
	ld a,$07
	ld [$FF00+$85],a
	ld a,$B9
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x19DDC:
	ld a,[$C093]
	bit 7,a
	jr z,Logged_0x19DE6
	jp Logged_0x19E89

Logged_0x19DE6:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $30
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x19E0F
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x19E0F:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $30
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x19E67
	call Logged_0x1700
	jr z,Logged_0x19E67
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	ld a,[hl]
	cp $08
	jr c,Logged_0x19E4D
	cp $0F
	jr c,Logged_0x19E57
	cp $15
	jr c,Logged_0x19E51
	jr z,Logged_0x19E67
	ret

Logged_0x19E4D:
	ld b,$02
	jr Logged_0x19E59

Logged_0x19E51:
	ld a,[$C08F]
	and $01
	ret z

Logged_0x19E57:
	ld b,$01

Logged_0x19E59:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x19E63
	call Logged_0x1270
	ret

Logged_0x19E63:
	call Logged_0x1259
	ret

Logged_0x19E67:
	ld a,[$CA85]
	and $01
	ld [$CA69],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret
	xor a
	ld [$CA84],a
	ld a,[$CA69]
	ld [$CA85],a

Logged_0x19E89:
	ld a,$31
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA89],a
	ld [$CA9A],a
	inc a
	ld [$CA8B],a
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA85]
	cp $01
	jr z,Logged_0x19ED7
	ld a,$4A
	ld [$CA81],a
	ld a,$38
	ld [$CA82],a
	jr Logged_0x19EE1

Logged_0x19ED7:
	ld a,$4A
	ld [$CA81],a
	ld a,$3B
	ld [$CA82],a

Logged_0x19EE1:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x19EF1:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C094]
	bit 0,a
	jr z,Logged_0x19F1E
	ld a,$07
	ld [$FF00+$85],a
	ld a,$3F
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x19F1E:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $31
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x19F47
	ld a,$07
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x19F47:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $31
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x19F9E
	call Logged_0x1700
	jr z,Logged_0x19F9E
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $06
	jr c,Logged_0x19F84
	cp $0A
	jr c,Logged_0x19F8E
	cp $0E
	jr c,Logged_0x19F88
	jr nc,Logged_0x19F9E
	ret

Logged_0x19F84:
	ld b,$02
	jr Logged_0x19F90

Logged_0x19F88:
	ld a,[$C08F]
	and $01
	ret z

Logged_0x19F8E:
	ld b,$01

Logged_0x19F90:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x19F9A
	call Logged_0x1270
	ret

Logged_0x19F9A:
	call Logged_0x1259
	ret

Logged_0x19F9E:
	ld a,[$CA85]
	and $01
	ld [$CA69],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$55
	ld [$FF00+$8D],a
	ld a,$68
	ld [$FF00+$8E],a
	call $FF80
	ret
	ld a,$32
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA89],a
	ld [$CA9A],a
	ld [$CA74],a
	ld [$CA75],a
	ld [$CA96],a
	ld [$CA8B],a
	ld [$CA9D],a
	inc a
	ld [$CA9B],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1A02C
	ld a,$5F
	ld [$CA81],a
	ld a,$70
	ld [$CA82],a
	jr Logged_0x1A036

Logged_0x1A02C:
	ld a,$5F
	ld [$CA81],a
	ld a,$7F
	ld [$CA82],a

Logged_0x1A036:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A046:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA9B]
	and a
	ret nz
	ld a,[$CA06]
	cp $C8
	jr z,Logged_0x1A071
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A071:
	ld a,$06
	ld [$CED4],a
	ret

Logged_0x1A077:
	ld a,$01
	ld [$CA8A],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $01
	jr z,Logged_0x1A0AB
	cp $B4
	ret c
	ld [hl],$00
	ld a,$15
	ld [$CA83],a
	ld a,$01
	ld [$CA8C],a
	ld hl,$C0D7
	res 7,[hl]
	jp Logged_0x11F6

Logged_0x1A0AB:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$82
	ld [$FF00+$B6],a
	ret

Unknown_0x1A0B4:
	ld a,$01
	ld [$CA8A],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $11
	jr z,Logged_0x1A0AB
	cp $B4
	ret c
	ld [hl],$00
	ld a,$10
	ld [$CA83],a
	ld a,$01
	ld [$CA8C],a
	ld hl,$C0D7
	res 7,[hl]
	jp Logged_0x11F6

Logged_0x1A0E8:
	xor a
	ld [$CA9A],a
	ld a,$35
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA96],a
	ld [$CA89],a
	ld [$CA9D],a
	ld [$CA6D],a
	ld [$CA8B],a
	ld [$C0E0],a
	ld hl,$4800
	call Logged_0x1AF6

Logged_0x1A12A:
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a

Logged_0x1A14B:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1A164
	ld a,$5F
	ld [$CA81],a
	ld a,$94
	ld [$CA82],a
	jr Logged_0x1A16E

Logged_0x1A164:
	ld a,$5F
	ld [$CA81],a
	ld a,$97
	ld [$CA82],a

Logged_0x1A16E:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A17E:
	call Logged_0x1B2C0
	ld a,[$CA83]
	cp $35
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	jp Unknown_0x1A236

Logged_0x1A1A7:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$01
	ld [$FF00+$B6],a
	ld a,$36
	ld [$CA83],a
	xor a
	ld [$CA75],a
	ld [$CA84],a
	ld [$CA85],a
	inc a
	ld [$CA74],a
	jp Logged_0x1A12A

Logged_0x1A1C5:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CAA0]
	and a
	jr nz,Logged_0x1A1EA
	ld a,$07
	ld [$FF00+$85],a
	ld a,$89
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A1EA:
	call Logged_0x1488
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$7A
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA86]
	cp $04
	jr c,Logged_0x1A208
	ld a,$00
	ld [$CA86],a

Logged_0x1A208:
	ld a,[$CA95]
	and a
	jr z,Logged_0x1A211
	call Logged_0x1A14B

Logged_0x1A211:
	ld a,[$C093]
	bit 0,a
	jp z,Logged_0x1A0E8
	ld a,[$CA75]
	cp $18
	jp nc,Logged_0x1A0E8
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	jp Logged_0x1A0E8

Unknown_0x1A236:
	ld a,$37
	ld [$CA83],a
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$40
	ld [$CA7F],a
	ld a,$00
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Unknown_0x1A27C
	ld a,$42
	ld [$CA81],a
	ld a,$52
	ld [$CA82],a
	jr Unknown_0x1A286

Unknown_0x1A27C:
	ld a,$42
	ld [$CA81],a
	ld a,$5F
	ld [$CA82],a

Unknown_0x1A286:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x1A296:
	call Unknown_0x1B322
	ret

Unknown_0x1A29A:
	xor a
	ld [$CA86],a
	ld a,$38
	ld [$CA83],a
	ld a,[$C093]
	bit 4,a
	jr nz,Unknown_0x1A2B0
	bit 5,a
	jr nz,Unknown_0x1A2B7
	jr Unknown_0x1A2BC

Unknown_0x1A2B0:
	ld a,$01
	ld [$CA69],a
	jr Unknown_0x1A2BC

Unknown_0x1A2B7:
	ld a,$00
	ld [$CA69],a

Unknown_0x1A2BC:
	xor a
	ld [$CEED],a
	ld [$CA75],a
	ld [$CA74],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$EA
	ld [$FF00+$8D],a
	ld a,$66
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x1A2D6:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Unknown_0x1A2ED
	ld a,$24
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$04
	ld [$FF00+$B6],a

Unknown_0x1A2ED:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Unknown_0x1B333
	ld a,[$CA83]
	cp $38
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x1A0E8
	ret

Unknown_0x1A330:
	ld a,$39
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$4A
	ld [$CA7F],a
	ld a,$82
	ld [$CA80],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	and a
	jr nz,Unknown_0x1A37A
	ld a,$4C
	ld [$CA81],a
	ld a,$BE
	ld [$CA82],a
	jr Unknown_0x1A384

Unknown_0x1A37A:
	ld a,$4C
	ld [$CA81],a
	ld a,$C5
	ld [$CA82],a

Unknown_0x1A384:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x1A394:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1A1A7
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,[$C093]
	and $30
	jp nz,Unknown_0x1A29A
	jp Unknown_0x1A236

Logged_0x1A3BB:
	ld a,$3A
	ld [$CA83],a
	ld a,[$CA64]
	and $F0
	add a,$08
	ld [$CA64],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA96],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA99],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$04
	ld [$CA7B],a
	ld a,$68
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$55
	ld [$CA7F],a
	ld a,$CC
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$58
	ld [$CA81],a
	ld a,$D6
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A436:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1A463
	ld a,$20
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$38
	ld [$FF00+$B6],a

Logged_0x1A463:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	jr z,Logged_0x1A49A
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld b,$04
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80

Logged_0x1A49A:
	call Logged_0x1B3A0
	ret

Logged_0x1A49E:
	ld a,$3B
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA96],a
	ld [$CA99],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$04
	ld [$CA7B],a
	ld a,$68
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$55
	ld [$CA7F],a
	ld a,$CC
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1A511
	ld a,$59
	ld [$CA81],a
	ld a,$00
	ld [$CA82],a

Logged_0x1A501:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A511:
	ld a,$58
	ld [$CA81],a
	ld a,$FD
	ld [$CA82],a
	jr Logged_0x1A501

Logged_0x1A51D:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C1C7]
	and a
	jr nz,Logged_0x1A549
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A549:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1B480
	ret

Logged_0x1A55C:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C1C7]
	and a
	jr nz,Logged_0x1A588
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A588:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld b,$02
	call Logged_0x1287
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x1A5B3
	call Logged_0x114E
	ld a,[$CA78]
	sub c
	jr z,Logged_0x1A5B3
	jr c,Logged_0x1A5B3
	call Logged_0x11AE

Logged_0x1A5B3:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1A5E1
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A5E1:
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $40
	ret c
	ld [hl],$00
	jp Logged_0x1A49E

Logged_0x1A5EE:
	ld a,$3D
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	inc a
	ld [$CA99],a
	ld [$CA8A],a
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1A611
	ld a,$00
	ld [$CA69],a
	ret

Logged_0x1A611:
	ld a,$01
	ld [$CA69],a
	ret

Logged_0x1A617:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1A62E
	ld a,$20
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$38
	ld [$FF00+$B6],a

Logged_0x1A62E:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1A63B
	ld b,$01
	call Logged_0x1270
	jr Logged_0x1A640

Logged_0x1A63B:
	ld b,$01
	call Logged_0x1259

Logged_0x1A640:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1C7]
	and a
	ret nz
	xor a
	ld [$CA99],a
	ld [$CA8A],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A66B:
	ld a,$3E
	ld [$CA83],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0C
	ld [$FF00+$B6],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA99],a
	inc a
	ld [$CA74],a
	ld a,[$CA3C]
	cp $01
	jr c,Logged_0x1A695
	ld a,$01
	ld [$CA96],a

Logged_0x1A695:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$59
	ld [$CA81],a
	ld a,$45
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A6B6:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C1C7]
	and a
	jr nz,Logged_0x1A6E6
	xor a
	ld [$CA96],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A6E6:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C093]
	bit 6,a
	jp nz,Logged_0x1A3BB
	ld b,$02
	call Logged_0x1287
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x1A719
	call Logged_0x114E
	ld a,[$CA78]
	sub c
	jr z,Logged_0x1A719
	jr c,Logged_0x1A719
	call Logged_0x11AE

Logged_0x1A719:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$CA96]
	and a
	jr z,Logged_0x1A753
	ld a,[$CA3C]
	cp $06
	jr c,Logged_0x1A763
	ld a,$07
	ld [$FF00+$85],a
	ld a,$FD
	ld [$FF00+$8D],a
	ld a,$45
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A753:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A763:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$6B
	ld [$FF00+$8D],a
	ld a,$46
	ld [$FF00+$8E],a
	call $FF80
	ret
	ld a,$3F
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA89],a
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1A7BC
	ld a,$4A
	ld [$CA81],a
	ld a,$20
	ld [$CA82],a
	jr Logged_0x1A7C6

Logged_0x1A7BC:
	ld a,$4A
	ld [$CA81],a
	ld a,$23
	ld [$CA82],a

Logged_0x1A7C6:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A7D6:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA9A]
	and a
	jr nz,Logged_0x1A802
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A802:
	ld a,[$C094]
	bit 0,a
	jr z,Logged_0x1A819
	ld a,$07
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A819:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $3F
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x1A842
	ld a,$07
	ld [$FF00+$85],a
	ld a,$D3
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A842:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $3F
	ret nz
	ld a,b
	and a
	jr nz,Unknown_0x1A88E
	call Logged_0x1700
	jr z,Unknown_0x1A88E
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $08
	jr c,Logged_0x1A874
	cp $0F
	jr c,Unknown_0x1A87E
	cp $15
	jr c,Unknown_0x1A878
	jr z,Unknown_0x1A88E
	ret

Logged_0x1A874:
	ld b,$02
	jr Logged_0x1A880

Unknown_0x1A878:
	ld a,[$C08F]
	and $01
	ret z

Unknown_0x1A87E:
	ld b,$01

Logged_0x1A880:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1A88A
	call Logged_0x1270
	ret

Logged_0x1A88A:
	call Logged_0x1259
	ret

Unknown_0x1A88E:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$E7
	ld [$FF00+$8D],a
	ld a,$6F
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A89E:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA74]
	and a
	jr z,Logged_0x1A8DA
	call Logged_0x1488
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	xor a
	ld [$CA74],a
	ld [$CA75],a

Logged_0x1A8DA:
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $30
	ret c
	ld a,$18
	ld [$CA84],a

Logged_0x1A8E7:
	ld hl,$CA83
	inc [hl]
	xor a
	ld [$CA85],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$EA
	ld [$FF00+$8D],a
	ld a,$66
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A8FF:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1A91B
	ld b,$01
	call Logged_0x1270
	jr Logged_0x1A920

Logged_0x1A91B:
	ld b,$01
	call Logged_0x1259

Logged_0x1A920:
	ld hl,$CA84
	dec [hl]
	ret nz
	ld hl,$CA83
	inc [hl]
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA85],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$43
	ld [$CA7F],a
	ld a,$1B
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1A966
	ld a,$44
	ld [$CA81],a
	ld a,$6A
	ld [$CA82],a
	jr Logged_0x1A970

Logged_0x1A966:
	ld a,$44
	ld [$CA81],a
	ld a,$61
	ld [$CA82],a

Logged_0x1A970:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A980:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,[$CA83]
	cp $48
	jp z,Logged_0x1AB64
	ld a,$43
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$0B
	ld [$CA7B],a
	ld a,$70
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$40
	ld [$CA7F],a
	ld a,$00
	ld [$CA80],a
	ld a,$42
	ld [$CA81],a
	ld a,$AB
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1A9E9:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$44
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$43
	ld [$CA7F],a
	ld a,$1B
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1AA42
	ld a,$44
	ld [$CA81],a
	ld a,$46
	ld [$CA82],a
	jr Logged_0x1AA4C

Logged_0x1AA42:
	ld a,$44
	ld [$CA81],a
	ld a,$39
	ld [$CA82],a

Logged_0x1AA4C:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1AA5C:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$45
	ld [$CA83],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$3E
	ld [$FF00+$B6],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$0B
	ld [$CA7B],a
	ld a,$70
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$40
	ld [$CA7F],a
	ld a,$00
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$42
	ld [$CA81],a
	ld a,$C4
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1AAC9:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$46
	ld [$CA83],a
	call Logged_0x1B4F
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$43
	ld [$CA7F],a
	ld a,$1B
	ld [$CA80],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	and a
	jr nz,Logged_0x1AB2A
	ld a,$44
	ld [$CA81],a
	ld a,$5A
	ld [$CA82],a
	jr Logged_0x1AB34

Logged_0x1AB2A:
	ld a,$44
	ld [$CA81],a
	ld a,$53
	ld [$CA82],a

Logged_0x1AB34:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1AB44:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$20
	ld [$CA84],a
	xor a
	ld [$CA9B],a
	jp Logged_0x1A8E7

Logged_0x1AB64:
	ld a,$49
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$0B
	ld [$CA7B],a
	ld a,$70
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$40
	ld [$CA7F],a
	ld a,$00
	ld [$CA80],a
	ld a,$43
	ld [$CA81],a
	ld a,$0D
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1ABB1:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$4A
	ld [$CA83],a
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld b,$0D
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ret

Logged_0x1ABF4:
	ld hl,$CA84
	ld a,[$C093]
	bit 0,a
	jr nz,Logged_0x1AC03
	inc [hl]
	ld a,[hl]
	cp $B4
	ret c

Logged_0x1AC03:
	ld a,[$CCE6]
	and a
	ret z
	ld [hl],$00
	ld hl,$CED4
	res 7,[hl]
	ret

UnknownData_0x1AC10:
INCBIN "baserom.gbc", $1AC10, $1AC73 - $1AC10

Unknown_0x1AC73:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA84]
	dec a
	jr z,Unknown_0x1ACD0
	dec a
	jp z,Unknown_0x1AD0C
	ld a,[$C1A8]
	and a
	ret z
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$36
	ld [$FF00+$B6],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld hl,$CA84
	inc [hl]
	ld a,[$CA69]
	and a
	jr nz,Unknown_0x1ACB6
	ld a,$42
	ld [$CA81],a
	ld a,$2E
	ld [$CA82],a
	jr Unknown_0x1ACC0

Unknown_0x1ACB6:
	ld a,$42
	ld [$CA81],a
	ld a,$37
	ld [$CA82],a

Unknown_0x1ACC0:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x1ACD0:
	ld a,[$C1A8]
	and a
	jr z,Unknown_0x1ACDE
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$36
	ld [$FF00+$B6],a

Unknown_0x1ACDE:
	ld a,[$C093]
	and a
	ret z
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld hl,$CA84
	inc [hl]
	ld a,[$CA69]
	and a
	jr nz,Unknown_0x1AD00
	ld a,$42
	ld [$CA81],a
	ld a,$40
	ld [$CA82],a
	jr Unknown_0x1ACC0

Unknown_0x1AD00:
	ld a,$42
	ld [$CA81],a
	ld a,$49
	ld [$CA82],a
	jr Unknown_0x1ACC0

Unknown_0x1AD0C:
	ld a,[$C1A8]
	and a
	ret z
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1AD21:
	ld a,$4C
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA99],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1AD63
	ld a,$59
	ld [$CA81],a
	ld a,$03
	ld [$CA82],a
	jr Logged_0x1AD6D

Logged_0x1AD63:
	ld a,$59
	ld [$CA81],a
	ld a,$24
	ld [$CA82],a

Logged_0x1AD6D:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1AD7D:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C093]
	and a
	jr nz,Logged_0x1AD97
	ld a,[$C1A8]
	and a
	ret z

Logged_0x1AD97:
	jp Logged_0x1A49E
	ld a,$4D
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld a,$03
	ld [$CA9B],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$4A
	ld [$CA7F],a
	ld a,$82
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1ADE1
	ld a,$4D
	ld [$CA81],a
	ld a,$0B
	ld [$CA82],a
	jr Logged_0x1ADEB

Logged_0x1ADE1:
	ld a,$4D
	ld [$CA81],a
	ld a,$10
	ld [$CA82],a

Logged_0x1ADEB:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1ADFB:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA84]
	and a
	jr nz,Logged_0x1AE3A
	ld a,[$C1A8]
	and a
	jr z,Logged_0x1AE3A
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$4D
	ld [$CA81],a
	ld a,$15
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CA84
	inc [hl]

Logged_0x1AE3A:
	ld a,[$CA74]
	and a
	jr z,Logged_0x1AE67
	call Logged_0x1488
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	xor a
	ld [$CA74],a
	ld [$CA75],a

Logged_0x1AE67:
	ret

Logged_0x1AE68:
	ld a,$4E
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA96],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$04
	ld [$CA7B],a
	ld a,$68
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$55
	ld [$CA7F],a
	ld a,$CC
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$58
	ld [$CA81],a
	ld a,$D6
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1AED0:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1AEE7
	ld a,$20
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$38
	ld [$FF00+$B6],a

Logged_0x1AEE7:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	jr z,Logged_0x1AF1E
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld b,$04
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80

Logged_0x1AF1E:
	call Logged_0x1B168
	ret

Logged_0x1AF22:
	ld a,$4F
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA96],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$04
	ld [$CA7B],a
	ld a,$68
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$55
	ld [$CA7F],a
	ld a,$CC
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1AF7E
	ld a,$59
	ld [$CA81],a
	ld a,$00
	ld [$CA82],a
	jr Logged_0x1AF88

Logged_0x1AF7E:
	ld a,$58
	ld [$CA81],a
	ld a,$FD
	ld [$CA82],a

Logged_0x1AF88:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1AF98:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1B21A
	ret

Logged_0x1AFAB:
	ld a,$50
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA96],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$E5
	ld [$CA6F],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1AFF5
	bit 5,a
	jr nz,Logged_0x1AFE9
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1AFF5

Logged_0x1AFE9:
	ld a,$58
	ld [$CA81],a
	ld a,$F2
	ld [$CA82],a
	jr Logged_0x1AFFF

Logged_0x1AFF5:
	ld a,$58
	ld [$CA81],a
	ld a,$E7
	ld [$CA82],a

Logged_0x1AFFF:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B00F:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$FB
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1C8]
	and a
	jr nz,Logged_0x1B034
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B034:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1B04B
	ld a,$20
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$38
	ld [$FF00+$B6],a

Logged_0x1B04B:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1B24F
	ret

Logged_0x1B05E:
	ld a,$51
	ld [$CA83],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0C
	ld [$FF00+$B6],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA99],a
	inc a
	ld [$CA74],a
	ld a,[$CA3C]
	cp $01
	jr c,Logged_0x1B088
	ld a,$01
	ld [$CA96],a

Logged_0x1B088:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$59
	ld [$CA81],a
	ld a,$45
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B0A9:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C1C8]
	and a
	jr nz,Logged_0x1B0D9
	xor a
	ld [$CA96],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B0D9:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C093]
	bit 6,a
	jr z,Logged_0x1B0F2
	jp Logged_0x1AE68

Logged_0x1B0F2:
	ld b,$02
	call Logged_0x1287
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x1B10E
	call Logged_0x114E
	ld a,[$CA78]
	sub c
	jr z,Logged_0x1B10E
	jr c,Logged_0x1B10E
	call Logged_0x11AE

Logged_0x1B10E:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$CA96]
	and a
	jr z,Unknown_0x1B148
	ld a,[$CA3C]
	cp $06
	jr c,Unknown_0x1B158
	ld a,$07
	ld [$FF00+$85],a
	ld a,$FD
	ld [$FF00+$8D],a
	ld a,$45
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x1B148:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x1B158:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$6B
	ld [$FF00+$8D],a
	ld a,$46
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B168:
	ld a,[$C093]
	and $82
	cp $82
	jp z,Logged_0x1B05E
	ld a,[$CA77]
	and a
	jr nz,Logged_0x1B18F
	ld a,[$C093]
	bit 0,a
	jr z,Logged_0x1B18F

Logged_0x1B17F:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$B9
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B18F:
	ld a,[$C094]
	bit 0,a
	jr nz,Logged_0x1B17F
	ld a,[$C093]
	bit 6,a
	jr nz,Logged_0x1B1A9
	bit 7,a
	jr nz,Logged_0x1B1C3
	and $30
	jp nz,Logged_0x1AFAB
	jp Logged_0x1AF22

Logged_0x1B1A9:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E4
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1C8]
	and a
	ret z
	ld b,$01
	call Logged_0x129E
	ret

Logged_0x1B1C3:
	ld b,$01
	call Logged_0x1287
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1B1FF
	ld a,$06
	ld [$FF00+$85],a
	ld a,$FB
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1C8]
	and a
	ret nz
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B1FF:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B21A:
	ld a,[$CA77]
	and a
	jr nz,Logged_0x1B237
	ld a,[$C093]
	bit 0,a
	jr z,Logged_0x1B237

Logged_0x1B227:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$B9
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B237:
	ld a,[$C094]
	bit 0,a
	jr nz,Logged_0x1B227
	ld a,[$C093]
	and $C0
	jp nz,Logged_0x1AE68
	ld a,[$C093]
	and $30
	jp nz,Logged_0x1AFAB
	ret

Logged_0x1B24F:
	ld a,[$CA77]
	and a
	jr nz,Logged_0x1B26C
	ld a,[$C093]
	bit 0,a
	jr z,Logged_0x1B26C

Logged_0x1B25C:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$B9
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B26C:
	ld a,[$C094]
	bit 0,a
	jr nz,Logged_0x1B25C
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1B286
	bit 5,a
	jr nz,Logged_0x1B2A3
	and $C0
	jp nz,Logged_0x1AE68
	jp Logged_0x1AF22

Logged_0x1B286:
	ld a,$01
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld b,$01
	call Logged_0x1259
	ret

Logged_0x1B2A3:
	ld a,$00
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld b,$01
	call Logged_0x1270
	ret

Logged_0x1B2C0:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1A1A7
	call Logged_0x1B302
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$7A
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA86]
	cp $04
	jr c,Logged_0x1B2F8
	ld a,$00
	ld [$CA86],a

Logged_0x1B2F8:
	ld a,[$CA95]
	and a
	jr z,Logged_0x1B301
	call Logged_0x1A14B

Logged_0x1B301:
	ret

Logged_0x1B302:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld b,$01
	ld a,[$C093]
	bit 7,a
	jr z,Logged_0x1B31E
	inc b

Logged_0x1B31E:
	call Logged_0x1287
	ret

Unknown_0x1B322:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1A1A7
	ld a,[$C093]
	and $30
	jp nz,Unknown_0x1A29A
	ret

Unknown_0x1B333:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1A1A7
	ld a,[$C093]
	bit 4,a
	jr nz,Unknown_0x1B349
	bit 5,a
	jr nz,Unknown_0x1B37A
	jp Unknown_0x1A236

Unknown_0x1B349:
	ld a,[$CA69]
	and a
	jp z,Unknown_0x1A330
	ld a,$01
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	call Logged_0x151E
	call Logged_0x1259

Unknown_0x1B36D:
	ld a,[$CA86]
	cp $04
	jr c,Unknown_0x1B379
	ld a,$00
	ld [$CA86],a

Unknown_0x1B379:
	ret

Unknown_0x1B37A:
	ld a,[$CA69]
	and a
	jp nz,Unknown_0x1A330
	ld a,$00
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	call Logged_0x153F
	call Logged_0x1270
	jr Unknown_0x1B36D

Logged_0x1B3A0:
	ld a,[$C093]
	and $82
	cp $82
	jp z,Logged_0x1A66B
	ld a,[$C093]
	bit 6,a
	jr nz,Logged_0x1B3B8
	bit 7,a
	jr nz,Logged_0x1B40F
	jp Logged_0x1A49E

Logged_0x1B3B8:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CED2]
	and a
	ret nz
	ld b,$01
	call Logged_0x129E
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x1B3E6
	call Logged_0x114E
	ld a,[$CA78]
	sub c
	jr nc,Logged_0x1B3E6
	jp Logged_0x11D6

Logged_0x1B3E6:
	ld a,[$C1C7]
	and a
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$12
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1C7]
	and a
	ret nz

Logged_0x1B3FF:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B40F:
	ld b,$01
	call Logged_0x1287
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x1B42B
	call Logged_0x114E
	ld a,[$CA78]
	sub c
	jr z,Logged_0x1B42B
	jr c,Logged_0x1B42B
	jp Logged_0x11AE

Logged_0x1B42B:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$12
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1C7]
	and a
	jr z,Logged_0x1B45D
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,[$CA64]
	and $F0
	add a,$08
	ld [$CA64],a
	ret

Logged_0x1B45D:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1B3FF
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1B480:
	ld a,[$C093]
	bit 1,a
	jr z,Logged_0x1B48E
	ld a,[$C093]
	and $30
	jr nz,Logged_0x1B4A7

Logged_0x1B48E:
	ld a,[$C093]
	and $C0
	jp nz,Logged_0x1A3BB
	ld hl,$CA84
	ld a,[hl]
	add a,$01
	ld [hli],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	cp $02
	ret c
	jp Logged_0x1AD21

Logged_0x1B4A7:
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1B4D3
	ld a,$F0
	ld [$CA71],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1B4EB

Logged_0x1B4C6:
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	jp Logged_0x1A5EE

Logged_0x1B4D3:
	ld a,$10
	ld [$CA72],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1B4C6

Logged_0x1B4EB:
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ret

UnknownData_0x1B4F6:
INCBIN "baserom.gbc", $1B4F6, $1C000 - $1B4F6

SECTION "Bank07", ROMX, BANK[$07]
	ld hl,$CAC2
	ld a,[hl]
	and a
	jr z,Logged_0x1C008
	dec [hl]

Logged_0x1C008:
	call Logged_0x1F6DC
	call Logged_0x1F64A
	ld a,[$CA83]
	cp $30
	jr c,Logged_0x1C04D
	cp $60
	jr c,Logged_0x1C03D
	cp $B0
	jr c,Logged_0x1C02D
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C02D:
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$00
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C03D:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$1B
	ld [$FF00+$8D],a
	ld a,$5C
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C04D:
	rst JumpList
	dw Logged_0x1C0B6
	dw Logged_0x1C1AB
	dw Logged_0x1C244
	dw Unknown_0x156D
	dw Logged_0x1C369
	dw Logged_0x1C6ED
	dw Logged_0x1C7C3
	dw Logged_0x1C8DF
	dw Logged_0x1CBB9
	dw Logged_0x1CCAF
	dw Logged_0x1CE42
	dw Logged_0x1CF53
	dw Logged_0x1D008
	dw Logged_0x1D0BA
	dw Logged_0x1D297
	dw Logged_0x1D354
	dw Logged_0x1D395
	dw Unknown_0x1D455
	dw Logged_0x1D46D
	dw Logged_0x1D4A7
	dw Logged_0x1D522
	dw Logged_0x1D627
	dw Logged_0x1D766
	dw Logged_0x1D7C1
	dw Logged_0x1D80D
	dw Logged_0x1D85C
	dw Logged_0x1D8F8
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Logged_0x1D916
	dw Logged_0x1D943
	dw Logged_0x1D995
	dw Logged_0x1DA4F
	dw Logged_0x1DCFC
	dw Logged_0x1DD7F
	dw Logged_0x1DE88
	dw Logged_0x1DEAA
	dw Logged_0x1DECC
	dw Logged_0x1DFD4
	dw Logged_0x1E09D
	dw Logged_0x1E1E9
	dw Logged_0x1E2C5
	dw Logged_0x1E347
	dw Logged_0x1E3E8
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D

Logged_0x1C0B6:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $00
	ret nz
	ld a,b
	and a
	jp z,Logged_0x1C2AE
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$CA83]
	cp $00
	ret nz
	ld a,[$C093]
	bit 7,a
	jr z,Logged_0x1C115
	ld a,$06
	ld [$FF00+$85],a
	ld a,$12
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $00
	ret nz
	ld a,[$C1C7]
	cp $02
	jp nz,Logged_0x1E855
	ld a,$06
	ld [$FF00+$85],a
	ld a,$BB
	ld [$FF00+$8D],a
	ld a,$63
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C115:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C1C7]
	and a
	jr z,Logged_0x1C157
	ld a,[$C093]
	bit 6,a
	jr z,Logged_0x1C157
	ld a,$06
	ld [$FF00+$85],a
	ld a,$BB
	ld [$FF00+$8D],a
	ld a,$63
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C157:
	ld a,[$C1C8]
	and a
	jr z,Logged_0x1C174
	ld a,[$C093]
	bit 6,a
	jr z,Logged_0x1C174
	ld a,$06
	ld [$FF00+$85],a
	ld a,$68
	ld [$FF00+$8D],a
	ld a,$6E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C174:
	ld a,[$CA83]
	cp $00
	ret nz
	call Logged_0x1E68A
	ld a,[$CA83]
	cp $00
	ret nz
	ld a,[$CAC9]
	and a
	ret nz
	ld a,[$CA84]
	add a,$01
	ld [$CA84],a
	ld a,[$CA85]
	adc a,$00
	ld [$CA85],a
	cp $07
	ret c
	ld a,$06
	ld [$FF00+$85],a
	ld a,$10
	ld [$FF00+$8D],a
	ld a,$6C
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C1AB:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1C1C2
	ld a,$24
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$04
	ld [$FF00+$B6],a

Logged_0x1C1C2:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	jr z,Logged_0x1C1F9
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld b,$04
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80

Logged_0x1C1F9:
	call Logged_0x1E8ED
	ld a,[$CA83]
	cp $01
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA83]
	cp $01
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $01
	ret nz
	ld a,b
	and a
	jp z,Logged_0x1C2AE
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x1C244:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1C2B9
	bit 1,a
	jp nz,Logged_0x1E7AB
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,[$C093]
	and $30
	jp nz,Logged_0x1E6B5
	jp Logged_0x1E99B

Logged_0x1C270:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0D
	ld [$FF00+$B6],a
	ld a,$01
	ld [$CA75],a
	ld a,$01
	ld [$CA77],a
	ld a,$01
	ld [$CA76],a
	jr Logged_0x1C2CD
	xor a
	ld [$CA75],a
	ld a,$01
	ld [$CA77],a
	ld a,$01
	ld [$CA76],a
	ld a,[$CA3C]
	cp $07
	ld a,$01
	jr c,Logged_0x1C2A9
	ld hl,$C093
	bit 6,[hl]
	jr z,Logged_0x1C2A9
	ld a,$02

Logged_0x1C2A9:
	ld [$CA74],a
	jr Logged_0x1C2E2

Logged_0x1C2AE:
	xor a
	ld [$CA77],a

Logged_0x1C2B2:
	ld a,$18
	ld [$CA75],a
	jr Logged_0x1C2CD

Logged_0x1C2B9:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$01
	ld [$FF00+$B6],a
	xor a
	ld [$CA75],a
	ld [$CA96],a
	ld a,$01
	ld [$CA77],a

Logged_0x1C2CD:
	ld a,[$CA3C]
	cp $07
	ld a,$02
	jr c,Logged_0x1C2DF
	ld hl,$C093
	bit 6,[hl]
	jr z,Logged_0x1C2DF
	ld a,$03

Logged_0x1C2DF:
	ld [$CA74],a

Logged_0x1C2E2:
	xor a
	ld [$C189],a
	ld a,$04
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA8B],a
	ld [$CA89],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1C345
	ld a,$5F
	ld [$CA81],a
	ld a,$94
	ld [$CA82],a
	jr Logged_0x1C34F

Logged_0x1C345:
	ld a,$5F
	ld [$CA81],a
	ld a,$97
	ld [$CA82],a

Logged_0x1C34F:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CAC9]
	and a
	ret z
	ld b,$02
	call Logged_0x129E
	ret

Logged_0x1C369:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA75]
	cp $18
	jr c,Logged_0x1C3F2
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1CD48
	ld a,[$CAA0]
	and a
	jr z,Logged_0x1C3A3
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E8
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C3A3:
	ld a,[$C1C7]
	and a
	jr z,Logged_0x1C3C0
	ld a,[$C093]
	bit 6,a
	jr z,Logged_0x1C3C0
	ld a,$06
	ld [$FF00+$85],a
	ld a,$BB
	ld [$FF00+$8D],a
	ld a,$63
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C3C0:
	ld a,[$CA83]
	cp $04
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$FB
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1C8]
	and a
	jr z,Logged_0x1C3F2
	ld a,[$C093]
	bit 6,a
	jr z,Logged_0x1C3F2
	ld a,$06
	ld [$FF00+$85],a
	ld a,$68
	ld [$FF00+$8D],a
	ld a,$6E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C3F2:
	ld a,[$CA83]
	cp $04
	ret nz
	call Logged_0x1F077
	ld a,[$CA83]
	cp $04
	ret nz
	ld a,[$CA3C]
	cp $01
	jr c,Logged_0x1C43D
	ld a,[$CA96]
	and a
	jr nz,Logged_0x1C430
	ld a,[$CA75]
	cp $18
	jr c,Logged_0x1C43D
	ld a,[$C093]
	bit 7,a
	jr z,Logged_0x1C43D
	ld a,$01
	ld [$CA96],a

Logged_0x1C421:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1C48D
	jr Logged_0x1C46E

Logged_0x1C430:
	ld a,[$C093]
	bit 7,a
	jr nz,Logged_0x1C43D
	xor a
	ld [$CA96],a
	jr Logged_0x1C449

Logged_0x1C43D:
	ld a,[$CA95]
	and a
	jr z,Logged_0x1C4AA
	ld a,[$CA96]
	and a
	jr nz,Logged_0x1C421

Logged_0x1C449:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1C462
	ld a,$5F
	ld [$CA81],a
	ld a,$94
	ld [$CA82],a
	jr Logged_0x1C4AA

Logged_0x1C462:
	ld a,$5F
	ld [$CA81],a
	ld a,$97
	ld [$CA82],a
	jr Logged_0x1C4AA

Logged_0x1C46E:
	ld a,[$CA3C]
	cp $06
	jr nc,Logged_0x1C481
	ld a,$5F
	ld [$CA81],a
	ld a,$8E
	ld [$CA82],a
	jr Logged_0x1C4AA

Logged_0x1C481:
	ld a,$60
	ld [$CA81],a
	ld a,$4E
	ld [$CA82],a
	jr Logged_0x1C4AA

Logged_0x1C48D:
	ld a,[$CA3C]
	cp $06
	jr nc,Logged_0x1C4A0
	ld a,$5F
	ld [$CA81],a
	ld a,$91
	ld [$CA82],a
	jr Logged_0x1C4AA

Logged_0x1C4A0:
	ld a,$60
	ld [$CA81],a
	ld a,$55
	ld [$CA82],a

Logged_0x1C4AA:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1C4EA
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,[$CA83]
	cp $04
	ret nz
	ld a,[$CED2]
	and a
	jp nz,Logged_0x1C2B2
	ld a,[$CA64]
	and $F0
	add a,$08
	ld [$CA64],a
	ret

Logged_0x1C4EA:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $04
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x1C506
	jp Logged_0x14DE

Logged_0x1C506:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld b,$04
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA75]
	cp $27
	jr c,Logged_0x1C541
	ld a,[$C093]
	and $30
	jr z,Logged_0x1C58A

Logged_0x1C541:
	call Logged_0x1501
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld a,[$CA96]
	and a
	jr z,Logged_0x1C55C
	ld a,[$CA3C]
	cp $06
	jp c,Logged_0x1C66B
	jp Logged_0x1C5FD

Logged_0x1C55C:
	ld a,[$C093]
	and $80
	jp nz,Logged_0x1E855
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1C57F
	jp Logged_0x1E855

Logged_0x1C57F:
	ld a,[$C093]
	and $30
	jp nz,Logged_0x1E6B9
	jp Logged_0x1E99B

Logged_0x1C58A:
	call Logged_0x1501
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA86],a
	ld a,[$CA96]
	and a
	jr z,Logged_0x1C5AD
	ld a,[$CA3C]
	cp $06
	jp c,Logged_0x1C66B
	jr Logged_0x1C5FD

Logged_0x1C5AD:
	ld a,[$C093]
	and $80
	jp nz,Logged_0x1E855
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$10
	ld [$FF00+$B6],a
	ld a,$05
	ld [$CA83],a
	ld a,$05
	ld [$CA7E],a
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1C5E3
	ld a,$5F
	ld [$CA81],a
	ld a,$9A
	ld [$CA82],a
	jr Logged_0x1C5ED

Logged_0x1C5E3:
	ld a,$5F
	ld [$CA81],a
	ld a,$A1
	ld [$CA82],a

Logged_0x1C5ED:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C5FD:
	ld a,[$CA97]
	and a
	jr nz,Logged_0x1C60D
	ld a,$20
	ld [$CA97],a
	ld a,$01
	ld [$CA98],a

Logged_0x1C60D:
	ld a,[$C1AA]
	and a
	jr nz,Logged_0x1C61B
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$02
	ld [$FF00+$B6],a

Logged_0x1C61B:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1C650
	ld a,$5F
	ld [$CA81],a
	ld a,$B8
	ld [$CA82],a
	jr Logged_0x1C65A

Logged_0x1C650:
	ld a,$5F
	ld [$CA81],a
	ld a,$C5
	ld [$CA82],a

Logged_0x1C65A:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x1C6C1

Logged_0x1C66B:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$33
	ld [$FF00+$B6],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1C6A8
	ld a,$5F
	ld [$CA81],a
	ld a,$F2
	ld [$CA82],a
	jr Logged_0x1C6B2

Logged_0x1C6A8:
	ld a,$60
	ld [$CA81],a
	ld a,$09
	ld [$CA82],a

Logged_0x1C6B2:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x1C6C1:
	ld a,$81
	ld [$CA96],a
	ld a,$1A
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA75],a
	ld [$CA74],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ret

Logged_0x1C6ED:
	ld a,[$C094]
	and $30
	jr nz,Logged_0x1C70A
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	jr nz,Logged_0x1C70D
	ret

Logged_0x1C70A:
	jp Logged_0x1E6B5

Logged_0x1C70D:
	ld a,[$CA77]
	and a
	jr nz,Logged_0x1C71A
	ld a,[$C093]
	bit 0,a
	jr nz,Logged_0x1C72C

Logged_0x1C71A:
	ld a,[$C094]
	bit 0,a
	jr nz,Logged_0x1C72C
	ld a,[$C093]
	bit 7,a
	jp nz,Logged_0x1E855
	jp Logged_0x1E99B

Logged_0x1C72C:
	call Logged_0x1C2B9
	ld a,[$CA3C]
	cp $07
	ret c
	ld a,$03
	ld [$CA74],a
	ret

Logged_0x1C73B:
	xor a
	ld [$CEED],a
	ld [$CA89],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0C
	ld [$FF00+$B6],a
	ld a,$06
	ld [$CA83],a
	ld a,$01
	ld [$CA8B],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F1
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	ld a,[$CA69]
	cp $01
	jr z,Logged_0x1C7B7
	ld a,$4A
	ld [$CA81],a
	ld a,$38
	ld [$CA82],a

Logged_0x1C7A7:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C7B7:
	ld a,$4A
	ld [$CA81],a
	ld a,$3B
	ld [$CA82],a
	jr Logged_0x1C7A7

Logged_0x1C7C3:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA83]
	cp $06
	ret nz
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1C885
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $06
	ret nz
	ld a,b
	and a
	jp z,Logged_0x1ED34
	ld a,[$C189]
	and a
	jr z,Logged_0x1C815
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	jp Logged_0x1DEF1

Logged_0x1C815:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $06
	ret nz
	ld a,b
	and a
	jp nz,Logged_0x1C8B1
	ld hl,$CA84
	inc [hl]
	ld a,[$CA3C]
	cp $05
	jr nc,Logged_0x1C84B
	ld a,[hl]
	cp $14
	jr c,Logged_0x1C85B
	cp $24
	jr c,Logged_0x1C86B
	cp $28
	jr c,Logged_0x1C875
	jp z,Logged_0x1C8B1
	ret

Logged_0x1C84B:
	ld a,[hl]
	cp $1E
	jr c,Logged_0x1C85B
	cp $36
	jr c,Logged_0x1C86B
	cp $3C
	jr c,Logged_0x1C875
	jr z,Logged_0x1C8B1
	ret

Logged_0x1C85B:
	ld b,$02
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1C867

Logged_0x1C863:
	call Logged_0x1270
	ret

Logged_0x1C867:
	call Logged_0x1259
	ret

Logged_0x1C86B:
	ld b,$01
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1C867
	jr Logged_0x1C863

Logged_0x1C875:
	ld a,[$C08F]
	and $01
	ret z
	ld b,$01
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1C867
	jr Logged_0x1C863

Logged_0x1C885:
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $06
	ret nz
	ld a,b
	and a
	jr nz,Unknown_0x1C8AB
	ld a,$F1
	ld [$CA6F],a
	jp Logged_0x1ED3F

Unknown_0x1C8AB:
	ld a,$F1
	ld [$CA6F],a
	ret

Logged_0x1C8B1:
	ld a,[$C093]
	bit 7,a
	jr nz,Logged_0x1C8D7
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $06
	ret nz
	ld a,b
	and a
	jp z,Logged_0x1E99B

Logged_0x1C8D7:
	ld a,$F1
	ld [$CA6F],a
	jp Logged_0x1E855

Logged_0x1C8DF:
	ld a,[$CA3C]
	cp $05
	jr nc,Logged_0x1C8FF
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1C8FD
	ld a,$06
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$07
	ld [$FF00+$B6],a

Logged_0x1C8FD:
	jr Logged_0x1C916

Logged_0x1C8FF:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1C916
	ld a,$06
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$08
	ld [$FF00+$B6],a

Logged_0x1C916:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1EA3E
	ld a,[$CA83]
	cp $07
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA83]
	cp $07
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $07
	ret nz
	ld a,b
	and $0F
	jp nz,Logged_0x1C9F7
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x1CB33
	ld a,[$CA83]
	cp $07
	ret nz
	ld a,[$CA89]
	cp $2B
	jr nc,Logged_0x1C9B2
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1C9A0
	call Logged_0x153F
	call Logged_0x1270
	ld a,[$CA86]
	cp $14
	jr c,Logged_0x1C99E
	ld a,$10
	ld [$CA86],a

Logged_0x1C99E:
	jr Logged_0x1C9B2

Logged_0x1C9A0:
	call Logged_0x151E
	call Logged_0x1259
	ld a,[$CA86]
	cp $14
	jr c,Logged_0x1C9B2
	ld a,$10
	ld [$CA86],a

Logged_0x1C9B2:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$CA83]
	cp $07
	ret nz
	ld hl,$CA89
	dec [hl]
	ret nz
	call Logged_0x1700
	jr z,Logged_0x1C9EC
	ld a,$06
	ld [$FF00+$85],a
	ld a,$81
	ld [$FF00+$8D],a
	ld a,$5C
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1C9EC:
	ld a,[$C093]
	and $30
	jp nz,Logged_0x1E6B5
	jp Logged_0x1E99B

Logged_0x1C9F7:
	jp Logged_0x1CA0E

Logged_0x1C9FA:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CA07
	ld b,$03
	call Logged_0x1259
	jr Logged_0x1CA0C

Logged_0x1CA07:
	ld b,$03
	call Logged_0x1270

Logged_0x1CA0C:
	jr Logged_0x1CA20

Logged_0x1CA0E:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CA1B
	ld b,$02
	call Logged_0x1259
	jr Logged_0x1CA20

Logged_0x1CA1B:
	ld b,$02
	call Logged_0x1270

Logged_0x1CA20:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$03
	ld [$FF00+$B6],a
	ld a,[$CA74]
	and a
	jr nz,Logged_0x1CA32
	ld a,$0A
	jr Logged_0x1CA34

Logged_0x1CA32:
	ld a,$18

Logged_0x1CA34:
	ld [$CA75],a
	jr Logged_0x1CA46
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$03
	ld [$FF00+$B6],a
	ld a,$0A
	ld [$CA75],a

Logged_0x1CA46:
	ld a,$09
	ld [$CA83],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	ld a,$01
	ld [$CA74],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA89],a
	ld a,[$CA9D]
	and a
	jp nz,Logged_0x1CABF
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CAA4
	ld a,$52
	ld [$CA81],a
	ld a,$19
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x1CABE

Logged_0x1CAA4:
	ld a,$52
	ld [$CA81],a
	ld a,$16
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x1CABD:
	ret

Logged_0x1CABE:
	ret

Logged_0x1CABF:
	xor a
	ld [$CA9D],a
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CAF9
	call Logged_0x1CABE
	ld a,$5F
	ld [$CA81],a
	ld a,$7F
	ld [$CA82],a
	jr Logged_0x1CB06

Logged_0x1CAF9:
	call Logged_0x1CABD
	ld a,$5F
	ld [$CA81],a
	ld a,$70
	ld [$CA82],a

Logged_0x1CB06:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1CB32
	ld a,$18
	ld [$CA75],a

Logged_0x1CB32:
	ret

Logged_0x1CB33:
	ld a,$18
	ld [$CA75],a
	jr Logged_0x1CB43

Logged_0x1CB3A:
	xor a
	ld [$CA75],a
	ld a,$01
	ld [$CA77],a

Logged_0x1CB43:
	xor a
	ld [$C189],a
	ld a,$08
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA3C]
	cp $07
	ld a,$02
	jr c,Logged_0x1CB5D
	inc a

Logged_0x1CB5D:
	ld [$CA74],a
	ld a,[$CA3C]
	cp $05
	jr nc,Logged_0x1CB85
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CB79
	ld a,$52
	ld [$CA81],a
	ld a,$16
	ld [$CA82],a
	jr Logged_0x1CBA1

Logged_0x1CB79:
	ld a,$52
	ld [$CA81],a
	ld a,$19
	ld [$CA82],a
	jr Logged_0x1CBA1

Logged_0x1CB85:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CB97
	ld a,$52
	ld [$CA81],a
	ld a,$3E
	ld [$CA82],a
	jr Logged_0x1CBA1

Logged_0x1CB97:
	ld a,$52
	ld [$CA81],a
	ld a,$49
	ld [$CA82],a

Logged_0x1CBA1:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CAC9]
	and a
	ret z
	call Logged_0x1CBB9
	ret

Logged_0x1CBB9:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1CD48
	ld a,[$CAA0]
	and a
	jr z,Logged_0x1CBEC
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E8
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1CBEC:
	ld a,[$CA83]
	cp $08
	ret nz
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1CC09
	ld a,$06
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$07
	ld [$FF00+$B6],a

Logged_0x1CC09:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1EA64
	ld a,[$CA83]
	cp $08
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $08
	ret nz
	ld a,b
	and $0F
	jr nz,Logged_0x1CCAC
	ld a,[$CA89]
	dec a
	jr z,Logged_0x1CC44
	ld [$CA89],a

Logged_0x1CC44:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CC58
	ld a,[$C094]
	bit 4,a
	jr z,Logged_0x1CC5F

Logged_0x1CC51:
	xor a
	ld [$CA89],a
	jp Logged_0x1C2AE

Logged_0x1CC58:
	ld a,[$C094]
	bit 5,a
	jr nz,Logged_0x1CC51

Logged_0x1CC5F:
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1CC8A
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,[$CA83]
	cp $08
	ret nz
	ld a,[$CA75]
	cp $18
	ret nc
	ld a,$18
	ld [$CA75],a
	ret

Logged_0x1CC8A:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1CCA0
	jp Logged_0x14DE

Logged_0x1CCA0:
	call Logged_0x14F6
	ld a,[$CA83]
	cp $08
	ret nz
	jp Logged_0x1E99B

Logged_0x1CCAC:
	jp Logged_0x1CA0E

Logged_0x1CCAF:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1CD48
	ld a,[$CAA0]
	and a
	jr z,Logged_0x1CCE2
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E8
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1CCE2:
	ld a,[$CA83]
	cp $09
	ret nz
	call Logged_0x1EA83
	ld a,[$CA83]
	cp $09
	ret nz
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1CD16
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $09
	ret nz
	ld a,b
	and a
	ret z
	ld a,$18
	ld [$CA75],a
	ret

Logged_0x1CD16:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1CD2C
	jp Logged_0x14DE

Logged_0x1CD2C:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	ld a,[$CA83]
	cp $09
	ret nz
	jp Logged_0x1C541

Logged_0x1CD48:
	xor a
	ld [$CA9A],a
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$FF00+$A9]
	and $F0
	ld [$FF00+$A9],a
	ld b,$03
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0D
	ld [$FF00+$B6],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$05
	ld [$CA7E],a
	ld a,$52
	ld [$CA7F],a
	ld a,$54
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CDA9
	ld a,$55
	ld [$CA81],a
	ld a,$A0
	ld [$CA82],a
	jr Logged_0x1CDB3

Logged_0x1CDA9:
	ld a,$55
	ld [$CA81],a
	ld a,$A3
	ld [$CA82],a

Logged_0x1CDB3:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x1CDF6

Logged_0x1CDC4:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CDDD
	ld a,$55
	ld [$CA81],a
	ld a,$69
	ld [$CA82],a
	jr Logged_0x1CDE7

Logged_0x1CDDD:
	ld a,$55
	ld [$CA81],a
	ld a,$73
	ld [$CA82],a

Logged_0x1CDE7:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x1CDF6:
	ld a,$0A
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA96],a
	ld [$CA89],a
	ld [$CA9D],a
	ld [$CA6D],a
	ld [$CA8B],a
	ld [$C0E0],a
	ld hl,$4800
	call Logged_0x1AF6
	ld a,$04
	ld [$CA7B],a
	ld a,$60
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ret

Logged_0x1CE42:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $0A
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x1CE8A
	call Logged_0x1F14F
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $0A
	jr c,Logged_0x1CE6D
	cp $0E
	jr c,Logged_0x1CE71
	jr Logged_0x1CE95

Logged_0x1CE6D:
	ld b,$02
	jr Logged_0x1CE73

Logged_0x1CE71:
	ld b,$01

Logged_0x1CE73:
	call Logged_0x1287
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1CE8A
	ret

Logged_0x1CE8A:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a

Logged_0x1CE95:
	ld a,$0B
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA6D],a
	ld [$C0E0],a
	ld [$CA9C],a
	ld a,$04
	ld [$CA7B],a
	ld a,$60
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$52
	ld [$CA7F],a
	ld a,$54
	ld [$CA80],a
	ld a,[$CA3C]
	cp $02
	jr c,Logged_0x1CF20
	ld a,[$C0DB]
	cp $02
	jr z,Logged_0x1CF20
	ld a,$FF
	ld [$CA70],a
	ld a,$F1
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CF06
	ld a,$55
	ld [$CA81],a
	ld a,$76
	ld [$CA82],a
	jr Logged_0x1CF10

Logged_0x1CF06:
	ld a,$55
	ld [$CA81],a
	ld a,$8B
	ld [$CA82],a

Logged_0x1CF10:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1CF20:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CF39
	ld a,$55
	ld [$CA81],a
	ld a,$A0
	ld [$CA82],a
	jr Logged_0x1CF43

Logged_0x1CF39:
	ld a,$55
	ld [$CA81],a
	ld a,$A3
	ld [$CA82],a

Logged_0x1CF43:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1CF53:
	xor a
	ld [$C0E1],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA83]
	cp $0B
	ret nz
	call Logged_0x1E46A
	call Logged_0x1F1A9
	ret

Logged_0x1CF7A:
	xor a
	ld [$CEED],a
	ld [$CA6E],a
	ld a,$04
	ld [$CA7B],a
	ld a,$60
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$52
	ld [$CA7F],a
	ld a,$54
	ld [$CA80],a

Logged_0x1CFA2:
	ld a,$0C
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA6D],a
	ld [$C0E0],a
	ld [$CA9C],a
	ld a,[$C0DB]
	and a
	jr nz,Logged_0x1CFDC
	ld a,$01
	ld [$C0DB],a

Logged_0x1CFDC:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1CFEE
	ld a,$55
	ld [$CA81],a
	ld a,$54
	ld [$CA82],a
	jr Logged_0x1CFF8

Logged_0x1CFEE:
	ld a,$55
	ld [$CA81],a
	ld a,$5B
	ld [$CA82],a

Logged_0x1CFF8:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1D008:
	xor a
	ld [$C0E1],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $0C
	ret nz
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1D03F
	ld a,$1C
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$37
	ld [$FF00+$B6],a

Logged_0x1D03F:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1D1BC
	call Logged_0x1F40F
	ld a,[$CA83]
	cp $0C
	ret nz
	ld a,[$C093]
	and $30
	jr nz,Logged_0x1D065
	call Logged_0x1E46A
	ret

Logged_0x1D065:
	ld a,$0D
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA6D],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1D0A0
	ld a,$55
	ld [$CA81],a
	ld a,$54
	ld [$CA82],a
	jr Logged_0x1D0AA

Logged_0x1D0A0:
	ld a,$55
	ld [$CA81],a
	ld a,$5B
	ld [$CA82],a

Logged_0x1D0AA:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1D0BA:
	xor a
	ld [$C0E1],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1D0EB
	ld a,$1C
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$37
	ld [$FF00+$B6],a

Logged_0x1D0EB:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1D1BC
	call Logged_0x1E46A
	call Logged_0x1D107
	call Logged_0x1F40F
	ret

Logged_0x1D107:
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1D115
	bit 5,a
	jr nz,Logged_0x1D16E
	jp Logged_0x1CFA2

Logged_0x1D115:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1D141
	ld a,$01
	ld [$CA69],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$55
	ld [$CA81],a
	ld a,$5B
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1D141:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld hl,$CEE2
	ld a,[hld]
	or [hl]
	and $03
	ret nz
	call Logged_0x151E
	call Logged_0x1259

Logged_0x1D161:
	ld a,[$CA86]
	cp $04
	jr c,Logged_0x1D16D
	ld a,$00
	ld [$CA86],a

Logged_0x1D16D:
	ret

Logged_0x1D16E:
	ld a,[$CA69]
	and a
	jr z,Logged_0x1D19A
	ld a,$00
	ld [$CA69],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$55
	ld [$CA81],a
	ld a,$54
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1D19A:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld hl,$CEE2
	ld a,[hld]
	or [hl]
	and $03
	ret nz
	call Logged_0x153F
	call Logged_0x1270
	jr Logged_0x1D161

Logged_0x1D1BC:
	ld a,[$C08F]
	and $03
	ret nz
	ld hl,$CA6E
	inc [hl]
	ld a,[hl]
	cp $07
	jr nc,Logged_0x1D1D1
	ld b,$01
	call Logged_0x128E
	ret

Logged_0x1D1D1:
	cp $0C
	jr c,Logged_0x1D1D7
	xor a
	ld [hl],a

Logged_0x1D1D7:
	ld b,$01
	call Logged_0x12A5
	ret

Logged_0x1D1DD:
	ld a,$40
	ld [$CA9C],a
	jr Logged_0x1D1EC

Logged_0x1D1E4:
	ld a,[$C093]
	and $F0
	ld [$CA9C],a

Logged_0x1D1EC:
	ld a,$0E
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F1
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CEED],a
	ld [$CA6D],a
	ld [$CA85],a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA9C]
	and a
	jr z,Logged_0x1D282
	ld a,[$CA9C]
	bit 5,a
	jr nz,Logged_0x1D22C
	bit 4,a
	jr nz,Logged_0x1D250
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1D250

Logged_0x1D22C:
	ld a,$00
	ld [$CA69],a
	ld a,[$CA3C]
	cp $08
	jr c,Logged_0x1D244
	ld a,$55
	ld [$CA81],a
	ld a,$62
	ld [$CA82],a
	jr Logged_0x1D272

Logged_0x1D244:
	ld a,$55
	ld [$CA81],a
	ld a,$BE
	ld [$CA82],a
	jr Logged_0x1D272

Logged_0x1D250:
	ld a,$01
	ld [$CA69],a
	ld a,[$CA3C]
	cp $08
	jr c,Logged_0x1D268
	ld a,$55
	ld [$CA81],a
	ld a,$6C
	ld [$CA82],a
	jr Logged_0x1D272

Logged_0x1D268:
	ld a,$55
	ld [$CA81],a
	ld a,$C5
	ld [$CA82],a

Logged_0x1D272:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1D282:
	ld a,[$CA69]
	cp $01
	jr z,Logged_0x1D290
	ld a,$20
	ld [$CA9C],a
	jr Logged_0x1D22C

Logged_0x1D290:
	ld a,$10
	ld [$CA9C],a
	jr Logged_0x1D250

Logged_0x1D297:
	xor a
	ld [$C0E1],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA83]
	cp $0E
	ret nz
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1D2CE
	ld a,$0F
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0F
	ld [$FF00+$B6],a

Logged_0x1D2CE:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1F470
	ld a,[$CA83]
	cp $0E
	ret nz
	call Logged_0x1E46A
	ret

Logged_0x1D2EA:
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$03
	ld [$FF00+$B6],a
	ld a,$0F
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA6D],a
	ld [$CA9C],a
	ld [$C0E0],a
	ld a,$04
	ld [$CA7B],a
	ld a,$60
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1D33A
	ld a,$55
	ld [$CA81],a
	ld a,$73
	ld [$CA82],a
	jr Logged_0x1D344

Logged_0x1D33A:
	ld a,$55
	ld [$CA81],a
	ld a,$69
	ld [$CA82],a

Logged_0x1D344:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1D354:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1D38A
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $04
	jr c,Logged_0x1D376
	cp $08
	jr c,Logged_0x1D37A
	jr Logged_0x1D38A

Logged_0x1D376:
	ld b,$02
	jr Logged_0x1D37C

Logged_0x1D37A:
	ld b,$01

Logged_0x1D37C:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1D386
	call Logged_0x1270
	ret

Logged_0x1D386:
	call Logged_0x1259
	ret

Logged_0x1D38A:
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	jp Logged_0x1CE95

Logged_0x1D395:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CA84
	inc [hl]
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1D3ED
	ld a,$06
	ld [$FF00+$85],a
	ld a,$CD
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DB]
	and a
	jr z,Logged_0x1D404
	ld a,[$CA84]
	cp $78
	jr nc,Logged_0x1D3F8
	ld a,[$C08F]
	and $01
	ret nz
	ld b,$01
	call Logged_0x129E
	ld a,[$CEE0]
	and a
	ret z
	xor a
	ld [$CEE0],a
	jr Logged_0x1D3F8

Logged_0x1D3ED:
	ld a,[$CA84]
	cp $78
	ret c
	ld a,$40
	ld [$C0E1],a

Logged_0x1D3F8:
	xor a
	ld [$CA8A],a
	ld a,$10
	ld [$CA8C],a
	jp Logged_0x1CE95

Logged_0x1D404:
	ld a,[$CA84]
	cp $78
	ret c
	xor a
	ld [$CA8A],a
	ld a,$10
	ld [$CA8C],a
	jp Logged_0x1CF7A

Unknown_0x1D416:
	ld a,$11
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Unknown_0x1D43B
	ld a,$55
	ld [$CA81],a
	ld a,$B0
	ld [$CA82],a
	jr Unknown_0x1D445

Unknown_0x1D43B:
	ld a,$55
	ld [$CA81],a
	ld a,$B7
	ld [$CA82],a

Unknown_0x1D445:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x1D455:
	ld a,[$C093]
	bit 7,a
	jp z,Logged_0x1CFA2
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1D46D:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $12
	ret nz
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1CD48
	call Logged_0x1EB46
	ld a,[$CA83]
	cp $12
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x1ED34
	ret

Logged_0x1D4A7:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1D4BE
	ld a,$15
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$4A
	ld [$FF00+$B6],a

Logged_0x1D4BE:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA83]
	cp $13
	ret nz
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1CD48
	call Logged_0x1EC6C
	ld a,[$CA83]
	cp $13
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x1ED34
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$C189]
	and a
	jr nz,Logged_0x1D51F
	ret

Logged_0x1D51F:
	jp Logged_0x1DEF1

Logged_0x1D522:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1CD48
	ld a,[$CAA0]
	and a
	jr z,Logged_0x1D555
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E8
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1D555:
	ld a,[$CA83]
	cp $14
	ret nz
	ld a,[$C093]
	bit 7,a
	jr nz,Logged_0x1D583
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $14
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x1D583
	jp Logged_0x1C2CD

Logged_0x1D583:
	ld a,$F1
	ld [$CA6F],a
	call Logged_0x1F077
	ld a,[$CA83]
	cp $14
	ret nz
	ld a,[$CA95]
	and a
	jr z,Logged_0x1D5C9
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1D5B0
	ld a,$4A
	ld [$CA81],a
	ld a,$38
	ld [$CA82],a
	jr Logged_0x1D5BA

Logged_0x1D5B0:
	ld a,$4A
	ld [$CA81],a
	ld a,$3B
	ld [$CA82],a

Logged_0x1D5BA:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x1D5C9:
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1D5EE
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,[$CA83]
	cp $14
	ret nz
	ld a,$18
	ld [$CA75],a
	ret

Logged_0x1D5EE:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1D60A
	ld a,[$CA83]
	cp $14
	ret nz
	jp Logged_0x14DE

Logged_0x1D60A:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$CA83]
	cp $14
	ret nz
	call Logged_0x1C541
	ld a,[$C093]
	bit 7,a
	ret z
	jp Logged_0x1E855

Logged_0x1D627:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1CD48
	ld a,[$CAA0]
	and a
	jr z,Logged_0x1D65A
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E8
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1D65A:
	call Logged_0x1F6C2
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1D6A3
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1D694
	ld b,$01
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1D68F
	inc b

Logged_0x1D68F:
	call Logged_0x1270
	jr Logged_0x1D6B5

Logged_0x1D694:
	ld b,$01
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1D69E
	inc b

Logged_0x1D69E:
	call Logged_0x1259
	jr Logged_0x1D6B5

Logged_0x1D6A3:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1D6B0
	ld b,$01
	call Logged_0x1259
	jr Logged_0x1D6B5

Logged_0x1D6B0:
	ld b,$01
	call Logged_0x1270

Logged_0x1D6B5:
	ld a,[$CA74]
	and a
	jr nz,Logged_0x1D6E3
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $27
	jp nc,Logged_0x1D759
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	ret nz
	ld a,$18
	ld [$CA75],a
	ld a,$01
	ld [$CA74],a
	ret

Logged_0x1D6E3:
	ld a,[$CA75]
	ld e,a
	ld d,$00
	ld hl,$18A7
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x1D715
	ld a,[hl]
	cpl
	inc a
	ld b,a
	call Logged_0x129E
	ld hl,$CA75
	inc [hl]
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,$18
	ld [$CA75],a
	jr Logged_0x1D6E3

Logged_0x1D715:
	ld b,[hl]
	call Logged_0x1287
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $27
	jr c,Logged_0x1D724
	ld [hl],$27

Logged_0x1D724:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1D73A
	jp Logged_0x14DE

Logged_0x1D73A:
	call Logged_0x14F6
	ld a,[$CA74]
	inc a
	ld [$CA74],a
	sub $02
	jr z,Logged_0x1D74D
	dec a
	jr z,Logged_0x1D753
	jr Logged_0x1D759

Logged_0x1D74D:
	ld a,$0A
	ld [$CA75],a
	ret

Logged_0x1D753:
	ld a,$0E
	ld [$CA75],a
	ret

Logged_0x1D759:
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$16
	ld [$CA83],a
	ret

Logged_0x1D766:
	call Logged_0x1F6C2
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $14
	ret c
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	ld a,$10
	ld [$CA8C],a
	ld hl,$4800
	call Logged_0x1AF6
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $16
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x1D7B9
	ld a,[$C093]
	bit 7,a
	jp z,Logged_0x1E99B

Logged_0x1D7B9:
	ld a,$F1
	ld [$CA6F],a
	jp Logged_0x1E855

Logged_0x1D7C1:
	ld a,$01
	ld [$CA8A],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld b,$01
	call Logged_0x1287
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $20
	jr z,Logged_0x1D7F9
	cp $21
	jr z,Logged_0x1D804
	cp $40
	ret c
	ld a,[$CA64]
	sub $08
	ld [$CA64],a
	xor a
	ld [$CA8A],a
	jp Logged_0x1E99B

Logged_0x1D7F9:
	call Logged_0x1079
	ld hl,$C0D7
	res 7,[hl]
	jp Logged_0x11F6

Logged_0x1D804:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E1
	ld [$FF00+$B6],a
	ret

Logged_0x1D80D:
	ld a,$01
	ld [$CA8A],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld b,$01
	call Logged_0x129E
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $20
	jr z,Logged_0x1D848
	cp $21
	jr z,Logged_0x1D853
	cp $40
	ret c
	ld a,[$CA64]
	sub $08
	ld [$CA64],a
	xor a
	ld [$CA8A],a
	call Logged_0x1146
	jp Logged_0x1E99B

Logged_0x1D848:
	call Logged_0x1079
	ld hl,$C0D7
	res 7,[hl]
	jp Logged_0x11F6

Logged_0x1D853:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E1
	ld [$FF00+$B6],a
	ret

Logged_0x1D85C:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1CD48
	ld a,[$CAA0]
	and a
	jr z,Logged_0x1D88F
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E8
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1D88F:
	ld a,[$CA83]
	cp $19
	ret nz
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1EA83
	ld a,[$CA83]
	cp $19
	ret nz
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1D8CC
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,$18
	ld [$CA75],a
	ret

Logged_0x1D8CC:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1D8E2
	jp Logged_0x14DE

Logged_0x1D8E2:
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	jp Logged_0x1C541

Logged_0x1D8F8:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $1B
	ret c
	xor a
	ld [$CA96],a
	jp Logged_0x1E99B

Logged_0x1D916:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1DD78
	ld a,[$CA9A]
	and a
	jp z,Logged_0x1E99B
	and $0F
	cp $02
	jp z,Logged_0x1EFE7
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x1EFE7

Logged_0x1D943:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA83]
	cp $1F
	ret nz
	ld a,[$CA9A]
	and a
	jp z,Logged_0x1E99B
	call Logged_0x1EE88
	ld a,[$CA83]
	cp $1F
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $1F
	ret nz
	ld a,b
	and a
	jp z,Logged_0x1EDD3
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x1D995:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA83]
	cp $20
	ret nz
	ld a,[$CA9A]
	and a
	jp z,Logged_0x1E6B5
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1D9CF
	ld a,$24
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$04
	ld [$FF00+$B6],a

Logged_0x1D9CF:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1EEFC
	ld a,[$CA83]
	cp $20
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x1EDD3
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x1DA07:
	ld a,$25
	ld [$CA83],a
	ld a,[$CA9A]
	and $F0
	or $07
	ld [$CA9A],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1DA43
	ld a,$5F
	ld [$CA81],a
	ld a,$AE
	ld [$CA82],a

Logged_0x1DA33:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1DA43:
	ld a,$5F
	ld [$CA81],a
	ld a,$B3
	ld [$CA82],a
	jr Logged_0x1DA33

Logged_0x1DA4F:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA83]
	cp $21
	ret nz
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1CD48
	ld a,[$CA9A]
	and a
	jp z,Logged_0x1C2AE
	ld a,[$CAA0]
	and a
	jr z,Logged_0x1DA8F
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E8
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1DA8F:
	ld a,[$C094]
	bit 1,a
	jp nz,Logged_0x1DA07
	call Logged_0x1F077
	ld a,[$CA83]
	cp $21
	ret nz
	ld a,[$CA3C]
	cp $01
	jr c,Logged_0x1DADC
	ld a,[$CA96]
	and a
	jr nz,Logged_0x1DACF
	ld a,[$CA75]
	cp $18
	jr c,Logged_0x1DADC
	ld a,[$C093]
	bit 7,a
	jr z,Logged_0x1DADC
	ld a,$01
	ld [$CA96],a

Logged_0x1DAC0:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1DB2C
	jr Logged_0x1DB0D

Logged_0x1DACF:
	ld a,[$C093]
	bit 7,a
	jr nz,Logged_0x1DADC
	xor a
	ld [$CA96],a
	jr Logged_0x1DAE8

Logged_0x1DADC:
	ld a,[$CA95]
	and a
	jr z,Logged_0x1DB49
	ld a,[$CA96]
	and a
	jr nz,Logged_0x1DAC0

Logged_0x1DAE8:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1DB01
	ld a,$5F
	ld [$CA81],a
	ld a,$A8
	ld [$CA82],a
	jr Logged_0x1DB49

Logged_0x1DB01:
	ld a,$5F
	ld [$CA81],a
	ld a,$AB
	ld [$CA82],a
	jr Logged_0x1DB49

Logged_0x1DB0D:
	ld a,[$CA3C]
	cp $06
	jr nc,Logged_0x1DB20
	ld a,$5F
	ld [$CA81],a
	ld a,$EC
	ld [$CA82],a
	jr Logged_0x1DB49

Logged_0x1DB20:
	ld a,$60
	ld [$CA81],a
	ld a,$5C
	ld [$CA82],a
	jr Logged_0x1DB49

Logged_0x1DB2C:
	ld a,[$CA3C]
	cp $06
	jr nc,Logged_0x1DB3F
	ld a,$5F
	ld [$CA81],a
	ld a,$EF
	ld [$CA82],a
	jr Logged_0x1DB49

Logged_0x1DB3F:
	ld a,$60
	ld [$CA81],a
	ld a,$63
	ld [$CA82],a

Logged_0x1DB49:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA9A]
	bit 7,a
	jr z,Logged_0x1DB6B
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x1DB6B
	ld a,$04
	ld [$CA86],a

Logged_0x1DB6B:
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1DB8A
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,$18
	ld [$CA75],a
	ret

Logged_0x1DB8A:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $21
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x1DBA6
	jp Logged_0x14DE

Logged_0x1DBA6:
	call Logged_0x14F6
	ld a,[$C1AA]
	and a
	jr nz,Logged_0x1DBB7
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$10
	ld [$FF00+$B6],a

Logged_0x1DBB7:
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA86],a
	ld a,[$CA96]
	and a
	jr z,Logged_0x1DBD0
	ld a,[$CA3C]
	cp $06
	jr c,Unknown_0x1DC25
	jr Logged_0x1DBD3

Logged_0x1DBD0:
	jp Logged_0x1EFE7

Logged_0x1DBD3:
	ld a,[$CA97]
	and a
	jr nz,Logged_0x1DBE3
	ld a,$20
	ld [$CA97],a
	ld a,$01
	ld [$CA98],a

Logged_0x1DBE3:
	ld a,[$C1AA]
	and a
	jr nz,Logged_0x1DBF1
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$02
	ld [$FF00+$B6],a

Logged_0x1DBF1:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Unknown_0x1DC0A
	ld a,$5F
	ld [$CA81],a
	ld a,$D2
	ld [$CA82],a
	jr Logged_0x1DC14

Unknown_0x1DC0A:
	ld a,$5F
	ld [$CA81],a
	ld a,$DF
	ld [$CA82],a

Logged_0x1DC14:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x1DC5F

Unknown_0x1DC25:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$33
	ld [$FF00+$B6],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Unknown_0x1DC46
	ld a,$60
	ld [$CA81],a
	ld a,$20
	ld [$CA82],a
	jr Unknown_0x1DC50

Unknown_0x1DC46:
	ld a,$60
	ld [$CA81],a
	ld a,$37
	ld [$CA82],a

Unknown_0x1DC50:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x1DC5F:
	ld a,$81
	ld [$CA96],a
	ld a,$26
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA75],a
	ld [$CA74],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ret

Logged_0x1DC8B:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$2C
	ld [$FF00+$B6],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$22
	ld [$CA83],a
	ld a,[$CA9A]
	and $F0
	add a,$04
	ld [$CA9A],a
	ld a,$04
	ld [$CA7B],a
	ld a,$70
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$60
	ld [$CA7F],a
	ld a,$6A
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1DCE2
	ld a,$64
	ld [$CA81],a
	ld a,$2C
	ld [$CA82],a
	jr Logged_0x1DCEC

Logged_0x1DCE2:
	ld a,$64
	ld [$CA81],a
	ld a,$2F
	ld [$CA82],a

Logged_0x1DCEC:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1DCFC:
	ld a,[$CA9A]
	and a
	jp z,Logged_0x1E99B
	ld a,[$C093]
	bit 1,a
	jp z,Logged_0x1DE3F
	bit 0,a
	jp nz,Logged_0x1DD78
	bit 7,a
	jp nz,Logged_0x1E855
	ld a,[$CA9A]
	bit 7,a
	jr nz,Logged_0x1DD20
	ld b,$1E
	jr Logged_0x1DD22

Logged_0x1DD20:
	ld b,$3C

Logged_0x1DD22:
	ld a,[$CA84]
	inc a
	ld [$CA84],a
	cp b
	jr nc,Logged_0x1DD2D
	ret

Logged_0x1DD2D:
	xor a
	ld [$CEED],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$23
	ld [$CA83],a
	ld a,[$CA9A]
	and $F0
	add a,$05
	ld [$CA9A],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1DD5E
	ld a,$64
	ld [$CA81],a
	ld a,$32
	ld [$CA82],a
	jr Logged_0x1DD68

Logged_0x1DD5E:
	ld a,$64
	ld [$CA81],a
	ld a,$35
	ld [$CA82],a

Logged_0x1DD68:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1DD78:
	xor a
	ld [$CA9A],a
	jp Logged_0x1C2B9

Logged_0x1DD7F:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1DD96
	ld a,$1E
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$2D
	ld [$FF00+$B6],a

Logged_0x1DD96:
	ld a,[$CA9A]
	and a
	jp z,Logged_0x1E99B
	and $0F
	cp $06
	jr z,Logged_0x1DDE0
	ld a,[$CA84]
	and a
	jr nz,Logged_0x1DDE0
	ld a,[$C1A8]
	and a
	jr z,Logged_0x1DDE0
	ld a,[$CA9A]
	and $F0
	add a,$06
	ld [$CA9A],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	inc a
	ld [$CA84],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1DDD6
	ld a,$64
	ld [$CA81],a
	ld a,$38
	ld [$CA82],a
	jr Logged_0x1DDE0

Logged_0x1DDD6:
	ld a,$64
	ld [$CA81],a
	ld a,$41
	ld [$CA82],a

Logged_0x1DDE0:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C093]
	bit 1,a
	jr z,Logged_0x1DE01
	bit 0,a
	jp nz,Logged_0x1DD78
	bit 7,a
	jp nz,Logged_0x1E855
	ret

Logged_0x1DE01:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1DE1A
	ld a,$64
	ld [$CA81],a
	ld a,$03
	ld [$CA82],a
	jr Logged_0x1DE24

Logged_0x1DE1A:
	ld a,$64
	ld [$CA81],a
	ld a,$23
	ld [$CA82],a

Logged_0x1DE24:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA9A]
	and $F0
	add a,$47
	ld [$CA9A],a
	jr Logged_0x1DE7B

Logged_0x1DE3F:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1DE58
	ld a,$63
	ld [$CA81],a
	ld a,$FE
	ld [$CA82],a
	jr Logged_0x1DE62

Logged_0x1DE58:
	ld a,$64
	ld [$CA81],a
	ld a,$1E
	ld [$CA82],a

Logged_0x1DE62:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA9A]
	and $F0
	add a,$07
	ld [$CA9A],a

Logged_0x1DE7B:
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$24
	ld [$CA83],a
	ret

Logged_0x1DE88:
	ld a,[$CA9A]
	and a
	jp z,Logged_0x1E99B
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	xor a
	ld [$CA9A],a
	jp Logged_0x1E99B

Logged_0x1DEAA:
	ld a,[$CA9A]
	and a
	jp z,Logged_0x1C2AE
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	xor a
	ld [$CA9A],a
	jp Logged_0x1C2AE

Logged_0x1DECC:
	ld a,[$CA9A]
	and a
	jp z,Logged_0x1E99B
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $1B
	ret c
	xor a
	ld [$CA96],a
	jp Logged_0x1EFE7

Logged_0x1DEF1:
	ld a,$27
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA8B],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA86],a
	ld [$CA9A],a
	ld a,$01
	ld [$CA9D],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$09
	ld [$CA7B],a
	ld a,$50
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$64
	ld [$CA7F],a
	ld a,$4A
	ld [$CA80],a
	ld a,[$C189]
	bit 1,a
	jr nz,Logged_0x1DF8B
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,$0C
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $0C
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	ld b,$06
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,$00
	ld [$CA69],a
	ld a,$67
	ld [$CA81],a
	ld a,$08
	ld [$CA82],a
	jr Logged_0x1DFC4

Logged_0x1DF8B:
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub $0C
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $0C
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	ld b,$05
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,$01
	ld [$CA69],a
	ld a,$67
	ld [$CA81],a
	ld a,$1D
	ld [$CA82],a

Logged_0x1DFC4:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1DFD4:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1DFEB
	ld a,$0C
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0B
	ld [$FF00+$B6],a

Logged_0x1DFEB:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1F825
	ld a,[$CA83]
	cp $27
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$C7
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x1E174
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	jp nz,Logged_0x1CA0E
	ld a,[$C1A8]
	and a
	ret z

Logged_0x1E042:
	xor a
	ld [$CEED],a
	ld [$CA75],a
	ld [$CA74],a
	ld a,$28
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F2
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$02
	ld [$CA9D],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1E083
	ld a,$66
	ld [$CA81],a
	ld a,$E6
	ld [$CA82],a
	jr Logged_0x1E08D

Logged_0x1E083:
	ld a,$66
	ld [$CA81],a
	ld a,$F7
	ld [$CA82],a

Logged_0x1E08D:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1E09D:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1E0CA
	ld a,$0C
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0A
	ld [$FF00+$B6],a

Logged_0x1E0CA:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C094]
	bit 0,a
	jr nz,Logged_0x1E145
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1E0EE
	call Logged_0x153F
	call Logged_0x1270
	jr Logged_0x1E0F4

Logged_0x1E0EE:
	call Logged_0x151E
	call Logged_0x1259

Logged_0x1E0F4:
	ld a,[$CA86]
	cp $18
	jr c,Logged_0x1E100
	ld a,$14
	ld [$CA86],a

Logged_0x1E100:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	jp nz,Logged_0x1C9FA
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x1E174
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$C189]
	and a
	ret z
	and $0F
	dec a
	ld b,a
	ld a,[$CA69]
	xor b
	jp nz,Logged_0x1CA0E
	ret

Logged_0x1E145:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$C189]
	and a
	jp z,Logged_0x1E1E3
	and $0F
	dec a
	ld b,a
	ld a,[$CA69]
	xor b
	jp nz,Logged_0x1CA0E
	jp Logged_0x1E1E3

Logged_0x1E174:
	ld a,$18
	ld [$CA75],a

Logged_0x1E179:
	xor a
	ld [$C189],a
	ld [$CA9A],a
	ld a,$01
	ld [$CA74],a
	ld a,$29
	ld [$CA83],a
	ld a,$02
	ld [$CA9D],a
	ld a,$09
	ld [$CA7B],a
	ld a,$50
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$64
	ld [$CA7F],a
	ld a,$4A
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1E1C9
	ld a,$66
	ld [$CA81],a
	ld a,$E6
	ld [$CA82],a
	jr Logged_0x1E1D3

Logged_0x1E1C9:
	ld a,$66
	ld [$CA81],a
	ld a,$F7
	ld [$CA82],a

Logged_0x1E1D3:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1E1E3:
	xor a
	ld [$CA75],a
	jr Logged_0x1E179

Logged_0x1E1E9:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1CD48
	ld a,[$CAA0]
	and a
	jr z,Logged_0x1E21C
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E8
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1E21C:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1E239
	call Logged_0x153F
	call Logged_0x1270
	jr Logged_0x1E23F

Logged_0x1E239:
	call Logged_0x151E
	call Logged_0x1259

Logged_0x1E23F:
	ld a,[$CA86]
	cp $18
	jr c,Logged_0x1E24B
	ld a,$14
	ld [$CA86],a

Logged_0x1E24B:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	jp nz,Logged_0x1C9FA
	ld a,[$CA75]
	ld e,a
	ld d,$00
	ld hl,$18CF
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x1E27B
	ld a,[hl]
	cpl
	inc a
	ld b,a
	call Logged_0x129E
	ld hl,$CA75
	inc [hl]
	jr Logged_0x1E28A

Logged_0x1E27B:
	ld b,[hl]
	call Logged_0x1287
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $27
	jr c,Logged_0x1E28A
	ld [hl],$27

Logged_0x1E28A:
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1E2A9
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,$18
	ld [$CA75],a
	ret

Logged_0x1E2A9:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1E2BF
	jp Logged_0x14DE

Logged_0x1E2BF:
	call Logged_0x14F6
	jp Logged_0x1E042

Logged_0x1E2C5:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1E32A
	ld a,[$C094]
	and $13
	jr nz,Logged_0x1E2EF

Logged_0x1E2D2:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CA9F
	dec [hl]
	ret nz
	ld a,$20
	ld [hl],a
	ld a,$06
	ld [$CA9E],a
	ret

Logged_0x1E2EF:
	ld a,$20
	ld [$CA9F],a
	ld a,$01
	ld [$CA69],a
	ld a,$5F
	ld [$CA81],a
	ld a,$7F
	ld [$CA82],a

Logged_0x1E303:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$20
	ld [$CA9F],a
	ld hl,$CA9E
	dec [hl]
	ret nz
	xor a
	ld [$CA9B],a
	jp Logged_0x1C2AE

Logged_0x1E32A:
	ld a,[$C094]
	and $23
	jr z,Logged_0x1E2D2
	ld a,$20
	ld [$CA9F],a
	ld a,$00
	ld [$CA69],a
	ld a,$5F
	ld [$CA81],a
	ld a,$70
	ld [$CA82],a
	jr Logged_0x1E303

Logged_0x1E347:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA97]
	and a
	jr z,Logged_0x1E3B6
	ld a,[$CA74]
	and a
	ret z
	call Logged_0x1488
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$A6
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1762
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1E395
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,$18
	ld [$CA75],a
	ret

Logged_0x1E395:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1E3AB
	jp Logged_0x14DE

Logged_0x1E3AB:
	call Logged_0x14F6
	xor a
	ld [$CA74],a
	ld [$CA75],a
	ret

Logged_0x1E3B6:
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1E3D1
	jp Logged_0x1E855

Logged_0x1E3D1:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x1C2AE
	jp Logged_0x1E99B

Logged_0x1E3E8:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1E3FF
	ld a,$24
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$04
	ld [$FF00+$B6],a

Logged_0x1E3FF:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA84]
	dec a
	jr z,Logged_0x1E444
	dec a
	jr z,Logged_0x1E455
	dec a
	jr z,Logged_0x1E45A
	ld a,[$C1A8]
	and a
	ret z
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$4D
	ld [$CA81],a
	ld a,$15
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CA84
	inc [hl]
	ret

Logged_0x1E444:
	ld a,[$C1A8]
	and a
	ret z
	ld hl,$CA84
	inc [hl]
	ld hl,$C0D7
	res 7,[hl]
	jp Logged_0x11F6

Logged_0x1E455:
	ld hl,$CA84
	inc [hl]
	ret

Logged_0x1E45A:
	ld a,[$C1A8]
	and a
	ret z
	ld a,[$C093]
	and $30
	jp nz,Logged_0x1E6B5
	jp Logged_0x1E99B

Logged_0x1E46A:
	call Logged_0x1E598
	ld a,[$CEE0]
	bit 0,a
	jr nz,Logged_0x1E48E
	bit 1,a
	jr nz,Logged_0x1E4CD
	bit 2,a
	jp nz,Logged_0x1E50C
	bit 3,a
	jp nz,Logged_0x1E54B
	ld a,[$CEE2]
	and a
	call nz,Logged_0x1E58A
	xor a
	ld [$CEE2],a
	ret

Logged_0x1E48E:
	ld a,[$CEE2]
	and $0E
	call nz,Logged_0x1E58A
	ld hl,$CEE0
	ld a,[hl]
	ld [$CEE2],a
	res 0,[hl]
	ld a,[$C0E1]
	bit 4,a
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld a,[$CA9C]
	bit 4,a
	ret nz
	bit 5,a
	jr z,Logged_0x1E4C7
	ld a,[$CA3C]
	cp $08
	ret nc

Logged_0x1E4C7:
	ld b,$02
	call Logged_0x1259
	ret

Logged_0x1E4CD:
	ld a,[$CEE2]
	and $0D
	call nz,Logged_0x1E58A
	ld hl,$CEE0
	ld a,[hl]
	ld [$CEE2],a
	res 1,[hl]
	ld a,[$C0E1]
	bit 5,a
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld a,[$CA9C]
	bit 5,a
	ret nz
	bit 4,a
	jr z,Logged_0x1E506
	ld a,[$CA3C]
	cp $08
	ret nc

Logged_0x1E506:
	ld b,$02
	call Logged_0x1270
	ret

Logged_0x1E50C:
	ld a,[$CEE2]
	and $0B
	call nz,Logged_0x1E58A
	ld hl,$CEE0
	ld a,[hl]
	ld [$CEE2],a
	res 2,[hl]
	ld a,[$C0E1]
	bit 6,a
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld a,[$CA9C]
	bit 6,a
	ret nz
	bit 7,a
	jr z,Logged_0x1E545
	ld a,[$CA3C]
	cp $08
	ret nc

Logged_0x1E545:
	ld b,$02
	call Logged_0x129E
	ret

Logged_0x1E54B:
	ld a,[$CEE2]
	and $07
	call nz,Logged_0x1E58A
	ld hl,$CEE0
	ld a,[hl]
	ld [$CEE2],a
	res 3,[hl]
	ld a,[$C0E1]
	bit 7,a
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld a,[$CA9C]
	bit 7,a
	ret nz
	bit 6,a
	jr z,Logged_0x1E584
	ld a,[$CA3C]
	cp $08
	ret nc

Logged_0x1E584:
	ld b,$02
	call Logged_0x1287
	ret

Logged_0x1E58A:
	ld a,[$CEE1]
	and a
	ret nz
	ld a,[$CEE2]
	add a,$F0
	ld [$CEE1],a
	ret

Logged_0x1E598:
	ld a,[$CEE1]
	and a
	ret z
	bit 0,a
	jr nz,Logged_0x1E5B0
	bit 1,a
	jr nz,Logged_0x1E5E3
	bit 2,a
	jp nz,Logged_0x1E624
	bit 3,a
	jp nz,Logged_0x1E657
	ret

Logged_0x1E5B0:
	ld a,[$C0E1]
	bit 4,a
	jr nz,Logged_0x1E61F
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1E61F
	ld a,[$CA9C]
	bit 4,a
	jr nz,Logged_0x1E614
	bit 5,a
	jr z,Logged_0x1E5DC
	ld a,[$CA3C]
	cp $08
	jr nc,Logged_0x1E614

Logged_0x1E5DC:
	ld b,$01
	call Logged_0x1259
	jr Logged_0x1E614

Logged_0x1E5E3:
	ld a,[$C0E1]
	bit 5,a
	jr nz,Logged_0x1E61F
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1E61F
	ld a,[$CA9C]
	bit 5,a
	jr nz,Logged_0x1E614
	bit 4,a
	jr z,Logged_0x1E60F
	ld a,[$CA3C]
	cp $08
	jr nc,Logged_0x1E614

Logged_0x1E60F:
	ld b,$01
	call Logged_0x1270

Logged_0x1E614:
	ld a,[$CEE1]
	sub $10
	ld [$CEE1],a
	and $F0
	ret nz

Logged_0x1E61F:
	xor a
	ld [$CEE1],a
	ret

Logged_0x1E624:
	ld a,[$C0E1]
	bit 6,a
	jr nz,Logged_0x1E61F
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1E61F
	ld a,[$CA9C]
	bit 6,a
	jr nz,Logged_0x1E614
	bit 7,a
	jr z,Logged_0x1E650
	ld a,[$CA3C]
	cp $08
	jr nc,Logged_0x1E614

Logged_0x1E650:
	ld b,$01
	call Logged_0x129E
	jr Logged_0x1E614

Logged_0x1E657:
	ld a,[$C0E1]
	bit 7,a
	jr nz,Logged_0x1E61F
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1E61F
	ld a,[$CA9C]
	bit 7,a
	jr nz,Logged_0x1E614
	bit 6,a
	jr z,Logged_0x1E683
	ld a,[$CA3C]
	cp $08
	jr nc,Logged_0x1E614

Logged_0x1E683:
	ld b,$01
	call Logged_0x1287
	jr Logged_0x1E614

Logged_0x1E68A:
	ld a,[$C094]
	bit 1,a
	jp nz,Logged_0x1E7AB
	bit 0,a
	jp nz,Logged_0x1C2B9
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1E6A3
	bit 5,a
	jr nz,Logged_0x1E6AC
	ret

Logged_0x1E6A3:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1E6B5
	jp Logged_0x1E73E

Logged_0x1E6AC:
	ld a,[$CA69]
	and a
	jr z,Logged_0x1E6B5
	jp Logged_0x1E73E

Logged_0x1E6B5:
	xor a
	ld [$CA86],a

Logged_0x1E6B9:
	ld a,$01
	ld [$CA83],a
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1E6CB
	bit 5,a
	jr nz,Logged_0x1E6D2
	jr Logged_0x1E6D7

Logged_0x1E6CB:
	ld a,$01
	ld [$CA69],a
	jr Logged_0x1E6D7

Logged_0x1E6D2:
	ld a,$00
	ld [$CA69],a

Logged_0x1E6D7:
	xor a
	ld [$CEED],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA96],a
	ld [$CA84],a
	ld [$CA85],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1E724
	ld a,$49
	ld [$CA81],a
	ld a,$B4
	ld [$CA82],a
	jr Logged_0x1E72E

Logged_0x1E724:
	ld a,$49
	ld [$CA81],a
	ld a,$C5
	ld [$CA82],a

Logged_0x1E72E:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1E73E:
	ld a,$02
	ld [$CA83],a
	xor a
	ld [$CA89],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA75],a
	ld [$CA74],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$4A
	ld [$CA7F],a
	ld a,$82
	ld [$CA80],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	and a
	jr nz,Logged_0x1E791
	ld a,$4C
	ld [$CA81],a
	ld a,$BE
	ld [$CA82],a
	jr Logged_0x1E79B

Logged_0x1E791:
	ld a,$4C
	ld [$CA81],a
	ld a,$C5
	ld [$CA82],a

Logged_0x1E79B:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1E7AB:
	ld a,$30
	ld [$CA89],a
	xor a
	ld [$CEED],a
	ld a,$07
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA8B],a
	ld a,$05
	ld [$CA7E],a
	ld a,$4D
	ld [$CA7F],a
	ld a,$1B
	ld [$CA80],a
	ld a,$04
	ld [$CA7B],a
	ld a,$58
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,[$CA3C]
	cp $05
	jr nc,Logged_0x1E829
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1E81D
	ld a,$51
	ld [$CA81],a
	ld a,$E4
	ld [$CA82],a
	jr Logged_0x1E845

Logged_0x1E81D:
	ld a,$51
	ld [$CA81],a
	ld a,$FD
	ld [$CA82],a
	jr Logged_0x1E845

Logged_0x1E829:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1E83B
	ld a,$52
	ld [$CA81],a
	ld a,$1C
	ld [$CA82],a
	jr Logged_0x1E845

Logged_0x1E83B:
	ld a,$52
	ld [$CA81],a
	ld a,$2D
	ld [$CA82],a

Logged_0x1E845:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1E855:
	ld a,[$C189]
	and a
	jp nz,Logged_0x1DEF1
	ld a,$FF
	ld [$CA70],a
	ld a,$F1
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$12
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA86],a
	ld [$CA74],a
	ld [$CA75],a
	ld a,$01
	ld [$CA8B],a
	ld a,[$C093]
	and $30
	jp nz,Logged_0x1EB94
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	cp $01
	jr z,Logged_0x1E8D3
	ld a,$4A
	ld [$CA81],a
	ld a,$38
	ld [$CA82],a
	jr Logged_0x1E8DD

Logged_0x1E8D3:
	ld a,$4A
	ld [$CA81],a
	ld a,$3B
	ld [$CA82],a

Logged_0x1E8DD:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1E8ED:
	ld a,[$CA77]
	and a
	jr nz,Logged_0x1E8FB
	ld a,[$C093]
	bit 0,a
	jp nz,Logged_0x1C2B9

Logged_0x1E8FB:
	ld a,[$C094]
	bit 1,a
	jp nz,Logged_0x1E7AB
	bit 0,a
	jp nz,Logged_0x1C2B9
	ld a,[$C093]
	bit 7,a
	jr nz,Logged_0x1E985
	bit 4,a
	jr nz,Logged_0x1E919
	bit 5,a
	jr nz,Logged_0x1E94A
	jr Logged_0x1E970

Logged_0x1E919:
	ld a,[$CA69]
	and a
	jp z,Logged_0x1E73E
	ld a,$01
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	call Logged_0x151E
	call Logged_0x1259

Logged_0x1E93D:
	ld a,[$CA86]
	cp $10
	jr c,Logged_0x1E949
	ld a,$0C
	ld [$CA86],a

Logged_0x1E949:
	ret

Logged_0x1E94A:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x1E73E
	ld a,$00
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	call Logged_0x153F
	call Logged_0x1270
	jr Logged_0x1E93D

Logged_0x1E970:
	call Logged_0x1700
	jr z,Logged_0x1E99B
	ld a,$06
	ld [$FF00+$85],a
	ld a,$81
	ld [$FF00+$8D],a
	ld a,$5C
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1E985:
	call Logged_0x1700
	jp z,Logged_0x1E855
	ld a,$06
	ld [$FF00+$85],a
	ld a,$7F
	ld [$FF00+$8D],a
	ld a,$5E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1E99B:
	xor a
	ld [$CA86],a
	ld a,$00
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA96],a
	ld [$CA8B],a
	ld [$CA89],a
	ld [$CA9A],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $00
	ret nz
	ld a,b
	and a
	jp nz,Logged_0x1E855
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$40
	ld [$CA7F],a
	ld a,$00
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1EA24
	ld a,$42
	ld [$CA81],a
	ld a,$52
	ld [$CA82],a
	jr Logged_0x1EA2E

Logged_0x1EA24:
	ld a,$42
	ld [$CA81],a
	ld a,$5F
	ld [$CA82],a

Logged_0x1EA2E:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1EA3E:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1EA5A
	ld a,[$C093]
	bit 4,a
	jp nz,Logged_0x1E73E

Logged_0x1EA4C:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1CB3A
	bit 7,a
	jp nz,Logged_0x1C73B
	ret

Logged_0x1EA5A:
	ld a,[$C093]
	bit 5,a
	jp nz,Logged_0x1E73E
	jr Logged_0x1EA4C

Logged_0x1EA64:
	call Logged_0x1488
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$A6
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA86]
	cp $14
	jr c,Logged_0x1EA82
	ld a,$10
	ld [$CA86],a

Logged_0x1EA82:
	ret

Logged_0x1EA83:
	ld a,[$CA75]
	cp $1C
	jr c,Logged_0x1EAD8
	ld a,[$C093]
	and $30
	jr z,Logged_0x1EAD8
	bit 4,a
	jr nz,Logged_0x1EAB4
	ld a,$00
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1EAD1
	ld b,$01
	call Logged_0x1259
	jr Logged_0x1EAD1

Logged_0x1EAB4:
	ld a,$01
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1EAD1
	ld b,$01
	call Logged_0x1270

Logged_0x1EAD1:
	xor a
	ld [$CA86],a
	jp Logged_0x1C2AE

Logged_0x1EAD8:
	ld a,[$CA69]
	cp $01
	jr z,Logged_0x1EAFE
	ld b,$01
	call Logged_0x1270
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1EB1B
	ld b,$01
	call Logged_0x1259
	jr Logged_0x1EB1B

Logged_0x1EAFE:
	ld b,$01
	call Logged_0x1259
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1EB1B
	ld b,$01
	call Logged_0x1270

Logged_0x1EB1B:
	ld a,[$CA75]
	ld e,a
	ld d,$00
	ld hl,$18A7
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x1EB36
	ld a,[hl]
	cpl
	inc a
	ld b,a
	call Logged_0x129E
	ld hl,$CA75
	inc [hl]
	jr Logged_0x1EB45

Logged_0x1EB36:
	ld b,[hl]
	call Logged_0x1287
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $27
	jr c,Logged_0x1EB45
	ld [hl],$27

Logged_0x1EB45:
	ret

Logged_0x1EB46:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1EC19
	bit 1,a
	jp nz,Logged_0x1EC4B
	ld a,[$C093]
	bit 7,a
	jr nz,Logged_0x1EB79
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $12
	ret nz
	ld a,b
	and a
	jp z,Logged_0x1E99B

Logged_0x1EB79:
	ld a,$F1
	ld [$CA6F],a
	ld a,[$C093]
	and $30
	ret z
	bit 4,a
	jr nz,Logged_0x1EB8F
	ld a,$00
	ld [$CA69],a
	jr Logged_0x1EB94

Logged_0x1EB8F:
	ld a,$01
	ld [$CA69],a

Logged_0x1EB94:
	ld a,$FF
	ld [$CA70],a
	ld a,$F1
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$13
	ld [$CA83],a
	ld a,$01
	ld [$CA8B],a
	xor a
	ld [$CEED],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA89],a
	ld [$CA9A],a
	ld [$CEED],a
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,[$CA69]
	cp $01
	jr z,Logged_0x1EC0D
	ld a,$4A
	ld [$CA81],a
	ld a,$26
	ld [$CA82],a

Logged_0x1EBFD:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1EC0D:
	ld a,$4A
	ld [$CA81],a
	ld a,$2F
	ld [$CA82],a
	jr Logged_0x1EBFD

Logged_0x1EC19:
	ld a,$01
	ld [$CA74],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $12
	jr z,Logged_0x1EC3C
	cp $13
	ret nz

Logged_0x1EC3C:
	ld a,b
	and a
	jp z,Logged_0x1ED3F
	xor a
	ld [$CA74],a
	ld a,$F1
	ld [$CA6F],a
	ret

Logged_0x1EC4B:
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1EC66
	jp Logged_0x1E7AB

Logged_0x1EC66:
	ld a,$F1
	ld [$CA6F],a
	ret

Logged_0x1EC6C:
	ld a,[$C094]
	bit 0,a
	jr nz,Logged_0x1EC19
	bit 1,a
	jr nz,Logged_0x1EC4B
	ld a,[$C093]
	bit 7,a
	jr nz,Logged_0x1EC9D
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $13
	ret nz
	ld a,b
	and a
	jp z,Logged_0x1E99B

Logged_0x1EC9D:
	ld a,$F1
	ld [$CA6F],a
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1ECB0
	bit 5,a
	jr nz,Logged_0x1ECF2
	jp Logged_0x1E855

Logged_0x1ECB0:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1ECCC
	ld a,$01
	ld [$CA69],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$4A
	ld [$CA81],a
	ld a,$2F
	ld [$CA82],a

Logged_0x1ECCC:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	ret nz
	call Logged_0x151E
	call Logged_0x1259
	ld a,[$CA86]
	cp $04
	jr c,Logged_0x1ECF1
	ld a,$00
	ld [$CA86],a

Logged_0x1ECF1:
	ret

Logged_0x1ECF2:
	ld a,[$CA69]
	and a
	jr z,Logged_0x1ED0E
	ld a,$00
	ld [$CA69],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$4A
	ld [$CA81],a
	ld a,$26
	ld [$CA82],a

Logged_0x1ED0E:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	ret nz
	call Logged_0x153F
	call Logged_0x1270
	ld a,[$CA86]
	cp $04
	jr c,Logged_0x1ED33
	ld a,$00
	ld [$CA86],a

Logged_0x1ED33:
	ret

Logged_0x1ED34:
	xor a
	ld [$CA86],a
	ld a,$18
	ld [$CA75],a
	jr Logged_0x1ED4B

Logged_0x1ED3F:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$01
	ld [$FF00+$B6],a
	xor a
	ld [$CA75],a

Logged_0x1ED4B:
	ld a,$14
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F1
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$02
	ld [$CA74],a
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1EDAF
	ld a,$4A
	ld [$CA81],a
	ld a,$38
	ld [$CA82],a
	jr Logged_0x1EDB9

Logged_0x1EDAF:
	ld a,$4A
	ld [$CA81],a
	ld a,$3B
	ld [$CA82],a

Logged_0x1EDB9:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CAC9]
	and a
	ret z
	ld b,$02
	call Logged_0x129E
	ret

Logged_0x1EDD3:
	ld a,[$CA9A]
	and $F0
	add a,$03
	ld [$CA9A],a
	ld a,$18
	ld [$CA75],a
	ld a,$03
	ld [$CA74],a
	jr Logged_0x1EE0D

Logged_0x1EDE9:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$01
	ld [$FF00+$B6],a
	xor a
	ld [$CA75],a
	ld [$CA96],a
	ld a,[$CA3C]
	cp $07
	ld a,$02
	jr c,Logged_0x1EE0A
	ld hl,$C093
	bit 6,[hl]
	jr z,Logged_0x1EE0A
	ld a,$03

Logged_0x1EE0A:
	ld [$CA74],a

Logged_0x1EE0D:
	ld a,$21
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1EE66
	ld a,$5F
	ld [$CA81],a
	ld a,$A8
	ld [$CA82],a
	jr Logged_0x1EE70

Logged_0x1EE66:
	ld a,$5F
	ld [$CA81],a
	ld a,$AB
	ld [$CA82],a

Logged_0x1EE70:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CAC9]
	and a
	ret z
	call Logged_0x1DA4F
	ret

Logged_0x1EE88:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1EDE9
	ld a,[$C093]
	bit 1,a
	jp nz,Logged_0x1DC8B
	bit 7,a
	jp nz,Logged_0x1E855
	and $30
	jr nz,Logged_0x1EEA2
	ret

Logged_0x1EEA2:
	ld a,$20
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1EEEB
	ld a,$00
	ld [$CA69],a
	ld a,$49
	ld [$CA81],a
	ld a,$FE
	ld [$CA82],a

Logged_0x1EEDB:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1EEEB:
	ld a,$01
	ld [$CA69],a
	ld a,$4A
	ld [$CA81],a
	ld a,$0F
	ld [$CA82],a
	jr Logged_0x1EEDB

Logged_0x1EEFC:
	ld a,[$C094]
	bit 1,a
	jp nz,Logged_0x1DC8B
	bit 0,a
	jp nz,Logged_0x1EDE9
	bit 7,a
	jp nz,Logged_0x1EFAF
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1EF31
	bit 5,a
	jr nz,Logged_0x1EF4D
	call Logged_0x1700
	jr z,Logged_0x1EF2E
	ld a,$06
	ld [$FF00+$85],a
	ld a,$73
	ld [$FF00+$8D],a
	ld a,$67
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1EF2E:
	jp Logged_0x1EFE7

Logged_0x1EF31:
	ld a,[$CA69]
	and a
	jp z,Logged_0x1EFE7
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	ret nz
	jr Logged_0x1EF69

Logged_0x1EF4D:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x1EFE7
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	ret nz
	jr Logged_0x1EF7B

Logged_0x1EF69:
	call Logged_0x151E
	call Logged_0x1259
	ld a,[$C189]
	and a
	jr z,Logged_0x1EF8D
	bit 0,a
	jr z,Logged_0x1EF8D
	jr Unknown_0x1EFC5

Logged_0x1EF7B:
	call Logged_0x153F
	call Logged_0x1270
	ld a,[$C189]
	and a
	jr z,Logged_0x1EF8D
	bit 0,a
	jr nz,Logged_0x1EF8D
	jr Unknown_0x1EFC5

Logged_0x1EF8D:
	ld a,[$CA9A]
	bit 7,a
	jr nz,Logged_0x1EFA1
	ld a,[$CA86]
	cp $10
	jr c,Logged_0x1EFA0
	ld a,$0C
	ld [$CA86],a

Logged_0x1EFA0:
	ret

Logged_0x1EFA1:
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x1EFA0
	ld a,$04
	ld [$CA86],a
	jr Logged_0x1EFA0

Logged_0x1EFAF:
	call Logged_0x1700
	jp z,Logged_0x1E855
	ld a,$06
	ld [$FF00+$85],a
	ld a,$7F
	ld [$FF00+$8D],a
	ld a,$5E
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x1EFC5:
	ld a,[$CA9A]
	bit 7,a
	jr nz,Unknown_0x1EFD9
	ld a,[$CA86]
	cp $08
	jr c,Unknown_0x1EFD8
	ld a,$04
	ld [$CA86],a

Unknown_0x1EFD8:
	ret

Unknown_0x1EFD9:
	ld a,[$CA86]
	cp $04
	jr c,Unknown_0x1EFD8
	ld a,$00
	ld [$CA86],a
	jr Unknown_0x1EFD8

Logged_0x1EFE7:
	ld a,[$CA9A]
	and a
	jp z,Logged_0x1E99B
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA96],a
	ld [$CA8B],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,[$CA9A]
	and $F0
	add a,$03
	ld [$CA9A],a
	ld a,$1F
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1F05D
	ld a,$4A
	ld [$CA81],a
	ld a,$20
	ld [$CA82],a
	jr Logged_0x1F067

Logged_0x1F05D:
	ld a,$4A
	ld [$CA81],a
	ld a,$23
	ld [$CA82],a

Logged_0x1F067:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1F077:
	ld a,[$C093]
	bit 0,a
	jr nz,Logged_0x1F094
	xor a
	ld [$CA77],a
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x1F094
	ld a,[$CA76]
	and a
	jr nz,Logged_0x1F094
	ld a,$18
	ld [$CA75],a

Logged_0x1F094:
	ld a,[$CA75]
	ld e,a
	ld d,$00
	ld a,[$CA74]
	dec a
	jr z,Logged_0x1F0AD
	dec a
	jr z,Logged_0x1F0A8
	ld hl,$18CF
	jr Logged_0x1F0B0

Logged_0x1F0A8:
	ld hl,$18A7
	jr Logged_0x1F0B0

Logged_0x1F0AD:
	ld hl,$18F7

Logged_0x1F0B0:
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x1F0C2
	ld a,[hl]
	cpl
	inc a
	ld b,a
	call Logged_0x129E
	ld hl,$CA75
	inc [hl]
	jr Logged_0x1F0D5

Logged_0x1F0C2:
	xor a
	ld [$CA76],a
	ld b,[hl]
	call Logged_0x1287
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $27
	jr c,Logged_0x1F0D5
	ld [hl],$27

Logged_0x1F0D5:
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1F0E1
	bit 5,a
	jr nz,Logged_0x1F0E7
	ret

Logged_0x1F0E1:
	call Logged_0x1F0ED
	jp Logged_0x1762

Logged_0x1F0E7:
	call Logged_0x1F104
	jp Logged_0x1762

Logged_0x1F0ED:
	xor a
	ld [$CA95],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1F101
	ld a,$01
	ld [$CA69],a
	ld a,$01
	ld [$CA95],a

Logged_0x1F101:
	jp Logged_0x1F11B

Logged_0x1F104:
	xor a
	ld [$CA95],a
	ld a,[$CA69]
	and a
	jr z,Logged_0x1F118
	ld a,$00
	ld [$CA69],a
	ld a,$01
	ld [$CA95],a

Logged_0x1F118:
	jp Logged_0x1F135

Logged_0x1F11B:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	ret nz
	call Logged_0x151E
	call Logged_0x1259
	ret

Logged_0x1F135:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	ret nz
	call Logged_0x153F
	call Logged_0x1270
	ret

Logged_0x1F14F:
	ld a,[$CA3C]
	cp $02
	ret c
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1F161
	bit 5,a
	jr nz,Logged_0x1F185
	ret

Logged_0x1F161:
	ld a,[$CA69]
	cp $01
	jr z,Logged_0x1F16D
	ld a,$01
	ld [$CA69],a

Logged_0x1F16D:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld b,$01
	call Logged_0x1259
	ret

Logged_0x1F185:
	ld a,[$CA69]
	cp $00
	jr z,Logged_0x1F191
	ld a,$00
	ld [$CA69],a

Logged_0x1F191:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld b,$01
	call Logged_0x1270
	ret

Logged_0x1F1A9:
	ld a,[$C0DB]
	cp $02
	jr z,Logged_0x1F1F5
	ld a,[$CA3C]
	cp $02
	jr c,Logged_0x1F1F5
	ld a,[$C094]
	bit 1,a
	jp nz,Logged_0x1D1E4
	bit 0,a
	jp nz,Logged_0x1D1DD
	ld a,[$C093]
	and $F0
	jp nz,Logged_0x1F24C
	ld a,[$CA85]
	and a
	jr nz,Logged_0x1F1F5
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1F1EB
	ld a,$55
	ld [$CA81],a
	ld a,$69
	ld [$CA82],a
	jr Logged_0x1F1F5

Logged_0x1F1EB:
	ld a,$55
	ld [$CA81],a
	ld a,$73
	ld [$CA82],a

Logged_0x1F1F5:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$01
	ld [$CA85],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1F246
	ld a,$06
	ld [$FF00+$85],a
	ld a,$CD
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DB]
	and a
	jp z,Logged_0x1CF7A
	ld a,[$C08F]
	and $01
	ret nz
	ld hl,$CEE2
	ld a,[hld]
	or [hl]
	and $0C
	ret nz
	ld b,$01
	call Logged_0x129E
	ret

Logged_0x1F246:
	ld a,$40
	ld [$C0E1],a
	ret

Logged_0x1F24C:
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x1F263
	ld a,$25
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0E
	ld [$FF00+$B6],a

Logged_0x1F263:
	ld a,[$CA85]
	and a
	jr z,Logged_0x1F28F
	xor a
	ld [$CA85],a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1F285
	ld a,$55
	ld [$CA81],a
	ld a,$76
	ld [$CA82],a
	jr Logged_0x1F28F

Logged_0x1F285:
	ld a,$55
	ld [$CA81],a
	ld a,$8B
	ld [$CA82],a

Logged_0x1F28F:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C08F]
	and $01
	jr z,Logged_0x1F2B2
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x1F2C0
	bit 5,a
	jp nz,Logged_0x1F357
	ret

Logged_0x1F2B2:
	ld a,[$C093]
	bit 6,a
	jp nz,Logged_0x1F3D9
	bit 7,a
	jp nz,Logged_0x1F3A7
	ret

Logged_0x1F2C0:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1F2DE
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a

Logged_0x1F2DE:
	ld a,[$CA83]
	cp $10
	ret z
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1F310
	ld a,$01
	ld [$CA69],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$55
	ld [$CA81],a
	ld a,$8B
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1F310:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1F345
	ld a,[$CA69]
	and a
	jr z,Logged_0x1F337
	ld hl,$CEE2
	ld a,[hld]
	or [hl]
	and $03
	ret nz
	ld b,$01
	call Logged_0x1259
	ret

Logged_0x1F337:
	ld hl,$CEE2
	ld a,[hld]
	or [hl]
	and $03
	ret nz
	ld b,$01
	call Logged_0x1270
	ret

Logged_0x1F345:
	ld a,[$CA69]
	and a
	jr z,Logged_0x1F351
	ld a,$10
	ld [$C0E1],a
	ret

Logged_0x1F351:
	ld a,$20
	ld [$C0E1],a
	ret

Logged_0x1F357:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1F375
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a

Logged_0x1F375:
	ld a,[$CA83]
	cp $10
	ret z
	ld a,[$CA69]
	and a
	jr z,Logged_0x1F310
	ld a,$00
	ld [$CA69],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$55
	ld [$CA81],a
	ld a,$76
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1F3A7:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1F3CB
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$80
	ld [$C0E1],a
	ret

Logged_0x1F3CB:
	ld hl,$CEE2
	ld a,[hld]
	or [hl]
	and $0C
	ret nz
	ld b,$01
	call Logged_0x1287
	ret

Logged_0x1F3D9:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$CD
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DB]
	and a
	jp z,Logged_0x1CF7A
	ld hl,$CEE2
	ld a,[hld]
	or [hl]
	and $0C
	ret nz
	ld b,$01
	call Logged_0x129E
	ret

Logged_0x1F40F:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x1C270
	bit 1,a
	jr z,Logged_0x1F448
	ld a,[$CA3C]
	cp $02
	jp c,Logged_0x1F448
	ld a,[$C093]
	bit 6,a
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$12
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DB]
	cp $02
	jp z,Unknown_0x1D416
	ld b,$03
	call Logged_0x1287
	jp Logged_0x1D1E4

Logged_0x1F448:
	ld a,[$C093]
	bit 7,a
	ret z
	ld a,[$CA3C]
	cp $02
	jp c,Unknown_0x1D416
	ld a,$06
	ld [$FF00+$85],a
	ld a,$12
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DB]
	cp $02
	jp z,Unknown_0x1D416
	jp Logged_0x1CE95

Logged_0x1F470:
	ld hl,$CA6D
	inc [hl]
	ld a,[hl]
	cp $28
	jr c,Logged_0x1F47E
	xor a
	ld [hl],a
	jp Logged_0x1CE95

Logged_0x1F47E:
	ld a,[$C093]
	and $03
	jp z,Logged_0x1CE95
	ld a,[$CA9C]
	bit 4,a
	jr nz,Logged_0x1F49C
	bit 5,a
	jr nz,Logged_0x1F4FB
	bit 6,a
	jp nz,Logged_0x1F600
	bit 7,a
	jp nz,Logged_0x1F5C3
	ret

Logged_0x1F49C:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1F4BA
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a

Logged_0x1F4BA:
	ld a,[$CA83]
	cp $10
	ret z
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp nz,Logged_0x1D2EA
	ld a,[$CA6D]
	ld e,a
	ld d,$00
	ld hl,$786C
	ld a,[$CA9C]
	and $C0
	jr z,Logged_0x1F4E7
	ld hl,$78BC

Logged_0x1F4E7:
	add hl,de
	ld b,[hl]
	call Logged_0x1259
	ld a,[$CA9C]
	bit 6,a
	jp nz,Logged_0x1F600
	bit 7,a
	jp nz,Logged_0x1F5C3
	jr Logged_0x1F55A

Logged_0x1F4FB:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x1F519
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a

Logged_0x1F519:
	ld a,[$CA83]
	cp $10
	ret z
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp nz,Logged_0x1D2EA
	ld a,[$CA6D]
	ld e,a
	ld d,$00
	ld hl,$786C
	ld a,[$CA9C]
	and $C0
	jr z,Logged_0x1F546
	ld hl,$78BC

Logged_0x1F546:
	add hl,de
	ld b,[hl]
	call Logged_0x1270
	ld a,[$CA9C]
	bit 6,a
	jp nz,Logged_0x1F600
	bit 7,a
	jp nz,Logged_0x1F5C3
	jr Logged_0x1F55A

Logged_0x1F55A:
	ld a,[$C093]
	and $C0
	ret z
	bit 7,a
	jr nz,Logged_0x1F599
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1F593
	ld a,$06
	ld [$FF00+$85],a
	ld a,$CD
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DB]
	and a
	jp z,Logged_0x1CF7A
	ld b,$01
	call Logged_0x129E
	ret

Logged_0x1F593:
	ld hl,$C0E1
	set 6,[hl]
	ret

Logged_0x1F599:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1F5B2
	ld b,$01
	call Logged_0x1287
	ret

Logged_0x1F5B2:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld hl,$C0E1
	set 7,[hl]
	ret

Logged_0x1F5C3:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1F5EF
	ld a,[$CA6D]
	ld e,a
	ld d,$00
	ld hl,$786C
	ld a,[$CA9C]
	and $30
	jr z,Logged_0x1F5E9
	ld hl,$7894

Logged_0x1F5E9:
	add hl,de
	ld b,[hl]
	call Logged_0x1287
	ret

Logged_0x1F5EF:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld hl,$C0E1
	set 7,[hl]
	ret

Logged_0x1F600:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x1F642
	ld a,$06
	ld [$FF00+$85],a
	ld a,$CD
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DB]
	and a
	jp z,Logged_0x1CF7A
	ld a,[$CA6D]
	ld e,a
	ld d,$00
	ld hl,$786C
	ld a,[$CA9C]
	and $30
	jr z,Logged_0x1F63C
	ld hl,$7894

Logged_0x1F63C:
	add hl,de
	ld b,[hl]
	call Logged_0x129E
	ret

Logged_0x1F642:
	ld hl,$C0E1
	set 6,[hl]
	jp Logged_0x1CDC4

Logged_0x1F64A:
	ld a,[$CA8C]
	and a
	ret z
	cp $16
	jr nc,Logged_0x1F68B
	cp $10
	jr nc,Logged_0x1F67C
	ld a,[$CA83]
	cp $15
	jr z,Logged_0x1F67B
	cp $16
	jr z,Logged_0x1F67B
	ld a,$10
	ld [$CA8C],a
	ld a,[$CA79]
	cp $48
	jr nz,Logged_0x1F67B
	ld a,[$CA7A]
	cp $10
	jr nz,Logged_0x1F67B
	ld hl,$4800
	call Logged_0x1AF6

Logged_0x1F67B:
	ret

Logged_0x1F67C:
	ld a,[$C08F]
	and $03
	ret nz
	ld a,[$CA8C]
	inc a
	ld [$CA8C],a
	jr Logged_0x1F6B9

Logged_0x1F68B:
	ld a,[$C08F]
	and $01
	ret nz
	ld a,[$CA8C]
	inc a
	ld [$CA8C],a
	cp $28
	jr c,Logged_0x1F6B9
	xor a
	ld [$CA8C],a
	ld [$CA8D],a
	ld a,[$C093]
	and $B0
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1F6B9:
	ld a,[$CA8D]
	xor $01
	ld [$CA8D],a
	ret

Logged_0x1F6C2:
	ld a,[$C08F]
	and $07
	jr z,Logged_0x1F6CE
	cp $03
	jr z,Logged_0x1F6D5
	ret

Logged_0x1F6CE:
	ld hl,$4810
	call Logged_0x1AF6
	ret

Logged_0x1F6D5:
	ld hl,$4800
	call Logged_0x1AF6
	ret

Logged_0x1F6DC:
	ld a,[$CED4]
	and a
	ret nz
	ld hl,$CA97
	ld a,[hl]
	and a
	jr z,Logged_0x1F726
	cp $10
	jr c,Logged_0x1F72B
	ld a,[$CA99]
	and a
	jr nz,Logged_0x1F72B
	ld a,[$CA98]
	and a
	jr nz,Logged_0x1F72B
	ld a,[$CA74]
	and a
	jr nz,Logged_0x1F72B
	ld a,[$C0DB]
	and a
	jr nz,Logged_0x1F72B
	ld a,[$CA8E]
	and a
	jr nz,Logged_0x1F72B
	ld a,[$C0D7]
	and a
	jr nz,Logged_0x1F72B
	ld a,[$CA8A]
	and a
	jr nz,Logged_0x1F72B
	ld a,[$CAC9]
	and a
	jr nz,Logged_0x1F72B
	ld a,[$CA83]
	cp $2B
	jr z,Logged_0x1F72B
	jr Logged_0x1F73C

UnknownData_0x1F725:
INCBIN "baserom.gbc", $1F725, $1F726 - $1F725

Logged_0x1F726:
	xor a
	ld [$CA98],a
	ret

Logged_0x1F72B:
	dec [hl]
	ld a,[hl]
	and $02
	jr nz,Logged_0x1F736
	xor a
	ld [$C0BC],a
	ret

Logged_0x1F736:
	ld a,$02
	ld [$C0BC],a
	ret

Logged_0x1F73C:
	ld a,[$CA83]
	cp $3A
	jp z,Logged_0x1F7E6
	cp $3B
	jp z,Logged_0x1F7E6
	cp $4C
	jp z,Logged_0x1F7E6
	ld a,$2B
	ld [$CA83],a
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA89],a
	ld [$CA9D],a
	ld [$CA9A],a
	ld a,$F1
	ld [$CA6F],a
	ld a,[$CA8B]
	and a
	jr nz,Logged_0x1F77D
	ld a,$E5
	ld [$CA6F],a
	ld a,$0A
	ld [$CA75],a
	ld a,$01
	ld [$CA74],a

Logged_0x1F77D:
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1F7CC
	ld a,$5F
	ld [$CA81],a
	ld a,$70
	ld [$CA82],a
	jr Logged_0x1F7D6

Logged_0x1F7CC:
	ld a,$5F
	ld [$CA81],a
	ld a,$7F
	ld [$CA82],a

Logged_0x1F7D6:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1F7E6:
	ld a,$3C
	ld [$CA83],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0C
	ld [$FF00+$B6],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA99],a
	inc a
	ld [$CA74],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$59
	ld [$CA81],a
	ld a,$48
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x1F825:
	ld a,[$C094]
	bit 0,a
	jr nz,Logged_0x1F85C
	ld a,[$CA69]
	and a
	jr nz,Logged_0x1F849
	ld a,[$C094]
	bit 4,a
	jr nz,Unknown_0x1F855
	call Logged_0x1F135

Logged_0x1F83C:
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x1F848
	ld a,$04
	ld [$CA86],a

Logged_0x1F848:
	ret

Logged_0x1F849:
	ld a,[$C094]
	bit 5,a
	jr nz,Unknown_0x1F855
	call Logged_0x1F11B
	jr Logged_0x1F83C

Unknown_0x1F855:
	xor a
	ld [$CA9D],a
	jp Logged_0x1E99B

Logged_0x1F85C:
	xor a
	ld [$CA9D],a
	jp Logged_0x1C2B9
	ld hl,$786C
	add hl,de
	ld b,[hl]
	call Logged_0x129E
	ret

LoggedData_0x1F86C:
INCBIN "baserom.gbc", $1F86C, $1F8B2 - $1F86C

UnknownData_0x1F8B2:
INCBIN "baserom.gbc", $1F8B2, $1F8BC - $1F8B2

LoggedData_0x1F8BC:
INCBIN "baserom.gbc", $1F8BC, $1F8DA - $1F8BC

UnknownData_0x1F8DA:
INCBIN "baserom.gbc", $1F8DA, $20000 - $1F8DA

SECTION "Bank08", ROMX, BANK[$08]
	ld a,[$CA8A]
	and a
	ret nz
	ld a,[$CA73]
	and a
	ret nz
	ld a,[$CA9B]
	and a
	ret nz
	xor a
	ld [$CAC9],a
	ld hl,$D000

Logged_0x20016:
	ld a,h
	cp $D1
	ret z
	ld [$C1B6],a
	ld a,l
	ld [$C1B7],a
	ld a,[hl]
	and $03
	cp $03
	jr z,Logged_0x20036

Logged_0x20028:
	ld a,[$C1B6]
	ld h,a
	ld a,[$C1B7]
	ld l,a
	ld de,$0020
	add hl,de
	jr Logged_0x20016

Logged_0x20036:
	push hl
	ld e,$1D
	ld d,$00
	add hl,de
	ld a,[hld]
	ld [$C1B8],a
	ld a,[hl]
	pop hl
	and a
	jr nz,Logged_0x20028
	ld e,$08
	ld d,$00
	add hl,de
	ld a,[hli]
	ld [$C1B9],a
	ld a,[hli]
	ld [$C1BA],a
	ld a,[hli]
	ld [$C1BB],a
	ld a,[hli]
	ld [$C1BC],a
	ld a,[hli]
	ld [$C1BD],a
	ld a,[hli]
	ld [$C1BE],a
	ld a,[hl]
	ld [$C1BF],a
	ld e,$0C
	ld d,$00
	add hl,de
	ld a,[hl]
	bit 7,a
	jr nz,Logged_0x20074
	ld a,$00
	jr Logged_0x20076

Logged_0x20074:
	ld a,$01

Logged_0x20076:
	ld [$C1C6],a
	xor a
	ld [$C1C0],a
	ld a,$FF
	ld [$C1C2],a
	ld [$C1C1],a
	ld [$C1C3],a
	ld [$C1C4],a
	ld e,$D0
	ld hl,$C1BA
	ld a,[$C1BE]
	add a,[hl]
	sub e
	ld b,a
	ld hl,$CA70
	ld a,[$CA87]
	add a,[hl]
	sub e
	sub b
	jp c,Logged_0x20028
	ld c,a
	ld hl,$CA6F
	ld a,[$CA87]
	add a,[hl]
	sub e
	ld b,a
	ld hl,$C1BB
	ld a,[$C1BE]
	add a,[hl]
	sub e
	sub b
	jp c,Logged_0x20028
	ld d,a
	ld a,d
	sub c
	jr c,Logged_0x200C9
	jr z,Logged_0x200C5
	ld a,c
	ld [$C1C1],a
	jr Logged_0x200CD

Logged_0x200C5:
	ld a,c
	ld [$C1C1],a

Logged_0x200C9:
	ld a,d
	ld [$C1C2],a

Logged_0x200CD:
	ld hl,$C1BC
	ld a,[$C1BF]
	add a,[hl]
	sub e
	ld b,a
	ld hl,$CA72
	ld a,[$CA88]
	add a,[hl]
	sub e
	sub b
	jp c,Logged_0x20028
	ld c,a
	ld hl,$CA71
	ld a,[$CA88]
	add a,[hl]
	sub e
	ld b,a
	ld hl,$C1BD
	ld a,[$C1BF]
	add a,[hl]
	sub e
	sub b
	jp c,Logged_0x20028
	ld d,a
	sub c
	jr c,Logged_0x20108
	jr z,Logged_0x20104
	ld a,c
	ld [$C1C3],a
	jr Logged_0x2010C

Logged_0x20104:
	ld a,c
	ld [$C1C3],a

Logged_0x20108:
	ld a,d
	ld [$C1C4],a

Logged_0x2010C:
	ld hl,$C1C0
	ld a,$F0
	ld [hl],a
	ld a,[$C1C4]
	ld b,a
	ld a,[$C1C3]
	ld c,a
	cp b
	jr z,Logged_0x20126
	jr c,Logged_0x20123
	res 5,[hl]
	jr Logged_0x20126

Logged_0x20123:
	res 4,[hl]
	ld b,c

Logged_0x20126:
	ld a,[$C1C2]
	ld d,a
	ld a,[$C1C1]
	ld e,a
	cp d
	jr z,Logged_0x2013A
	jr c,Logged_0x20137
	res 6,[hl]
	jr Logged_0x2013A

Logged_0x20137:
	res 7,[hl]
	ld d,e

Logged_0x2013A:
	ld a,b
	cp d
	jr z,Logged_0x2014A
	jr c,Logged_0x20146
	res 4,[hl]
	res 5,[hl]
	jr Logged_0x2014A

Logged_0x20146:
	res 6,[hl]
	res 7,[hl]

Logged_0x2014A:
	ld a,[$C1B9]
	and $7F
	rst JumpList
	dw Logged_0x20B6B
	dw Logged_0x20D1D
	dw Logged_0x20D20
	dw Unknown_0x20D47
	dw Logged_0x20D6E
	dw Logged_0x20D7E
	dw Logged_0x20D81
	dw Unknown_0x20D8C
	dw Unknown_0x20DEB
	dw Unknown_0x20E39
	dw Logged_0x20E60
	dw Logged_0x20E6A
	dw Logged_0x20E77
	dw Logged_0x20E82
	dw Logged_0x20E97
	dw Logged_0x20F6A
	dw Logged_0x20FED
	dw Logged_0x20FF4
	dw Logged_0x20FFB
	dw Logged_0x21002
	dw Logged_0x2101C
	dw Logged_0x2103C
	dw Logged_0x2105C
	dw Logged_0x2107C
	dw Logged_0x21156
	dw Logged_0x21245
	dw Logged_0x21358
	dw Logged_0x21433
	dw Logged_0x21455
	dw Logged_0x21548
	dw Logged_0x21569
	dw Logged_0x215A2
	dw Logged_0x215E7
	dw Logged_0x2164F
	dw Logged_0x21675
	dw Logged_0x21774
	dw Logged_0x217B9
	dw Logged_0x21819
	dw Logged_0x21853
	dw Logged_0x21887
	dw Logged_0x218E7
	dw Logged_0x21999
	dw Logged_0x20E0F
	dw Logged_0x21A4F
	dw Logged_0x21A47
	dw Logged_0x21A52
	dw Logged_0x21A8C
	dw Logged_0x21A97
	dw Logged_0x21AC3
	dw Logged_0x21AF1
	dw Logged_0x21B08
	dw Logged_0x21B0B
	dw Logged_0x21B2B
	dw Logged_0x21B42
	dw Logged_0x21B78
	dw Logged_0x21573
	dw Logged_0x21B89
	dw Logged_0x21C17
	dw Unknown_0x21C26
	dw Logged_0x21C56
	dw Logged_0x21C61
	dw Logged_0x21C86
	dw Logged_0x21C98
	dw Logged_0x21CA8
	dw Unknown_0x21CCF
	dw Logged_0x21CE9
	dw Logged_0x21CF8
	dw Logged_0x207ED
	dw Logged_0x21CFD
	dw Logged_0x21D17
	dw Unknown_0x21D3B
	dw Unknown_0x21D64
	dw Logged_0x21D6F
	dw Logged_0x21D88
	dw Logged_0x21DD3
	dw Logged_0x21DF8
	dw Logged_0x21E2E
	dw Logged_0x21E3E
	dw Logged_0x21E9C
	dw Logged_0x21EA6
	dw Logged_0x21ECD
	dw Unknown_0x21F01
	dw Logged_0x21F28
	dw Unknown_0x20202
	dw Unknown_0x20202
	dw Unknown_0x20202
	dw Unknown_0x20202
	dw Unknown_0x20202
	dw Unknown_0x20202

Unknown_0x20202:
	ret

Logged_0x20203:
	ld hl,$D000
	ld de,$0020

Logged_0x20209:
	ld a,h
	cp $D1
	ret z
	ld a,[hl]
	and $03
	cp $01
	jr z,Logged_0x2021B
	cp $03
	jr z,Logged_0x2021B

Logged_0x20218:
	add hl,de
	jr Logged_0x20209

Logged_0x2021B:
	ld a,[$C1B7]
	cp l
	jr z,Logged_0x20218
	push hl
	ld c,$1C
	ld b,$00
	add hl,bc
	ld [hl],$08
	pop hl
	jr Logged_0x20218

Logged_0x2022C:
	ld a,[$CA9D]
	and a
	jp nz,Logged_0x20350
	ld a,[$C1C0]
	and $C0
	jp nz,Logged_0x20447

Logged_0x2023B:
	ld a,[$CA93]
	and a
	jr z,Logged_0x20257
	cp $02
	jr z,Logged_0x20257
	cp $01
	jp z,Logged_0x20939
	cp $03
	jp z,Logged_0x20350
	cp $04
	jp z,Logged_0x205E7
	jp Logged_0x20028

Logged_0x20257:
	ld a,[$CA89]
	and a
	jp nz,Logged_0x20350
	ld b,$01
	call Logged_0x20657
	ld a,[$CA8C]
	cp $01
	ret z
	ld a,[$CA8E]
	cp $42
	jr z,Logged_0x2028A
	and a
	ret nz
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x20283
	ld a,$00
	ld [$CA69],a
	jr Logged_0x20288

Logged_0x20283:
	ld a,$01
	ld [$CA69],a

Logged_0x20288:
	jr Logged_0x202B5

Logged_0x2028A:
	ld a,[$CA74]
	and a
	ret z
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x202A0
	ld a,$00
	ld [$CA69],a
	jr Logged_0x202A5

Logged_0x202A0:
	ld a,$01
	ld [$CA69],a

Logged_0x202A5:
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$57
	ld [$FF00+$8D],a
	ld a,$47
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x202B5:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$03
	ld [$FF00+$B6],a
	ld a,$0E
	ld [$CA75],a
	ld a,$01
	ld [$CA74],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA96],a
	ld [$CA9A],a
	ld a,$19
	ld [$CA83],a
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	ld a,[$CA8B]
	and a
	jr nz,Logged_0x20332
	ld a,[$CA69]
	and a
	jr nz,Logged_0x20326
	ld a,$4A
	ld [$CA81],a
	ld a,$71
	ld [$CA82],a

Logged_0x20316:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20326:
	ld a,$4A
	ld [$CA81],a
	ld a,$6C
	ld [$CA82],a
	jr Logged_0x20316

Logged_0x20332:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x20344
	ld a,$4A
	ld [$CA81],a
	ld a,$3B
	ld [$CA82],a
	jr Logged_0x20316

Logged_0x20344:
	ld a,$4A
	ld [$CA81],a
	ld a,$38
	ld [$CA82],a
	jr Logged_0x20316

Logged_0x20350:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$17
	ld [$FF00+$B6],a
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x20382
	ld a,$20
	ld [$C1C0],a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,$08
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $08
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	jr Logged_0x203A0

Logged_0x20382:
	ld a,$10
	ld [$C1C0],a
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub $08
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $08
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a

Logged_0x203A0:
	ld b,$02
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld b,$02
	call Logged_0x20657
	ld a,[$CA8E]
	cp $84
	jr z,Logged_0x20422
	cp $50
	jr z,Logged_0x20432
	and a
	ret nz
	ld a,[$CA9D]
	and a
	jr z,Logged_0x203E5
	ld a,[$C1B9]
	bit 7,a
	ret z
	ld a,[$CA3C]
	cp $05
	ret nc
	ld a,$07
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$4A
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x203E5:
	ld a,[$C1B9]
	bit 7,a
	jr z,Logged_0x203FC
	ld a,$07
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$4A
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x203FC:
	ld a,[$CA74]
	and a
	jr nz,Logged_0x20412
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20412:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20422:
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$31
	ld [$FF00+$8D],a
	ld a,$4E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20432:
	ld a,[$CA8F]
	and a
	ret nz
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$B2
	ld [$FF00+$8D],a
	ld a,$4B
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20447:
	ld a,[$CA8C]
	cp $01
	ret z
	ld a,[$CA96]
	dec a
	jr nz,Logged_0x2045E
	ld a,[$CA8E]
	cp $84
	jp z,Logged_0x205E7
	jp Logged_0x20602

Logged_0x2045E:
	ld a,[$CA8E]
	and a
	jp nz,Logged_0x20585
	xor a
	ld [$CA89],a
	ld a,[$CA9D]
	and a
	jp nz,Logged_0x20350
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x20484
	ld a,[$C1C0]
	or $20
	ld [$C1C0],a
	jr Logged_0x2048C

Logged_0x20484:
	ld a,[$C1C0]
	or $10
	ld [$C1C0],a

Logged_0x2048C:
	ld a,[$C1C0]
	bit 7,a
	jr nz,Logged_0x20506
	ld a,[$CA87]
	ld b,a
	ld a,[$C1BE]
	cp b
	jr c,Logged_0x20506
	ld a,[$CA9A]
	and $0F
	cp $03
	jr z,Logged_0x204D9
	xor a
	ld [$CA9A],a
	ld a,[$CA8B]
	and a
	jr nz,Logged_0x204C8
	ld a,[$C093]
	and a
	jp z,Logged_0x20575
	ld a,$07
	ld [$FF00+$85],a
	ld a,$B9
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x204E8

Logged_0x204C8:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$3F
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x204E8

Logged_0x204D9:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80

Logged_0x204E8:
	ld a,$01
	ld [$CA76],a
	ld a,$0A
	ld [$CA75],a
	ld a,[$C093]
	bit 0,a
	jr z,Logged_0x20578
	ld a,[$CA3C]
	cp $07
	jr c,Logged_0x20578
	xor a
	ld [$CA75],a
	jr Logged_0x20578

Logged_0x20506:
	ld a,[$CA8C]
	cp $01
	ret z
	ld a,[$CA8B]
	and a
	jr nz,Logged_0x2055E
	ld a,[$CA9A]
	and $0F
	cp $03
	jr z,Logged_0x20547
	xor a
	ld [$CA9A],a
	ld a,[$CA74]
	and a
	jr nz,Logged_0x20536
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x20578

Logged_0x20536:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x20578

Logged_0x20547:
	ld a,[$CA74]
	and a
	jr z,Logged_0x20578
	ld a,$07
	ld [$FF00+$85],a
	ld a,$D3
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x20578

Logged_0x2055E:
	ld a,[$CA74]
	and a
	jr z,Logged_0x20578
	ld a,$07
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x20578

Logged_0x20575:
	call Logged_0x20939

Logged_0x20578:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$14
	ld [$FF00+$B6],a
	ld b,$04
	jp Logged_0x20657

Logged_0x20585:
	ld a,[$CA8E]
	cp $C1
	jr nz,Logged_0x20593
	ld a,[$CA8F]
	cp $02
	jr nc,Logged_0x205E7

Logged_0x20593:
	ld a,[$CA8E]
	cp $84
	jp z,Logged_0x20350
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x205AF
	ld a,[$C1C0]
	or $20
	ld [$C1C0],a
	jr Logged_0x205B7

Logged_0x205AF:
	ld a,[$C1C0]
	or $10
	ld [$C1C0],a

Logged_0x205B7:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$14
	ld [$FF00+$B6],a
	ld b,$04
	call Logged_0x20657
	ld a,[$CA8E]
	cp $42
	jp z,Logged_0x2028A
	cp $09
	jr z,Logged_0x205D1
	ret

Logged_0x205D1:
	ld a,[$CA93]
	cp $05
	ret z
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$B2
	ld [$FF00+$8D],a
	ld a,$60
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x205E7:
	ld b,$05
	call Logged_0x20657
	ld a,[$CA8E]
	cp $48
	ret nz
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$A8
	ld [$FF00+$8D],a
	ld a,$5E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20602:
	ld a,[$CA8E]
	cp $06
	jr z,Logged_0x2060C
	and a
	jr nz,Logged_0x205E7

Logged_0x2060C:
	ld a,[$CA9A]
	and $0F
	cp $03
	jr z,Logged_0x2062A
	xor a
	ld [$CA9A],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$B9
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x20639

Logged_0x2062A:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80

Logged_0x20639:
	ld a,$01
	ld [$CA76],a
	ld a,$0A
	ld [$CA75],a
	ld a,[$C093]
	bit 0,a
	jr z,Logged_0x20655
	ld a,[$CA3C]
	cp $07
	jr c,Logged_0x20655
	xor a
	ld [$CA75],a

Logged_0x20655:
	ld b,$05

Logged_0x20657:
	ld a,[$C1B6]
	ld h,a
	ld a,[$C1B7]
	ld l,a
	ld e,$1C
	ld d,$00
	add hl,de
	ld [hl],b
	inc l
	ld a,[$C1C0]
	ld b,a
	ld a,[hl]
	and $0F
	or b
	ld [hl],a
	ret

Logged_0x20670:
	ld a,[$CA8C]
	and a
	jp nz,Logged_0x20939
	ld a,[$CA3C]
	cp $05
	jr nc,Logged_0x20685
	ld a,[$C1B9]
	bit 7,a
	jr nz,Logged_0x2068C

Logged_0x20685:
	ld a,[$CA9D]
	and a
	jp nz,Logged_0x20350

Logged_0x2068C:
	ld a,[$CA92]
	and a
	jr z,Logged_0x206A8
	cp $01
	jr z,Logged_0x206A8
	cp $02
	jp z,Logged_0x2023B
	cp $03
	jp z,Logged_0x20350
	cp $04
	jp z,Logged_0x205E7
	jp Logged_0x20028

Logged_0x206A8:
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x206BC
	ld a,[$C1C0]
	or $20
	ld [$C1C0],a
	jr Logged_0x206C4

Logged_0x206BC:
	ld a,[$C1C0]
	or $10
	ld [$C1C0],a

Logged_0x206C4:
	ld a,[$C1C0]
	bit 5,a
	jr nz,Logged_0x206D2
	ld a,$01
	ld [$CA69],a
	jr Logged_0x206D7

Logged_0x206D2:
	ld a,$00
	ld [$CA69],a

Logged_0x206D7:
	ld b,$06
	call Logged_0x20657
	ld a,[$CA8C]
	cp $01
	ret z
	ld a,[$CA92]
	cp $01
	jr z,Logged_0x206EB
	jr Logged_0x206F9

Logged_0x206EB:
	ld a,[$CA8E]
	cp $0E
	call z,Logged_0x16D9
	call Logged_0x1079
	call Logged_0x161A

Logged_0x206F9:
	ld a,$01
	ld [$CA8C],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$13
	ld [$FF00+$B6],a
	ld a,$15
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA9D],a
	ld [$CA96],a
	ld a,$06
	ld [$CA75],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,[$CA8B]
	and a
	jr z,Logged_0x20774
	ld a,$E5
	ld [$CA6F],a
	ld a,[$FF00+$A8]
	ld [$FF00+$AD],a
	ld a,[$FF00+$A9]
	ld [$FF00+$AE],a
	ld a,[$FF00+$AA]
	ld [$FF00+$AF],a
	ld a,[$FF00+$AB]
	ld [$FF00+$B0],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x20780
	xor a
	ld [$CA8B],a
	ld a,[$FF00+$AD]
	ld [$FF00+$A8],a
	ld a,[$FF00+$AE]
	ld [$FF00+$A9],a
	ld a,[$FF00+$AF]
	ld [$FF00+$AA],a
	ld a,[$FF00+$B0]
	ld [$FF00+$AB],a

Logged_0x20774:
	ld a,$E5
	ld [$CA6F],a
	ld a,$01
	ld [$CA74],a
	jr Logged_0x20799

Logged_0x20780:
	ld a,$F1
	ld [$CA6F],a
	xor a
	ld [$CA74],a
	ld a,[$FF00+$AD]
	ld [$FF00+$A8],a
	ld a,[$FF00+$AE]
	ld [$FF00+$A9],a
	ld a,[$FF00+$AF]
	ld [$FF00+$AA],a
	ld a,[$FF00+$B0]
	ld [$FF00+$AB],a

Logged_0x20799:
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x207D3
	ld a,$5F
	ld [$CA81],a
	ld a,$7F
	ld [$CA82],a
	jr Logged_0x207DD

Logged_0x207D3:
	ld a,$5F
	ld [$CA81],a
	ld a,$70
	ld [$CA82],a

Logged_0x207DD:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x207ED:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$C0DB]
	and a
	ret z
	ld a,[$CA92]
	and a
	jr z,Logged_0x20808
	cp $02
	jp z,Logged_0x208FA
	cp $04
	jp z,Unknown_0x2092D
	ret

Logged_0x20808:
	ld b,$06
	call Logged_0x20657

Logged_0x2080D:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$13
	ld [$FF00+$B6],a
	ld a,$01
	ld [$CA8C],a
	ld a,$10
	ld [$CA83],a
	xor a
	ld [$CA6D],a
	ld [$CA74],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$01
	ld [$CA8A],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F1
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2087F
	ld a,$5F
	ld [$CA81],a
	ld a,$70
	ld [$CA82],a
	jr Logged_0x20889

Logged_0x2087F:
	ld a,$5F
	ld [$CA81],a
	ld a,$7F
	ld [$CA82],a

Logged_0x20889:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20899:
	ld a,[$CA92]
	and a
	jr z,Logged_0x208A9
	cp $02
	jr z,Logged_0x208A9
	cp $04
	jp z,Unknown_0x2092D
	ret

Logged_0x208A9:
	ld a,[$C0DB]
	and a
	ret z
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x208C2
	ld a,[$C1C0]
	or $20
	ld [$C1C0],a
	jr Logged_0x208CA

Logged_0x208C2:
	ld a,[$C1C0]
	or $10
	ld [$C1C0],a

Logged_0x208CA:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$14
	ld [$FF00+$B6],a
	ld b,$04
	call Logged_0x20657
	ld a,[$CA8E]
	and a
	ret nz
	ld a,[$C1C0]
	bit 6,a
	ret nz
	ld a,$07
	ld [$FF00+$85],a
	ld a,$C4
	ld [$FF00+$8D],a
	ld a,$4D
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x208F2:
	jr Logged_0x208FA

Logged_0x208F4:
	ld b,$01
	call Logged_0x20657
	ret

Logged_0x208FA:
	ld a,[$CA92]
	and a
	jr z,Logged_0x2090A
	cp $02
	jr z,Logged_0x2090A
	cp $04
	jp z,Unknown_0x2092D
	ret

Logged_0x2090A:
	ld a,[$C0DB]
	and a
	ret z
	call Logged_0x208F4
	ld a,[$CA8C]
	cp $01
	ret z
	ld a,[$CA8E]
	and a
	ret nz
	ld a,$07
	ld [$FF00+$85],a
	ld a,$C4
	ld [$FF00+$8D],a
	ld a,$4D
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x2092D:
	ld b,$05
	jp Logged_0x20657

Logged_0x20932:
	ld a,[$CA89]
	and a
	jp nz,Logged_0x20350

Logged_0x20939:
	ld a,[$CA93]
	and a
	jp nz,Logged_0x2023B
	ld b,$06
	call Logged_0x20657
	ld a,[$CA8C]
	cp $01
	ret z
	ld a,$07
	ld [$FF00+$85],a
	ld a,$39
	ld [$FF00+$8D],a
	ld a,$4A
	ld [$FF00+$8E],a
	call $FF80
	ld a,$04
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$05
	ld [$CA7E],a
	ld a,$42
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	xor a
	ld [$CA9A],a
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x209B4
	ld a,$20
	ld [$C1C0],a
	ld a,$00
	ld [$CA69],a
	ld a,$4A
	ld [$CA81],a
	ld a,$79
	ld [$CA82],a

Logged_0x209A4:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x209B4:
	ld a,$10
	ld [$C1C0],a
	ld a,$01
	ld [$CA69],a
	ld a,$4A
	ld [$CA81],a
	ld a,$76
	ld [$CA82],a
	jr Logged_0x209A4

Logged_0x209CA:
	ld a,[$CA83]
	cp $08
	jr nz,Logged_0x209D5
	xor a
	ld [$CA89],a

Logged_0x209D5:
	ld a,[$C0DB]
	and a
	ret nz
	ld a,[$CA83]
	cp $0A
	ret z
	ld a,$01
	ld [$CAC9],a
	ld a,[$C1C1]
	and a
	jr z,Logged_0x209F5
	cp $03
	jr c,Logged_0x209F1
	ld a,$02

Logged_0x209F1:
	ld b,a
	call Logged_0x129E

Logged_0x209F5:
	ld b,$09
	call Logged_0x20657
	ld a,[$CA74]
	and a
	jr z,Logged_0x20A60
	ld a,[$CA89]
	and a
	jr nz,Logged_0x20A60
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x20A60
	call Logged_0x1501
	ld a,[$CA8C]
	cp $01
	jr z,Logged_0x20A60
	ld a,[$CA8E]
	and a
	ret nz
	ld a,[$CA9A]
	and a
	jr nz,Logged_0x20A51
	ld a,[$CA8B]
	and a
	jr nz,Logged_0x20A3C
	xor a
	ld [$C0DB],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x20A60

Logged_0x20A3C:
	xor a
	ld [$C0DB],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$55
	ld [$FF00+$8D],a
	ld a,$68
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x20A60

Logged_0x20A51:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$E7
	ld [$FF00+$8D],a
	ld a,$6F
	ld [$FF00+$8E],a
	call $FF80

Logged_0x20A60:
	jp Logged_0x20028

Logged_0x20A63:
	ld b,$07
	call Logged_0x20657
	ret

Logged_0x20A69:
	ld b,$0D
	call Logged_0x20657
	ret

Logged_0x20A6F:
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x20AA5

Logged_0x20A79:
	ld a,[$CA69]
	and a
	jp z,Logged_0x20028
	ld a,$20
	ld [$C1C0],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x20ACF
	ld a,[$C1C3]
	cp $FF
	jr z,Logged_0x20AA5
	ld b,a
	call Logged_0x1270
	jr Logged_0x20ACF

Logged_0x20AA5:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x20028
	ld a,$10
	ld [$C1C0],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x20ACF
	ld a,[$C1C4]
	cp $FF
	jr z,Logged_0x20A79
	ld b,a
	call Logged_0x1259

Logged_0x20ACF:
	ld a,[$CA8E]
	cp $C3
	jr z,Logged_0x20AFF
	cp $C1
	jr z,Logged_0x20B15
	cp $4D
	jr z,Logged_0x20B2B
	xor a
	ld [$CA86],a
	ld a,[$CA9D]
	and a
	jr nz,Logged_0x20AEF
	ld a,[$CA89]
	and a
	jp z,Logged_0x20028

Logged_0x20AEF:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$39
	ld [$FF00+$8D],a
	ld a,$4A
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20AFF:
	ld a,[$CA8F]
	cp $01
	ret nz
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$D5
	ld [$FF00+$8D],a
	ld a,$4B
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20B15:
	ld a,[$CA8F]
	cp $01
	ret nz
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$C5
	ld [$FF00+$8D],a
	ld a,$6F
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20B2B:
	ld a,[$CA83]
	cp $B3
	ret z
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$15
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20B41:
	ld a,[$CA93]
	and a
	jr z,Logged_0x20B5E
	cp $02
	jp z,Logged_0x20A6F
	cp $01
	jp z,Logged_0x20A6F
	cp $03
	jp z,Logged_0x20350
	cp $04
	jp z,Logged_0x205E7
	jp Logged_0x20A6F

Logged_0x20B5E:
	ld a,[$CA93]
	and a
	ret nz
	call Logged_0x20939
	ld b,$12
	jp Logged_0x20657

Logged_0x20B6B:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x20447
	ld a,[$CA93]
	and a
	jr z,Logged_0x20B8B
	cp $03
	jp z,Logged_0x20350
	cp $04
	jp z,Logged_0x205E7
	cp $05
	jp z,Logged_0x20028
	jp Logged_0x20C41

Logged_0x20B8B:
	ld a,[$CA83]
	cp $0A
	jr c,Logged_0x20B97
	cp $12
	jp c,Logged_0x20899

Logged_0x20B97:
	ld a,[$CA9D]
	ld b,a
	ld a,[$CA89]
	or b
	jp nz,Logged_0x20350
	ld a,[$CA8B]
	ld b,a
	ld a,[$CA9A]
	or b
	jp nz,Logged_0x20C41
	ld a,[$CA3C]
	cp $04
	jp c,Logged_0x20C41
	ld a,[$CA83]
	cp $4C
	jp z,Logged_0x20C41
	cp $3A
	jr c,Logged_0x20BC6
	cp $3F
	jp c,Logged_0x20C41

Logged_0x20BC6:
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x20BDD
	ld a,$20
	ld [$C1C0],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x20BE8
	jr Logged_0x20C41

Logged_0x20BDD:
	ld a,$10
	ld [$C1C0],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x20C41

Logged_0x20BE8:
	ld a,[$CA8C]
	cp $01
	ret z
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	sub $08
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	ld a,[$C1B9]
	bit 7,a
	jr nz,Logged_0x20C11
	ld a,$01
	ld [$CA9A],a
	jr Logged_0x20C1D

Logged_0x20C11:
	ld a,[$CA3C]
	cp $09
	jr c,Logged_0x20C41
	ld a,$81
	ld [$CA9A],a

Logged_0x20C1D:
	ld b,$03
	call Logged_0x20657
	ld a,[$CA74]
	and a
	jr z,Logged_0x20C5E
	ld a,[$C1B9]
	bit 7,a
	jr z,Logged_0x20C31
	jr Logged_0x20C41

Logged_0x20C31:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$D3
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20C41:
	jp Logged_0x20447

UnknownData_0x20C44:
INCBIN "baserom.gbc", $20C44, $20C5E - $20C44

Logged_0x20C5E:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$15
	ld [$FF00+$B6],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$1E
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$04
	ld [$CA7B],a
	ld a,$70
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$60
	ld [$CA7F],a
	ld a,$6A
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x20CDB
	ld a,[$C189]
	bit 1,a
	jr nz,Unknown_0x20CF5
	ld a,[$CA9A]
	and $80
	jr nz,Logged_0x20D05
	ld a,$63
	ld [$CA81],a
	ld a,$EC
	ld [$CA82],a

Logged_0x20CCB:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20CDB:
	ld a,[$C189]
	bit 0,a
	jr nz,Unknown_0x20CF5
	ld a,[$CA9A]
	and $80
	jr nz,Logged_0x20D11
	ld a,$64
	ld [$CA81],a
	ld a,$0C
	ld [$CA82],a
	jr Logged_0x20CCB

Unknown_0x20CF5:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$E7
	ld [$FF00+$8D],a
	ld a,$6F
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20D05:
	ld a,$63
	ld [$CA81],a
	ld a,$F5
	ld [$CA82],a
	jr Logged_0x20CCB

Logged_0x20D11:
	ld a,$64
	ld [$CA81],a
	ld a,$15
	ld [$CA82],a
	jr Logged_0x20CCB

Logged_0x20D1D:
	jp Logged_0x2022C

Logged_0x20D20:
	ld a,[$C1C0]
	and $C0
	jr nz,Logged_0x20D44
	ld a,[$C1C6]
	cp $01
	jr z,Logged_0x20D39
	ld a,[$C1C0]
	bit 5,a
	jp nz,Logged_0x20670
	jp Logged_0x2022C

Logged_0x20D39:
	ld a,[$C1C0]
	bit 4,a
	jp nz,Logged_0x20670
	jp Logged_0x2022C

Logged_0x20D44:
	jp Logged_0x20447

Unknown_0x20D47:
	ld a,[$C1C0]
	and $C0
	jr nz,Unknown_0x20D6B
	ld a,[$C1C6]
	cp $01
	jr z,Unknown_0x20D60
	ld a,[$C1C0]
	bit 4,a
	jp nz,Logged_0x20670
	jp Logged_0x2022C

Unknown_0x20D60:
	ld a,[$C1C0]
	bit 5,a
	jp nz,Logged_0x20670
	jp Logged_0x2022C

Unknown_0x20D6B:
	jp Logged_0x20447

Logged_0x20D6E:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x20670
	bit 7,a
	jp nz,Logged_0x20447
	jp Logged_0x2022C

Logged_0x20D7E:
	jp Logged_0x20670

Logged_0x20D81:
	ld a,[$C1C0]
	and $C0
	jp nz,Logged_0x20899
	jp Logged_0x208F2

Unknown_0x20D8C:
	ld a,[$C0DB]
	and a
	ret z
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x207ED
	ld a,[$CA8E]
	and a
	ret nz
	ld a,[$C1C0]
	bit 7,a
	jr nz,Unknown_0x20DDB
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Unknown_0x20DBE
	ld a,[$C1C0]
	or $20
	ld [$C1C0],a
	ld a,$00
	ld [$CA69],a
	jr Unknown_0x20DCB

Unknown_0x20DBE:
	ld a,[$C1C0]
	or $10
	ld [$C1C0],a
	ld a,$01
	ld [$CA69],a

Unknown_0x20DCB:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$F2
	ld [$FF00+$8D],a
	ld a,$52
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x20DDB:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$C4
	ld [$FF00+$8D],a
	ld a,$4D
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x20DEB:
	ld a,[$C1C0]
	and $C0
	jp nz,Logged_0x20899
	ld a,[$C1C6]
	and a
	jr nz,Unknown_0x20E04
	ld a,[$C1C0]
	bit 5,a
	jp nz,Logged_0x207ED
	jp Logged_0x208F2

Unknown_0x20E04:
	ld a,[$C1C0]
	bit 4,a
	jp nz,Logged_0x207ED
	jp Logged_0x208F2

Logged_0x20E0F:
	ld a,[$C1C0]
	bit 7,a
	jp nz,Logged_0x20899
	bit 6,a
	jp nz,Logged_0x207ED
	ld a,[$C1C6]
	cp $01
	jr z,Logged_0x20E2E
	ld a,[$C1C0]
	bit 5,a
	jp nz,Logged_0x207ED
	jp Logged_0x208F2

Logged_0x20E2E:
	ld a,[$C1C0]
	bit 4,a
	jp nz,Logged_0x207ED
	jp Logged_0x208F2

Unknown_0x20E39:
	ld a,[$C1C0]
	and $C0
	jr nz,Unknown_0x20E5D
	ld a,[$C1C6]
	cp $01
	jr z,Unknown_0x20E52
	ld a,[$C1C0]
	bit 5,a
	jp nz,Logged_0x20939
	jp Logged_0x2022C

Unknown_0x20E52:
	ld a,[$C1C0]
	bit 4,a
	jp nz,Logged_0x20939
	jp Logged_0x2022C

Unknown_0x20E5D:
	jp Logged_0x20447

Logged_0x20E60:
	jp Logged_0x20939

Logged_0x20E63:
	ld a,[$CA89]
	and a
	jp nz,Logged_0x20350

Logged_0x20E6A:
	call Logged_0x20939
	ld a,[$CA93]
	and a
	ret nz
	ld b,$0A
	jp Logged_0x20657

Logged_0x20E77:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x21AAC
	jp Logged_0x20932

Logged_0x20E82:
	ld hl,$CA5C
	ld a,[hl]
	cp $08
	jp nc,Logged_0x20028
	inc [hl]
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$31
	ld [$FF00+$B6],a
	jp Logged_0x21DDB

Logged_0x20E97:
	ld b,$06
	call Logged_0x20657
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2022C
	ld a,$C1
	ld [$CA8E],a
	ld a,$01
	ld [$CA8F],a
	ld a,$02
	ld [$CA93],a
	ld a,$02
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld a,$02
	ld [$CA90],a
	ld a,$58
	ld [$CA91],a
	call Logged_0x161A
	xor a
	ld [$CA84],a
	ld a,$60
	ld [$CA83],a
	xor a
	ld [$CA8D],a
	ld [$CEED],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,[$CA84]
	and a
	ret nz
	ld hl,$4820
	call Logged_0x1AF6
	ld a,$09
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$67
	ld [$CA7F],a
	ld a,$3C
	ld [$CA80],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x20F50
	ld a,$6B
	ld [$CA81],a
	ld a,$38
	ld [$CA82],a
	jr Logged_0x20F5A

Logged_0x20F50:
	ld a,$6B
	ld [$CA81],a
	ld a,$49
	ld [$CA82],a

Logged_0x20F5A:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x20F6A:
	ld a,[$C1C0]
	bit 6,a
	jr nz,Logged_0x20F78
	bit 7,a
	jr nz,Logged_0x20F82
	jp Logged_0x20932

Logged_0x20F78:
	ld a,[$CA96]
	dec a
	jp z,Logged_0x20602
	jp Logged_0x20447

Logged_0x20F82:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2022C
	ld a,$F5
	ld [$CA71],a
	ld a,$0B
	ld [$CA72],a
	ld a,[$C1C7]
	cp $02
	jr z,Unknown_0x20FDB
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Unknown_0x20FDB
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Unknown_0x20FDB
	ld b,$0B
	call Logged_0x20657
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$35
	ld [$FF00+$8D],a
	ld a,$44
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x20FDB:
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	jp Logged_0x20447

UnknownData_0x20FE8:
INCBIN "baserom.gbc", $20FE8, $20FED - $20FE8

Logged_0x20FED:
	ld hl,$CA5B
	set 0,[hl]
	jr Logged_0x21007

Logged_0x20FF4:
	ld hl,$CA5B
	set 1,[hl]
	jr Logged_0x21007

Logged_0x20FFB:
	ld hl,$CA5B
	set 2,[hl]
	jr Logged_0x21007

Logged_0x21002:
	ld hl,$CA5B
	set 3,[hl]

Logged_0x21007:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$32
	ld [$FF00+$B6],a
	call Logged_0x20A63
	ld a,$08
	ld [$C09B],a
	xor a
	ld [$CEE5],a
	ret

Logged_0x2101C:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x209CA
	ld a,[$CA8E]
	and a
	jp nz,Logged_0x20A6F
	ld hl,$CA5B
	bit 0,[hl]
	jp z,Logged_0x20A6F
	set 4,[hl]
	ld a,$01
	ld [$CED4],a
	jr Logged_0x2109A

Logged_0x2103C:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x209CA
	ld a,[$CA8E]
	and a
	jp nz,Logged_0x20A6F
	ld hl,$CA5B
	bit 1,[hl]
	jp z,Logged_0x20A6F
	set 5,[hl]
	ld a,$02
	ld [$CED4],a
	jr Logged_0x2109A

Logged_0x2105C:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x209CA
	ld a,[$CA8E]
	and a
	jp nz,Logged_0x20A6F
	ld hl,$CA5B
	bit 2,[hl]
	jp z,Logged_0x20A6F
	set 6,[hl]
	ld a,$03
	ld [$CED4],a
	jr Logged_0x2109A

Logged_0x2107C:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x209CA
	ld a,[$CA8E]
	and a
	jp nz,Logged_0x20A6F
	ld hl,$CA5B
	bit 3,[hl]
	jp z,Logged_0x20A6F
	set 7,[hl]
	ld a,$04
	ld [$CED4],a

Logged_0x2109A:
	ld a,$FF
	ld [$FF00+$B1],a
	ld a,$00
	ld [$FF00+$B2],a
	call Logged_0x20A63
	call Logged_0x20203
	ld hl,$CED4
	ld a,[hl]
	cp $05
	ret z
	set 7,[hl]
	ld a,$01
	ld [$C09A],a
	xor a
	ld [$CA86],a
	ld a,$40
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA75],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA96],a
	ld [$CA8B],a
	ld [$CA89],a
	inc a
	ld [$CA8A],a
	ld [$CA9B],a
	ld a,[$CA74]
	and a
	jr z,Logged_0x210EA
	ld a,$18
	ld [$CA75],a

Logged_0x210EA:
	ld hl,$4800
	call Logged_0x1AF6
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$40
	ld [$CA7F],a
	ld a,$00
	ld [$CA80],a
	ld a,[$C1C0]
	bit 4,a
	jr nz,Logged_0x21130
	ld a,[$C1C3]
	ld b,a
	call Logged_0x1270
	ld a,$01
	ld [$CA69],a
	ld a,$42
	ld [$CA81],a
	ld a,$5F
	ld [$CA82],a
	jr Logged_0x21146

Logged_0x21130:
	ld a,[$C1C4]
	ld b,a
	call Logged_0x1259
	ld a,$00
	ld [$CA69],a
	ld a,$42
	ld [$CA81],a
	ld a,$52
	ld [$CA82],a

Logged_0x21146:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21156:
	ld a,[$CA74]
	and a
	jp nz,Logged_0x2022C
	ld b,$0C
	call Logged_0x20657
	ld a,[$CA8E]
	cp $42
	jp z,Logged_0x211FB
	and a
	jp nz,Logged_0x2022C
	ld a,$01
	ld [$CA9B],a
	ld a,$2A
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA96],a
	ld [$CA89],a
	ld [$CA8B],a
	ld [$CA9A],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA67],a
	ld [$CA68],a
	inc a
	ld [$CA74],a
	ld a,$06
	ld [$CA9E],a
	ld a,$04
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$59
	ld [$CA7F],a
	ld a,$55
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x211E1
	ld a,$5F
	ld [$CA81],a
	ld a,$70
	ld [$CA82],a
	jr Logged_0x211EB

Logged_0x211E1:
	ld a,$5F
	ld [$CA81],a
	ld a,$7F
	ld [$CA82],a

Logged_0x211EB:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x211FB:
	ld a,$01
	ld [$CA9B],a
	ld a,$6B
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F8
	ld [$CA6F],a
	ld a,$F5
	ld [$CA71],a
	ld a,$0B
	ld [$CA72],a
	ld a,$06
	ld [$CA9E],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$71
	ld [$CA81],a
	ld a,$93
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21245:
	ld a,[$C1C0]
	and $C0
	jr nz,Logged_0x21267
	ld a,[$C1C6]
	cp $01
	jr z,Logged_0x2125D
	ld a,[$C1C0]
	bit 5,a
	jr nz,Logged_0x2126A
	jp Logged_0x2022C

Logged_0x2125D:
	ld a,[$C1C0]
	bit 4,a
	jr nz,Logged_0x2126A
	jp Logged_0x2022C

Logged_0x21267:
	jp Logged_0x20447

Logged_0x2126A:
	ld a,[$CA8B]
	and a
	jr z,Logged_0x21290
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x21290
	ld a,$F1
	ld [$CA6F],a
	jp Logged_0x2022C

Logged_0x21290:
	ld b,$06
	call Logged_0x20657
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2023B
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x212B3
	ld a,$00
	ld [$CA69],a
	jr Logged_0x212B8

Logged_0x212B3:
	ld a,$01
	ld [$CA69],a

Logged_0x212B8:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$39
	ld [$FF00+$B6],a
	ld a,$C3
	ld [$CA8E],a
	xor a
	ld [$CA8F],a
	ld a,$03
	ld [$CA93],a
	ld a,$03
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	call Logged_0x161A
	ld a,$70
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld hl,$4860
	call Logged_0x1AF6
	ld a,$09
	ld [$CA7B],a
	ld a,$58
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$71
	ld [$CA7F],a
	ld a,$C0
	ld [$CA80],a
	ld a,$74
	ld [$CA81],a
	ld a,$14
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21358:
	ld a,[$CA8B]
	and a
	jp nz,Logged_0x20A69
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x20A69
	cp $84
	jr nz,Logged_0x21373
	jp Logged_0x20A69

Logged_0x21373:
	call Logged_0x20A63
	ld a,$84
	ld [$CA8E],a
	ld a,$02
	ld [$CA93],a
	ld a,$02
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld a,$01
	ld [$CA90],a
	ld a,$A4
	ld [$CA91],a
	xor a
	ld [$CA8D],a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	ld a,[$CA74]
	and a
	jr z,Logged_0x213BB
	ld a,$18
	ld [$CA75],a

Logged_0x213BB:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$3A
	ld [$FF00+$B6],a
	call Logged_0x161A
	ld a,$77
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$09
	ld [$CA7B],a
	ld a,$60
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$74
	ld [$CA7F],a
	ld a,$2D
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x21419
	ld a,$78
	ld [$CA81],a
	ld a,$9C
	ld [$CA82],a
	jr Logged_0x21423

Logged_0x21419:
	ld a,$78
	ld [$CA81],a
	ld a,$C3
	ld [$CA82],a

Logged_0x21423:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21433:
	ld hl,$CA05
	ld a,[hl]
	add a,$01
	daa
	ld [hld],a
	ld a,[hl]
	adc a,$00
	daa
	ld [hl],a
	and $F0
	jr z,Logged_0x2144A
	ld a,$09
	ld [hli],a
	ld a,$99
	ld [hl],a

Logged_0x2144A:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$09
	ld [$FF00+$B6],a
	jp Logged_0x20A63

Logged_0x21455:
	ld a,[$CA88]
	ld b,a
	ld a,[$C1BF]
	cp b
	jr c,Logged_0x21469
	ld a,[$C1C0]
	or $20
	ld [$C1C0],a
	jr Logged_0x21471

Logged_0x21469:
	ld a,[$C1C0]
	or $10
	ld [$C1C0],a

Logged_0x21471:
	ld b,$06
	call Logged_0x20657
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	ret nz
	cp $85
	ret z
	ld a,[$C1C0]
	bit 5,a
	jr nz,Logged_0x21492
	ld a,$01
	ld [$CA69],a
	jr Logged_0x21497

Logged_0x21492:
	ld a,$00
	ld [$CA69],a

Logged_0x21497:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$40
	ld [$FF00+$B6],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	ld [$CA8D],a
	ld a,$7F
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$85
	ld [$CA8E],a
	ld a,$04
	ld [$CA93],a
	ld a,$04
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	call Logged_0x161A
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld hl,$4870
	call Logged_0x1AF6
	ld a,$09
	ld [$CA7B],a
	ld a,$68
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$79
	ld [$CA7F],a
	ld a,$0E
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2152E
	ld a,$7B
	ld [$CA81],a
	ld a,$79
	ld [$CA82],a
	jr Logged_0x21538

Logged_0x2152E:
	ld a,$7B
	ld [$CA81],a
	ld a,$76
	ld [$CA82],a

Logged_0x21538:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21548:
	call Logged_0x20A63
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	ret nz
	cp $06
	ret z
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$89
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21569:
	ld a,[$C1C0]
	bit 7,a
	jr nz,Logged_0x21573
	jp Logged_0x2022C

Logged_0x21573:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2022C
	cp $07
	jp z,Logged_0x2022C
	ld a,[$CA8E]
	cp $0E
	call z,Logged_0x16D9
	ld b,$06
	call Logged_0x20657
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$5E
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x215A2:
	ld a,[$CA8C]
	and a
	jp nz,Logged_0x20A69
	ld a,[$CA8E]
	cp $48
	jp z,Logged_0x205E7
	bit 6,a
	jp nz,Logged_0x20A69
	ld b,$06
	call Logged_0x20657
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$28
	ld [$FF00+$B6],a
	ld a,$48
	ld [$CA8E],a
	ld a,$04
	ld [$CA93],a
	ld a,$04
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$D0
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x215E7:
	ld a,[$C1C0]
	and $C0
	jp nz,Logged_0x20447
	ld a,[$C1C6]
	cp $01
	jr z,Logged_0x21600
	ld a,[$C1C0]
	bit 5,a
	jr nz,Logged_0x2160A
	jp Logged_0x2022C

Logged_0x21600:
	ld a,[$C1C0]
	bit 4,a
	jr nz,Logged_0x2160A
	jp Logged_0x2022C

Logged_0x2160A:
	ld a,[$CA8C]
	and a
	ret nz
	ld b,$06
	call Logged_0x20657
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2022C
	cp $09
	jp z,Logged_0x2022C
	ld a,$09
	ld [$CA8E],a
	ld a,$02
	ld [$CA93],a
	ld a,$02
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	ld a,$03
	ld [$CA90],a
	ld a,$84
	ld [$CA91],a
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$59
	ld [$FF00+$8D],a
	ld a,$5F
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2164F:
	ld a,[$C1C0]
	and $C0
	jp nz,Logged_0x20447
	ld a,[$C1C6]
	cp $01
	jr z,Logged_0x21668
	ld a,[$C1C0]
	bit 5,a
	jr nz,Logged_0x21672
	jp Logged_0x2022C

Logged_0x21668:
	ld a,[$C1C0]
	bit 4,a
	jr nz,Logged_0x21672
	jp Logged_0x2022C

Logged_0x21672:
	jp Logged_0x20E97

Logged_0x21675:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x209CA
	bit 7,a
	jr nz,Logged_0x2168B
	ld a,[$CA89]
	and a
	jp nz,Logged_0x217A9
	jp Logged_0x20A6F

Logged_0x2168B:
	ld a,[$CA83]
	cp $6E
	jr nz,Logged_0x216A2
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$5B
	ld [$FF00+$8D],a
	ld a,$4A
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x216A2:
	ld a,[$C1C2]
	cp $10
	jr c,Logged_0x216AB
	ld a,$0C

Logged_0x216AB:
	ld b,a
	call Logged_0x1287
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DB]
	and a
	jr z,Logged_0x216D4
	ld a,$07
	ld [$FF00+$85],a
	ld a,$7C
	ld [$FF00+$8D],a
	ld a,$4D
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x216D4:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x21710
	ld a,[$CA8C]
	cp $01
	ret z
	ld a,[$CA8E]
	cp $42
	jr z,Unknown_0x2173E
	and a
	ret nz
	ld a,[$CA8B]
	and a
	jr nz,Logged_0x2174E
	xor a
	ld [$CA9A],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$AE
	ld [$FF00+$8D],a
	ld a,$42
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21710:
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$CA8C]
	cp $01
	ret z
	ld a,[$CA8E]
	cp $42
	jr z,Unknown_0x2175E
	and a
	ret nz
	xor a
	ld [$CA9A],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x2173E:
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$57
	ld [$FF00+$8D],a
	ld a,$47
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2174E:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$6D
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x2175E:
	ld a,[$CA83]
	cp $6E
	ret z
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$B8
	ld [$FF00+$8D],a
	ld a,$45
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21774:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x209CA
	bit 7,a
	jr nz,Logged_0x21789
	ld a,[$CA89]
	and a
	jr nz,Logged_0x217A9
	jp Logged_0x20A6F

Logged_0x21789:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	ret nz
	ld b,$0B
	call Logged_0x20657
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$35
	ld [$FF00+$8D],a
	ld a,$44
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x217A9:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$39
	ld [$FF00+$8D],a
	ld a,$4A
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x217B9:
	ld a,[$C1C0]
	and $C0
	jr nz,Unknown_0x217DB
	ld a,[$C1C6]
	cp $01
	jr z,Unknown_0x217D1
	ld a,[$C1C0]
	bit 5,a
	jr nz,Logged_0x217DE
	jp Logged_0x2022C

Unknown_0x217D1:
	ld a,[$C1C0]
	bit 4,a
	jr nz,Logged_0x217DE
	jp Logged_0x2022C

Unknown_0x217DB:
	jp Logged_0x20447

Logged_0x217DE:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2022C
	cp $0A
	jp z,Logged_0x2022C
	ld b,$06
	call Logged_0x20657
	ld a,$0A
	ld [$CA8E],a
	ld a,$03
	ld [$CA93],a
	ld a,$03
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$ED
	ld [$FF00+$8D],a
	ld a,$63
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21819:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	ret nz
	ld b,$06
	call Logged_0x20657
	ld a,$4B
	ld [$CA8E],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA8E]
	cp $4B
	ret nz
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$81
	ld [$FF00+$8D],a
	ld a,$6A
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21853:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	ret nz
	ld b,$07
	call Logged_0x20657
	ld a,$4C
	ld [$CA8E],a
	ld a,$02
	ld [$CA93],a
	ld a,$02
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	ld a,$0A
	ld [$FF00+$85],a
	ld a,$7D
	ld [$FF00+$8D],a
	ld a,$6C
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21887:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	ret nz
	ld a,[$CA8B]
	and a
	jr z,Logged_0x218B6
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x218B6
	ld a,$F1
	ld [$CA6F],a
	ret

Logged_0x218B6:
	ld b,$07
	call Logged_0x20657
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$28
	ld [$FF00+$B6],a
	ld a,$4D
	ld [$CA8E],a
	ld a,$03
	ld [$CA93],a
	ld a,$03
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$8C
	ld [$FF00+$8D],a
	ld a,$40
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x218E7:
	ld a,[$C1C0]
	bit 7,a
	jr nz,Logged_0x218F1
	jp Logged_0x20939

Logged_0x218F1:
	ld a,[$CA8E]
	bit 6,a
	ret nz
	cp $0E
	ret z
	call Logged_0x20A63
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$21
	ld [$FF00+$B6],a
	ld a,$0E
	ld [$CA8E],a
	ld a,$02
	ld [$CA93],a
	ld a,$01
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	ld a,$B8
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	ld [$CA74],a
	ld [$CA75],a
	call Logged_0x161A
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$0B
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$5D
	ld [$CA7F],a
	ld a,$B4
	ld [$CA80],a
	ld a,[$C1C6]
	ld [$CA69],a
	ld a,$6D
	ld [$CA81],a
	ld a,$53
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21999:
	ld a,[$CA8E]
	bit 6,a
	ret nz
	cp $0F
	ret z
	ld b,$06
	call Logged_0x20657
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$21
	ld [$FF00+$B6],a
	ld a,$0F
	ld [$CA8E],a
	ld a,$02
	ld [$CA93],a
	ld a,$01
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	ld a,$C0
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	ld [$CA74],a
	ld [$CA75],a
	inc a
	ld [$CA9B],a
	call Logged_0x161A
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$0B
	ld [$CA7B],a
	ld a,$78
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$6E
	ld [$CA7F],a
	ld a,$05
	ld [$CA80],a
	ld a,[$C1C6]
	ld [$CA69],a
	ld a,$6E
	ld [$CA81],a
	ld a,$C4
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21A47:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x20447

Logged_0x21A4F:
	jp Logged_0x2126A

Logged_0x21A52:
	ld a,[$CA8C]
	and a
	jp nz,Logged_0x20A69
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x20A69
	call Logged_0x20A63
	ld a,$50
	ld [$CA8E],a
	xor a
	ld [$CA8F],a
	ld a,$03
	ld [$CA93],a
	ld a,$03
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$49
	ld [$FF00+$8D],a
	ld a,$47
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21A8C:
	ld a,[$CA8E]
	cp $C1
	ret nz
	ld b,$0E
	jp Logged_0x20657

Logged_0x21A97:
	ld a,[$C1C0]
	bit 6,a
	jr nz,Logged_0x21AAC
	bit 7,a
	jp nz,Logged_0x2168B
	ld a,[$CA89]
	and a
	jr nz,Logged_0x21ABB
	jp Logged_0x20A6F

Logged_0x21AAC:
	ld a,[$CA96]
	dec a
	jp nz,Logged_0x209CA
	call Logged_0x20602
	ld b,$0F
	jp Logged_0x20657

Logged_0x21ABB:
	ld b,$02
	call Logged_0x20657
	jp Logged_0x20A6F

Logged_0x21AC3:
	ld a,[$C1C0]
	bit 6,a
	jr nz,Logged_0x21AE4
	ld a,[$C1C6]
	and a
	jr nz,Logged_0x21ADA
	ld a,[$C1C0]
	bit 5,a
	jr nz,Logged_0x21AEE
	jp Logged_0x20E6A

Logged_0x21ADA:
	ld a,[$C1C0]
	bit 4,a
	jr nz,Logged_0x21AEE
	jp Logged_0x20E6A

Logged_0x21AE4:
	ld a,[$CA96]
	and a
	jp nz,Logged_0x20602
	jp Logged_0x20E6A

Logged_0x21AEE:
	jp Logged_0x21CFD

Logged_0x21AF1:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x209CA
	bit 7,a
	jp nz,Logged_0x20447
	ld a,[$CA89]
	and a
	jp nz,Logged_0x217A9
	jp Logged_0x20A6F

Logged_0x21B08:
	jp Logged_0x2160A

Logged_0x21B0B:
	ld b,$06
	call Logged_0x20657
	ld a,[$CA9D]
	and a
	ret nz
	ld a,[$C1C6]
	ld [$CA69],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$74
	ld [$FF00+$8D],a
	ld a,$61
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21B2B:
	ld a,[$C1C0]
	and $C0
	jp nz,Logged_0x20447
	ld a,[$CA89]
	and a
	jp nz,Logged_0x20350

Logged_0x21B3A:
	call Logged_0x20939
	ld b,$00
	jp Logged_0x20657

Logged_0x21B42:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2022C
	ld b,$06
	call Logged_0x20657
	ld a,$51
	ld [$CA8E],a
	ld a,$05
	ld [$CA93],a
	ld a,$05
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$9E
	ld [$FF00+$8D],a
	ld a,$4E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21B78:
	ld a,[$C1C0]
	bit 6,a
	jr z,Logged_0x21B86
	ld a,[$CA96]
	and a
	jp nz,Logged_0x20602

Logged_0x21B86:
	jp Logged_0x20939

Logged_0x21B89:
	ld a,[$C1C0]
	bit 7,a
	jp z,Logged_0x2022C
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2022C
	ld b,$06
	call Logged_0x20657
	ld a,$53
	ld [$CA8E],a
	ld a,$02
	ld [$CA93],a
	ld a,$01
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$31
	ld [$FF00+$8D],a
	ld a,$53
	ld [$FF00+$8E],a
	call $FF80
	ld a,$80
	ld [$FF00+$68],a
	ld b,$04
	ld c,$69

Logged_0x21BCE:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x21BCE

Logged_0x21BD4:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x21BD4
	xor a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x21BCE
	ld a,$98
	ld [$FF00+$6A],a
	ld b,$02
	ld c,$6B

Logged_0x21BF6:
	ld a,[$FF00+$41]
	and $03
	jr z,Logged_0x21BF6

Logged_0x21BFC:
	ld a,[$FF00+$41]
	and $03
	jr nz,Logged_0x21BFC
	xor a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	ld [$FF00+c],a
	dec b
	jr nz,Logged_0x21BF6
	ret

Logged_0x21C17:
	ld b,$06
	call Logged_0x20657
	ld a,[$CA8E]
	and a
	jp z,Logged_0x20028
	jp Logged_0x1570

Unknown_0x21C26:
	ld a,[$C1C6]
	cp $01
	jr z,Unknown_0x21C37
	ld a,[$C1C0]
	bit 5,a
	jr nz,Unknown_0x21C41
	jp Logged_0x207ED

Unknown_0x21C37:
	ld a,[$C1C0]
	bit 4,a
	jr nz,Unknown_0x21C41
	jp Logged_0x207ED

Unknown_0x21C41:
	ld b,$11
	call Logged_0x20657
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$60
	ld [$FF00+$8D],a
	ld a,$56
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21C56:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x21AAC
	jp Logged_0x20B6B

Logged_0x21C61:
	ld a,[$C1C0]
	and $C0
	jp nz,Logged_0x20447
	ld a,[$C1C6]
	and a
	jr nz,Unknown_0x21C7A
	ld a,[$C1C0]
	bit 5,a
	jp nz,Logged_0x21B0B
	jp Logged_0x20E6A

Unknown_0x21C7A:
	ld a,[$C1C0]
	bit 4,a
	jp nz,Logged_0x21B0B
	jp Logged_0x20E6A

UnknownData_0x21C85:
INCBIN "baserom.gbc", $21C85, $21C86 - $21C85

Logged_0x21C86:
	ld a,[$C1C0]
	and $C0
	jp nz,Logged_0x20E6A
	ld a,[$CA89]
	and a
	jp nz,Logged_0x20350
	jp Logged_0x20E6A

Logged_0x21C98:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x209CA
	bit 7,a
	jp nz,Logged_0x2168B
	jp Logged_0x20B41

Logged_0x21CA8:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	and a
	ret nz
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$3B
	ld [$FF00+$B6],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B6
	ld [$FF00+$8D],a
	ld a,$5F
	ld [$FF00+$8E],a
	call $FF80

Logged_0x21CC9:
	ld b,$13
	call Logged_0x20657
	ret

Unknown_0x21CCF:
	ld a,$E7
	ld [$C0D7],a
	call Logged_0x2080D
	ld a,$FF
	ld [$FF00+$B5],a
	ld a,$00
	ld [$FF00+$B6],a
	ld a,$34
	ld [$CA83],a
	ld b,$10
	jp Logged_0x20657

Logged_0x21CE9:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x20899
	bit 7,a
	jr nz,Unknown_0x21CCF
	jp Logged_0x208F2

Logged_0x21CF8:
	ld b,$06
	jp Logged_0x20657

Logged_0x21CFD:
	ld a,$E7
	ld [$C0D7],a
	call Logged_0x206EB
	ld a,$FF
	ld [$FF00+$B5],a
	ld a,$00
	ld [$FF00+$B6],a
	ld a,$33
	ld [$CA83],a
	ld b,$10
	jp Logged_0x20657

Logged_0x21D17:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x209CA
	ld a,[$CA8E]
	and a
	ret nz
	ld a,[$C0DB]
	and a
	jp z,Logged_0x21B3A
	ld a,$07
	ld [$FF00+$85],a
	ld a,$C4
	ld [$FF00+$8D],a
	ld a,$4D
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x21D3B:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x20E6A
	bit 7,a
	jp nz,Logged_0x20E6A
	ld a,[$C1C6]
	and a
	jr nz,Unknown_0x21D59
	ld a,[$C1C0]
	bit 5,a
	jp nz,Logged_0x20670
	jp Logged_0x20E6A

Unknown_0x21D59:
	ld a,[$C1C0]
	bit 4,a
	jp nz,Logged_0x20670
	jp Logged_0x20E6A

Unknown_0x21D64:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x20670
	jp Logged_0x20E6A

Logged_0x21D6F:
	ld a,[$C1C0]
	bit 6,a
	jr nz,Logged_0x21D7E
	bit 7,a
	jp nz,Logged_0x20670
	jp Logged_0x20E6A

Logged_0x21D7E:
	ld a,[$CA96]
	and a
	jp nz,Logged_0x20602
	jp Logged_0x20E6A

Logged_0x21D88:
	ld a,[$C1C0]
	and $C0
	jp nz,Logged_0x20899
	ld a,[$C1C6]
	and a
	jr nz,Logged_0x21DA1
	ld a,[$C1C0]
	bit 5,a
	jp nz,Logged_0x21DAC
	jp Logged_0x208F2

Logged_0x21DA1:
	ld a,[$C1C0]
	bit 4,a
	jp nz,Logged_0x21DAC
	jp Logged_0x208F2

Logged_0x21DAC:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2022C
	ld a,[$C1C6]
	ld [$CA69],a
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$38
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld b,$06
	jp Logged_0x20657

Logged_0x21DD3:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$4B
	ld [$FF00+$B6],a

Logged_0x21DDB:
	ld hl,$CA05
	ld a,[hl]
	add a,$10
	daa
	ld [hld],a
	ld a,[hl]
	adc a,$00
	daa
	ld [hl],a
	and $F0
	jr z,Logged_0x21DF2
	ld a,$09
	ld [hli],a
	ld a,$99
	ld [hl],a

Logged_0x21DF2:
	call Logged_0x20A63
	jp Logged_0x20028

Logged_0x21DF8:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2022C
	ld b,$06
	call Logged_0x20657
	ld a,$55
	ld [$CA8E],a
	ld a,$05
	ld [$CA93],a
	ld a,$05
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$AA
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21E2E:
	ld a,[$C1C0]
	bit 7,a
	jp nz,Logged_0x20670
	bit 6,a
	jp nz,Logged_0x20447
	jp Logged_0x2022C

Logged_0x21E3E:
	ld a,[$CA8E]
	cp $56
	jr z,Logged_0x21E8A
	ld a,[$C1C0]
	bit 7,a
	jr nz,Logged_0x21E54
	bit 6,a
	jp nz,Logged_0x20447
	jp Logged_0x20E63

Logged_0x21E54:
	ld a,[$CA8C]
	and a
	ret nz
	ld a,[$CA8E]
	bit 6,a
	jp nz,Logged_0x2022C
	ld b,$06
	call Logged_0x20657
	ld a,$56
	ld [$CA8E],a
	ld a,$05
	ld [$CA93],a
	ld a,$05
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$21
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21E8A:
	ld a,$7B
	ld [$FF00+$85],a
	ld a,$D8
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x21CC9

Logged_0x21E9C:
	ld a,[$CA8E]
	cp $56
	jr z,Logged_0x21E8A
	jp Logged_0x20939

Logged_0x21EA6:
	ld a,[$C1C6]
	ld b,a
	and a
	jr nz,Logged_0x21EB6
	ld a,[$C1C0]
	bit 5,a
	jr nz,Logged_0x21EBF
	jr Logged_0x21ECA

Logged_0x21EB6:
	ld a,[$C1C0]
	bit 4,a
	jr nz,Logged_0x21EBF
	jr Logged_0x21ECA

Logged_0x21EBF:
	ld a,[$C1C6]
	xor $01
	ld [$CA69],a
	jp Logged_0x20A6F

Logged_0x21ECA:
	jp Logged_0x21B3A

Logged_0x21ECD:
	ld a,[$C1C6]
	and a
	jr nz,Logged_0x21EDD
	ld a,[$C1C0]
	bit 5,a
	jr nz,Logged_0x21EE7
	jp Logged_0x20E6A

Logged_0x21EDD:
	ld a,[$C1C0]
	bit 4,a
	jr nz,Logged_0x21EE7
	jp Logged_0x20E6A

Logged_0x21EE7:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$3B
	ld [$FF00+$B6],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B6
	ld [$FF00+$8D],a
	ld a,$5F
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x21CC9

Unknown_0x21F01:
	ld a,[$C1C0]
	bit 6,a
	jr nz,Unknown_0x21F0B
	jp Unknown_0x20D8C

Unknown_0x21F0B:
	ld a,[$C1C0]
	or $10
	ld [$C1C0],a
	ld a,$01
	ld [$CA69],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$F2
	ld [$FF00+$8D],a
	ld a,$52
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x21F28:
	ld a,[$C1C0]
	bit 6,a
	jp nz,Logged_0x21D7E
	bit 7,a
	jp nz,Logged_0x20E6A
	ld a,[$C1C6]
	and a
	jr nz,Unknown_0x21F46
	ld a,[$C1C0]
	bit 5,a
	jp nz,Logged_0x20670
	jp Logged_0x20E6A

Unknown_0x21F46:
	ld a,[$C1C0]
	bit 4,a
	jp nz,Logged_0x20670
	jp Logged_0x20E6A
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$CCE7],a
	ld a,$01
	add a,b
	ld [$CCE8],a
	ld a,[$C0A4]
	and $08
	jr nz,Logged_0x21FA3
	ld b,$10

Logged_0x21F69:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x21F9F
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x21F9F:
	dec b
	jr nz,Logged_0x21F69
	ret

Logged_0x21FA3:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	inc a
	ld [$CCE8],a
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x21FD6
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x21FD6:
	ld b,$10

Logged_0x21FD8:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x2200E
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x2200E:
	dec b
	jr nz,Logged_0x21FD8
	ret
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$C0B3],a
	ld a,$35
	add a,b
	ld [$C0B4],a
	ld a,[$C0A4]
	and $08
	jp nz,Logged_0x2208A
	ld b,$10

Logged_0x22032:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x22068
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x22068:
	dec b
	jr nz,Logged_0x22032
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	ld a,[hl]
	ld [de],a
	pop hl
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x2208A:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$CE35
	add hl,de
	inc l
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	inc a
	ld [$C0B4],a
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x220BD
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x220BD:
	ld b,$10

Logged_0x220BF:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x220F5
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x220F5:
	dec b
	jr nz,Logged_0x220BF
	pop af
	ld [$FF00+$70],a
	ret
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$CCE7],a
	ld a,$01
	add a,b
	ld [$CCE8],a
	ld a,[$C0A4]
	and $08
	jp nz,Logged_0x2214E
	ld b,$10

Logged_0x22115:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x2214A
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x2214A:
	dec b
	jr nz,Logged_0x22115
	ret

Logged_0x2214E:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	inc l
	inc l
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	inc a
	ld [$CCE8],a
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x22180
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x22180:
	ld b,$10

Logged_0x22182:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$C600
	add hl,de
	ld a,[$CCE7]
	ld d,a
	ld a,[$CCE8]
	ld e,a
	add a,$02
	ld [$CCE8],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x221B7
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x221B7:
	dec b
	jr nz,Logged_0x22182
	ret
	ld a,[$FF00+$70]
	push af
	ld a,$03
	ld [$FF00+$70],a
	ld a,[$CE00]
	ld b,a
	ld a,$CE
	ld [$C0B3],a
	ld a,$35
	add a,b
	ld [$C0B4],a
	ld a,[$C0A4]
	and $08
	jp nz,Logged_0x22217
	ld b,$10

Logged_0x221DB:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x22210
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x22210:
	dec b
	jr nz,Logged_0x221DB
	pop af
	ld [$FF00+$70],a
	ret

Logged_0x22217:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	inc l
	inc l
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	inc a
	ld [$C0B4],a
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x22249
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x22249:
	ld b,$10

Logged_0x2224B:
	ld a,[hl]
	ld d,$00
	ld e,a
	sla e
	sla e
	rl d
	push hl
	ld hl,$D300
	add hl,de
	ld a,[$C0B3]
	ld d,a
	ld a,[$C0B4]
	ld e,a
	add a,$02
	ld [$C0B4],a
	ld a,[hli]
	ld [de],a
	inc l
	inc e
	ld a,[hl]
	ld [de],a
	pop hl
	inc h
	ld a,h
	cp $C0
	jr nz,Logged_0x22280
	ld h,$A0
	ld a,[$C08E]
	inc a
	ld [$C08E],a
	ld [$4100],a

Logged_0x22280:
	dec b
	jr nz,Logged_0x2224B
	pop af
	ld [$FF00+$70],a
	ret

UnknownData_0x22287:
INCBIN "baserom.gbc", $22287, $24000 - $22287

SECTION "Bank09", ROMX, BANK[$09]

UnknownData_0x24000:
INCBIN "baserom.gbc", $24000, $28000 - $24000

SECTION "Bank0A", ROMX, BANK[$0A]
	ld a,[$CA83]
	sub $60
	rst JumpList
	dw Logged_0x280A6
	dw Logged_0x281C1
	dw Logged_0x2827A
	dw Logged_0x2839F
	dw Logged_0x2841E
	dw Logged_0x28511
	dw Logged_0x28599
	dw Logged_0x28601
	dw Logged_0x28672
	dw Logged_0x2871F
	dw Logged_0x287A2
	dw Logged_0x288E5
	dw Logged_0x2894E
	dw Logged_0x28A39
	dw Logged_0x28A5A
	dw Logged_0x28A8A
	dw Logged_0x28AAD
	dw Logged_0x28B36
	dw Logged_0x28C25
	dw Logged_0x28CEB
	dw Logged_0x28D92
	dw Logged_0x28E1A
	dw Logged_0x28E70
	dw Logged_0x28E87
	dw Logged_0x28F39
	dw Logged_0x28FC0
	dw Logged_0x2906D
	dw Logged_0x29123
	dw Logged_0x29243
	dw Logged_0x292E5
	dw Logged_0x293B9
	dw Logged_0x293D0
	dw Logged_0x294BF
	dw Logged_0x29672
	dw Logged_0x2972E
	dw Logged_0x29816
	dw Logged_0x29871
	dw Logged_0x298F3
	dw Logged_0x29975
	dw Logged_0x29A74
	dw Logged_0x29B06
	dw Logged_0x29BA2
	dw Logged_0x29C29
	dw Logged_0x29D6F
	dw Logged_0x29DD3
	dw Logged_0x29E7E
	dw Logged_0x29EF3
	dw Unknown_0x29F42
	dw Logged_0x29FFA
	dw Logged_0x2A087
	dw Logged_0x2A0F9
	dw Logged_0x2A1F5
	dw Logged_0x2A267
	dw Logged_0x2A2D3
	dw Logged_0x2A362
	dw Logged_0x2A489
	dw Logged_0x2A544
	dw Logged_0x2A5D8
	dw Logged_0x2A657
	dw Logged_0x2A6C0
	dw Logged_0x2A77B
	dw Logged_0x2A804
	dw Logged_0x2A890
	dw Logged_0x2A8D2
	dw Logged_0x2A9B2
	dw Logged_0x2AA08
	dw Logged_0x2AB18
	dw Logged_0x2AB42
	dw Logged_0x2AC04
	dw Logged_0x2AD06
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D
	dw Unknown_0x156D

Logged_0x280A6:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x280D3
	ld a,$0E
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$1E
	ld [$FF00+$B6],a

Logged_0x280D3:
	ld a,[$CA84]
	and a
	jr nz,Logged_0x28100
	ld a,[$C1A8]
	and a
	jr z,Logged_0x28100
	ld a,$01
	ld [$CA84],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x280F6
	ld a,$6B
	ld [$CA81],a
	ld a,$14
	ld [$CA82],a
	jr Logged_0x28100

Logged_0x280F6:
	ld a,$6B
	ld [$CA81],a
	ld a,$1D
	ld [$CA82],a

Logged_0x28100:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2AE2F
	ld hl,$CA90
	ld a,[hli]
	cp $01
	jr nz,Logged_0x28121
	ld a,[hl]
	cp $2C
	jr nz,Logged_0x28121
	jr Logged_0x28154

Logged_0x28121:
	call Logged_0x2AE8A
	ld a,[$CA83]
	cp $60
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x2AF75
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Unknown_0x2814A:
	ld a,$01
	ld [$CA90],a
	ld a,$2C
	ld [$CA91],a

Logged_0x28154:
	ld a,$02
	ld [$CA8F],a
	ld a,$62
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$04
	ld [$CA92],a
	ld a,$04
	ld [$CA93],a
	ld a,$02
	ld [$CA94],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$C093]
	and $30
	jr z,Logged_0x28195
	bit 4,a
	jr nz,Logged_0x28190
	ld a,$00
	ld [$CA69],a
	jr Logged_0x28195

Logged_0x28190:
	ld a,$01
	ld [$CA69],a

Logged_0x28195:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x281B5
	ld a,$6B
	ld [$CA81],a
	ld a,$26
	ld [$CA82],a

Logged_0x281A5:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x281B5:
	ld a,$6B
	ld [$CA81],a
	ld a,$2F
	ld [$CA82],a
	jr Logged_0x281A5

Logged_0x281C1:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x2ADE4
	ld a,[$CA84]
	and a
	jr nz,Logged_0x2820B
	ld a,[$C1A8]
	and a
	jr z,Logged_0x2820B
	ld a,$01
	ld [$CA84],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x28201
	ld a,$6B
	ld [$CA81],a
	ld a,$14
	ld [$CA82],a
	jr Logged_0x2820B

Logged_0x28201:
	ld a,$6B
	ld [$CA81],a
	ld a,$1D
	ld [$CA82],a

Logged_0x2820B:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2AF9C
	ld a,[$CA83]
	cp $61
	ret nz
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x28245
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,[$CA83]
	cp $61
	ret nz
	jp Logged_0x2AF75

Logged_0x28245:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x28261
	ld a,[$CA83]
	cp $61
	ret nz
	jp Logged_0x14DE

Logged_0x28261:
	call Logged_0x14F6
	ld a,[$CA83]
	cp $61
	ret nz
	ld a,$08
	ld [$FF00+$85],a
	ld a,$D3
	ld [$FF00+$8D],a
	ld a,$4E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2827A:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x282A7
	ld a,$10
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$1F
	ld [$FF00+$B6],a

Logged_0x282A7:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2AE2F
	ld hl,$CA90
	ld a,[hli]
	cp $00
	jr nz,Logged_0x282EA
	ld a,[hl]
	cp $E0
	jr z,Logged_0x282D4
	cp $A4
	jr z,Logged_0x282DC
	cp $3C
	jr z,Logged_0x282E4
	cp $01
	jr nz,Logged_0x282EA
	jr Logged_0x28313

Logged_0x282D4:
	ld hl,$4830
	call Logged_0x1AF6
	jr Logged_0x282EA

Logged_0x282DC:
	ld hl,$4840
	call Logged_0x1AF6
	jr Logged_0x282EA

Logged_0x282E4:
	ld hl,$4850
	call Logged_0x1AF6

Logged_0x282EA:
	call Logged_0x2B07A
	ld a,[$CA83]
	cp $62
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x28380
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x28313:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$22
	ld [$FF00+$B6],a
	ld a,$64
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld hl,$4820
	call Logged_0x1AF6
	ld a,$09
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$6B
	ld [$CA7F],a
	ld a,$6C
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x28366
	ld a,$6E
	ld [$CA81],a
	ld a,$47
	ld [$CA82],a
	jr Logged_0x28370

Logged_0x28366:
	ld a,$6E
	ld [$CA81],a
	ld a,$72
	ld [$CA82],a

Logged_0x28370:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28380:
	ld a,[$CA64]
	and $F0
	add a,$08
	ld [$CA64],a

Logged_0x2838A:
	ld a,$18
	ld [$CA75],a
	ld a,$02
	ld [$CA74],a
	ld a,$63
	ld [$CA83],a
	ld a,$08
	ld [$CA84],a
	ret

Logged_0x2839F:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x2ADE4
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B027
	ld a,[$CA83]
	cp $63
	ret nz
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x283F6
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,[$CA83]
	cp $63
	ret nz
	jp Logged_0x2838A

Logged_0x283F6:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x28412
	ld a,[$CA83]
	cp $63
	ret nz
	jp Logged_0x14DE

Logged_0x28412:
	call Logged_0x14F6
	ld a,[$CA83]
	cp $63
	ret nz
	jp Logged_0x28154

Logged_0x2841E:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x1570
	ld a,[$CA8E]
	bit 6,a
	ret nz
	ld a,[$CA8E]
	cp $0E
	call z,Logged_0x16D9
	ld a,[$FF00+$70]
	push af
	ld a,$01
	ld [$FF00+$70],a
	ld a,[$C1B6]
	ld h,a
	ld a,[$C1B7]
	ld l,a
	ld de,$0005
	add hl,de
	ld b,$00
	ld a,[$C1B9]
	and $7F
	sub $0F
	jr z,Logged_0x2846A
	ld a,$01
	ld [$CA84],a
	ld b,$08
	jr Logged_0x2846D

Logged_0x2846A:
	ld [$CA84],a

Logged_0x2846D:
	ld a,[hli]
	sub b
	ld [$CA64],a
	ld a,[hl]
	sbc a,$00
	ld [$CA63],a
	pop af
	ld [$FF00+$70],a
	ld a,$42
	ld [$CA8E],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$1B
	ld [$FF00+$B6],a
	call Logged_0x161A
	ld a,$02
	ld [$CA93],a
	ld a,$02
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA75],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	inc a
	ld [$CA9B],a
	ld [$CA74],a
	ld a,$65
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F8
	ld [$CA6F],a
	ld a,$F5
	ld [$CA71],a
	ld a,$0B
	ld [$CA72],a
	ld a,$09
	ld [$CA7B],a
	ld a,$50
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$6E
	ld [$CA7F],a
	ld a,$9D
	ld [$CA80],a
	ld a,$71
	ld [$CA81],a
	ld a,$BD
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28511:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x28900
	ld b,$02
	call Logged_0x1287
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x28549
	jp Logged_0x14DE

Logged_0x28549:
	call Logged_0x14F6
	ld a,$66
	ld [$CA83],a
	xor a
	ld [$CA86],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA85],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA9B],a
	inc a
	ld [$CA8A],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F8
	ld [$CA6F],a
	ld a,$F5
	ld [$CA71],a
	ld a,$0B
	ld [$CA72],a
	ld a,$71
	ld [$CA81],a
	ld a,$5F
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28599:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	xor a
	ld [$CA8A],a
	ld a,[$CA84]
	and a
	jp nz,Logged_0x28A50

Logged_0x285B8:
	ld a,$67
	ld [$CA83],a
	xor a
	ld [$CA86],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA74],a
	ld [$CA75],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F8
	ld [$CA6F],a
	ld a,$F5
	ld [$CA71],a
	ld a,$0B
	ld [$CA72],a
	ld a,$71
	ld [$CA81],a
	ld a,$8B
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28601:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B10A
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	jp Logged_0x28757

Logged_0x28628:
	ld a,$68
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA86],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA74],a
	ld [$CA75],a
	ld a,$71
	ld [$CA81],a
	ld a,$75
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x2866C
	ld a,$00
	ld [$CA69],a
	ret

Logged_0x2866C:
	ld a,$01
	ld [$CA69],a
	ret

Logged_0x28672:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x2869F
	ld a,$0A
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$1C
	ld [$FF00+$B6],a

Logged_0x2869F:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B11B
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x28757
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x286D1:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$1D
	ld [$FF00+$B6],a
	ld a,$69
	ld [$CA83],a
	xor a
	ld [$CA86],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA75],a
	ld a,[$C093]
	bit 6,a
	jr nz,Logged_0x286FC
	ld a,$01
	jr Logged_0x286FE

Logged_0x286FC:
	ld a,$02

Logged_0x286FE:
	ld [$CA74],a
	ld a,$71
	ld [$CA81],a
	ld a,$90
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CAC9]
	and a
	ret z

Logged_0x2871F:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	call Logged_0x1488
	call Logged_0x2B17A
	call Logged_0x1762
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x28757
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z

Logged_0x28757:
	ld a,$6A
	ld [$CA83],a
	xor a
	ld [$CA86],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$C189],a
	inc a
	ld [$CA75],a
	ld [$CA74],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x28796
	ld a,$71
	ld [$CA81],a
	ld a,$B8
	ld [$CA82],a

Logged_0x28786:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28796:
	ld a,$71
	ld [$CA81],a
	ld a,$86
	ld [$CA82],a
	jr Logged_0x28786

Logged_0x287A2:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x28900
	ld a,[$C1A8]
	and a
	jr nz,Logged_0x287FF
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	jr z,Logged_0x287FF
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$71
	ld [$CA81],a
	ld a,$90
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$01
	ld [$C1A8],a

Logged_0x287FF:
	ld hl,$CA86
	ld e,[hl]
	ld d,$00
	inc [hl]
	push de
	ld a,[$CA69]
	and a
	jp nz,Logged_0x288AD
	ld hl,$768C
	add hl,de
	ld b,[hl]
	call Logged_0x1270

Logged_0x28816:
	ld a,[$CA86]
	cp $28
	jr nc,Logged_0x28857
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x288B8
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$03
	ld [$FF00+$B6],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2884E
	ld b,$03
	call Logged_0x1270
	jr Logged_0x28853

Logged_0x2884E:
	ld b,$03
	call Logged_0x1259

Logged_0x28853:
	ld a,$00
	jr Logged_0x288A8

Logged_0x28857:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x28866
	ld a,[$C093]
	bit 5,a
	jr nz,Logged_0x288A7
	jr Logged_0x2886D

Logged_0x28866:
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x288A7

Logged_0x2886D:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$C1A8],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	and a
	jr nz,Logged_0x2888E
	ld a,$71
	ld [$CA81],a
	ld a,$B8
	ld [$CA82],a
	jr Logged_0x28898

Logged_0x2888E:
	ld a,$71
	ld [$CA81],a
	ld a,$86
	ld [$CA82],a

Logged_0x28898:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x288A7:
	xor a

Logged_0x288A8:
	ld [$CA86],a
	pop de
	ret

Logged_0x288AD:
	ld hl,$768C
	add hl,de
	ld b,[hl]
	call Logged_0x1259
	jp Logged_0x28816

Logged_0x288B8:
	pop de
	ld hl,$7664
	add hl,de
	ld b,[hl]
	call Logged_0x1287
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x288D7
	jp Logged_0x14DE

Logged_0x288D7:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$20
	ld [$FF00+$B6],a
	call Logged_0x14F6
	jp Logged_0x285B8

Logged_0x288E5:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	xor a
	ld [$CA9B],a
	jp Logged_0x1570

Logged_0x28900:
	ld a,$6C
	ld [$CA83],a
	xor a
	ld [$CA86],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA75],a
	ld [$CA74],a
	inc a
	ld [$CA8A],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F8
	ld [$CA6F],a
	ld a,$F5
	ld [$CA71],a
	ld a,$0B
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$71
	ld [$CA81],a
	ld a,$9A
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2894E:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C08F]
	and $0F
	call z,Logged_0x2899A
	ld a,[$C08F]
	and $01
	ret nz
	ld b,$01
	call Logged_0x1287
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	jr Logged_0x289C5

Logged_0x2899A:
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub $04
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $08
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	ld b,$09
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x289C5:
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub $04
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $08
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	ld b,$09
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,$6D
	ld [$CA83],a
	xor a
	ld [$CA86],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA75],a
	ld [$CA74],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F8
	ld [$CA6F],a
	ld a,$F5
	ld [$CA71],a
	ld a,$0B
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$71
	ld [$CA81],a
	ld a,$A3
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28A39:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x2AD6A

Logged_0x28A50:
	ld a,$6E
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ret

Logged_0x28A5A:
	ret
	ld a,$01
	ld [$CA8A],a
	ld a,$6F
	ld [$CA83],a
	xor a
	ld [$CA84],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$71
	ld [$CA81],a
	ld a,$6C
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28A8A:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld b,$01
	call Logged_0x129E
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $32
	ret c
	xor a
	ld [$CA8A],a
	jp Logged_0x28757

Logged_0x28AAD:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x28C15

Logged_0x28AD5:
	ld a,$71
	ld [$CA83],a
	ld a,$01
	ld [$CA8F],a
	xor a
	ld [$CEED],a
	ld [$CA86],a
	ld [$CA85],a
	ld [$CA74],a
	ld [$CA75],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E8
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x28B2A
	ld a,$74
	ld [$CA81],a
	ld a,$1F
	ld [$CA82],a

Logged_0x28B1A:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28B2A:
	ld a,$73
	ld [$CA81],a
	ld a,$FE
	ld [$CA82],a
	jr Logged_0x28B1A

Logged_0x28B36:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x28B63
	ld a,$0C
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0A
	ld [$FF00+$B6],a

Logged_0x28B63:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA69]
	and a
	jr nz,Logged_0x28B80
	call Logged_0x153F
	call Logged_0x1270
	jr Logged_0x28B86

Logged_0x28B80:
	call Logged_0x151E
	call Logged_0x1259

Logged_0x28B86:
	ld a,[$CA86]
	cp $18
	jr c,Logged_0x28B92
	ld a,$14
	ld [$CA86],a

Logged_0x28B92:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	jr nz,Logged_0x28BD5
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x28C15
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$C189]
	and a
	ret z
	and $0F
	dec a
	ld b,a
	ld a,[$CA69]
	xor b
	jr nz,Logged_0x28BD5
	ret

Logged_0x28BD5:
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $05
	jr nc,Logged_0x28C12
	ld a,[$CA69]
	and a
	jr nz,Logged_0x28C06
	ld a,$74
	ld [$CA81],a
	ld a,$1F
	ld [$CA82],a

Logged_0x28BF6:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28C06:
	ld a,$73
	ld [$CA81],a
	ld a,$FE
	ld [$CA82],a
	jr Logged_0x28BF6

Logged_0x28C12:
	jp Logged_0x28C94

Logged_0x28C15:
	ld a,$18
	ld [$CA75],a
	ld a,$03
	ld [$CA74],a
	ld a,$72
	ld [$CA83],a
	ret

Logged_0x28C25:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	jp nz,Logged_0x28BD5
	call Logged_0x1488
	call Logged_0x2B1A6
	ld a,[$CA86]
	cp $18
	jr c,Logged_0x28C78
	ld a,$14
	ld [$CA86],a

Logged_0x28C78:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x28C8E
	jp Logged_0x14DE

Logged_0x28C8E:
	call Logged_0x14F6
	jp Logged_0x28AD5

Logged_0x28C94:
	xor a
	ld [$CA8F],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$03
	ld [$FF00+$B6],a
	ld a,$73
	ld [$CA83],a
	ld a,$0A
	ld [$CA75],a
	ld a,$01
	ld [$CA74],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$74
	ld [$CA81],a
	ld a,$2A
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28CEB:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B1CC
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x28D22
	ret

Logged_0x28D22:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x28D38
	jp Logged_0x14DE

Logged_0x28D38:
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	call Logged_0x14F6
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$3C
	ld [$FF00+$B6],a
	ld a,$74
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA74],a
	ld [$CA75],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$74
	ld [$CA81],a
	ld a,$09
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28D92:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$3D
	ld [$FF00+$B6],a
	ld a,$75
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA74],a
	ld [$CA75],a
	inc a
	ld [$CA8A],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$04
	ld [$CA7B],a
	ld a,$50
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$7B
	ld [$CA7F],a
	ld a,$BC
	ld [$CA80],a
	ld a,$7C
	ld [$CA81],a
	ld a,$E2
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28E1A:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x1570
	ld a,$76
	ld [$CA83],a
	xor a
	ld [$CA75],a
	ld [$CA74],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x28E64
	ld a,$78
	ld [$CA81],a
	ld a,$FC
	ld [$CA82],a

Logged_0x28E54:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28E64:
	ld a,$79
	ld [$CA81],a
	ld a,$05
	ld [$CA82],a
	jr Logged_0x28E54

Logged_0x28E70:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x28EEB

Logged_0x28E87:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x2926A
	ld a,[$CA74]
	and a
	jr z,Logged_0x28ECD
	call Logged_0x1488
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x28EC3
	jp Logged_0x14DE

Logged_0x28EC3:
	call Logged_0x14F6
	xor a
	ld [$CA74],a
	ld [$CA75],a

Logged_0x28ECD:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a

Logged_0x28EEB:
	ld a,$78
	ld [$CA83],a
	ld a,$03
	ld [$CA93],a
	ld a,$03
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	xor a
	ld [$CA75],a
	ld [$CA74],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x28F2D
	ld a,$78
	ld [$CA81],a
	ld a,$1C
	ld [$CA82],a

Logged_0x28F1D:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28F2D:
	ld a,$78
	ld [$CA81],a
	ld a,$1F
	ld [$CA82],a
	jr Logged_0x28F1D

Logged_0x28F39:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	call Logged_0x28F6D
	ld a,[$CA83]
	cp $78
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x290D6
	ret

Logged_0x28F6D:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x290A1
	ld a,[$C093]
	and $30
	jr nz,Logged_0x28F7D
	ret

Logged_0x28F7D:
	xor a
	ld [$CA86],a
	ld a,$79
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA75],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x28FB4
	ld a,$78
	ld [$CA81],a
	ld a,$22
	ld [$CA82],a

Logged_0x28FA4:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x28FB4:
	ld a,$78
	ld [$CA81],a
	ld a,$2B
	ld [$CA82],a
	jr Logged_0x28FA4

Logged_0x28FC0:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x28FED
	ld a,$1C
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$3B
	ld [$FF00+$B6],a

Logged_0x28FED:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2AE2F
	ld hl,$CA90
	ld a,[hli]
	cp $02
	jp nc,Logged_0x29363
	or [hl]
	jp z,Logged_0x29363
	call Logged_0x2B239
	ld a,[$CA83]
	cp $79
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x290D6
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x29035:
	ld a,$7A
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29061
	ld a,$78
	ld [$CA81],a
	ld a,$F3
	ld [$CA82],a

Logged_0x29051:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29061:
	ld a,$78
	ld [$CA81],a
	ld a,$EA
	ld [$CA82],a
	jr Logged_0x29051

Logged_0x2906D:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C094]
	bit 0,a
	jr nz,Logged_0x290A1
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x28F7D

Logged_0x290A1:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$01
	ld [$FF00+$B6],a
	xor a
	ld [$CA75],a
	ld [$CA96],a
	ld [$CA84],a
	ld a,$01
	ld [$CA74],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x290CA
	ld a,$78
	ld [$CA81],a
	ld a,$34
	ld [$CA82],a
	jr Logged_0x290D4

Logged_0x290CA:
	ld a,$78
	ld [$CA81],a
	ld a,$39
	ld [$CA82],a

Logged_0x290D4:
	jr Logged_0x29104

Logged_0x290D6:
	ld a,$18
	ld [$CA75],a
	ld a,$01
	ld [$CA96],a
	ld [$CA84],a
	ld a,$02
	ld [$CA74],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x290FA
	ld a,$78
	ld [$CA81],a
	ld a,$3E
	ld [$CA82],a
	jr Logged_0x29104

Logged_0x290FA:
	ld a,$78
	ld [$CA81],a
	ld a,$41
	ld [$CA82],a

Logged_0x29104:
	xor a
	ld [$CA85],a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$7B
	ld [$CA83],a
	ret

Logged_0x29123:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x2926A
	call Logged_0x2AE2F
	ld hl,$CA90
	ld a,[hli]
	or [hl]
	jr nz,Logged_0x2914B
	inc [hl]

Logged_0x2914B:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA84]
	and a
	jr nz,Logged_0x2919D
	ld a,[$C1A8]
	and a
	jr z,Logged_0x2919D
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$01
	ld [$CA84],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29184
	ld a,$78
	ld [$CA81],a
	ld a,$3E
	ld [$CA82],a
	jr Logged_0x2918E

Logged_0x29184:
	ld a,$78
	ld [$CA81],a
	ld a,$41
	ld [$CA82],a

Logged_0x2918E:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x2919D:
	call Logged_0x2B2A4
	ld a,[$CA83]
	cp $7B
	ret nz
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x291C8
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,[$CA83]
	cp $7B
	ret nz
	jp Logged_0x290D6

Logged_0x291C8:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x291DE
	jp Logged_0x14DE

Logged_0x291DE:
	call Logged_0x14F6
	ld a,[$CA97]
	and a
	jr nz,Logged_0x291F1
	ld a,$20
	ld [$CA97],a
	ld a,$01
	ld [$CA98],a

Logged_0x291F1:
	ld a,[$C1AA]
	and a
	jr nz,Logged_0x291FF
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$24
	ld [$FF00+$B6],a

Logged_0x291FF:
	ld a,$7C
	ld [$CA83],a
	xor a
	ld [$CA74],a
	ld [$CA75],a
	ld [$CA96],a
	ld [$CA84],a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29229
	ld a,$78
	ld [$CA81],a
	ld a,$72
	ld [$CA82],a
	jr Logged_0x29233

Logged_0x29229:
	ld a,$78
	ld [$CA81],a
	ld a,$87
	ld [$CA82],a

Logged_0x29233:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29243:
	call Logged_0x2AE2F
	ld hl,$CA90
	ld a,[hli]
	cp $02
	jp nc,Logged_0x29363
	or [hl]
	jp z,Logged_0x29363
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA97]
	and a
	ret nz
	jp Logged_0x28EEB

Logged_0x2926A:
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$FF00+$A9]
	and $F0
	ld [$FF00+$A9],a
	ld b,$03
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0D
	ld [$FF00+$B6],a
	ld a,$7D
	ld [$CA83],a
	xor a
	ld [$CA74],a
	ld [$CA75],a
	ld [$CA96],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA67],a
	ld [$CA68],a
	inc a
	ld [$CA8A],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x292CB
	ld a,$78
	ld [$CA81],a
	ld a,$72
	ld [$CA82],a
	jr Logged_0x292D5

Logged_0x292CB:
	ld a,$78
	ld [$CA81],a
	ld a,$87
	ld [$CA82],a

Logged_0x292D5:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x292E5:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C08F]
	and $0F
	call z,Logged_0x29317
	ld b,$01
	call Logged_0x1287
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	call Logged_0x2AD6A
	ret

Logged_0x29317:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29338
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub $04
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $10
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	jr Logged_0x29351

Logged_0x29338:
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,$04
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $10
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a

Logged_0x29351:
	ld b,$09
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29363:
	ld a,$7E
	ld [$CA83],a
	ld a,$02
	ld [$CA93],a
	ld a,$02
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	xor a
	ld [$CA74],a
	ld [$CA75],a
	ld [$CA96],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2939F
	ld a,$78
	ld [$CA81],a
	ld a,$44
	ld [$CA82],a
	jr Logged_0x293A9

Logged_0x2939F:
	ld a,$78
	ld [$CA81],a
	ld a,$5B
	ld [$CA82],a

Logged_0x293A9:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x293B9:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x1570

Logged_0x293D0:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$01
	ld [$CA8C],a
	ld a,$80
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$06
	ld [$CA75],a
	ld a,$FF
	ld [$CA70],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,[$CA8B]
	and a
	jr z,Logged_0x2946E
	ld a,$E5
	ld [$CA6F],a
	ld a,[$FF00+$A8]
	ld [$FF00+$AD],a
	ld a,[$FF00+$A9]
	ld [$FF00+$AE],a
	ld a,[$FF00+$AA]
	ld [$FF00+$AF],a
	ld a,[$FF00+$AB]
	ld [$FF00+$B0],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $80
	ret nz
	ld a,b
	and a
	jr nz,Unknown_0x2947A
	xor a
	ld [$CA8B],a
	ld a,[$FF00+$AD]
	ld [$FF00+$A8],a
	ld a,[$FF00+$AE]
	ld [$FF00+$A9],a
	ld a,[$FF00+$AF]
	ld [$FF00+$AA],a
	ld a,[$FF00+$B0]
	ld [$FF00+$AB],a

Logged_0x2946E:
	ld a,$E5
	ld [$CA6F],a
	ld a,$01
	ld [$CA74],a
	jr Logged_0x29493

Unknown_0x2947A:
	ld a,$F1
	ld [$CA6F],a
	xor a
	ld [$CA74],a
	ld a,[$FF00+$AD]
	ld [$FF00+$A8],a
	ld a,[$FF00+$AE]
	ld [$FF00+$A9],a
	ld a,[$FF00+$AF]
	ld [$FF00+$AA],a
	ld a,[$FF00+$B0]
	ld [$FF00+$AB],a

Logged_0x29493:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x294A5
	ld a,$7B
	ld [$CA81],a
	ld a,$8D
	ld [$CA82],a
	jr Logged_0x294AF

Logged_0x294A5:
	ld a,$7B
	ld [$CA81],a
	ld a,$7C
	ld [$CA82],a

Logged_0x294AF:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x294BF:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x29522
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29513
	ld b,$01
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x2950E
	inc b

Logged_0x2950E:
	call Logged_0x1270
	jr Logged_0x29534

Logged_0x29513:
	ld b,$01
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x2951D
	inc b

Logged_0x2951D:
	call Logged_0x1259
	jr Logged_0x29534

Logged_0x29522:
	ld a,[$CA69]
	and a
	jr nz,Unknown_0x2952F
	ld b,$01
	call Logged_0x1259
	jr Logged_0x29534

Unknown_0x2952F:
	ld b,$01
	call Logged_0x1270

Logged_0x29534:
	ld a,[$CA74]
	and a
	jr nz,Logged_0x29562
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $27
	jp nc,Logged_0x295D8
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and $0F
	ret nz
	ld a,$18
	ld [$CA75],a
	ld a,$01
	ld [$CA74],a
	ret

Logged_0x29562:
	ld a,[$CA75]
	ld e,a
	ld d,$00
	ld hl,$18A7
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x29594
	ld a,[hl]
	cpl
	inc a
	ld b,a
	call Logged_0x129E
	ld hl,$CA75
	inc [hl]
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,$18
	ld [$CA75],a
	jr Logged_0x29562

Logged_0x29594:
	ld b,[hl]
	call Logged_0x1287
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $27
	jr c,Logged_0x295A3
	ld [hl],$27

Logged_0x295A3:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x295B9
	jp Logged_0x14DE

Logged_0x295B9:
	call Logged_0x14F6
	ld a,[$CA74]
	inc a
	ld [$CA74],a
	sub $02
	jr z,Logged_0x295CC
	dec a
	jr z,Logged_0x295D2
	jr Logged_0x295D8

Logged_0x295CC:
	ld a,$0A
	ld [$CA75],a
	ret

Logged_0x295D2:
	ld a,$0E
	ld [$CA75],a
	ret

Logged_0x295D8:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$41
	ld [$FF00+$B6],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29601
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	sub $08
	ld [de],a
	dec de
	ld a,[hld]
	sbc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $20
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a
	jr Logged_0x2961A

Logged_0x29601:
	ld hl,$CA64
	ld de,$FFAB
	ld a,[hld]
	add a,$08
	ld [de],a
	dec de
	ld a,[hld]
	adc a,$00
	ld [de],a
	dec de
	ld a,[hld]
	sub $20
	ld [de],a
	dec de
	ld a,[hl]
	sbc a,$00
	ld [de],a

Logged_0x2961A:
	ld b,$08
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	ld a,$81
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29658
	ld a,$7B
	ld [$CA81],a
	ld a,$9E
	ld [$CA82],a
	jr Logged_0x29662

Logged_0x29658:
	ld a,$7B
	ld [$CA81],a
	ld a,$AD
	ld [$CA82],a

Logged_0x29662:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29672:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x1570
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$3F
	ld [$FF00+$B6],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	inc a
	ld [$CA8A],a
	ld a,$82
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA93],a
	ld [$CA92],a
	ld [$CA94],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld hl,$4800
	call Logged_0x1AF6
	ld a,$04
	ld [$CA7B],a
	ld a,$50
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$7C
	ld [$CA7F],a
	ld a,$F7
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29714
	ld a,$7E
	ld [$CA81],a
	ld a,$1B
	ld [$CA82],a
	jr Logged_0x2971E

Logged_0x29714:
	ld a,$7E
	ld [$CA81],a
	ld a,$3A
	ld [$CA82],a

Logged_0x2971E:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2972E:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	xor a
	ld [$CA8A],a
	ld a,$06
	ld [$CA8E],a
	call Logged_0x161A
	ld a,$07
	ld [$FF00+$85],a
	ld a,$9B
	ld [$FF00+$8D],a
	ld a,$69
	ld [$FF00+$8E],a
	call $FF80
	ret
	ld a,$07
	ld [$CA8E],a
	ld a,$01
	ld [$CA92],a
	ld a,$02
	ld [$CA93],a
	ld a,$01
	ld [$CA94],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$25
	ld [$FF00+$B6],a
	ld a,$83
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	ld [$CA6D],a
	ld [$CA6E],a
	ld [$CEE0],a
	ld [$CEE1],a
	ld [$CEE2],a
	call Logged_0x161A
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$09
	ld [$CA7B],a
	ld a,$70
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$77
	ld [$CA7E],a
	ld a,$49
	ld [$CA7F],a
	ld a,$3F
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x297FB
	ld a,$4C
	ld [$CA81],a
	ld a,$C0
	ld [$CA82],a
	jr Logged_0x29805

Logged_0x297FB:
	ld a,$4C
	ld [$CA81],a
	ld a,$C9
	ld [$CA82],a

Logged_0x29805:
	ld a,[$CA7E]
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29816:
	ld a,[$CA7E]
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z

Logged_0x2982B:
	ld a,$84
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA67],a
	ld [$CA68],a
	inc a
	ld [$CA74],a
	ld hl,$4800
	call Logged_0x1AF6
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29856
	ld a,$4D
	ld [$CA81],a
	ld a,$4E
	ld [$CA82],a
	jr Logged_0x29860

Logged_0x29856:
	ld a,$4D
	ld [$CA81],a
	ld a,$57
	ld [$CA82],a

Logged_0x29860:
	ld a,[$CA7E]
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29871:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x2989E
	ld a,$20
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$26
	ld [$FF00+$B6],a

Logged_0x2989E:
	ld a,[$CA7E]
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B2C2
	ret

Logged_0x298B2:
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	ld a,$85
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x298D8
	ld a,$4C
	ld [$CA81],a
	ld a,$E3
	ld [$CA82],a
	jr Logged_0x298E2

Logged_0x298D8:
	ld a,$4C
	ld [$CA81],a
	ld a,$D8
	ld [$CA82],a

Logged_0x298E2:
	ld a,[$CA7E]
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x298F3:
	ld a,[$CA7E]
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B342
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $85
	ret nz
	ld a,b
	and a
	jr z,Logged_0x29922
	jp Logged_0x2992A

Logged_0x29922:
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x2982B

Logged_0x2992A:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$27
	ld [$FF00+$B6],a
	ld a,$86
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA67],a
	ld [$CA68],a
	inc a
	ld [$CA8A],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2995A
	ld a,$4C
	ld [$CA81],a
	ld a,$EE
	ld [$CA82],a
	jr Logged_0x29964

Logged_0x2995A:
	ld a,$4D
	ld [$CA81],a
	ld a,$1E
	ld [$CA82],a

Logged_0x29964:
	ld a,[$CA7E]
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29975:
	ld a,[$CA84]
	and a
	jr nz,Logged_0x299B8
	ld a,[$CA7E]
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$01
	ld [$CA84],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x299AE
	ld a,$4D
	ld [$CA81],a
	ld a,$01
	ld [$CA82],a
	jr Logged_0x299B8

Logged_0x299AE:
	ld a,$4D
	ld [$CA81],a
	ld a,$31
	ld [$CA82],a

Logged_0x299B8:
	ld a,[$CA7E]
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x1570

Logged_0x299D0:
	ld a,$87
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	ld a,$04
	ld [$CA93],a
	ld a,$04
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA8D],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	call Logged_0x161A
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld hl,$4890
	call Logged_0x1AF6
	ld a,$0B
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$44
	ld [$CA7F],a
	ld a,$8B
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29A5A
	ld a,$48
	ld [$CA81],a
	ld a,$B6
	ld [$CA82],a
	jr Logged_0x29A64

Logged_0x29A5A:
	ld a,$48
	ld [$CA81],a
	ld a,$B9
	ld [$CA82],a

Logged_0x29A64:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29A74:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $87
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $87
	ret nz
	ld a,b
	and a
	jp z,Logged_0x29BB9
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B34E
	ret

Logged_0x29AC1:
	xor a
	ld [$CEED],a
	ld [$CA86],a
	ld [$CA84],a
	ld [$CA85],a
	ld a,$88
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29AEC
	ld a,$48
	ld [$CA81],a
	ld a,$70
	ld [$CA82],a
	jr Logged_0x29AF6

Logged_0x29AEC:
	ld a,$48
	ld [$CA81],a
	ld a,$79
	ld [$CA82],a

Logged_0x29AF6:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29B06:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x29B33
	ld a,$24
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$29
	ld [$FF00+$B6],a

Logged_0x29B33:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B381
	ld a,[$CA83]
	cp $88
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x29BB9
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x29B6A:
	ld a,$89
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29B88
	ld a,$48
	ld [$CA81],a
	ld a,$9D
	ld [$CA82],a
	jr Logged_0x29B92

Logged_0x29B88:
	ld a,$48
	ld [$CA81],a
	ld a,$94
	ld [$CA82],a

Logged_0x29B92:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29BA2:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x29AC1

Logged_0x29BB9:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29BCB
	ld a,$48
	ld [$CA81],a
	ld a,$B0
	ld [$CA82],a
	jr Logged_0x29BD5

Logged_0x29BCB:
	ld a,$48
	ld [$CA81],a
	ld a,$B3
	ld [$CA82],a

Logged_0x29BD5:
	ld a,$01
	ld [$CA84],a
	ld a,$18
	ld [$CA75],a
	jr Logged_0x29C04

Logged_0x29BE1:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29BF3
	ld a,$48
	ld [$CA81],a
	ld a,$A6
	ld [$CA82],a
	jr Logged_0x29BFD

Logged_0x29BF3:
	ld a,$48
	ld [$CA81],a
	ld a,$AB
	ld [$CA82],a

Logged_0x29BFD:
	xor a
	ld [$CA84],a
	ld [$CA75],a

Logged_0x29C04:
	ld a,$01
	ld [$CA74],a
	xor a
	ld [$CA85],a
	ld a,$8A
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29C29:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,[$CA83]
	cp $8A
	ret nz
	call Logged_0x2B3DD
	ld a,[$CA83]
	cp $8A
	ret nz
	ld a,[$CA84]
	and a
	jr nz,Logged_0x29C88
	ld a,[$C1A8]
	and a
	jr z,Logged_0x29C88
	xor a
	ld [$CA67],a
	ld [$CA68],a
	inc a
	ld [$CA84],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29C7E
	ld a,$48
	ld [$CA81],a
	ld a,$B0
	ld [$CA82],a
	jr Logged_0x29C88

Logged_0x29C7E:
	ld a,$48
	ld [$CA81],a
	ld a,$B3
	ld [$CA82],a

Logged_0x29C88:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $8A
	ret nz
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x29CBF
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,[$CA83]
	cp $8A
	ret nz
	jp Logged_0x29BB9

Logged_0x29CBF:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x29CD5
	jp Logged_0x14DE

Logged_0x29CD5:
	call Logged_0x14F6
	ld a,[$CA83]
	cp $8A
	ret nz

Logged_0x29CDE:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$2A
	ld [$FF00+$B6],a
	ld a,$02
	ld [$CA93],a
	ld a,$02
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld a,$8B
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$77
	ld [$FF00+$8D],a
	ld a,$5A
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1CA]
	and a
	jr z,Logged_0x29D43
	ld a,$01
	ld [$CA84],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29D37
	ld a,$48
	ld [$CA81],a
	ld a,$BC
	ld [$CA82],a
	jr Logged_0x29D5F

Logged_0x29D37:
	ld a,$48
	ld [$CA81],a
	ld a,$D5
	ld [$CA82],a
	jr Logged_0x29D5F

Logged_0x29D43:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29D55
	ld a,$49
	ld [$CA81],a
	ld a,$48
	ld [$CA82],a
	jr Logged_0x29D5F

Logged_0x29D55:
	ld a,$49
	ld [$CA81],a
	ld a,$53
	ld [$CA82],a

Logged_0x29D5F:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29D6F:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,[$CA84]
	dec a
	jr z,Logged_0x29D8C
	jp Logged_0x299D0

Logged_0x29D8C:
	ld a,$18
	ld [$CA75],a
	ld a,$02
	ld [$CA74],a
	ld a,$06
	ld [$CA85],a
	ld a,$8C
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29DB9
	ld a,$49
	ld [$CA81],a
	ld a,$28
	ld [$CA82],a
	jr Logged_0x29DC3

Logged_0x29DB9:
	ld a,$49
	ld [$CA81],a
	ld a,$2B
	ld [$CA82],a

Logged_0x29DC3:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29DD3:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,[$CA83]
	cp $8C
	ret nz
	call Logged_0x2B3DD
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $8C
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x29E2A
	ld a,[$CA83]
	cp $8C
	ret nz
	jp Logged_0x14DE

Logged_0x29E2A:
	call Logged_0x14F6
	ld a,[$CA83]
	cp $8C
	ret nz
	call Logged_0x29CDE
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29E48
	ld a,$48
	ld [$CA81],a
	ld a,$EE
	ld [$CA82],a
	jr Logged_0x29E52

Logged_0x29E48:
	ld a,$49
	ld [$CA81],a
	ld a,$0B
	ld [$CA82],a

Logged_0x29E52:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$C1A8],a
	ld a,$02
	ld [$CA84],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret
	ld a,$8D
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ret

Logged_0x29E7E:
	ld a,[$C08F]
	and $03
	ret nz
	ld hl,$CA84
	inc [hl]
	ld a,[hli]
	cp $08
	jr c,Logged_0x29E95
	cp $0B
	jr z,Logged_0x29EA5
	dec [hl]
	ld a,[hl]
	jr Logged_0x29E96

Logged_0x29E95:
	ld [hl],a

Logged_0x29E96:
	add a,a
	add a,a
	add a,a
	add a,a
	ld e,a
	ld d,$00
	ld hl,$4890
	add hl,de
	call Logged_0x1AF6
	ret

Logged_0x29EA5:
	jp Logged_0x1570
	ld a,[$CA83]
	cp $8E
	ret z
	cp $8C
	ret z
	cp $8B
	ret z
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld a,$8E
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x29ED9
	ld a,$49
	ld [$CA81],a
	ld a,$2E
	ld [$CA82],a
	jr Logged_0x29EE3

Logged_0x29ED9:
	ld a,$49
	ld [$CA81],a
	ld a,$3B
	ld [$CA82],a

Logged_0x29EE3:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x29EF3:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x299D0

Unknown_0x29F0A:
	ld a,$8F
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Unknown_0x29F28
	ld a,$48
	ld [$CA81],a
	ld a,$82
	ld [$CA82],a
	jr Unknown_0x29F32

Unknown_0x29F28:
	ld a,$48
	ld [$CA81],a
	ld a,$8B
	ld [$CA82],a

Unknown_0x29F32:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Unknown_0x29F42:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C093]
	and a
	jp nz,Logged_0x299D0
	ret
	ld a,$90
	ld [$CA83],a
	ld a,$18
	ld [$CA75],a
	ld a,$02
	ld [$CA74],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E3
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA8D],a
	ld [$CA86],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	call Logged_0x161A
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld hl,$4910
	call Logged_0x1AF6
	ld a,$0B
	ld [$CA7B],a
	ld a,$48
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$49
	ld [$CA7F],a
	ld a,$5E
	ld [$CA80],a
	ld a,$4C
	ld [$CA81],a
	ld a,$6C
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld b,$02
	call Logged_0x1259
	ret

Logged_0x29FFA:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	call Logged_0x1488
	call Logged_0x2B1A6
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x2A029
	ld a,$04
	ld [$CA86],a

Logged_0x2A029:
	ld a,[$CA83]
	cp $90
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2A04B
	ld a,[$CA83]
	cp $90
	ret nz
	jp Logged_0x14DE

Logged_0x2A04B:
	call Logged_0x14F6
	ld a,[$CA83]
	cp $90
	ret nz

Logged_0x2A054:
	xor a
	ld [$CA75],a
	ld [$CA74],a
	ld [$CA84],a
	ld [$CA86],a
	ld a,$91
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$4C
	ld [$CA81],a
	ld a,$5F
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A087:
	call Logged_0x2AE2F
	ld hl,$CA90
	ld a,[hli]
	or [hl]
	jp z,Logged_0x2A2E7
	call Logged_0x2AE3B
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,[$C093]
	bit 0,a
	jr nz,Logged_0x2A0BB
	jr Logged_0x2A0C2
	ld a,[$C093]
	bit 0,a
	jr nz,Logged_0x2A0BB
	jr Logged_0x2A0C2

Logged_0x2A0BB:
	ld a,$05
	ld [$CA74],a
	jr Logged_0x2A0C7

Logged_0x2A0C2:
	ld a,$04
	ld [$CA74],a

Logged_0x2A0C7:
	xor a
	ld [$CA75],a

Logged_0x2A0CB:
	ld a,$92
	ld [$CA83],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$2B
	ld [$FF00+$B6],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$4C
	ld [$CA81],a
	ld a,$6C
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A0F9:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,[$C1A8]
	and a
	jr nz,Logged_0x2A15A
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA74]
	cp $05
	jr nz,Logged_0x2A15A
	ld a,[$C1A8]
	and a
	jr z,Logged_0x2A15A
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld b,$0A
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80

Logged_0x2A15A:
	call Logged_0x2AE2F
	ld hl,$CA90
	ld a,[hli]
	or [hl]
	jp z,Logged_0x2A21E
	call Logged_0x2AE3B
	call Logged_0x1488
	call Logged_0x2B17A
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x2A17A
	ld a,$04
	ld [$CA86],a

Logged_0x2A17A:
	ld a,[$CA83]
	cp $92
	ret nz
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x2A1A6
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,[$CA83]
	cp $92
	ret nz
	ld a,$18
	ld [$CA75],a
	jr Logged_0x2A1CE

Logged_0x2A1A6:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2A1C2
	ld a,[$CA83]
	cp $92
	ret nz
	jp Logged_0x14DE

Logged_0x2A1C2:
	call Logged_0x14F6
	ld a,[$CA83]
	cp $92
	ret nz
	jp Logged_0x2A054

Logged_0x2A1CE:
	xor a
	ld a,$93
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$4C
	ld [$CA81],a
	ld a,$75
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A1F5:
	call Logged_0x2AE2F
	ld hl,$CA90
	ld a,[hli]
	or [hl]
	jr z,Logged_0x2A21E
	call Logged_0x2AE3B
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	ld a,$18
	ld [$CA75],a
	jp Logged_0x2A0CB

Logged_0x2A21E:
	ld a,$94
	ld [$CA83],a
	ld a,$18
	ld [$CA75],a
	ld a,$02
	ld [$CA74],a
	xor a
	ld [$CA85],a
	ld a,$05
	ld [$CA93],a
	ld a,$05
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld hl,$4910
	call Logged_0x1AF6
	ld a,$4C
	ld [$CA81],a
	ld a,$82
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A267:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	call Logged_0x1488
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2A29D
	jp Logged_0x14DE

Logged_0x2A29D:
	call Logged_0x14F6
	ld a,[$CA83]
	cp $94
	ret nz
	ld a,$95
	ld [$CA83],a
	xor a
	ld [$CA75],a
	ld [$CA74],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$4C
	ld [$CA81],a
	ld a,$85
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A2D3:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z

Logged_0x2A2E7:
	ld a,$05
	ld [$CA93],a
	ld a,$05
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld hl,$4910
	call Logged_0x1AF6
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2A30E
	ld a,$4C
	ld [$CA81],a
	ld a,$BF
	ld [$CA82],a
	jr Logged_0x2A318

Logged_0x2A30E:
	ld a,$4C
	ld [$CA81],a
	ld a,$B2
	ld [$CA82],a

Logged_0x2A318:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	jr Logged_0x2A344

UnknownData_0x2A321:
INCBIN "baserom.gbc", $2A321, $2A344 - $2A321

Logged_0x2A344:
	ld a,$96
	ld [$CA83],a
	xor a
	ld [$CA75],a
	ld a,$02
	ld [$CA74],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A362:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,[$C1A8]
	and a
	jr nz,Logged_0x2A394
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x2A394:
	call Logged_0x1488
	call Logged_0x2B1A6
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x2A3A6
	ld a,$04
	ld [$CA86],a

Logged_0x2A3A6:
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x2A3CB
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,[$CA83]
	cp $96
	ret nz
	ld a,$18
	ld [$CA75],a
	ret

Logged_0x2A3CB:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2A3E1
	jp Logged_0x14DE

Logged_0x2A3E1:
	call Logged_0x14F6
	ld a,[$CA83]
	cp $96
	ret nz
	jp Logged_0x1570
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$42
	ld [$FF00+$B6],a
	ld a,$97
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	ld a,[$CA74]
	and a
	jr z,Logged_0x2A42F
	ld a,$18
	ld [$CA75],a

Logged_0x2A42F:
	call Logged_0x161A
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$04
	ld [$CA7B],a
	ld a,$40
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$4A
	ld [$CA7F],a
	ld a,$82
	ld [$CA80],a
	ld a,[$C1C6]
	ld [$CA69],a
	and a
	jr nz,Unknown_0x2A46F
	ld a,$4C
	ld [$CA81],a
	ld a,$CC
	ld [$CA82],a
	jr Logged_0x2A479

Unknown_0x2A46F:
	ld a,$4C
	ld [$CA81],a
	ld a,$E1
	ld [$CA82],a

Logged_0x2A479:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A489:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,[$CA74]
	and a
	jr z,Logged_0x2A4CF
	call Logged_0x1488
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2A4C5
	jp Logged_0x14DE

Logged_0x2A4C5:
	call Logged_0x14F6
	xor a
	ld [$CA74],a
	ld [$CA75],a

Logged_0x2A4CF:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$CA84
	inc [hl]
	ld a,[hl]
	cp $80
	ret c
	ld [hl],$00
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$43
	ld [$FF00+$B6],a
	ld a,$98
	ld [$CA83],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA74],a
	ld [$CA75],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$04
	ld [$CA7B],a
	ld a,$50
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$7B
	ld [$CA7F],a
	ld a,$BC
	ld [$CA80],a
	ld a,$7C
	ld [$CA81],a
	ld a,$E2
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A544:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z

Logged_0x2A558:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$43
	ld [$FF00+$B6],a
	ld a,$99
	ld [$CA83],a
	ld a,$02
	ld [$CA93],a
	ld a,$01
	ld [$CA92],a
	ld a,$01
	ld [$CA94],a
	xor a
	ld [$CA86],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA74],a
	ld [$CA75],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$0B
	ld [$CA7B],a
	ld a,$50
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$4C
	ld [$CA7F],a
	ld a,$D5
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2A5BE
	ld a,$4F
	ld [$CA81],a
	ld a,$9F
	ld [$CA82],a
	jr Logged_0x2A5C8

Logged_0x2A5BE:
	ld a,$4F
	ld [$CA81],a
	ld a,$6E
	ld [$CA82],a

Logged_0x2A5C8:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A5D8:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B3F9
	ld a,[$CA83]
	cp $99
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Unknown_0x2A67B
	ret

Logged_0x2A61A:
	ld a,$9A
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	and a
	jr nz,Logged_0x2A63D
	ld a,$4F
	ld [$CA81],a
	ld a,$D0
	ld [$CA82],a
	jr Logged_0x2A647

Logged_0x2A63D:
	ld a,$4F
	ld [$CA81],a
	ld a,$D7
	ld [$CA82],a

Logged_0x2A647:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A657:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C094]
	bit 0,a
	jr nz,Logged_0x2A675
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x2A558

Logged_0x2A675:
	xor a
	ld [$CA75],a
	jr Logged_0x2A680

Unknown_0x2A67B:
	ld a,$18
	ld [$CA75],a

Logged_0x2A680:
	ld a,$9B
	ld [$CA83],a
	ld a,$02
	ld [$CA74],a
	xor a
	ld [$CA86],a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2A6A6
	ld a,$4F
	ld [$CA81],a
	ld a,$9F
	ld [$CA82],a
	jr Logged_0x2A6B0

Logged_0x2A6A6:
	ld a,$4F
	ld [$CA81],a
	ld a,$6E
	ld [$CA82],a

Logged_0x2A6B0:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A6C0:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x1488
	call Logged_0x2B1A6
	ld a,[$CA86]
	cp $10
	jr c,Logged_0x2A6FE
	ld a,$0C
	ld [$CA86],a

Logged_0x2A6FE:
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x2A71D
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,$18
	ld [$CA75],a
	ret

Logged_0x2A71D:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Unknown_0x2A733
	jp Logged_0x14DE

Unknown_0x2A733:
	call Logged_0x14F6
	jp Logged_0x2A558

Logged_0x2A739:
	ld a,$9C
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$0B
	ld [$CA7B],a
	ld a,$60
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$54
	ld [$CA7F],a
	ld a,$98
	ld [$CA80],a
	ld a,$58
	ld [$CA81],a
	ld a,$1C
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A77B:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $9C
	ret nz
	ld a,b
	and a
	jp z,Logged_0x2A8A7
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B4F3
	ret

Logged_0x2A7A8:
	ld a,$9D
	ld [$CA83],a
	xor a
	ld [$CA86],a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA74],a
	ld [$CA75],a
	ld a,[$C093]
	bit 5,a
	jr nz,Logged_0x2A7D4
	bit 4,a
	jr nz,Logged_0x2A7E5
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2A7E5

Logged_0x2A7D4:
	ld a,$00
	ld [$CA69],a
	ld a,$58
	ld [$CA81],a
	ld a,$25
	ld [$CA82],a
	jr Logged_0x2A7F4

Logged_0x2A7E5:
	ld a,$01
	ld [$CA69],a
	ld a,$58
	ld [$CA81],a
	ld a,$2E
	ld [$CA82],a

Logged_0x2A7F4:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A804:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$CA83]
	cp $9D
	ret nz
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B509
	ld a,[$CA83]
	cp $9D
	ret nz
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $9D
	ret nz
	ld a,b
	and a
	ret nz
	jp Logged_0x2A8A7

Logged_0x2A853:
	ld a,$9E
	ld [$CA83],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	and a
	jr nz,Unknown_0x2A876
	ld a,$58
	ld [$CA81],a
	ld a,$41
	ld [$CA82],a
	jr Logged_0x2A880

Unknown_0x2A876:
	ld a,$58
	ld [$CA81],a
	ld a,$3A
	ld [$CA82],a

Logged_0x2A880:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A890:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x2A7A8

Logged_0x2A8A7:
	ld a,$18
	ld [$CA75],a
	jr Logged_0x2A8BA

Logged_0x2A8AE:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$1D
	ld [$FF00+$B6],a
	xor a
	ld [$CA75],a

Logged_0x2A8BA:
	ld a,$9F
	ld [$CA83],a
	ld a,$01
	ld [$CA74],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld [$CA84],a
	ld [$CA85],a
	ret

Logged_0x2A8D2:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,[$CA83]
	cp $9F
	ret nz
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B55C
	ld a,[$CA83]
	cp $9F
	ret nz
	ld a,[$CA75]
	cp $18
	jr nc,Logged_0x2A92F
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $9F
	ret nz
	ld a,b
	and a
	ret z
	jp Logged_0x2A8A7

Logged_0x2A92F:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2A945
	jp Logged_0x14DE

Logged_0x2A945:
	call Logged_0x14F6
	ld a,[$CA83]
	cp $9F
	ret nz
	jp Logged_0x2A739

Logged_0x2A951:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$46
	ld [$FF00+$B6],a
	ld a,$A0
	ld [$CA83],a
	ld a,$F1
	ld [$CA6F],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$0B
	ld [$CA7B],a
	ld a,$58
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$50
	ld [$CA7F],a
	ld a,$31
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2A998
	ld a,$54
	ld [$CA81],a
	ld a,$0A
	ld [$CA82],a
	jr Logged_0x2A9A2

Logged_0x2A998:
	ld a,$54
	ld [$CA81],a
	ld a,$79
	ld [$CA82],a

Logged_0x2A9A2:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2A9B2:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z

Logged_0x2A9C6:
	ld a,$A1
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA75],a
	ld [$CA74],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2A9EE
	ld a,$54
	ld [$CA81],a
	ld a,$5F
	ld [$CA82],a
	jr Logged_0x2A9F8

Logged_0x2A9EE:
	ld a,$54
	ld [$CA81],a
	ld a,$6C
	ld [$CA82],a

Logged_0x2A9F8:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2AA08:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $A1
	ret nz
	ld a,b
	and a
	jp z,Logged_0x2ABF4
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x2AA39
	ld a,$20
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$71
	ld [$FF00+$B6],a

Logged_0x2AA39:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C094]
	bit 1,a
	jr nz,Logged_0x2AA55
	bit 0,a
	jp nz,Logged_0x2AB2F
	ret

Logged_0x2AA55:
	ld a,$E5
	ld [$CA6F],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $A1
	ret nz
	ld a,b
	and a
	jr z,Logged_0x2AA81
	ld a,$F1
	ld [$CA6F],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$E5
	ld [$FF00+$B6],a
	ret

Logged_0x2AA81:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$45
	ld [$FF00+$B6],a
	ld a,$A2
	ld [$CA83],a
	ld a,$04
	ld [$CA93],a
	ld a,$04
	ld [$CA92],a
	ld a,$02
	ld [$CA94],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CA84],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	ld [$CA74],a
	ld [$CA75],a
	call Logged_0x161A
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld hl,$4950
	call Logged_0x1AF6
	ld a,$0B
	ld [$CA7B],a
	ld a,$58
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$50
	ld [$CA7F],a
	ld a,$31
	ld [$CA80],a
	ld a,$54
	ld [$CA81],a
	ld a,$39
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2AB18:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C1A8]
	and a
	ret z
	jp Logged_0x2A739

Logged_0x2AB2F:
	ld a,$A3
	ld [$CA83],a
	xor a
	ld [$CEED],a
	ld [$CA75],a
	inc a
	ld [$CA74],a
	jp Logged_0x2ABC1

Logged_0x2AB42:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,[$CA83]
	cp $A3
	ret nz
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x2AB7C
	ld a,$10
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$71
	ld [$FF00+$B6],a

Logged_0x2AB7C:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $A3
	ret nz
	ld a,b
	and a
	jr nz,Logged_0x2ABF4
	call Logged_0x2B63B
	ld a,[$CA83]
	cp $A3
	ret nz
	call Logged_0x2B17A
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x2ABBC
	ld a,$04
	ld [$CA86],a

Logged_0x2ABBC:
	ld a,[$CA95]
	and a
	ret z

Logged_0x2ABC1:
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2ABDA
	ld a,$54
	ld [$CA81],a
	ld a,$2C
	ld [$CA82],a
	jr Logged_0x2ABE4

Logged_0x2ABDA:
	ld a,$54
	ld [$CA81],a
	ld a,$34
	ld [$CA82],a

Logged_0x2ABE4:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2ABF4:
	ld a,$A4
	ld [$CA83],a
	ld a,$03
	ld [$CA74],a
	ld a,$18
	ld [$CA75],a
	ret

Logged_0x2AC04:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0D7]
	and a
	jp nz,Logged_0x11F6
	ld a,[$C0DB]
	and a
	jp nz,Logged_0x1570
	ld a,[$CA83]
	cp $A4
	ret nz
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x2AB2F
	call Logged_0x1488
	call Logged_0x2B17A
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x2AC50
	ld a,$04
	ld [$CA86],a

Logged_0x2AC50:
	ld a,[$CA95]
	and a
	call nz,Logged_0x2ABC1
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E9
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $A4
	ret nz
	ld a,b
	and a
	ret z
	ld hl,$FFA8
	ld de,$CA61
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	jp Logged_0x2A9C6
	ld a,$A5
	ld [$CA83],a
	ld a,$FF
	ld [$CA70],a
	ld a,$E5
	ld [$CA6F],a
	ld a,$F7
	ld [$CA71],a
	ld a,$09
	ld [$CA72],a
	xor a
	ld [$CEED],a
	ld [$CA85],a
	ld [$CA9A],a
	ld [$CA89],a
	ld [$CA8B],a
	ld [$CA9D],a
	ld [$CA96],a
	ld [$CA74],a
	ld [$CA75],a
	call Logged_0x161A
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld hl,$4980
	call Logged_0x1AF6
	ld a,$0B
	ld [$CA7B],a
	ld a,$68
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$7F
	ld [$CA7E],a
	ld a,$58
	ld [$CA7F],a
	ld a,$7C
	ld [$CA80],a
	ld a,[$C1C6]
	ld [$CA69],a
	ld [$CA84],a
	ld a,$5B
	ld [$CA81],a
	ld a,$2C
	ld [$CA82],a
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2AD06:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$25
	ld [$FF00+$8D],a
	ld a,$5B
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$C0DB]
	and a
	jr z,Logged_0x2AD45
	ld a,[$CEED]
	sub $01
	ld [$CEED],a
	jr nc,Logged_0x2AD32
	ld a,$0E
	ld [$CEED],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$23
	ld [$FF00+$B6],a

Logged_0x2AD32:
	ld a,$7F
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	call Logged_0x2B56F
	ret

Logged_0x2AD45:
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld b,$0B
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x1570

Logged_0x2AD6A:
	call Logged_0x1079
	ld a,$10
	ld [$CA8C],a
	call Logged_0x161A
	ld a,$07
	ld [$FF00+$85],a
	ld a,$95
	ld [$FF00+$8D],a
	ld a,$4E
	ld [$FF00+$8E],a
	call $FF80
	xor a
	ld [$CA67],a
	ld [$CA68],a
	inc a
	ld [$CA85],a
	ld hl,$4800
	call Logged_0x1AF6
	ld a,$04
	ld [$CA7B],a
	ld a,$60
	ld [$CA7C],a
	ld a,$00
	ld [$CA7D],a
	call Logged_0x15B0
	ld a,$05
	ld [$CA7E],a
	ld a,$52
	ld [$CA7F],a
	ld a,$54
	ld [$CA80],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2ADC8
	ld a,$55
	ld [$CA81],a
	ld a,$A6
	ld [$CA82],a
	jr Logged_0x2ADD2

Logged_0x2ADC8:
	ld a,$55
	ld [$CA81],a
	ld a,$AB
	ld [$CA82],a

Logged_0x2ADD2:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x1070

Logged_0x2ADE4:
	call Logged_0x1079
	ld a,$10
	ld [$CA8C],a
	call Logged_0x161A
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$FF00+$A9]
	and $F0
	ld [$FF00+$A9],a
	ld b,$07
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$0D
	ld [$FF00+$B6],a
	ld a,$07
	ld [$FF00+$85],a
	ld a,$7C
	ld [$FF00+$8D],a
	ld a,$4D
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2AE2F:
	ld hl,$CA91
	ld a,[hl]
	sub $01
	ld [hld],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	ret

Logged_0x2AE3B:
	call Logged_0x2AE5C
	ret nc
	ld de,$0000
	ld a,[$CA85]
	xor $01
	ld [$CA85],a
	jr z,Logged_0x2AE54
	ld hl,$4920
	add hl,de
	call Logged_0x1AF6
	ret

Logged_0x2AE54:
	ld hl,$4910
	add hl,de
	call Logged_0x1AF6
	ret

Logged_0x2AE5C:
	ld hl,$CA90
	ld a,[hli]
	cp $02
	jr nc,Logged_0x2AE87
	and a
	jr z,Logged_0x2AE6E
	ld a,[hl]
	cp $68
	jr nc,Logged_0x2AE87
	jr Logged_0x2AE7E

Logged_0x2AE6E:
	ld a,[hl]
	cp $78
	jr nc,Logged_0x2AE7E
	ld a,[$C08F]
	and $03
	jr nz,Logged_0x2AE87
	ld a,$01
	jr Logged_0x2AE85

Logged_0x2AE7E:
	ld a,[$C08F]
	and $0F
	jr nz,Logged_0x2AE87

Logged_0x2AE85:
	scf
	ret

Logged_0x2AE87:
	scf
	ccf
	ret

Logged_0x2AE8A:
	ld a,[$C094]
	bit 0,a
	jr z,Logged_0x2AEA7
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2AEA7
	jp Logged_0x2AF81

Logged_0x2AEA7:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2AECB
	jr Logged_0x2AEAF

Logged_0x2AEAF:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2AEF1
	call Logged_0x153F
	call Logged_0x1270
	jp Logged_0x2AEE4

Logged_0x2AECB:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2AF19
	call Logged_0x151E
	call Logged_0x1259

Logged_0x2AEE4:
	ld a,[$CA86]
	cp $14
	jr c,Logged_0x2AEF0
	ld a,$10
	ld [$CA86],a

Logged_0x2AEF0:
	ret

Logged_0x2AEF1:
	ld b,$02
	call Logged_0x1259
	ld a,$01
	ld [$CA69],a
	ld a,[$CA84]
	and a
	jr nz,Logged_0x2AF0D
	ld a,$6B
	ld [$CA81],a
	ld a,$49
	ld [$CA82],a
	jr Logged_0x2AF3F

Logged_0x2AF0D:
	ld a,$6B
	ld [$CA81],a
	ld a,$1D
	ld [$CA82],a
	jr Logged_0x2AF3F

Logged_0x2AF19:
	ld b,$02
	call Logged_0x1270
	ld a,$00
	ld [$CA69],a
	ld a,[$CA84]
	and a
	jr nz,Logged_0x2AF35
	ld a,$6B
	ld [$CA81],a
	ld a,$38
	ld [$CA82],a
	jr Logged_0x2AF3F

Logged_0x2AF35:
	ld a,$6B
	ld [$CA81],a
	ld a,$14
	ld [$CA82],a

Logged_0x2AF3F:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp nz,Unknown_0x2814A
	ret

Logged_0x2AF75:
	ld a,$18
	ld [$CA75],a
	ld a,$03
	ld [$CA74],a
	jr Logged_0x2AF92

Logged_0x2AF81:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$01
	ld [$FF00+$B6],a
	xor a
	ld [$CA75],a
	ld a,$02
	ld [$CA74],a

Logged_0x2AF92:
	xor a
	ld [$CA85],a
	ld a,$61
	ld [$CA83],a
	ret

Logged_0x2AF9C:
	call Logged_0x1488
	call Logged_0x2B1A6
	ld a,[$CA86]
	cp $14
	jr c,Logged_0x2AFAE
	ld a,$10
	ld [$CA86],a

Logged_0x2AFAE:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld a,$18
	ld [$CA75],a
	ld a,[$CA69]
	xor $01
	ld [$CA69],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2AFF6
	ld b,$03
	call Logged_0x1270
	ld a,[$CA84]
	and a
	jr nz,Logged_0x2AFEA
	ld a,$6B
	ld [$CA81],a
	ld a,$38
	ld [$CA82],a
	jr Logged_0x2B017

Logged_0x2AFEA:
	ld a,$6B
	ld [$CA81],a
	ld a,$14
	ld [$CA82],a
	jr Logged_0x2B017

Logged_0x2AFF6:
	ld b,$03
	call Logged_0x1259
	ld a,[$CA84]
	and a
	jr nz,Logged_0x2B00D
	ld a,$6B
	ld [$CA81],a
	ld a,$49
	ld [$CA82],a
	jr Logged_0x2B017

Logged_0x2B00D:
	ld a,$6B
	ld [$CA81],a
	ld a,$1D
	ld [$CA82],a

Logged_0x2B017:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2B027:
	call Logged_0x1488
	ld hl,$CA84
	ld a,[hl]
	and a
	jr z,Logged_0x2B033
	dec [hl]
	ret

Logged_0x2B033:
	call Logged_0x2B17A
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x2B042
	ld a,$04
	ld [$CA86],a

Logged_0x2B042:
	ld a,[$CA95]
	and a
	ret z
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2B060
	ld a,$6B
	ld [$CA81],a
	ld a,$26
	ld [$CA82],a
	jr Logged_0x2B06A

Logged_0x2B060:
	ld a,$6B
	ld [$CA81],a
	ld a,$2F
	ld [$CA82],a

Logged_0x2B06A:
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2B07A:
	ld a,[$C093]
	and $30
	ret z
	and $10
	jr nz,Logged_0x2B0C7
	ld a,[$CA69]
	and a
	jr z,Logged_0x2B0AF
	ld a,$00
	ld [$CA69],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$6B
	ld [$CA81],a
	ld a,$26
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x2B0AF:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld b,$01
	call Logged_0x1270
	ret

Logged_0x2B0C7:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2B0F2
	ld a,$01
	ld [$CA69],a
	xor a
	ld [$CA67],a
	ld [$CA68],a
	ld a,$6B
	ld [$CA81],a
	ld a,$2F
	ld [$CA82],a
	ld a,$05
	ld [$FF00+$85],a
	ld a,$53
	ld [$FF00+$8D],a
	ld a,$0E
	ld [$FF00+$8E],a
	call $FF80

Logged_0x2B0F2:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld b,$01
	call Logged_0x1259
	ret

Logged_0x2B10A:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x286D1
	ld a,[$C093]
	and $30
	jp nz,Logged_0x28628
	ret

Logged_0x2B11B:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x286D1
	ld a,[$C093]
	bit 5,a
	jr nz,Logged_0x2B131
	bit 4,a
	jr nz,Logged_0x2B150
	jp Logged_0x285B8

Logged_0x2B131:
	ld a,$00
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	call Logged_0x153F
	call Logged_0x1270
	jr Logged_0x2B16D

Logged_0x2B150:
	ld a,$01
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	call Logged_0x151E
	call Logged_0x1259

Logged_0x2B16D:
	ld a,[$CA86]
	cp $04
	jr c,Logged_0x2B179
	ld a,$00
	ld [$CA86],a

Logged_0x2B179:
	ret

Logged_0x2B17A:
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x2B186
	bit 5,a
	jr nz,Logged_0x2B196
	ret

Logged_0x2B186:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$ED
	ld [$FF00+$8D],a
	ld a,$70
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2B196:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$04
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2B1A6:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2B1BC
	ld a,$07
	ld [$FF00+$85],a
	ld a,$04
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2B1BC:
	ld a,$07
	ld [$FF00+$85],a
	ld a,$ED
	ld [$FF00+$8D],a
	ld a,$70
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2B1CC:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2B1F1
	ld b,$02
	call Logged_0x1270
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x2B20E
	ld b,$02
	call Logged_0x1259
	jr Logged_0x2B20E

Logged_0x2B1F1:
	ld b,$02
	call Logged_0x1259
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr z,Logged_0x2B20E
	ld b,$02
	call Logged_0x1270

Logged_0x2B20E:
	ld a,[$CA75]
	ld e,a
	ld d,$00
	ld hl,$18A7
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x2B229
	ld a,[hl]
	cpl
	inc a
	ld b,a
	call Logged_0x129E
	ld hl,$CA75
	inc [hl]
	jr Logged_0x2B238

Logged_0x2B229:
	ld b,[hl]
	call Logged_0x1287
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $27
	jr c,Logged_0x2B238
	ld [hl],$27

Logged_0x2B238:
	ret

Logged_0x2B239:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x290A1
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x2B24F
	bit 5,a
	jr nz,Logged_0x2B279
	jp Logged_0x28EEB

Logged_0x2B24F:
	ld a,[$CA69]
	and a
	jr z,Logged_0x2B271
	ld a,$07
	ld [$FF00+$85],a
	ld a,$1B
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x2B270
	ld a,$04
	ld [$CA86],a

Logged_0x2B270:
	ret

Logged_0x2B271:
	ld a,$01
	ld [$CA69],a
	jp Logged_0x29035

Logged_0x2B279:
	ld a,[$CA69]
	cp $00
	jr nz,Logged_0x2B29C
	ld a,$07
	ld [$FF00+$85],a
	ld a,$35
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x2B29B
	ld a,$04
	ld [$CA86],a

Logged_0x2B29B:
	ret

Logged_0x2B29C:
	ld a,$00
	ld [$CA69],a
	jp Logged_0x29035

Logged_0x2B2A4:
	call Logged_0x1488
	call Logged_0x2B17A
	ld a,[$CA86]
	cp $08
	jr c,Logged_0x2B2B6
	ld a,$04
	ld [$CA86],a

Logged_0x2B2B6:
	ld a,[$CA75]
	cp $18
	ret nz
	ld a,$01
	ld [$CA96],a
	ret

Logged_0x2B2C2:
	call Logged_0x2B342
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,[$CA83]
	cp $84
	ret nz
	ld a,b
	and a
	jr z,Logged_0x2B2E1
	jp Logged_0x2992A

Logged_0x2B2E1:
	ld a,[$C0BA]
	and $0F
	cp $08
	jr c,Logged_0x2B2F6
	call Logged_0x114E
	ld a,[$CA78]
	sub c
	jr nc,Logged_0x2B2F6
	call Logged_0x11D6

Logged_0x2B2F6:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2B31F
	ld a,[$C093]
	bit 4,a
	jp nz,Logged_0x298B2
	bit 5,a
	ret z
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld b,$01
	call Logged_0x1270
	ret

Logged_0x2B31F:
	ld a,[$C093]
	bit 5,a
	jp nz,Logged_0x298B2
	bit 4,a
	ret z
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret nz
	ld b,$01
	call Logged_0x1259
	ret

Logged_0x2B342:
	ld a,[$C08F]
	and $01
	ret nz
	ld b,$01
	call Logged_0x129E
	ret

Logged_0x2B34E:
	ld a,[$C093]
	bit 0,a
	jp nz,Logged_0x29BE1
	and $30
	jp nz,Logged_0x29AC1
	ld a,$06
	ld [$FF00+$85],a
	ld a,$E0
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jp z,Logged_0x29BB9
	ld hl,$CA84
	ld a,[hl]
	add a,$01
	ld [hli],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	cp $02
	ret c
	jp Unknown_0x29F0A

UnknownData_0x2B380:
INCBIN "baserom.gbc", $2B380, $2B381 - $2B380

Logged_0x2B381:
	ld a,[$C093]
	bit 0,a
	jp nz,Logged_0x29BE1
	bit 4,a
	jr nz,Logged_0x2B394
	bit 5,a
	jr nz,Logged_0x2B3B3
	jp Logged_0x299D0

Logged_0x2B394:
	ld a,[$CA69]
	and a
	jr z,Logged_0x2B3AB
	ld a,$07
	ld [$FF00+$85],a
	ld a,$1B
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x2B3C8

Logged_0x2B3AB:
	ld a,$01
	ld [$CA69],a
	jp Logged_0x29B6A

Logged_0x2B3B3:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2B3D5
	ld a,$07
	ld [$FF00+$85],a
	ld a,$35
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80

Logged_0x2B3C8:
	ld a,[$CA86]
	cp $04
	jr c,Logged_0x2B3D4
	ld a,$00
	ld [$CA86],a

Logged_0x2B3D4:
	ret

Logged_0x2B3D5:
	ld a,$00
	ld [$CA69],a
	jp Logged_0x29B6A

Logged_0x2B3DD:
	call Logged_0x1488
	ld hl,$CA85
	ld a,[hl]
	and a
	jr z,Logged_0x2B3E9
	dec [hl]
	ret

Logged_0x2B3E9:
	call Logged_0x2B17A
	ld a,[$CA86]
	cp $04
	jr c,Logged_0x2B3F8
	ld a,$00
	ld [$CA86],a

Logged_0x2B3F8:
	ret

Logged_0x2B3F9:
	ld a,[$C094]
	bit 0,a
	jp nz,Logged_0x2A675
	call Logged_0x2B42B
	ld a,[$CA83]
	cp $99
	ret nz
	ld a,[$C1A8]
	and a
	ret z
	ld a,[$CA69]
	and a
	jr nz,Unknown_0x2B421
	ld a,[$C093]
	bit 5,a
	jr z,Unknown_0x2B428

Unknown_0x2B41C:
	xor a
	ld [$CA86],a
	ret

Unknown_0x2B421:
	ld a,[$C093]
	bit 4,a
	jr nz,Unknown_0x2B41C

Unknown_0x2B428:
	jp Logged_0x2A61A

Logged_0x2B42B:
	ld hl,$CA86
	inc [hl]
	ld a,[hl]
	cp $06
	jr c,Logged_0x2B495
	jp z,Logged_0x2B4D0
	cp $09
	ret c
	cp $12
	jr c,Logged_0x2B495
	jp z,Logged_0x2B4D0
	cp $15
	ret c
	cp $18
	jr c,Logged_0x2B495
	cp $22
	jr c,Logged_0x2B45D
	jp z,Logged_0x2B4D0
	cp $25
	ret c
	cp $2C
	jr c,Logged_0x2B457
	ret

Logged_0x2B457:
	ld a,[$C08F]
	and $01
	ret z

Logged_0x2B45D:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2B47C
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2B4CD
	ld b,$01
	call Logged_0x1270
	ret

Logged_0x2B47C:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2B4CD
	ld b,$01
	call Logged_0x1259
	ret

Logged_0x2B495:
	ld a,[$CA69]
	and a
	jr nz,Logged_0x2B4B4
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2B4CD
	ld b,$02
	call Logged_0x1270
	ret

Logged_0x2B4B4:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2B4CD
	ld b,$02
	call Logged_0x1259
	ret

Logged_0x2B4CD:
	jp Logged_0x2A61A

Logged_0x2B4D0:
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld b,$04
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x2B4F3:
	ld a,[$C094]
	bit 1,a
	jp nz,Logged_0x2A951
	bit 0,a
	jp nz,Logged_0x2A8AE
	ld a,[$C093]
	and $30
	jp nz,Logged_0x2A7A8
	ret

Logged_0x2B509:
	ld a,[$C093]
	bit 1,a
	jp nz,Logged_0x2A951
	bit 0,a
	jp nz,Logged_0x2A8AE
	bit 4,a
	jr nz,Logged_0x2B521
	bit 5,a
	jr nz,Logged_0x2B539
	jp Logged_0x2A739

Logged_0x2B521:
	ld a,[$CA69]
	and a
	jp z,Logged_0x2A853
	ld a,$07
	ld [$FF00+$85],a
	ld a,$1B
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80
	jr Logged_0x2B54F

Logged_0x2B539:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x2A853
	ld a,$07
	ld [$FF00+$85],a
	ld a,$35
	ld [$FF00+$8D],a
	ld a,$71
	ld [$FF00+$8E],a
	call $FF80

Logged_0x2B54F:
	ld a,[$CA86]
	cp $10
	jr c,Logged_0x2B55B
	ld a,$0C
	ld [$CA86],a

Logged_0x2B55B:
	ret

Logged_0x2B55C:
	call Logged_0x1488
	call Logged_0x2B17A
	ld a,[$CA86]
	cp $10
	jr c,Logged_0x2B56E
	ld a,$0C
	ld [$CA86],a

Logged_0x2B56E:
	ret

Logged_0x2B56F:
	ld a,[$C08F]
	and $01
	jr z,Logged_0x2B5B2
	ld b,$01
	call Logged_0x129E
	ld a,$06
	ld [$FF00+$85],a
	ld a,$6E
	ld [$FF00+$8D],a
	ld a,$59
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	ret z
	ld hl,$CA61
	ld de,$FFA8
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld b,$0B
	ld a,$03
	ld [$FF00+$85],a
	ld a,$F3
	ld [$FF00+$8D],a
	ld a,$49
	ld [$FF00+$8E],a
	call $FF80
	jp Logged_0x1570

Logged_0x2B5B2:
	ld a,[$C093]
	bit 4,a
	jr nz,Logged_0x2B607
	bit 5,a
	jr nz,Logged_0x2B621
	ld a,[$CA84]
	ld [$CA69],a
	ld a,$06
	ld [$FF00+$85],a
	ld a,$34
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2B5F7
	ld hl,$76B4
	ld a,[$CA75]
	ld e,a
	ld d,$00
	add hl,de
	ld b,[hl]
	ld a,[$CA84]
	and a
	jr nz,Logged_0x2B5EC
	call Logged_0x1270
	jr Logged_0x2B5EF

Logged_0x2B5EC:
	call Logged_0x1259

Logged_0x2B5EF:
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $2F
	ret c

Logged_0x2B5F7:
	ld a,[$CA84]
	xor $01
	ld [$CA84],a
	ld [$CA69],a

Logged_0x2B602:
	xor a
	ld [$CA75],a
	ret

Logged_0x2B607:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$41
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2B5F7
	ld b,$01
	call Logged_0x1259
	jr Logged_0x2B602

Logged_0x2B621:
	ld a,$06
	ld [$FF00+$85],a
	ld a,$B1
	ld [$FF00+$8D],a
	ld a,$57
	ld [$FF00+$8E],a
	call $FF80
	ld a,b
	and a
	jr nz,Logged_0x2B5F7
	ld b,$01
	call Logged_0x1270
	jr Logged_0x2B602

Logged_0x2B63B:
	ld a,[$C093]
	bit 0,a
	jp z,Logged_0x2ABF4
	ld hl,$CA75
	inc [hl]
	ld a,[hl]
	cp $28
	jr c,Logged_0x2B651
	jp Logged_0x2ABF4

UnknownData_0x2B64F:
INCBIN "baserom.gbc", $2B64F, $2B651 - $2B64F

Logged_0x2B651:
	ld e,a
	ld d,$00
	ld a,$07
	ld [$FF00+$85],a
	ld a,$63
	ld [$FF00+$8D],a
	ld a,$78
	ld [$FF00+$8E],a
	call $FF80
	ret

LoggedData_0x2B664:
INCBIN "baserom.gbc", $2B664, $2B68B - $2B664

UnknownData_0x2B68B:
INCBIN "baserom.gbc", $2B68B, $2B68C - $2B68B

LoggedData_0x2B68C:
INCBIN "baserom.gbc", $2B68C, $2B6E3 - $2B68C

UnknownData_0x2B6E3:
INCBIN "baserom.gbc", $2B6E3, $2C000 - $2B6E3

SECTION "Bank0B", ROMX, BANK[$0B]

UnknownData_0x2C000:
INCBIN "baserom.gbc", $2C000, $2F000 - $2C000

LoggedData_0x2F000:
INCBIN "baserom.gbc", $2F000, $2F800 - $2F000

UnknownData_0x2F800:
INCBIN "baserom.gbc", $2F800, $30000 - $2F800

SECTION "Bank0C", ROMX, BANK[$0C]

Logged_0x30000:
	ld a,$FF
	ld [$D000],a
	ld a,[$D001]
	push af
	ld hl,$D001
	ld b,$3F
	xor a

Logged_0x3000F:
	ld [hli],a
	dec b
	jr nz,Logged_0x3000F
	pop af
	ld [$D001],a
	ld a,$4A
	ld [$D005],a
	ld [$D007],a
	ld [$D00A],a
	ld [$D00C],a
	ld a,$40
	ld [$D006],a
	ld [$D00B],a
	ld a,$FF
	ld [$D01D],a
	xor a
	ld b,$08
	ld de,$003C
	ld hl,$D040

Logged_0x3003B:
	ld [hl],a
	add hl,de
	dec b
	jr nz,Logged_0x3003B
	xor a
	ld b,$04
	ld de,$0018
	ld hl,$D220

Logged_0x30049:
	ld [hl],a
	add hl,de
	dec b
	jr nz,Logged_0x30049
	ld a,$80
	ld [$FF00+$26],a
	ld a,$00
	ld [$FF00+$25],a
	ld a,$08
	ld [$FF00+$12],a
	ld [$FF00+$17],a
	ld [$FF00+$21],a
	ld a,$80
	ld [$FF00+$14],a
	ld [$FF00+$19],a
	ld [$FF00+$23],a
	ld a,$00
	ld [$FF00+$1A],a
	ld a,$FF
	ld [$FF00+$25],a
	ld a,$77
	ld [$FF00+$24],a
	ld a,$00
	ld [$D000],a
	jp Logged_0x3F5D

Logged_0x3007A:
	push bc
	push de
	call Logged_0x30527
	ld hl,$D000
	set 5,[hl]
	ld hl,$D007
	ld a,[hli]
	add a,[hl]
	ld [hli],a
	ld a,$00
	adc a,[hl]
	ld [hld],a
	ld a,[hli]
	sub $4A
	ld b,a
	ld a,[hl]
	sbc a,$00
	jr nc,Logged_0x300A4
	call Logged_0x30144

Logged_0x3009A:
	call Logged_0x30547
	call Logged_0x3015F
	jr nz,Logged_0x3009A
	jr Logged_0x300C8

Logged_0x300A4:
	ld [hld],a
	ld [hl],b
	call Logged_0x30193

Logged_0x300A9:
	call Logged_0x30BB0
	call Logged_0x301A4
	jr nz,Logged_0x300A9
	call Logged_0x30144

Logged_0x300B4:
	call Logged_0x30559
	call Logged_0x3015F
	jr nz,Logged_0x300B4
	ld hl,$D008
	ld a,[hli]
	sub $4A
	ld b,a
	ld a,[hl]
	sbc a,$00
	jr nc,Logged_0x300A4

Logged_0x300C8:
	ld hl,$D000
	res 5,[hl]
	ld hl,$D00C
	ld a,[hli]
	add a,[hl]
	ld [hli],a
	ld a,$00
	adc a,[hl]
	ld [hld],a
	ld a,[hli]
	sub $4A
	ld b,a
	ld a,[hl]
	sbc a,$00
	jr nc,Logged_0x300ED
	call Logged_0x3014B

Logged_0x300E3:
	call Logged_0x30547
	call Logged_0x3015F
	jr nz,Logged_0x300E3
	jr Logged_0x30111

Logged_0x300ED:
	ld [hld],a
	ld [hl],b
	call Logged_0x30193

Logged_0x300F2:
	call Logged_0x30BC2
	call Logged_0x301A4
	jr nz,Logged_0x300F2
	call Logged_0x3014B

Logged_0x300FD:
	call Logged_0x30559
	call Logged_0x3015F
	jr nz,Logged_0x300FD
	ld hl,$D00D
	ld a,[hli]
	sub $4A
	ld b,a
	ld a,[hl]
	sbc a,$00
	jr nc,Logged_0x300ED

Logged_0x30111:
	call Logged_0x30193

Logged_0x30114:
	call Logged_0x30BFB
	call Logged_0x301A4
	jr nz,Logged_0x30114
	ld a,[$D01A]
	and a
	jr nz,Logged_0x30124
	ld a,$0F

Logged_0x30124:
	dec a
	ld [$D01A],a
	ld c,$08
	ld de,$003C
	ld hl,$D040

Logged_0x30130:
	ld a,[hl]
	and $F8
	ld [hl],a
	rla
	rr b
	add hl,de
	dec c
	jr nz,Logged_0x30130
	ld a,b
	ld [$D024],a
	pop de
	pop bc
	jp Logged_0x3F8D

Logged_0x30144:
	ld de,$D040
	ld a,$04
	jr Logged_0x30157

Logged_0x3014B:
	ld de,$D130
	ld a,$04
	jr Logged_0x30157

UnknownData_0x30152:
INCBIN "baserom.gbc", $30152, $30157 - $30152

Logged_0x30157:
	ld hl,$D00F
	ld [hli],a
	ld a,e
	ld [hli],a
	ld [hl],d
	ret

Logged_0x3015F:
	ld hl,$D00F
	dec [hl]
	ret z
	inc hl
	ld a,$3C
	add a,[hl]
	ld [hli],a
	ld a,$00
	adc a,[hl]
	ld [hl],a
	rra
	ret

Logged_0x3016F:
	ld de,$D220
	ld a,$01
	ld c,$12
	jr Logged_0x3019A

Logged_0x30178:
	ld de,$D238
	ld a,$01
	ld c,$17
	jr Logged_0x3019A

Logged_0x30181:
	ld de,$D250
	ld a,$01
	ld c,$1C
	jr Logged_0x3019A

Logged_0x3018A:
	ld de,$D268
	ld a,$01
	ld c,$21
	jr Logged_0x3019A

Logged_0x30193:
	ld de,$D220
	ld a,$04
	ld c,$12

Logged_0x3019A:
	ld hl,$D012
	ld [hli],a
	ld a,e
	ld [hli],a
	ld a,d
	ld [hli],a
	ld [hl],c
	ret

Logged_0x301A4:
	ld hl,$D012
	dec [hl]
	ret z
	inc hl
	ld a,$18
	add a,[hl]
	ld [hli],a
	ld a,$00
	adc a,[hl]
	ld [hli],a
	ld a,[hl]
	add a,$05
	ld [hl],a
	rra
	ret

Logged_0x301B8:
	ld a,b
	or c
	jp z,Logged_0x30401
	call Logged_0x30302
	ld a,[$D03F]
	bit 7,a
	jr nz,Unknown_0x30211
	ld b,a
	sub $04
	jr nc,Logged_0x3020E
	cpl
	inc a
	ld [$D00F],a
	ld hl,$D040
	ld a,b
	and a
	jr z,Logged_0x301DF
	ld de,$003C

Logged_0x301DB:
	add hl,de
	dec b
	jr nz,Logged_0x301DB

Logged_0x301DF:
	ld a,l
	ld [$D010],a
	ld a,h
	ld [$D011],a
	jr Logged_0x301F1

Logged_0x301E9:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a

Logged_0x301F1:
	bit 7,[hl]
	jr z,Logged_0x30204
	ld bc,$0008
	add hl,bc
	ld a,[$D03E]
	cp [hl]
	jr nc,Logged_0x30204
	call Logged_0x30366
	jr Logged_0x30207

Logged_0x30204:
	call Logged_0x30341

Logged_0x30207:
	jr z,Logged_0x3020E
	call Logged_0x3015F
	jr nz,Logged_0x301E9

Logged_0x3020E:
	jp Logged_0x3F8D

Unknown_0x30211:
	call Logged_0x30144
	ld a,$01
	ld [$D03B],a
	xor a
	ld [$D03A],a

Unknown_0x3021D:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	bit 7,[hl]
	jr nz,Unknown_0x30239
	call Logged_0x30341
	jr z,Unknown_0x3027C
	ld a,[$D03B]
	ld b,a
	ld a,[$D03A]
	or b
	ld [$D03A],a

Unknown_0x30239:
	ld a,[$D03B]
	sla a
	ld [$D03B],a
	call Logged_0x3015F
	jr nz,Unknown_0x3021D
	call Logged_0x30144
	ld a,$01
	ld [$D03B],a

Unknown_0x3024E:
	ld a,[$D03B]
	ld b,a
	ld a,[$D03A]
	and b
	jr nz,Unknown_0x3026F
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$0008
	add hl,bc
	ld a,[$D03E]
	cp [hl]
	jr c,Unknown_0x3026F
	call Logged_0x30341
	jr z,Unknown_0x3027C

Unknown_0x3026F:
	ld a,[$D03B]
	sla a
	ld [$D03B],a
	call Logged_0x3015F
	jr nz,Unknown_0x3024E

Unknown_0x3027C:
	jp Logged_0x3F8D

Logged_0x3027F:
	ld a,b
	or c
	jp z,Logged_0x30416
	ld a,c
	ld [$D01B],a
	ld a,b
	ld [$D01C],a
	xor a
	ld [$D020],a
	xor a
	ld [$D025],a
	call Logged_0x30302
	call Logged_0x3014B

Logged_0x3029A:
	call Logged_0x30341
	jr z,Logged_0x302B0
	call Logged_0x3015F
	jr nz,Logged_0x3029A
	jr Logged_0x302B5

Logged_0x302A6:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	xor a
	ld [hl],a

Logged_0x302B0:
	call Logged_0x3015F
	jr nz,Logged_0x302A6

Logged_0x302B5:
	jp Logged_0x3F8D

Logged_0x302B8:
	ld a,[$D01B]
	cp c
	jr nz,Logged_0x3027F
	ld a,[$D01C]
	cp b
	jr nz,Logged_0x3027F
	ld a,[$D024]
	and $F0
	jr z,Logged_0x3027F
	jp Logged_0x3F8D

Logged_0x302CE:
	ld a,[$D01B]
	cp c
	jr nz,Logged_0x3027F
	ld a,[$D01C]
	cp b
	jr nz,Logged_0x3027F
	ld a,[$D024]
	and $F0
	jr z,Logged_0x302E4
	jp Logged_0x3F8D

Logged_0x302E4:
	xor a
	ld [$D025],a
	call Logged_0x3014B

Logged_0x302EB:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld a,[hl]
	and $60
	jr z,Logged_0x302FA
	set 7,[hl]

Logged_0x302FA:
	call Logged_0x3015F
	jr nz,Logged_0x302EB
	jp Logged_0x3F8D

Logged_0x30302:
	ld a,b
	ld [$D039],a
	cp $02
	ld a,c
	jr z,Logged_0x30311
	jr c,Logged_0x30315

Unknown_0x3030D:
	pop hl
	jp Logged_0x3F8D

Logged_0x30311:
	cp $39
	jr nc,Unknown_0x3030D

Logged_0x30315:
	ld [$D038],a
	ld l,c
	ld h,b
	add hl,hl
	add hl,hl
	add hl,hl
	ld bc,$555E
	add hl,bc
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld [$D026],a
	inc hl
	ld a,[hli]
	ld [$D03E],a
	ld a,[hli]
	ld [$D03F],a
	ld a,[hl]
	ld [$D03C],a
	inc de
	inc de
	ld a,e
	ld [$D017],a
	ld a,d
	ld [$D018],a
	ret

Logged_0x30341:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld a,$A0
	ld [hli],a
	inc hl
	ld a,[$D017]
	ld [hli],a
	ld a,[$D018]
	ld [hli],a
	ld a,[$D026]
	ld [hli],a
	inc hl
	ld a,[$D038]
	ld [hli],a
	ld a,[$D039]
	ld [hli],a
	ld a,[$D03E]
	ld [hli],a

Logged_0x30366:
	ld hl,$D03C
	dec [hl]
	ret z
	ld hl,$D017
	ld a,$02
	add a,[hl]
	ld [hli],a
	ld a,$00
	adc a,[hl]
	ld [hl],a
	rra
	ret

Logged_0x30378:
	ld a,$C0
	ld [hli],a
	xor a
	ld [hli],a
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ld a,[hld]
	ld [$D026],a
	call Logged_0x3FB5
	ld a,b
	ld [hld],a
	ld [hl],c
	ld bc,$0007
	add hl,bc
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$FF
	ld [hli],a
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$FF
	ld [hli],a
	ld a,$40
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$17
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$FF
	ld [hli],a
	ret

Logged_0x303C9:
	ld a,b
	or c
	jp z,Logged_0x30401
	ld a,c
	ld [$D038],a
	ld a,b
	ld [$D039],a
	call Logged_0x30144

Unknown_0x303D9:
	ld a,[$D010]
	ld c,a
	ld a,[$D011]
	ld b,a
	ld a,[bc]
	bit 7,a
	jr z,Unknown_0x303F9
	ld hl,$0006
	add hl,bc
	ld a,[$D038]
	cp [hl]
	jr nz,Unknown_0x303F9
	inc hl
	ld a,[$D039]
	cp [hl]
	jr nz,Unknown_0x303F9
	xor a
	ld [bc],a

Unknown_0x303F9:
	call Logged_0x3015F
	jr nz,Unknown_0x303D9
	jp Logged_0x3F8D

Logged_0x30401:
	call Logged_0x30144

Logged_0x30404:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	xor a
	ld [hl],a
	call Logged_0x3015F
	jr nz,Logged_0x30404
	jp Logged_0x3F8D

Logged_0x30416:
	call Logged_0x30420
	jp Logged_0x3F8D

Unknown_0x3041C:
	xor a
	ld [$D020],a

Logged_0x30420:
	ld a,$FF
	ld [$D025],a
	call Logged_0x3014B

Logged_0x30428:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	res 7,[hl]
	call Logged_0x3015F
	jr nz,Logged_0x30428
	ret

UnknownData_0x30438:
INCBIN "baserom.gbc", $30438, $30494 - $30438

LoggedData_0x30494:
INCBIN "baserom.gbc", $30494, $30496 - $30494

UnknownData_0x30496:
INCBIN "baserom.gbc", $30496, $3049E - $30496

Logged_0x3049E:
	call Logged_0x304A4
	jp Logged_0x3F8D

Logged_0x304A4:
	cp $07
	ret nc
	push af
	ld hl,$D038
	ld a,c
	ld [hli],a
	ld a,b
	ld [hli],a
	ld a,e
	ld [hli],a
	ld a,d
	ld [hli],a
	xor a
	ld [hl],a
	pop af
	ld bc,$4490
	jp Logged_0x305B6

Logged_0x304BC:
	call Logged_0x304FA

Logged_0x304BF:
	rrc d
	jr nc,Logged_0x304D3
	bit 7,[hl]
	jr z,Logged_0x304D3
	ld a,[$D03C]
	or [hl]
	ld [hl],a
	push hl
	add hl,bc
	ld a,[$D039]
	ld [hl],a
	pop hl

Logged_0x304D3:
	call Logged_0x3050F
	jr nz,Logged_0x304BF
	ret

UnknownData_0x304D9:
INCBIN "baserom.gbc", $304D9, $304FA - $304D9

Logged_0x304FA:
	ld a,[$D03B]
	and $0F
	ld d,a
	ld a,[$D03A]
	swap a
	and $F0
	or d
	ld d,a
	ld e,$08
	ld hl,$D040
	ret

Logged_0x3050F:
	ld a,$3C
	add a,l
	ld l,a
	ld a,$00
	adc a,h
	ld h,a
	dec e
	ret

UnknownData_0x30519:
INCBIN "baserom.gbc", $30519, $30527 - $30519

Logged_0x30527:
	ld a,[$D025]
	and a
	ret nz
	ld a,[$D020]
	and a
	ret z
	ld hl,$D021
	dec [hl]
	ret nz
	ld [hli],a
	ld a,[hl]
	sub $04
	jp c,Unknown_0x3041C
	ld [hl],a
	ld b,a
	ld a,$02
	ld de,$00FF
	jp Logged_0x304A4

Logged_0x30547:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld a,[hl]
	cp $C0
	ret c
	ld [$D019],a
	jp Logged_0x30651

Logged_0x30559:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld a,[hl]
	bit 7,a
	ret z
	bit 6,a
	jr nz,Logged_0x3056F
	push hl
	call Logged_0x30378
	pop hl
	ld a,[hl]

Logged_0x3056F:
	ld [$D019],a
	inc hl
	ld a,[hl]
	and a
	jr z,Logged_0x3057B
	dec [hl]
	inc hl
	jr Logged_0x305CF

Logged_0x3057B:
	inc hl
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld [$D026],a

Logged_0x30584:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$0011
	add hl,bc
	call Logged_0x3FB5
	bit 7,c
	jr nz,Logged_0x3059F
	ld a,c
	ld [$D01F],a
	dec de
	ld a,[hl]
	jr Logged_0x305A9

Logged_0x3059F:
	ld a,b
	ld [$D01F],a
	ld a,c
	cp $BE
	jr c,Logged_0x305A9
	ld [hl],a

Logged_0x305A9:
	cp $D0
	jp nc,Logged_0x30A14
	sub $B1
	jp c,Logged_0x3073F
	ld bc,$46D1

Logged_0x305B6:
	sla a
	add a,c
	ld c,a
	ld a,$00
	adc a,b
	ld b,a
	ld a,[bc]
	ld l,a
	inc bc
	ld a,[bc]
	ld h,a
	jp hl

Logged_0x305C4:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	xor a
	ld [hli],a
	ret

Logged_0x305CF:
	ld bc,$0029
	add hl,bc
	ld a,[hl]
	and a
	jr z,Logged_0x305E0
	dec [hl]
	ld bc,$FFF5
	add hl,bc
	ld a,$40
	jr Logged_0x305E6

Logged_0x305E0:
	ld bc,$FFF4
	add hl,bc
	ld a,[hli]
	add a,[hl]

Logged_0x305E6:
	ld [hl],a
	sla a
	jr nc,Logged_0x305EC
	cpl

Logged_0x305EC:
	ld [$D01E],a
	ld bc,$0001
	add hl,bc
	ld a,[hli]
	add a,[hl]
	jr z,Logged_0x3060C
	ld c,a
	ld a,[$D01E]
	ld b,a
	push hl
	push bc
	call Logged_0x30FEE
	pop bc
	ld b,h
	pop hl
	inc hl
	ld a,[hli]
	cp $00
	jr z,Logged_0x30617
	jr Logged_0x30646

Logged_0x3060C:
	ld bc,$0000
	inc hl
	ld a,[hli]
	cp $00
	jr z,Logged_0x30629
	jr Logged_0x30646

Logged_0x30617:
	ld a,b
	srl c
	sub c
	ld c,a
	ld a,$00
	sbc a,a
	sla c
	rla
	sla c
	rla
	sla c
	rla
	ld b,a

Logged_0x30629:
	ld a,c
	cp [hl]
	jr z,Logged_0x30636
	ld a,[$D019]
	set 2,a
	ld [$D019],a
	ld [hl],c

Logged_0x30636:
	inc hl
	ld a,b
	cp [hl]
	jr z,Logged_0x30644
	ld a,[$D019]
	set 2,a
	ld [$D019],a
	ld [hl],b

Logged_0x30644:
	jr Logged_0x30646

Logged_0x30646:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld a,[$D019]

Logged_0x30651:
	bit 2,a
	jr z,Logged_0x30691
	ld bc,$001D
	add hl,bc
	ld e,[hl]
	ld a,$00
	sla e
	sbc a,a
	ld d,a
	ld bc,$FFFE
	add hl,bc
	ld a,[hli]
	add a,e
	ld e,a
	ld a,[hld]
	adc a,d
	ld d,a
	ld bc,$FFF8
	add hl,bc
	ld a,[hli]
	add a,e
	ld e,a
	ld a,[hld]
	adc a,d
	ld d,a
	ld bc,$0010
	add hl,bc
	ld a,[hli]
	cp $00
	jr nz,Logged_0x30683
	ld a,[hli]
	add a,e
	ld e,a
	ld a,[hld]
	adc a,d
	ld d,a

Logged_0x30683:
	ld bc,$0008
	add hl,bc
	ld a,e
	ld [hli],a
	ld [hl],d
	ld bc,$FFD3
	add hl,bc
	ld a,[$D019]

Logged_0x30691:
	bit 0,a
	jr z,Logged_0x306A8
	ld bc,$0017
	add hl,bc
	ld a,[hli]
	add a,[hl]
	ld e,a
	ld bc,$0016
	add hl,bc
	ld [hl],e
	ld bc,$FFD2
	add hl,bc
	ld a,[$D019]

Logged_0x306A8:
	bit 1,a
	jr z,Logged_0x306CF
	ld bc,$0015
	add hl,bc
	ld a,[hli]
	ld b,a
	ld c,[hl]
	call Logged_0x31012
	add a,$0F
	and $F0
	cp $40
	jr c,Logged_0x306C0
	ld a,$FF

Logged_0x306C0:
	rlca
	rlca
	ld e,a
	ld bc,$0019
	add hl,bc
	ld [hl],e
	ld bc,$FFD1
	add hl,bc
	ld a,[$D019]

Logged_0x306CF:
	ld [hl],a
	ret

LoggedData_0x306D1:
INCBIN "baserom.gbc", $306D1, $306D9 - $306D1

UnknownData_0x306D9:
INCBIN "baserom.gbc", $306D9, $306E7 - $306D9

LoggedData_0x306E7:
INCBIN "baserom.gbc", $306E7, $306EF - $306E7

UnknownData_0x306EF:
INCBIN "baserom.gbc", $306EF, $306F1 - $306EF

LoggedData_0x306F1:
INCBIN "baserom.gbc", $306F1, $306FD - $306F1

UnknownData_0x306FD:
INCBIN "baserom.gbc", $306FD, $3070B - $306FD

LoggedData_0x3070B:
INCBIN "baserom.gbc", $3070B, $3070F - $3070B

UnknownData_0x3070F:
INCBIN "baserom.gbc", $3070F, $3073F - $3070F

Logged_0x3073F:
	add a,$31
	jp z,Logged_0x30584
	add a,$2B
	ld l,a
	ld a,$00
	adc a,$50
	ld h,a
	ld b,[hl]
	dec b
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	inc hl
	ld a,b
	ld [hli],a
	ld a,e
	ld [hli],a
	ld a,d
	ld [hld],a
	jp Logged_0x305CF
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$0026
	add hl,bc
	ld a,[hl]
	cp $0A
	jp nc,Logged_0x305C4
	inc a
	inc a
	ld [hl],a
	ld c,a
	ld b,$00
	add hl,bc
	ld bc,$000A
	add hl,bc
	inc de
	inc de
	ld a,e
	ld [hli],a
	ld [hl],d
	dec de
	dec de
	call Logged_0x3FB5
	ld e,c
	ld d,b
	jp Logged_0x30584
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$0026
	add hl,bc
	ld a,[hl]
	and a
	jp z,Logged_0x30584
	dec a
	dec a
	ld [hl],a
	ld c,a
	ld b,$00
	add hl,bc
	ld bc,$000C
	add hl,bc
	ld a,[hli]
	ld e,a
	ld d,[hl]
	jp Logged_0x30584

UnknownData_0x307AE:
INCBIN "baserom.gbc", $307AE, $307CC - $307AE
	ld hl,$D000
	bit 5,[hl]
	ld hl,$D00A
	jr z,Logged_0x307D9
	ld hl,$D005

Logged_0x307D9:
	ld a,[$D01F]
	inc de
	ld [hl],a
	call Logged_0x307E4
	jp Logged_0x30584

Logged_0x307E4:
	ld a,[hli]
	ld b,a
	ld a,[hli]
	ld c,a
	push hl
	call Logged_0x30FEE
	ld a,h
	cp $40
	jr c,Logged_0x307F5
	ld a,$3F
	ld l,$FF

Logged_0x307F5:
	sla l
	rla
	sla l
	rla
	and a
	jr nz,Logged_0x307FF
	inc a

Logged_0x307FF:
	pop hl
	ld [hl],a
	ret

UnknownData_0x30802:
INCBIN "baserom.gbc", $30802, $30823 - $30802
	ld bc,$0012
	jp Logged_0x3095C

UnknownData_0x30829:
INCBIN "baserom.gbc", $30829, $30837 - $30829
	ld a,[$D01F]
	inc de
	cp $28
	jr z,Logged_0x30867
	call Logged_0x30872
	ld a,[$D010]
	add a,$0C
	ld c,a
	ld a,[$D011]
	adc a,$00
	ld b,a
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	ld a,[$D019]
	res 4,a
	ld [$D019],a
	jp Logged_0x30584

Logged_0x30867:
	ld a,[$D019]
	set 4,a
	ld [$D019],a
	jp Logged_0x30584

Logged_0x30872:
	ld l,a
	ld h,$00
	add hl,hl
	ld c,l
	ld b,h
	add hl,hl
	add hl,bc
	ld bc,$51C4
	add hl,bc
	ret
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$0019
	add hl,bc
	ld a,[$D01F]
	inc de
	rlca
	sub $80
	ld [hli],a
	ld b,a
	ld a,[hli]
	ld c,a

Logged_0x30896:
	push hl
	sla b
	jr c,Logged_0x308A2
	call Logged_0x30FEE
	ld c,l
	ld b,h
	jr Logged_0x308AF

Logged_0x308A2:
	ld a,b
	cpl
	ld b,a
	call Logged_0x30FEE
	dec hl
	ld a,l
	cpl
	ld c,a
	ld a,h
	cpl
	ld b,a

Logged_0x308AF:
	pop hl
	ld a,c
	ld [hli],a
	ld [hl],b
	ld a,[$D019]
	set 2,a
	ld [$D019],a
	jp Logged_0x30584
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$001A
	add hl,bc
	ld a,[$D01F]
	inc de
	ld [hld],a
	ld c,a
	ld a,[hli]
	ld b,a
	inc hl
	jr Logged_0x30896
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$001F
	add hl,bc
	ld a,[$D01F]
	inc de
	ld [hli],a
	sla a
	jr nz,Logged_0x308EE
	ccf
	rra
	rra
	ld [hl],a

Logged_0x308EE:
	jp Logged_0x30584

UnknownData_0x308F1:
INCBIN "baserom.gbc", $308F1, $3090E - $308F1
	ld bc,$002A
	jr Logged_0x3095C
	ld a,[$D019]
	set 1,a
	ld [$D019],a
	ld bc,$0015
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	add hl,bc
	ld a,[$D01F]
	inc de
	rlca
	ld [hl],a
	jp Logged_0x30584
	ld a,[$D03C]
	set 1,a
	ld [$D03C],a
	ld bc,$0016
	jp Logged_0x304BC

UnknownData_0x3093E:
INCBIN "baserom.gbc", $3093E, $30959 - $3093E
	ld bc,$0021

Logged_0x3095C:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	add hl,bc
	ld a,[$D01F]
	inc de
	ld [hl],a
	jp Logged_0x30584
	ld a,[$D019]
	or $07
	ld [$D019],a
	ld bc,$0023
	jr Logged_0x3095C

UnknownData_0x3097A:
INCBIN "baserom.gbc", $3097A, $30A10 - $3097A
	ld b,$00
	jr Logged_0x30A1F

Logged_0x30A14:
	sub $CF
	add a,$2B
	ld l,a
	ld a,$00
	adc a,$50
	ld h,a
	ld b,[hl]

Logged_0x30A1F:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld a,b
	ld bc,$000B
	add hl,bc
	ld [hld],a
	ld b,$00
	ld a,[$D01F]
	jr Logged_0x30A39

Logged_0x30A34:
	inc de
	call Logged_0x3FAA
	ld a,c

Logged_0x30A39:
	bit 7,a
	jr nz,Logged_0x30A68
	cp $24
	jr nc,Logged_0x30A50
	cp $20
	jr c,Logged_0x30A5A
	bit 5,b
	jr nz,Logged_0x30A68
	set 5,b
	inc hl
	add a,[hl]
	ld [hld],a
	jr Logged_0x30A34

Logged_0x30A50:
	bit 7,b
	jr nz,Logged_0x30A68
	set 7,b
	dec hl
	ld [hli],a
	jr Logged_0x30A34

Logged_0x30A5A:
	bit 6,b
	jr nz,Logged_0x30A68
	set 6,b
	rlca
	rlca
	rlca
	or $07
	ld [hl],a
	jr Logged_0x30A34

Logged_0x30A68:
	push de
	dec hl
	ld a,[hl]
	ld bc,$0009
	add hl,bc
	add a,[hl]
	ld [$D03A],a
	ld [$D03B],a
	ld bc,$0018
	add hl,bc
	ld a,[hli]
	ld [hld],a
	ld bc,$FFE2
	add hl,bc
	ld a,[$D019]
	bit 4,a
	jr z,Logged_0x30AA5
	push hl
	ld e,l
	ld d,h
	ld a,[$D03A]
	add a,$04
	call Logged_0x30872
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	ld a,[hl]
	ld [$D03B],a
	pop hl

Logged_0x30AA5:
	ld a,[hl]
	cp $10
	jr nc,Logged_0x30AB8
	cp $08
	jr nc,Logged_0x30AB3
	call Logged_0x3016F
	jr Logged_0x30AC4

Logged_0x30AB3:
	call Logged_0x30178
	jr Logged_0x30AC4

Logged_0x30AB8:
	cp $40
	jr nc,Logged_0x30AC1
	call Logged_0x30181
	jr Logged_0x30AC4

Logged_0x30AC1:
	call Logged_0x3018A

Logged_0x30AC4:
	ld a,[$D00F]
	ld hl,$D000
	bit 5,[hl]
	jr z,Logged_0x30AD0
	set 7,a

Logged_0x30AD0:
	ld [$D039],a
	ld e,a
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$0008
	add hl,bc
	ld a,[hl]
	ld [$D038],a
	ld d,a
	ld a,[$D013]
	ld l,a
	ld a,[$D014]
	ld h,a
	ld a,[hli]
	and a
	jr z,Logged_0x30B01
	bit 5,a
	jr nz,Logged_0x30AF7
	jr Logged_0x30B01

Logged_0x30AF7:
	ld a,[hli]
	cp d
	jr c,Logged_0x30B01
	jr nz,Logged_0x30B49
	ld a,e
	cp [hl]
	jr c,Logged_0x30B49

Logged_0x30B01:
	call Logged_0x30FBB
	ld a,[$D010]
	ld e,a
	ld a,[$D011]
	ld d,a
	ld a,[$D013]
	ld l,a
	ld a,[$D014]
	ld h,a
	ld a,$F0
	ld [hli],a
	ld a,[$D038]
	ld [hli],a
	ld a,[$D039]
	ld [hli],a
	ld a,[$D03A]
	ld [hli],a
	ld a,e
	ld [hli],a
	ld a,d
	ld [hli],a
	ld a,$0A
	add a,e
	ld e,a
	ld a,$00
	adc a,d
	ld d,a
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	xor a
	ld [hli],a
	ld a,[$D03B]
	ld [hl],a

Logged_0x30B49:
	pop de
	jp Logged_0x30584
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$0009
	add hl,bc
	ld a,[$D01F]
	bit 7,a
	jr nz,Logged_0x30B66
	cp $24
	jr c,Logged_0x30B66
	inc de
	ld [hl],a

Logged_0x30B66:
	ld a,[hl]
	ld bc,$0009
	add hl,bc
	add a,[hl]
	ld [$D03A],a
	push de
	call Logged_0x30193
	ld a,[$D00F]
	ld hl,$D000
	bit 5,[hl]
	jr z,Logged_0x30B7F
	set 7,a

Logged_0x30B7F:
	ld e,a
	ld a,[$D03A]
	ld d,a

Logged_0x30B84:
	ld a,[$D013]
	ld l,a
	ld a,[$D014]
	ld h,a
	ld a,[hli]
	bit 5,a
	jr z,Logged_0x30BA7
	inc hl
	ld a,[hli]
	cp e
	jr nz,Logged_0x30BA7
	ld a,[hl]
	cp d
	jr nz,Logged_0x30BA7
	ld bc,$0004
	add hl,bc
	ld a,[hl]
	and a
	jr nz,Logged_0x30BA7
	call Logged_0x30BE3
	jr Logged_0x30BAC

Logged_0x30BA7:
	call Logged_0x301A4
	jr nz,Logged_0x30B84

Logged_0x30BAC:
	pop de
	jp Logged_0x30584

Logged_0x30BB0:
	ld a,[$D013]
	ld l,a
	ld a,[$D014]
	ld h,a
	bit 7,[hl]
	ret z
	inc hl
	inc hl
	bit 7,[hl]
	ret z
	jr Logged_0x30BD2

Logged_0x30BC2:
	ld a,[$D013]
	ld l,a
	ld a,[$D014]
	ld h,a
	bit 7,[hl]
	ret z
	inc hl
	inc hl
	bit 7,[hl]
	ret nz

Logged_0x30BD2:
	inc hl
	inc hl
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ld a,[de]
	cp $C0
	jr c,Logged_0x30BF2
	inc hl
	ld a,[hl]
	and a
	ret z
	dec [hl]
	ret nz

Logged_0x30BE3:
	ld bc,$FFF9
	add hl,bc
	ld a,[hl]
	bit 6,a
	jr nz,Logged_0x30BF6
	or $50
	and $DF
	ld [hl],a
	ret

Logged_0x30BF2:
	ld bc,$FFFA
	add hl,bc

Logged_0x30BF6:
	xor a
	ld [hl],a
	jp Logged_0x30FBB

Logged_0x30BFB:
	ld a,[$D013]
	ld l,a
	ld a,[$D014]
	ld h,a
	ld a,[hl]
	bit 7,a
	ret z
	ld b,a
	push hl
	ld de,$0004
	add hl,de
	ld a,[hli]
	ld [$D010],a
	ld e,a
	ld a,[hli]
	ld [$D011],a
	ld d,a
	ld a,[de]
	cp $C0
	jr nc,Logged_0x30C1F
	pop hl
	jr Logged_0x30BF6

Logged_0x30C1F:
	ld [$D019],a
	bit 6,b
	jr nz,Logged_0x30C46
	ld de,$000C
	add hl,de
	ld a,[$D01A]
	and a
	jr nz,Logged_0x30C31
	inc [hl]

Logged_0x30C31:
	inc [hl]
	pop hl
	bit 5,b
	jr z,Logged_0x30C3E
	bit 4,b
	jr nz,Logged_0x30C95
	jp Logged_0x30CE9

Logged_0x30C3E:
	bit 4,b
	jp nz,Logged_0x30D22
	jp Unknown_0x30D70

Logged_0x30C46:
	pop hl
	res 6,[hl]
	bit 5,[hl]
	jr z,Logged_0x30C76
	push hl
	call Logged_0x30E32
	pop hl
	ld a,[$D019]
	or $07
	ld [$D019],a
	call Logged_0x30DC6
	ld bc,$000B
	add hl,bc
	ld a,[hl]
	ld bc,$0006
	add hl,bc
	swap a
	cpl
	rrca
	and $07
	jr z,Logged_0x30CBA
	or $08
	ld [hli],a
	xor a
	ld [hli],a
	jp Logged_0x30D9D

Logged_0x30C76:
	ld bc,$000C
	add hl,bc
	ld b,[hl]
	ld de,$0005
	add hl,de
	ld a,[hl]
	and $F0
	jp z,Logged_0x30D3B
	ld c,a
	ld a,b
	cpl
	rrca
	and $07
	jp z,Logged_0x30D3B
	or c
	ld [hli],a
	xor a
	ld [hli],a
	jp Logged_0x30D95

Logged_0x30C95:
	ld a,[$D019]
	bit 1,a
	call nz,Logged_0x30DC6
	ld bc,$0011
	add hl,bc
	ld a,[hli]
	and $07
	dec a
	cp [hl]
	jr nc,Logged_0x30CB3
	xor a
	ld [hld],a
	ld a,[hl]
	add a,$10
	jr c,Logged_0x30CBA
	call Logged_0x30E1B
	ld [hli],a

Logged_0x30CB3:
	dec hl
	ld a,[hld]
	cp [hl]
	jp c,Logged_0x30D84
	inc hl

Logged_0x30CBA:
	ld bc,$FFFA
	add hl,bc
	ld b,[hl]
	ld de,$0005
	add hl,de
	ld c,[hl]
	push bc
	ld bc,$FFF0
	add hl,bc
	res 4,[hl]
	call Logged_0x30DEB
	ld d,a
	ld bc,$0011
	add hl,bc
	pop bc
	ld a,b
	cpl
	rrca
	and $07
	jr nz,Logged_0x30CE2
	call Logged_0x30DBA
	jr z,Logged_0x30D3B
	ld a,d
	ld c,d

Logged_0x30CE2:
	or c
	ld [hli],a
	xor a
	ld [hli],a
	jp Logged_0x30D95

Logged_0x30CE9:
	ld a,[$D019]
	bit 1,a
	call nz,Logged_0x30DEB
	ld bc,$0011
	add hl,bc
	ld a,[hli]
	and $07
	jr z,Logged_0x30D1B
	dec a
	cp [hl]
	jr nc,Logged_0x30D09
	xor a
	ld [hld],a
	ld a,[hl]
	sub $10
	jr c,Logged_0x30D11
	call Logged_0x30E1B
	ld [hli],a

Logged_0x30D09:
	dec hl
	dec hl
	ld a,[hli]
	or $0F
	cp [hl]
	jr c,Logged_0x30D84

Logged_0x30D11:
	call Logged_0x30DBA
	jr z,Logged_0x30D3B
	dec hl

Logged_0x30D17:
	ld a,[hli]
	ld [hl],a
	jr Logged_0x30D95

Logged_0x30D1B:
	dec hl
	ld a,[hld]
	xor [hl]
	jr nz,Logged_0x30D17
	jr Logged_0x30D9D

Logged_0x30D22:
	ld bc,$0011
	add hl,bc
	ld a,[hli]
	and $07
	dec a
	cp [hl]
	jr nc,Logged_0x30D84
	xor a
	ld [hld],a
	ld a,[hl]
	sub $10
	jr c,Logged_0x30D3B
	call Logged_0x30E1B
	ld [hl],a
	jr Logged_0x30D84

UnknownData_0x30D3A:
INCBIN "baserom.gbc", $30D3A, $30D3B - $30D3A

Logged_0x30D3B:
	push hl
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$002F
	add hl,bc
	ld b,[hl]
	ld de,$FFF8
	add hl,de
	ld a,[hli]
	ld c,a
	ld d,[hl]
	pop hl
	ld a,b
	and a
	jr z,Logged_0x30D77
	ld a,c
	and a
	jr z,Logged_0x30D77
	ld a,d
	and a
	jr z,Logged_0x30D77
	call Logged_0x31012
	add a,$0F
	and $F0
	ld [hli],a
	ld [hl],d
	ld bc,$FFEE
	add hl,bc
	ld a,[hl]
	and $8F
	ld [hl],a
	jr Logged_0x30D95

Unknown_0x30D70:
	ld bc,$0012
	add hl,bc
	dec [hl]
	jr nz,Logged_0x30D9D

Logged_0x30D77:
	ld a,[$D013]
	ld l,a
	ld a,[$D014]
	ld h,a
	xor a
	ld [hl],a
	jp Logged_0x30FBB

Logged_0x30D84:
	ld a,[$D015]
	cp $1C
	jr z,Logged_0x30D9D
	ld a,[$D019]
	res 1,a
	ld [$D019],a
	jr Logged_0x30D9D

Logged_0x30D95:
	ld a,[$D019]
	set 1,a
	ld [$D019],a

Logged_0x30D9D:
	ld a,[$D019]
	bit 2,a
	jr z,Logged_0x30DAA
	call Logged_0x30EB1
	ld a,[$D019]

Logged_0x30DAA:
	bit 0,a
	jr z,Logged_0x30DB4
	call Logged_0x30F36
	ld a,[$D019]

Logged_0x30DB4:
	bit 1,a
	ret z
	jp Logged_0x30F7E

Logged_0x30DBA:
	ld bc,$FFFB
	add hl,bc
	ld a,[hl]
	ld bc,$0005
	add hl,bc
	and $F0
	ret

Logged_0x30DC6:
	push hl
	ld bc,$0006
	add hl,bc
	ld c,[hl]
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld de,$002F
	add hl,de
	ld b,[hl]
	call Logged_0x31012
	add a,$0F
	and $F0
	pop hl
	ld de,$0010
	add hl,de
	ld [hl],a
	ld de,$FFF0
	add hl,de
	ret

Logged_0x30DEB:
	push hl
	ld bc,$000C
	add hl,bc
	ld b,[hl]
	ld de,$FFFA
	add hl,de
	ld c,[hl]
	call Logged_0x31012
	add a,$0F
	ld c,a
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld de,$002F
	add hl,de
	ld b,[hl]
	call Logged_0x31012
	add a,$0F
	and $F0
	pop hl
	ld de,$0010
	add hl,de
	ld [hl],a
	ld de,$FFF0
	add hl,de
	ret

Logged_0x30E1B:
	ld b,a
	ld a,[$D015]
	cp $1C
	ld a,b
	ret nz
	xor [hl]
	and $C0
	jr z,Logged_0x30E30
	ld a,[$D019]
	set 1,a
	ld [$D019],a

Logged_0x30E30:
	ld a,b
	ret

Logged_0x30E32:
	ld a,[$D013]
	ld l,a
	ld a,[$D014]
	ld h,a
	ld bc,$0008
	add hl,bc
	ld a,[$D015]
	ld c,a
	cp $1C
	jr c,Logged_0x30E64
	jr z,Logged_0x30E82
	ld a,[hli]
	rlca
	rlca
	rlca
	and $08
	ld b,a
	inc c
	ld a,[$FF00+c]
	and $F7
	or b
	ld [$FF00+c],a
	ld a,[hl]
	and a
	jr z,Logged_0x30E5F
	cpl
	inc a
	ld [$FF00+$20],a
	ld a,$40

Logged_0x30E5F:
	or $80
	ld [$FF00+$23],a
	ret

Logged_0x30E64:
	ld a,[hli]
	rrca
	rrca
	and $C0
	ld b,a
	ld a,[hli]
	and a
	jr z,Logged_0x30E76
	cpl
	inc a
	and $3F
	or b
	ld b,a
	ld a,$40

Logged_0x30E76:
	inc c
	inc c
	ld [$FF00+c],a
	dec c
	dec c
	dec c
	ld a,b
	ld [$FF00+c],a
	dec c
	ld a,[hl]
	ld [$FF00+c],a
	ret

Logged_0x30E82:
	ld a,[hli]
	sub $10
	ld b,a
	ld a,[hl]
	and a
	jr z,Logged_0x30E90
	cpl
	inc a
	ld [$FF00+$1B],a
	ld a,$40

Logged_0x30E90:
	ld [$FF00+$1E],a
	ld a,[$D01D]
	cp b
	ret z
	ld a,b
	ld [$D01D],a
	ld l,b
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld bc,$54A6
	add hl,bc
	ld c,$30
	ld b,$10

Logged_0x30EAA:
	ld a,[hli]
	ld [$FF00+c],a
	inc c
	dec b
	jr nz,Logged_0x30EAA
	ret

Logged_0x30EB1:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$002C
	add hl,bc
	ld a,[hli]
	ld c,a
	ld b,[hl]
	ld a,[$D013]
	ld l,a
	ld a,[$D014]
	ld h,a
	ld de,$000E
	add hl,de
	ld a,[hl]
	add a,b
	ld b,a
	ld a,[$D015]
	cp $1C
	jr c,Logged_0x30EDC
	jr nz,Logged_0x30F14
	ld a,b
	add a,$0C
	ld b,a

Logged_0x30EDC:
	push hl
	ld a,b
	call Logged_0x30FD1
	ld b,a
	call Logged_0x30FEE
	ld bc,$00FF
	add hl,bc
	ld l,h
	ld h,$00
	add hl,de
	ld a,[$D015]
	ld c,a
	inc c
	ld a,l
	ld [$FF00+c],a
	inc c
	ld a,[$FF00+c]
	and $40
	jr z,Logged_0x30EFE
	or h
	ld [$FF00+c],a
	jr Logged_0x30F0B

Logged_0x30EFE:
	or h
	ld [$FF00+c],a
	ld b,a
	ld a,[$D015]
	ld c,a
	dec c
	ld a,[$FF00+c]
	and $C0
	ld [$FF00+c],a
	ld a,b

Logged_0x30F0B:
	pop hl
	ld bc,$0005
	add hl,bc
	or $80
	ld [hl],a
	ret

Logged_0x30F14:
	ld c,a
	inc c
	ld a,b
	sub $0D
	cpl
	ld b,a
	and $03
	ld d,a
	ld a,b
	cp $C0
	jr c,Logged_0x30F2B
	and $3C
	rlca
	rlca
	or d
	or $04
	ld d,a

Logged_0x30F2B:
	ld a,[$FF00+c]
	and $08
	or d
	ld [$FF00+c],a
	inc c
	ld a,[$FF00+c]
	or $80
	ld [$FF00+c],a
	ret

Logged_0x30F36:
	ld a,[$D010]
	ld l,a
	ld a,[$D011]
	ld h,a
	ld bc,$002E
	add hl,bc
	ld a,[$D015]
	cp $17
	jr c,Logged_0x30F54
	jr z,Logged_0x30F59
	cp $21
	jr c,Logged_0x30F5E
	ld de,$7788
	jr Logged_0x30F61

Logged_0x30F54:
	ld de,$EE11
	jr Logged_0x30F61

Logged_0x30F59:
	ld de,$DD22
	jr Logged_0x30F61

Logged_0x30F5E:
	ld de,$BB44

Logged_0x30F61:
	bit 7,[hl]
	jr nz,Unknown_0x30F6D
	bit 6,[hl]
	jr z,Logged_0x30F77
	ld a,$0F
	jr Unknown_0x30F75

Unknown_0x30F6D:
	bit 6,[hl]
	jr nz,Logged_0x30F77
	ld a,$F0
	jr Unknown_0x30F75

Unknown_0x30F75:
	and e
	ld e,a

Logged_0x30F77:
	ld c,$25
	ld a,[$FF00+c]
	and d
	or e
	ld [$FF00+c],a
	ret

Logged_0x30F7E:
	ld a,[$D013]
	ld l,a
	ld a,[$D014]
	ld h,a
	ld bc,$0011
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[$D015]
	ld c,a
	cp $1C
	jr c,Logged_0x30F9F
	jr z,Logged_0x30FA7
	ld a,b
	ld [$FF00+c],a
	ld a,[$FF00+$23]
	or $80
	ld [$FF00+$23],a
	ret

Logged_0x30F9F:
	ld a,b
	ld [$FF00+c],a
	inc c
	inc c
	inc hl
	ld a,[hl]
	ld [$FF00+c],a
	ret

Logged_0x30FA7:
	ld a,b
	sub $40
	xor $C0
	rrca
	ld [$FF00+c],a
	ld a,[$FF00+$1A]
	rla
	ret c
	ld a,$80
	ld [$FF00+$1A],a
	inc hl
	ld a,[hl]
	ld [$FF00+$1E],a
	ret

Logged_0x30FBB:
	ld a,[$D015]
	ld c,a
	cp $1C
	jr z,Logged_0x30FCC
	ld a,$08
	ld [$FF00+c],a
	inc c
	inc c
	ld a,$80
	ld [$FF00+c],a
	ret

Logged_0x30FCC:
	ld a,$00
	ld [$FF00+$1A],a
	ret

Logged_0x30FD1:
	sub $24
	jr nc,Logged_0x30FD6
	xor a

Logged_0x30FD6:
	cp $78
	jr c,Logged_0x30FDC
	ld a,$77

Logged_0x30FDC:
	ld d,$00
	ld e,a
	add a,e
	add a,e
	rl d
	ld e,a
	ld hl,$505C
	add hl,de
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ld a,[hl]
	ret

Logged_0x30FEE:
	ld h,b
	ld l,$00
	ld b,l
	add hl,hl
	jr nc,Logged_0x30FF6
	add hl,bc

Logged_0x30FF6:
	add hl,hl
	jr nc,Logged_0x30FFA
	add hl,bc

Logged_0x30FFA:
	add hl,hl
	jr nc,Logged_0x30FFE
	add hl,bc

Logged_0x30FFE:
	add hl,hl
	jr nc,Logged_0x31002
	add hl,bc

Logged_0x31002:
	add hl,hl
	jr nc,Logged_0x31006
	add hl,bc

Logged_0x31006:
	add hl,hl
	jr nc,Logged_0x3100A
	add hl,bc

Logged_0x3100A:
	add hl,hl
	jr nc,Logged_0x3100E
	add hl,bc

Logged_0x3100E:
	add hl,hl
	ret nc
	add hl,bc
	ret

Logged_0x31012:
	ld a,c
	and $F0
	swap a
	ld c,a
	ld a,b
	and $F0
	add a,a
	jr nc,Logged_0x3101F
	add a,c

Logged_0x3101F:
	add a,a
	jr nc,Logged_0x31023
	add a,c

Logged_0x31023:
	add a,a
	jr nc,Logged_0x31027
	add a,c

Logged_0x31027:
	add a,a
	ret nc
	add a,c
	ret

UnknownData_0x3102B:
INCBIN "baserom.gbc", $3102B, $3102C - $3102B

LoggedData_0x3102C:
INCBIN "baserom.gbc", $3102C, $3103C - $3102C

UnknownData_0x3103C:
INCBIN "baserom.gbc", $3103C, $3103D - $3103C

LoggedData_0x3103D:
INCBIN "baserom.gbc", $3103D, $31042 - $3103D

UnknownData_0x31042:
INCBIN "baserom.gbc", $31042, $31043 - $31042

LoggedData_0x31043:
INCBIN "baserom.gbc", $31043, $31055 - $31043

UnknownData_0x31055:
INCBIN "baserom.gbc", $31055, $31056 - $31055

LoggedData_0x31056:
INCBIN "baserom.gbc", $31056, $31143 - $31056

UnknownData_0x31143:
INCBIN "baserom.gbc", $31143, $31155 - $31143

LoggedData_0x31155:
INCBIN "baserom.gbc", $31155, $31158 - $31155

UnknownData_0x31158:
INCBIN "baserom.gbc", $31158, $31200 - $31158

LoggedData_0x31200:
INCBIN "baserom.gbc", $31200, $31205 - $31200

UnknownData_0x31205:
INCBIN "baserom.gbc", $31205, $31206 - $31205

LoggedData_0x31206:
INCBIN "baserom.gbc", $31206, $3120B - $31206

UnknownData_0x3120B:
INCBIN "baserom.gbc", $3120B, $31212 - $3120B

LoggedData_0x31212:
INCBIN "baserom.gbc", $31212, $31217 - $31212

UnknownData_0x31217:
INCBIN "baserom.gbc", $31217, $3121E - $31217

LoggedData_0x3121E:
INCBIN "baserom.gbc", $3121E, $31223 - $3121E

UnknownData_0x31223:
INCBIN "baserom.gbc", $31223, $31224 - $31223

LoggedData_0x31224:
INCBIN "baserom.gbc", $31224, $31229 - $31224

UnknownData_0x31229:
INCBIN "baserom.gbc", $31229, $3122A - $31229

LoggedData_0x3122A:
INCBIN "baserom.gbc", $3122A, $3122F - $3122A

UnknownData_0x3122F:
INCBIN "baserom.gbc", $3122F, $31230 - $3122F

LoggedData_0x31230:
INCBIN "baserom.gbc", $31230, $31235 - $31230

UnknownData_0x31235:
INCBIN "baserom.gbc", $31235, $3123C - $31235

LoggedData_0x3123C:
INCBIN "baserom.gbc", $3123C, $31241 - $3123C

UnknownData_0x31241:
INCBIN "baserom.gbc", $31241, $31242 - $31241

LoggedData_0x31242:
INCBIN "baserom.gbc", $31242, $31247 - $31242

UnknownData_0x31247:
INCBIN "baserom.gbc", $31247, $31248 - $31247

LoggedData_0x31248:
INCBIN "baserom.gbc", $31248, $3124D - $31248

UnknownData_0x3124D:
INCBIN "baserom.gbc", $3124D, $3124E - $3124D

LoggedData_0x3124E:
INCBIN "baserom.gbc", $3124E, $31253 - $3124E

UnknownData_0x31253:
INCBIN "baserom.gbc", $31253, $31254 - $31253

LoggedData_0x31254:
INCBIN "baserom.gbc", $31254, $31259 - $31254

UnknownData_0x31259:
INCBIN "baserom.gbc", $31259, $3125A - $31259

LoggedData_0x3125A:
INCBIN "baserom.gbc", $3125A, $3125F - $3125A

UnknownData_0x3125F:
INCBIN "baserom.gbc", $3125F, $31260 - $3125F

LoggedData_0x31260:
INCBIN "baserom.gbc", $31260, $31265 - $31260

UnknownData_0x31265:
INCBIN "baserom.gbc", $31265, $31266 - $31265

LoggedData_0x31266:
INCBIN "baserom.gbc", $31266, $3126B - $31266

UnknownData_0x3126B:
INCBIN "baserom.gbc", $3126B, $3126C - $3126B

LoggedData_0x3126C:
INCBIN "baserom.gbc", $3126C, $31271 - $3126C

UnknownData_0x31271:
INCBIN "baserom.gbc", $31271, $31296 - $31271

LoggedData_0x31296:
INCBIN "baserom.gbc", $31296, $3129B - $31296

UnknownData_0x3129B:
INCBIN "baserom.gbc", $3129B, $312A2 - $3129B

LoggedData_0x312A2:
INCBIN "baserom.gbc", $312A2, $312A7 - $312A2

UnknownData_0x312A7:
INCBIN "baserom.gbc", $312A7, $312B4 - $312A7

LoggedData_0x312B4:
INCBIN "baserom.gbc", $312B4, $312D2 - $312B4

UnknownData_0x312D2:
INCBIN "baserom.gbc", $312D2, $312D8 - $312D2

LoggedData_0x312D8:
INCBIN "baserom.gbc", $312D8, $312DE - $312D8

UnknownData_0x312DE:
INCBIN "baserom.gbc", $312DE, $312E4 - $312DE

LoggedData_0x312E4:
INCBIN "baserom.gbc", $312E4, $312EA - $312E4

UnknownData_0x312EA:
INCBIN "baserom.gbc", $312EA, $312F0 - $312EA

LoggedData_0x312F0:
INCBIN "baserom.gbc", $312F0, $312F5 - $312F0

UnknownData_0x312F5:
INCBIN "baserom.gbc", $312F5, $312F6 - $312F5

LoggedData_0x312F6:
INCBIN "baserom.gbc", $312F6, $312FB - $312F6

UnknownData_0x312FB:
INCBIN "baserom.gbc", $312FB, $312FC - $312FB

LoggedData_0x312FC:
INCBIN "baserom.gbc", $312FC, $31301 - $312FC

UnknownData_0x31301:
INCBIN "baserom.gbc", $31301, $31302 - $31301

LoggedData_0x31302:
INCBIN "baserom.gbc", $31302, $31307 - $31302

UnknownData_0x31307:
INCBIN "baserom.gbc", $31307, $31308 - $31307

LoggedData_0x31308:
INCBIN "baserom.gbc", $31308, $3130D - $31308

UnknownData_0x3130D:
INCBIN "baserom.gbc", $3130D, $3130E - $3130D

LoggedData_0x3130E:
INCBIN "baserom.gbc", $3130E, $31313 - $3130E

UnknownData_0x31313:
INCBIN "baserom.gbc", $31313, $31314 - $31313

LoggedData_0x31314:
INCBIN "baserom.gbc", $31314, $31319 - $31314

UnknownData_0x31319:
INCBIN "baserom.gbc", $31319, $3131A - $31319

LoggedData_0x3131A:
INCBIN "baserom.gbc", $3131A, $3131F - $3131A

UnknownData_0x3131F:
INCBIN "baserom.gbc", $3131F, $31320 - $3131F

LoggedData_0x31320:
INCBIN "baserom.gbc", $31320, $31325 - $31320

UnknownData_0x31325:
INCBIN "baserom.gbc", $31325, $31326 - $31325

LoggedData_0x31326:
INCBIN "baserom.gbc", $31326, $3132B - $31326

UnknownData_0x3132B:
INCBIN "baserom.gbc", $3132B, $3132C - $3132B

LoggedData_0x3132C:
INCBIN "baserom.gbc", $3132C, $31331 - $3132C

UnknownData_0x31331:
INCBIN "baserom.gbc", $31331, $31332 - $31331

LoggedData_0x31332:
INCBIN "baserom.gbc", $31332, $31337 - $31332

UnknownData_0x31337:
INCBIN "baserom.gbc", $31337, $31338 - $31337

LoggedData_0x31338:
INCBIN "baserom.gbc", $31338, $3133D - $31338

UnknownData_0x3133D:
INCBIN "baserom.gbc", $3133D, $3133E - $3133D

LoggedData_0x3133E:
INCBIN "baserom.gbc", $3133E, $31343 - $3133E

UnknownData_0x31343:
INCBIN "baserom.gbc", $31343, $31344 - $31343

LoggedData_0x31344:
INCBIN "baserom.gbc", $31344, $31349 - $31344

UnknownData_0x31349:
INCBIN "baserom.gbc", $31349, $3134A - $31349

LoggedData_0x3134A:
INCBIN "baserom.gbc", $3134A, $3134F - $3134A

UnknownData_0x3134F:
INCBIN "baserom.gbc", $3134F, $31350 - $3134F

LoggedData_0x31350:
INCBIN "baserom.gbc", $31350, $31355 - $31350

UnknownData_0x31355:
INCBIN "baserom.gbc", $31355, $31356 - $31355

LoggedData_0x31356:
INCBIN "baserom.gbc", $31356, $3135B - $31356

UnknownData_0x3135B:
INCBIN "baserom.gbc", $3135B, $3135C - $3135B

LoggedData_0x3135C:
INCBIN "baserom.gbc", $3135C, $31361 - $3135C

UnknownData_0x31361:
INCBIN "baserom.gbc", $31361, $31362 - $31361

LoggedData_0x31362:
INCBIN "baserom.gbc", $31362, $31367 - $31362

UnknownData_0x31367:
INCBIN "baserom.gbc", $31367, $31368 - $31367

LoggedData_0x31368:
INCBIN "baserom.gbc", $31368, $3136D - $31368

UnknownData_0x3136D:
INCBIN "baserom.gbc", $3136D, $3136E - $3136D

LoggedData_0x3136E:
INCBIN "baserom.gbc", $3136E, $31373 - $3136E

UnknownData_0x31373:
INCBIN "baserom.gbc", $31373, $31374 - $31373

LoggedData_0x31374:
INCBIN "baserom.gbc", $31374, $31379 - $31374

UnknownData_0x31379:
INCBIN "baserom.gbc", $31379, $3137A - $31379

LoggedData_0x3137A:
INCBIN "baserom.gbc", $3137A, $3137F - $3137A

UnknownData_0x3137F:
INCBIN "baserom.gbc", $3137F, $31380 - $3137F

LoggedData_0x31380:
INCBIN "baserom.gbc", $31380, $31385 - $31380

UnknownData_0x31385:
INCBIN "baserom.gbc", $31385, $31386 - $31385

LoggedData_0x31386:
INCBIN "baserom.gbc", $31386, $3138B - $31386

UnknownData_0x3138B:
INCBIN "baserom.gbc", $3138B, $313A4 - $3138B

LoggedData_0x313A4:
INCBIN "baserom.gbc", $313A4, $313A9 - $313A4

UnknownData_0x313A9:
INCBIN "baserom.gbc", $313A9, $313AA - $313A9

LoggedData_0x313AA:
INCBIN "baserom.gbc", $313AA, $313AF - $313AA

UnknownData_0x313AF:
INCBIN "baserom.gbc", $313AF, $313B0 - $313AF

LoggedData_0x313B0:
INCBIN "baserom.gbc", $313B0, $313B5 - $313B0

UnknownData_0x313B5:
INCBIN "baserom.gbc", $313B5, $313B6 - $313B5

LoggedData_0x313B6:
INCBIN "baserom.gbc", $313B6, $313BB - $313B6

UnknownData_0x313BB:
INCBIN "baserom.gbc", $313BB, $313C2 - $313BB

LoggedData_0x313C2:
INCBIN "baserom.gbc", $313C2, $313C7 - $313C2

UnknownData_0x313C7:
INCBIN "baserom.gbc", $313C7, $313D4 - $313C7

LoggedData_0x313D4:
INCBIN "baserom.gbc", $313D4, $313D9 - $313D4

UnknownData_0x313D9:
INCBIN "baserom.gbc", $313D9, $313E0 - $313D9

LoggedData_0x313E0:
INCBIN "baserom.gbc", $313E0, $313E5 - $313E0

UnknownData_0x313E5:
INCBIN "baserom.gbc", $313E5, $313EC - $313E5

LoggedData_0x313EC:
INCBIN "baserom.gbc", $313EC, $313F1 - $313EC

UnknownData_0x313F1:
INCBIN "baserom.gbc", $313F1, $313F2 - $313F1

LoggedData_0x313F2:
INCBIN "baserom.gbc", $313F2, $313F7 - $313F2

UnknownData_0x313F7:
INCBIN "baserom.gbc", $313F7, $313F8 - $313F7

LoggedData_0x313F8:
INCBIN "baserom.gbc", $313F8, $313FD - $313F8

UnknownData_0x313FD:
INCBIN "baserom.gbc", $313FD, $31404 - $313FD

LoggedData_0x31404:
INCBIN "baserom.gbc", $31404, $31409 - $31404

UnknownData_0x31409:
INCBIN "baserom.gbc", $31409, $3140A - $31409

LoggedData_0x3140A:
INCBIN "baserom.gbc", $3140A, $3140F - $3140A

UnknownData_0x3140F:
INCBIN "baserom.gbc", $3140F, $31410 - $3140F

LoggedData_0x31410:
INCBIN "baserom.gbc", $31410, $31415 - $31410

UnknownData_0x31415:
INCBIN "baserom.gbc", $31415, $31416 - $31415

LoggedData_0x31416:
INCBIN "baserom.gbc", $31416, $3141B - $31416

UnknownData_0x3141B:
INCBIN "baserom.gbc", $3141B, $3141C - $3141B

LoggedData_0x3141C:
INCBIN "baserom.gbc", $3141C, $31421 - $3141C

UnknownData_0x31421:
INCBIN "baserom.gbc", $31421, $31422 - $31421

LoggedData_0x31422:
INCBIN "baserom.gbc", $31422, $31427 - $31422

UnknownData_0x31427:
INCBIN "baserom.gbc", $31427, $31428 - $31427

LoggedData_0x31428:
INCBIN "baserom.gbc", $31428, $3142D - $31428

UnknownData_0x3142D:
INCBIN "baserom.gbc", $3142D, $31434 - $3142D

LoggedData_0x31434:
INCBIN "baserom.gbc", $31434, $31439 - $31434

UnknownData_0x31439:
INCBIN "baserom.gbc", $31439, $3143A - $31439

LoggedData_0x3143A:
INCBIN "baserom.gbc", $3143A, $3143F - $3143A

UnknownData_0x3143F:
INCBIN "baserom.gbc", $3143F, $31440 - $3143F

LoggedData_0x31440:
INCBIN "baserom.gbc", $31440, $31445 - $31440

UnknownData_0x31445:
INCBIN "baserom.gbc", $31445, $31446 - $31445

LoggedData_0x31446:
INCBIN "baserom.gbc", $31446, $3144B - $31446

UnknownData_0x3144B:
INCBIN "baserom.gbc", $3144B, $3144C - $3144B

LoggedData_0x3144C:
INCBIN "baserom.gbc", $3144C, $31451 - $3144C

UnknownData_0x31451:
INCBIN "baserom.gbc", $31451, $31452 - $31451

LoggedData_0x31452:
INCBIN "baserom.gbc", $31452, $31457 - $31452

UnknownData_0x31457:
INCBIN "baserom.gbc", $31457, $31458 - $31457

LoggedData_0x31458:
INCBIN "baserom.gbc", $31458, $3145D - $31458

UnknownData_0x3145D:
INCBIN "baserom.gbc", $3145D, $3145E - $3145D

LoggedData_0x3145E:
INCBIN "baserom.gbc", $3145E, $31463 - $3145E

UnknownData_0x31463:
INCBIN "baserom.gbc", $31463, $3146A - $31463

LoggedData_0x3146A:
INCBIN "baserom.gbc", $3146A, $3146F - $3146A

UnknownData_0x3146F:
INCBIN "baserom.gbc", $3146F, $3147C - $3146F

LoggedData_0x3147C:
INCBIN "baserom.gbc", $3147C, $31481 - $3147C

UnknownData_0x31481:
INCBIN "baserom.gbc", $31481, $3148E - $31481

LoggedData_0x3148E:
INCBIN "baserom.gbc", $3148E, $31493 - $3148E

UnknownData_0x31493:
INCBIN "baserom.gbc", $31493, $314A0 - $31493

LoggedData_0x314A0:
INCBIN "baserom.gbc", $314A0, $314A5 - $314A0

UnknownData_0x314A5:
INCBIN "baserom.gbc", $314A5, $314B6 - $314A5

LoggedData_0x314B6:
INCBIN "baserom.gbc", $314B6, $314D6 - $314B6

UnknownData_0x314D6:
INCBIN "baserom.gbc", $314D6, $314E6 - $314D6

LoggedData_0x314E6:
INCBIN "baserom.gbc", $314E6, $31506 - $314E6

UnknownData_0x31506:
INCBIN "baserom.gbc", $31506, $31516 - $31506

LoggedData_0x31516:
INCBIN "baserom.gbc", $31516, $31526 - $31516

UnknownData_0x31526:
INCBIN "baserom.gbc", $31526, $31546 - $31526

LoggedData_0x31546:
INCBIN "baserom.gbc", $31546, $31569 - $31546

UnknownData_0x31569:
INCBIN "baserom.gbc", $31569, $3156A - $31569

LoggedData_0x3156A:
INCBIN "baserom.gbc", $3156A, $3156D - $3156A

UnknownData_0x3156D:
INCBIN "baserom.gbc", $3156D, $3156E - $3156D

LoggedData_0x3156E:
INCBIN "baserom.gbc", $3156E, $31571 - $3156E

UnknownData_0x31571:
INCBIN "baserom.gbc", $31571, $31572 - $31571

LoggedData_0x31572:
INCBIN "baserom.gbc", $31572, $31575 - $31572

UnknownData_0x31575:
INCBIN "baserom.gbc", $31575, $31576 - $31575

LoggedData_0x31576:
INCBIN "baserom.gbc", $31576, $31579 - $31576

UnknownData_0x31579:
INCBIN "baserom.gbc", $31579, $3157A - $31579

LoggedData_0x3157A:
INCBIN "baserom.gbc", $3157A, $3157D - $3157A

UnknownData_0x3157D:
INCBIN "baserom.gbc", $3157D, $3157E - $3157D

LoggedData_0x3157E:
INCBIN "baserom.gbc", $3157E, $31581 - $3157E

UnknownData_0x31581:
INCBIN "baserom.gbc", $31581, $31582 - $31581

LoggedData_0x31582:
INCBIN "baserom.gbc", $31582, $31585 - $31582

UnknownData_0x31585:
INCBIN "baserom.gbc", $31585, $31586 - $31585

LoggedData_0x31586:
INCBIN "baserom.gbc", $31586, $31589 - $31586

UnknownData_0x31589:
INCBIN "baserom.gbc", $31589, $3158A - $31589

LoggedData_0x3158A:
INCBIN "baserom.gbc", $3158A, $3158D - $3158A

UnknownData_0x3158D:
INCBIN "baserom.gbc", $3158D, $3158E - $3158D

LoggedData_0x3158E:
INCBIN "baserom.gbc", $3158E, $31591 - $3158E

UnknownData_0x31591:
INCBIN "baserom.gbc", $31591, $31592 - $31591

LoggedData_0x31592:
INCBIN "baserom.gbc", $31592, $31595 - $31592

UnknownData_0x31595:
INCBIN "baserom.gbc", $31595, $31596 - $31595

LoggedData_0x31596:
INCBIN "baserom.gbc", $31596, $31599 - $31596

UnknownData_0x31599:
INCBIN "baserom.gbc", $31599, $3159A - $31599

LoggedData_0x3159A:
INCBIN "baserom.gbc", $3159A, $3159D - $3159A

UnknownData_0x3159D:
INCBIN "baserom.gbc", $3159D, $3159E - $3159D

LoggedData_0x3159E:
INCBIN "baserom.gbc", $3159E, $315A1 - $3159E

UnknownData_0x315A1:
INCBIN "baserom.gbc", $315A1, $315A2 - $315A1

LoggedData_0x315A2:
INCBIN "baserom.gbc", $315A2, $315A5 - $315A2

UnknownData_0x315A5:
INCBIN "baserom.gbc", $315A5, $315A6 - $315A5

LoggedData_0x315A6:
INCBIN "baserom.gbc", $315A6, $315A9 - $315A6

UnknownData_0x315A9:
INCBIN "baserom.gbc", $315A9, $315AA - $315A9

LoggedData_0x315AA:
INCBIN "baserom.gbc", $315AA, $315AD - $315AA

UnknownData_0x315AD:
INCBIN "baserom.gbc", $315AD, $315AE - $315AD

LoggedData_0x315AE:
INCBIN "baserom.gbc", $315AE, $315B1 - $315AE

UnknownData_0x315B1:
INCBIN "baserom.gbc", $315B1, $315B2 - $315B1

LoggedData_0x315B2:
INCBIN "baserom.gbc", $315B2, $315B5 - $315B2

UnknownData_0x315B5:
INCBIN "baserom.gbc", $315B5, $315B6 - $315B5

LoggedData_0x315B6:
INCBIN "baserom.gbc", $315B6, $315B9 - $315B6

UnknownData_0x315B9:
INCBIN "baserom.gbc", $315B9, $315BA - $315B9

LoggedData_0x315BA:
INCBIN "baserom.gbc", $315BA, $315BD - $315BA

UnknownData_0x315BD:
INCBIN "baserom.gbc", $315BD, $315BE - $315BD

LoggedData_0x315BE:
INCBIN "baserom.gbc", $315BE, $315C1 - $315BE

UnknownData_0x315C1:
INCBIN "baserom.gbc", $315C1, $315C2 - $315C1

LoggedData_0x315C2:
INCBIN "baserom.gbc", $315C2, $315C5 - $315C2

UnknownData_0x315C5:
INCBIN "baserom.gbc", $315C5, $315C6 - $315C5

LoggedData_0x315C6:
INCBIN "baserom.gbc", $315C6, $315C9 - $315C6

UnknownData_0x315C9:
INCBIN "baserom.gbc", $315C9, $315CA - $315C9

LoggedData_0x315CA:
INCBIN "baserom.gbc", $315CA, $315CD - $315CA

UnknownData_0x315CD:
INCBIN "baserom.gbc", $315CD, $315CE - $315CD

LoggedData_0x315CE:
INCBIN "baserom.gbc", $315CE, $315D1 - $315CE

UnknownData_0x315D1:
INCBIN "baserom.gbc", $315D1, $315D2 - $315D1

LoggedData_0x315D2:
INCBIN "baserom.gbc", $315D2, $315D5 - $315D2

UnknownData_0x315D5:
INCBIN "baserom.gbc", $315D5, $315D6 - $315D5

LoggedData_0x315D6:
INCBIN "baserom.gbc", $315D6, $315D9 - $315D6

UnknownData_0x315D9:
INCBIN "baserom.gbc", $315D9, $315DA - $315D9

LoggedData_0x315DA:
INCBIN "baserom.gbc", $315DA, $315DD - $315DA

UnknownData_0x315DD:
INCBIN "baserom.gbc", $315DD, $315DE - $315DD

LoggedData_0x315DE:
INCBIN "baserom.gbc", $315DE, $315E1 - $315DE

UnknownData_0x315E1:
INCBIN "baserom.gbc", $315E1, $315E2 - $315E1

LoggedData_0x315E2:
INCBIN "baserom.gbc", $315E2, $315E5 - $315E2

UnknownData_0x315E5:
INCBIN "baserom.gbc", $315E5, $315E6 - $315E5

LoggedData_0x315E6:
INCBIN "baserom.gbc", $315E6, $315E9 - $315E6

UnknownData_0x315E9:
INCBIN "baserom.gbc", $315E9, $315EA - $315E9

LoggedData_0x315EA:
INCBIN "baserom.gbc", $315EA, $315ED - $315EA

UnknownData_0x315ED:
INCBIN "baserom.gbc", $315ED, $315EE - $315ED

LoggedData_0x315EE:
INCBIN "baserom.gbc", $315EE, $315F1 - $315EE

UnknownData_0x315F1:
INCBIN "baserom.gbc", $315F1, $315F2 - $315F1

LoggedData_0x315F2:
INCBIN "baserom.gbc", $315F2, $315F5 - $315F2

UnknownData_0x315F5:
INCBIN "baserom.gbc", $315F5, $315F6 - $315F5

LoggedData_0x315F6:
INCBIN "baserom.gbc", $315F6, $315F9 - $315F6

UnknownData_0x315F9:
INCBIN "baserom.gbc", $315F9, $315FA - $315F9

LoggedData_0x315FA:
INCBIN "baserom.gbc", $315FA, $315FD - $315FA

UnknownData_0x315FD:
INCBIN "baserom.gbc", $315FD, $315FE - $315FD

LoggedData_0x315FE:
INCBIN "baserom.gbc", $315FE, $31601 - $315FE

UnknownData_0x31601:
INCBIN "baserom.gbc", $31601, $31602 - $31601

LoggedData_0x31602:
INCBIN "baserom.gbc", $31602, $31605 - $31602

UnknownData_0x31605:
INCBIN "baserom.gbc", $31605, $31606 - $31605

LoggedData_0x31606:
INCBIN "baserom.gbc", $31606, $31609 - $31606

UnknownData_0x31609:
INCBIN "baserom.gbc", $31609, $3160A - $31609

LoggedData_0x3160A:
INCBIN "baserom.gbc", $3160A, $3160D - $3160A

UnknownData_0x3160D:
INCBIN "baserom.gbc", $3160D, $3160E - $3160D

LoggedData_0x3160E:
INCBIN "baserom.gbc", $3160E, $31611 - $3160E

UnknownData_0x31611:
INCBIN "baserom.gbc", $31611, $31612 - $31611

LoggedData_0x31612:
INCBIN "baserom.gbc", $31612, $31615 - $31612

UnknownData_0x31615:
INCBIN "baserom.gbc", $31615, $31616 - $31615

LoggedData_0x31616:
INCBIN "baserom.gbc", $31616, $31619 - $31616

UnknownData_0x31619:
INCBIN "baserom.gbc", $31619, $3161A - $31619

LoggedData_0x3161A:
INCBIN "baserom.gbc", $3161A, $3161D - $3161A

UnknownData_0x3161D:
INCBIN "baserom.gbc", $3161D, $3161E - $3161D

LoggedData_0x3161E:
INCBIN "baserom.gbc", $3161E, $31621 - $3161E

UnknownData_0x31621:
INCBIN "baserom.gbc", $31621, $31622 - $31621

LoggedData_0x31622:
INCBIN "baserom.gbc", $31622, $31625 - $31622

UnknownData_0x31625:
INCBIN "baserom.gbc", $31625, $31626 - $31625

LoggedData_0x31626:
INCBIN "baserom.gbc", $31626, $31629 - $31626

UnknownData_0x31629:
INCBIN "baserom.gbc", $31629, $3162A - $31629

LoggedData_0x3162A:
INCBIN "baserom.gbc", $3162A, $3162D - $3162A

UnknownData_0x3162D:
INCBIN "baserom.gbc", $3162D, $3162E - $3162D

LoggedData_0x3162E:
INCBIN "baserom.gbc", $3162E, $31631 - $3162E

UnknownData_0x31631:
INCBIN "baserom.gbc", $31631, $31632 - $31631

LoggedData_0x31632:
INCBIN "baserom.gbc", $31632, $31635 - $31632

UnknownData_0x31635:
INCBIN "baserom.gbc", $31635, $31636 - $31635

LoggedData_0x31636:
INCBIN "baserom.gbc", $31636, $31639 - $31636

UnknownData_0x31639:
INCBIN "baserom.gbc", $31639, $3163A - $31639

LoggedData_0x3163A:
INCBIN "baserom.gbc", $3163A, $3163D - $3163A

UnknownData_0x3163D:
INCBIN "baserom.gbc", $3163D, $3163E - $3163D

LoggedData_0x3163E:
INCBIN "baserom.gbc", $3163E, $31641 - $3163E

UnknownData_0x31641:
INCBIN "baserom.gbc", $31641, $31642 - $31641

LoggedData_0x31642:
INCBIN "baserom.gbc", $31642, $31645 - $31642

UnknownData_0x31645:
INCBIN "baserom.gbc", $31645, $31646 - $31645

LoggedData_0x31646:
INCBIN "baserom.gbc", $31646, $31649 - $31646

UnknownData_0x31649:
INCBIN "baserom.gbc", $31649, $3164A - $31649

LoggedData_0x3164A:
INCBIN "baserom.gbc", $3164A, $3164D - $3164A

UnknownData_0x3164D:
INCBIN "baserom.gbc", $3164D, $3164E - $3164D

LoggedData_0x3164E:
INCBIN "baserom.gbc", $3164E, $31651 - $3164E

UnknownData_0x31651:
INCBIN "baserom.gbc", $31651, $31652 - $31651

LoggedData_0x31652:
INCBIN "baserom.gbc", $31652, $31655 - $31652

UnknownData_0x31655:
INCBIN "baserom.gbc", $31655, $31656 - $31655

LoggedData_0x31656:
INCBIN "baserom.gbc", $31656, $31659 - $31656

UnknownData_0x31659:
INCBIN "baserom.gbc", $31659, $3165A - $31659

LoggedData_0x3165A:
INCBIN "baserom.gbc", $3165A, $3165D - $3165A

UnknownData_0x3165D:
INCBIN "baserom.gbc", $3165D, $3165E - $3165D

LoggedData_0x3165E:
INCBIN "baserom.gbc", $3165E, $31661 - $3165E

UnknownData_0x31661:
INCBIN "baserom.gbc", $31661, $31662 - $31661

LoggedData_0x31662:
INCBIN "baserom.gbc", $31662, $31665 - $31662

UnknownData_0x31665:
INCBIN "baserom.gbc", $31665, $31666 - $31665

LoggedData_0x31666:
INCBIN "baserom.gbc", $31666, $31669 - $31666

UnknownData_0x31669:
INCBIN "baserom.gbc", $31669, $3166A - $31669

LoggedData_0x3166A:
INCBIN "baserom.gbc", $3166A, $3166D - $3166A

UnknownData_0x3166D:
INCBIN "baserom.gbc", $3166D, $3166E - $3166D

LoggedData_0x3166E:
INCBIN "baserom.gbc", $3166E, $31671 - $3166E

UnknownData_0x31671:
INCBIN "baserom.gbc", $31671, $31672 - $31671

LoggedData_0x31672:
INCBIN "baserom.gbc", $31672, $31675 - $31672

UnknownData_0x31675:
INCBIN "baserom.gbc", $31675, $31676 - $31675

LoggedData_0x31676:
INCBIN "baserom.gbc", $31676, $31679 - $31676

UnknownData_0x31679:
INCBIN "baserom.gbc", $31679, $3167A - $31679

LoggedData_0x3167A:
INCBIN "baserom.gbc", $3167A, $3167D - $3167A

UnknownData_0x3167D:
INCBIN "baserom.gbc", $3167D, $3167E - $3167D

LoggedData_0x3167E:
INCBIN "baserom.gbc", $3167E, $31681 - $3167E

UnknownData_0x31681:
INCBIN "baserom.gbc", $31681, $31682 - $31681

LoggedData_0x31682:
INCBIN "baserom.gbc", $31682, $31685 - $31682

UnknownData_0x31685:
INCBIN "baserom.gbc", $31685, $31686 - $31685

LoggedData_0x31686:
INCBIN "baserom.gbc", $31686, $31689 - $31686

UnknownData_0x31689:
INCBIN "baserom.gbc", $31689, $3168A - $31689

LoggedData_0x3168A:
INCBIN "baserom.gbc", $3168A, $3168D - $3168A

UnknownData_0x3168D:
INCBIN "baserom.gbc", $3168D, $3168E - $3168D

LoggedData_0x3168E:
INCBIN "baserom.gbc", $3168E, $31691 - $3168E

UnknownData_0x31691:
INCBIN "baserom.gbc", $31691, $31692 - $31691

LoggedData_0x31692:
INCBIN "baserom.gbc", $31692, $31695 - $31692

UnknownData_0x31695:
INCBIN "baserom.gbc", $31695, $31696 - $31695

LoggedData_0x31696:
INCBIN "baserom.gbc", $31696, $31699 - $31696

UnknownData_0x31699:
INCBIN "baserom.gbc", $31699, $3169A - $31699

LoggedData_0x3169A:
INCBIN "baserom.gbc", $3169A, $3169D - $3169A

UnknownData_0x3169D:
INCBIN "baserom.gbc", $3169D, $3169E - $3169D

LoggedData_0x3169E:
INCBIN "baserom.gbc", $3169E, $316A1 - $3169E

UnknownData_0x316A1:
INCBIN "baserom.gbc", $316A1, $316A2 - $316A1

LoggedData_0x316A2:
INCBIN "baserom.gbc", $316A2, $316A5 - $316A2

UnknownData_0x316A5:
INCBIN "baserom.gbc", $316A5, $316A6 - $316A5

LoggedData_0x316A6:
INCBIN "baserom.gbc", $316A6, $316A9 - $316A6

UnknownData_0x316A9:
INCBIN "baserom.gbc", $316A9, $316AA - $316A9

LoggedData_0x316AA:
INCBIN "baserom.gbc", $316AA, $316AD - $316AA

UnknownData_0x316AD:
INCBIN "baserom.gbc", $316AD, $316AE - $316AD

LoggedData_0x316AE:
INCBIN "baserom.gbc", $316AE, $316B1 - $316AE

UnknownData_0x316B1:
INCBIN "baserom.gbc", $316B1, $316B2 - $316B1

LoggedData_0x316B2:
INCBIN "baserom.gbc", $316B2, $316B5 - $316B2

UnknownData_0x316B5:
INCBIN "baserom.gbc", $316B5, $316B6 - $316B5

LoggedData_0x316B6:
INCBIN "baserom.gbc", $316B6, $316B9 - $316B6

UnknownData_0x316B9:
INCBIN "baserom.gbc", $316B9, $316BA - $316B9

LoggedData_0x316BA:
INCBIN "baserom.gbc", $316BA, $316BD - $316BA

UnknownData_0x316BD:
INCBIN "baserom.gbc", $316BD, $316BE - $316BD

LoggedData_0x316BE:
INCBIN "baserom.gbc", $316BE, $316C1 - $316BE

UnknownData_0x316C1:
INCBIN "baserom.gbc", $316C1, $316C2 - $316C1

LoggedData_0x316C2:
INCBIN "baserom.gbc", $316C2, $316C5 - $316C2

UnknownData_0x316C5:
INCBIN "baserom.gbc", $316C5, $316C6 - $316C5

LoggedData_0x316C6:
INCBIN "baserom.gbc", $316C6, $316C9 - $316C6

UnknownData_0x316C9:
INCBIN "baserom.gbc", $316C9, $316CA - $316C9

LoggedData_0x316CA:
INCBIN "baserom.gbc", $316CA, $316CD - $316CA

UnknownData_0x316CD:
INCBIN "baserom.gbc", $316CD, $316CE - $316CD

LoggedData_0x316CE:
INCBIN "baserom.gbc", $316CE, $316D1 - $316CE

UnknownData_0x316D1:
INCBIN "baserom.gbc", $316D1, $316D2 - $316D1

LoggedData_0x316D2:
INCBIN "baserom.gbc", $316D2, $316D5 - $316D2

UnknownData_0x316D5:
INCBIN "baserom.gbc", $316D5, $316D6 - $316D5

LoggedData_0x316D6:
INCBIN "baserom.gbc", $316D6, $316D9 - $316D6

UnknownData_0x316D9:
INCBIN "baserom.gbc", $316D9, $316DA - $316D9

LoggedData_0x316DA:
INCBIN "baserom.gbc", $316DA, $316DD - $316DA

UnknownData_0x316DD:
INCBIN "baserom.gbc", $316DD, $316DE - $316DD

LoggedData_0x316DE:
INCBIN "baserom.gbc", $316DE, $316E1 - $316DE

UnknownData_0x316E1:
INCBIN "baserom.gbc", $316E1, $316E2 - $316E1

LoggedData_0x316E2:
INCBIN "baserom.gbc", $316E2, $316E5 - $316E2

UnknownData_0x316E5:
INCBIN "baserom.gbc", $316E5, $316E6 - $316E5

LoggedData_0x316E6:
INCBIN "baserom.gbc", $316E6, $316E9 - $316E6

UnknownData_0x316E9:
INCBIN "baserom.gbc", $316E9, $316EA - $316E9

LoggedData_0x316EA:
INCBIN "baserom.gbc", $316EA, $316ED - $316EA

UnknownData_0x316ED:
INCBIN "baserom.gbc", $316ED, $316EE - $316ED

LoggedData_0x316EE:
INCBIN "baserom.gbc", $316EE, $316F1 - $316EE

UnknownData_0x316F1:
INCBIN "baserom.gbc", $316F1, $316F2 - $316F1

LoggedData_0x316F2:
INCBIN "baserom.gbc", $316F2, $316F5 - $316F2

UnknownData_0x316F5:
INCBIN "baserom.gbc", $316F5, $316F6 - $316F5

LoggedData_0x316F6:
INCBIN "baserom.gbc", $316F6, $316F9 - $316F6

UnknownData_0x316F9:
INCBIN "baserom.gbc", $316F9, $316FA - $316F9

LoggedData_0x316FA:
INCBIN "baserom.gbc", $316FA, $316FD - $316FA

UnknownData_0x316FD:
INCBIN "baserom.gbc", $316FD, $316FE - $316FD

LoggedData_0x316FE:
INCBIN "baserom.gbc", $316FE, $31701 - $316FE

UnknownData_0x31701:
INCBIN "baserom.gbc", $31701, $31702 - $31701

LoggedData_0x31702:
INCBIN "baserom.gbc", $31702, $31705 - $31702

UnknownData_0x31705:
INCBIN "baserom.gbc", $31705, $31706 - $31705

LoggedData_0x31706:
INCBIN "baserom.gbc", $31706, $31709 - $31706

UnknownData_0x31709:
INCBIN "baserom.gbc", $31709, $3170A - $31709

LoggedData_0x3170A:
INCBIN "baserom.gbc", $3170A, $3170D - $3170A

UnknownData_0x3170D:
INCBIN "baserom.gbc", $3170D, $3170E - $3170D

LoggedData_0x3170E:
INCBIN "baserom.gbc", $3170E, $31711 - $3170E

UnknownData_0x31711:
INCBIN "baserom.gbc", $31711, $31712 - $31711

LoggedData_0x31712:
INCBIN "baserom.gbc", $31712, $31715 - $31712

UnknownData_0x31715:
INCBIN "baserom.gbc", $31715, $31716 - $31715

LoggedData_0x31716:
INCBIN "baserom.gbc", $31716, $31719 - $31716

UnknownData_0x31719:
INCBIN "baserom.gbc", $31719, $3171A - $31719

LoggedData_0x3171A:
INCBIN "baserom.gbc", $3171A, $3171D - $3171A

UnknownData_0x3171D:
INCBIN "baserom.gbc", $3171D, $3171E - $3171D

LoggedData_0x3171E:
INCBIN "baserom.gbc", $3171E, $31721 - $3171E

UnknownData_0x31721:
INCBIN "baserom.gbc", $31721, $31722 - $31721

LoggedData_0x31722:
INCBIN "baserom.gbc", $31722, $31725 - $31722

UnknownData_0x31725:
INCBIN "baserom.gbc", $31725, $31726 - $31725

LoggedData_0x31726:
INCBIN "baserom.gbc", $31726, $31729 - $31726

UnknownData_0x31729:
INCBIN "baserom.gbc", $31729, $3172A - $31729

LoggedData_0x3172A:
INCBIN "baserom.gbc", $3172A, $3172D - $3172A

UnknownData_0x3172D:
INCBIN "baserom.gbc", $3172D, $3172E - $3172D

LoggedData_0x3172E:
INCBIN "baserom.gbc", $3172E, $31731 - $3172E

UnknownData_0x31731:
INCBIN "baserom.gbc", $31731, $31732 - $31731

LoggedData_0x31732:
INCBIN "baserom.gbc", $31732, $31735 - $31732

UnknownData_0x31735:
INCBIN "baserom.gbc", $31735, $31D66 - $31735

LoggedData_0x31D66:
INCBIN "baserom.gbc", $31D66, $31D69 - $31D66

UnknownData_0x31D69:
INCBIN "baserom.gbc", $31D69, $31D6A - $31D69

LoggedData_0x31D6A:
INCBIN "baserom.gbc", $31D6A, $31D6D - $31D6A

UnknownData_0x31D6D:
INCBIN "baserom.gbc", $31D6D, $31D6E - $31D6D

LoggedData_0x31D6E:
INCBIN "baserom.gbc", $31D6E, $31D71 - $31D6E

UnknownData_0x31D71:
INCBIN "baserom.gbc", $31D71, $31D72 - $31D71

LoggedData_0x31D72:
INCBIN "baserom.gbc", $31D72, $31D75 - $31D72

UnknownData_0x31D75:
INCBIN "baserom.gbc", $31D75, $31D76 - $31D75

LoggedData_0x31D76:
INCBIN "baserom.gbc", $31D76, $31D79 - $31D76

UnknownData_0x31D79:
INCBIN "baserom.gbc", $31D79, $31D7A - $31D79

LoggedData_0x31D7A:
INCBIN "baserom.gbc", $31D7A, $31D7D - $31D7A

UnknownData_0x31D7D:
INCBIN "baserom.gbc", $31D7D, $31D7E - $31D7D

LoggedData_0x31D7E:
INCBIN "baserom.gbc", $31D7E, $31D81 - $31D7E

UnknownData_0x31D81:
INCBIN "baserom.gbc", $31D81, $31D82 - $31D81

LoggedData_0x31D82:
INCBIN "baserom.gbc", $31D82, $31D85 - $31D82

UnknownData_0x31D85:
INCBIN "baserom.gbc", $31D85, $31D86 - $31D85

LoggedData_0x31D86:
INCBIN "baserom.gbc", $31D86, $31D89 - $31D86

UnknownData_0x31D89:
INCBIN "baserom.gbc", $31D89, $31D8A - $31D89

LoggedData_0x31D8A:
INCBIN "baserom.gbc", $31D8A, $31D8D - $31D8A

UnknownData_0x31D8D:
INCBIN "baserom.gbc", $31D8D, $31D8E - $31D8D

LoggedData_0x31D8E:
INCBIN "baserom.gbc", $31D8E, $31D91 - $31D8E

UnknownData_0x31D91:
INCBIN "baserom.gbc", $31D91, $31D92 - $31D91

LoggedData_0x31D92:
INCBIN "baserom.gbc", $31D92, $31D95 - $31D92

UnknownData_0x31D95:
INCBIN "baserom.gbc", $31D95, $31D96 - $31D95

LoggedData_0x31D96:
INCBIN "baserom.gbc", $31D96, $31D99 - $31D96

UnknownData_0x31D99:
INCBIN "baserom.gbc", $31D99, $31D9A - $31D99

LoggedData_0x31D9A:
INCBIN "baserom.gbc", $31D9A, $31D9D - $31D9A

UnknownData_0x31D9D:
INCBIN "baserom.gbc", $31D9D, $31D9E - $31D9D

LoggedData_0x31D9E:
INCBIN "baserom.gbc", $31D9E, $31DA1 - $31D9E

UnknownData_0x31DA1:
INCBIN "baserom.gbc", $31DA1, $31DA2 - $31DA1

LoggedData_0x31DA2:
INCBIN "baserom.gbc", $31DA2, $31DA5 - $31DA2

UnknownData_0x31DA5:
INCBIN "baserom.gbc", $31DA5, $31DA6 - $31DA5

LoggedData_0x31DA6:
INCBIN "baserom.gbc", $31DA6, $31DA9 - $31DA6

UnknownData_0x31DA9:
INCBIN "baserom.gbc", $31DA9, $31DAA - $31DA9

LoggedData_0x31DAA:
INCBIN "baserom.gbc", $31DAA, $31DAD - $31DAA

UnknownData_0x31DAD:
INCBIN "baserom.gbc", $31DAD, $31DAE - $31DAD

LoggedData_0x31DAE:
INCBIN "baserom.gbc", $31DAE, $31DB1 - $31DAE

UnknownData_0x31DB1:
INCBIN "baserom.gbc", $31DB1, $31DB2 - $31DB1

LoggedData_0x31DB2:
INCBIN "baserom.gbc", $31DB2, $31DB5 - $31DB2

UnknownData_0x31DB5:
INCBIN "baserom.gbc", $31DB5, $31DB6 - $31DB5

LoggedData_0x31DB6:
INCBIN "baserom.gbc", $31DB6, $31DB9 - $31DB6

UnknownData_0x31DB9:
INCBIN "baserom.gbc", $31DB9, $31DBA - $31DB9

LoggedData_0x31DBA:
INCBIN "baserom.gbc", $31DBA, $31DBD - $31DBA

UnknownData_0x31DBD:
INCBIN "baserom.gbc", $31DBD, $31DBE - $31DBD

LoggedData_0x31DBE:
INCBIN "baserom.gbc", $31DBE, $31DC1 - $31DBE

UnknownData_0x31DC1:
INCBIN "baserom.gbc", $31DC1, $31DC2 - $31DC1

LoggedData_0x31DC2:
INCBIN "baserom.gbc", $31DC2, $31DC5 - $31DC2

UnknownData_0x31DC5:
INCBIN "baserom.gbc", $31DC5, $31DC6 - $31DC5

LoggedData_0x31DC6:
INCBIN "baserom.gbc", $31DC6, $31DC9 - $31DC6

UnknownData_0x31DC9:
INCBIN "baserom.gbc", $31DC9, $31DCA - $31DC9

LoggedData_0x31DCA:
INCBIN "baserom.gbc", $31DCA, $31DCD - $31DCA

UnknownData_0x31DCD:
INCBIN "baserom.gbc", $31DCD, $31DCE - $31DCD

LoggedData_0x31DCE:
INCBIN "baserom.gbc", $31DCE, $31DD1 - $31DCE

UnknownData_0x31DD1:
INCBIN "baserom.gbc", $31DD1, $31DD2 - $31DD1

LoggedData_0x31DD2:
INCBIN "baserom.gbc", $31DD2, $31DD5 - $31DD2

UnknownData_0x31DD5:
INCBIN "baserom.gbc", $31DD5, $31DD6 - $31DD5

LoggedData_0x31DD6:
INCBIN "baserom.gbc", $31DD6, $31DD9 - $31DD6

UnknownData_0x31DD9:
INCBIN "baserom.gbc", $31DD9, $31DDA - $31DD9

LoggedData_0x31DDA:
INCBIN "baserom.gbc", $31DDA, $31DDD - $31DDA

UnknownData_0x31DDD:
INCBIN "baserom.gbc", $31DDD, $31DDE - $31DDD

LoggedData_0x31DDE:
INCBIN "baserom.gbc", $31DDE, $31DE1 - $31DDE

UnknownData_0x31DE1:
INCBIN "baserom.gbc", $31DE1, $31DE2 - $31DE1

LoggedData_0x31DE2:
INCBIN "baserom.gbc", $31DE2, $31DE5 - $31DE2

UnknownData_0x31DE5:
INCBIN "baserom.gbc", $31DE5, $31DE6 - $31DE5

LoggedData_0x31DE6:
INCBIN "baserom.gbc", $31DE6, $31DE9 - $31DE6

UnknownData_0x31DE9:
INCBIN "baserom.gbc", $31DE9, $31DEA - $31DE9

LoggedData_0x31DEA:
INCBIN "baserom.gbc", $31DEA, $31DED - $31DEA

UnknownData_0x31DED:
INCBIN "baserom.gbc", $31DED, $31DEE - $31DED

LoggedData_0x31DEE:
INCBIN "baserom.gbc", $31DEE, $31DF1 - $31DEE

UnknownData_0x31DF1:
INCBIN "baserom.gbc", $31DF1, $31DF2 - $31DF1

LoggedData_0x31DF2:
INCBIN "baserom.gbc", $31DF2, $31DF5 - $31DF2

UnknownData_0x31DF5:
INCBIN "baserom.gbc", $31DF5, $31DF6 - $31DF5

LoggedData_0x31DF6:
INCBIN "baserom.gbc", $31DF6, $31DF9 - $31DF6

UnknownData_0x31DF9:
INCBIN "baserom.gbc", $31DF9, $31DFA - $31DF9

LoggedData_0x31DFA:
INCBIN "baserom.gbc", $31DFA, $31DFD - $31DFA

UnknownData_0x31DFD:
INCBIN "baserom.gbc", $31DFD, $31DFE - $31DFD

LoggedData_0x31DFE:
INCBIN "baserom.gbc", $31DFE, $31E01 - $31DFE

UnknownData_0x31E01:
INCBIN "baserom.gbc", $31E01, $31E02 - $31E01

LoggedData_0x31E02:
INCBIN "baserom.gbc", $31E02, $31E05 - $31E02

UnknownData_0x31E05:
INCBIN "baserom.gbc", $31E05, $31E06 - $31E05

LoggedData_0x31E06:
INCBIN "baserom.gbc", $31E06, $31E09 - $31E06

UnknownData_0x31E09:
INCBIN "baserom.gbc", $31E09, $31E0A - $31E09

LoggedData_0x31E0A:
INCBIN "baserom.gbc", $31E0A, $31E0D - $31E0A

UnknownData_0x31E0D:
INCBIN "baserom.gbc", $31E0D, $31E0E - $31E0D

LoggedData_0x31E0E:
INCBIN "baserom.gbc", $31E0E, $31E11 - $31E0E

UnknownData_0x31E11:
INCBIN "baserom.gbc", $31E11, $31E12 - $31E11

LoggedData_0x31E12:
INCBIN "baserom.gbc", $31E12, $31E15 - $31E12

UnknownData_0x31E15:
INCBIN "baserom.gbc", $31E15, $31E16 - $31E15

LoggedData_0x31E16:
INCBIN "baserom.gbc", $31E16, $31E19 - $31E16

UnknownData_0x31E19:
INCBIN "baserom.gbc", $31E19, $31E1A - $31E19

LoggedData_0x31E1A:
INCBIN "baserom.gbc", $31E1A, $31E1D - $31E1A

UnknownData_0x31E1D:
INCBIN "baserom.gbc", $31E1D, $31E1E - $31E1D

LoggedData_0x31E1E:
INCBIN "baserom.gbc", $31E1E, $31E21 - $31E1E

UnknownData_0x31E21:
INCBIN "baserom.gbc", $31E21, $31E22 - $31E21

LoggedData_0x31E22:
INCBIN "baserom.gbc", $31E22, $31E25 - $31E22

UnknownData_0x31E25:
INCBIN "baserom.gbc", $31E25, $31E26 - $31E25

LoggedData_0x31E26:
INCBIN "baserom.gbc", $31E26, $31E29 - $31E26

UnknownData_0x31E29:
INCBIN "baserom.gbc", $31E29, $31E2A - $31E29

LoggedData_0x31E2A:
INCBIN "baserom.gbc", $31E2A, $31E2D - $31E2A

UnknownData_0x31E2D:
INCBIN "baserom.gbc", $31E2D, $31E2E - $31E2D

LoggedData_0x31E2E:
INCBIN "baserom.gbc", $31E2E, $31E31 - $31E2E

UnknownData_0x31E31:
INCBIN "baserom.gbc", $31E31, $31E32 - $31E31

LoggedData_0x31E32:
INCBIN "baserom.gbc", $31E32, $31E35 - $31E32

UnknownData_0x31E35:
INCBIN "baserom.gbc", $31E35, $31E36 - $31E35

LoggedData_0x31E36:
INCBIN "baserom.gbc", $31E36, $31E39 - $31E36

UnknownData_0x31E39:
INCBIN "baserom.gbc", $31E39, $31E3A - $31E39

LoggedData_0x31E3A:
INCBIN "baserom.gbc", $31E3A, $31E3D - $31E3A

UnknownData_0x31E3D:
INCBIN "baserom.gbc", $31E3D, $31E3E - $31E3D

LoggedData_0x31E3E:
INCBIN "baserom.gbc", $31E3E, $31E41 - $31E3E

UnknownData_0x31E41:
INCBIN "baserom.gbc", $31E41, $31E42 - $31E41

LoggedData_0x31E42:
INCBIN "baserom.gbc", $31E42, $31E45 - $31E42

UnknownData_0x31E45:
INCBIN "baserom.gbc", $31E45, $31E46 - $31E45

LoggedData_0x31E46:
INCBIN "baserom.gbc", $31E46, $31E49 - $31E46

UnknownData_0x31E49:
INCBIN "baserom.gbc", $31E49, $31E4A - $31E49

LoggedData_0x31E4A:
INCBIN "baserom.gbc", $31E4A, $31E4D - $31E4A

UnknownData_0x31E4D:
INCBIN "baserom.gbc", $31E4D, $31E4E - $31E4D

LoggedData_0x31E4E:
INCBIN "baserom.gbc", $31E4E, $31E51 - $31E4E

UnknownData_0x31E51:
INCBIN "baserom.gbc", $31E51, $31E52 - $31E51

LoggedData_0x31E52:
INCBIN "baserom.gbc", $31E52, $31E55 - $31E52

UnknownData_0x31E55:
INCBIN "baserom.gbc", $31E55, $31E56 - $31E55

LoggedData_0x31E56:
INCBIN "baserom.gbc", $31E56, $31E59 - $31E56

UnknownData_0x31E59:
INCBIN "baserom.gbc", $31E59, $31E5A - $31E59

LoggedData_0x31E5A:
INCBIN "baserom.gbc", $31E5A, $31E5D - $31E5A

UnknownData_0x31E5D:
INCBIN "baserom.gbc", $31E5D, $31E5E - $31E5D

LoggedData_0x31E5E:
INCBIN "baserom.gbc", $31E5E, $31E61 - $31E5E

UnknownData_0x31E61:
INCBIN "baserom.gbc", $31E61, $31E62 - $31E61

LoggedData_0x31E62:
INCBIN "baserom.gbc", $31E62, $31E65 - $31E62

UnknownData_0x31E65:
INCBIN "baserom.gbc", $31E65, $31E66 - $31E65

LoggedData_0x31E66:
INCBIN "baserom.gbc", $31E66, $31E69 - $31E66

UnknownData_0x31E69:
INCBIN "baserom.gbc", $31E69, $31E6A - $31E69

LoggedData_0x31E6A:
INCBIN "baserom.gbc", $31E6A, $31E6D - $31E6A

UnknownData_0x31E6D:
INCBIN "baserom.gbc", $31E6D, $31E6E - $31E6D

LoggedData_0x31E6E:
INCBIN "baserom.gbc", $31E6E, $31E71 - $31E6E

UnknownData_0x31E71:
INCBIN "baserom.gbc", $31E71, $31E72 - $31E71

LoggedData_0x31E72:
INCBIN "baserom.gbc", $31E72, $31E75 - $31E72

UnknownData_0x31E75:
INCBIN "baserom.gbc", $31E75, $31E76 - $31E75

LoggedData_0x31E76:
INCBIN "baserom.gbc", $31E76, $31E79 - $31E76

UnknownData_0x31E79:
INCBIN "baserom.gbc", $31E79, $31E7A - $31E79

LoggedData_0x31E7A:
INCBIN "baserom.gbc", $31E7A, $31E7D - $31E7A

UnknownData_0x31E7D:
INCBIN "baserom.gbc", $31E7D, $31E7E - $31E7D

LoggedData_0x31E7E:
INCBIN "baserom.gbc", $31E7E, $31E81 - $31E7E

UnknownData_0x31E81:
INCBIN "baserom.gbc", $31E81, $31E82 - $31E81

LoggedData_0x31E82:
INCBIN "baserom.gbc", $31E82, $31E85 - $31E82

UnknownData_0x31E85:
INCBIN "baserom.gbc", $31E85, $31E86 - $31E85

LoggedData_0x31E86:
INCBIN "baserom.gbc", $31E86, $31E89 - $31E86

UnknownData_0x31E89:
INCBIN "baserom.gbc", $31E89, $31E8A - $31E89

LoggedData_0x31E8A:
INCBIN "baserom.gbc", $31E8A, $31E8D - $31E8A

UnknownData_0x31E8D:
INCBIN "baserom.gbc", $31E8D, $31E8E - $31E8D

LoggedData_0x31E8E:
INCBIN "baserom.gbc", $31E8E, $31E91 - $31E8E

UnknownData_0x31E91:
INCBIN "baserom.gbc", $31E91, $31E92 - $31E91

LoggedData_0x31E92:
INCBIN "baserom.gbc", $31E92, $31E95 - $31E92

UnknownData_0x31E95:
INCBIN "baserom.gbc", $31E95, $31E96 - $31E95

LoggedData_0x31E96:
INCBIN "baserom.gbc", $31E96, $31E99 - $31E96

UnknownData_0x31E99:
INCBIN "baserom.gbc", $31E99, $31E9A - $31E99

LoggedData_0x31E9A:
INCBIN "baserom.gbc", $31E9A, $31E9D - $31E9A

UnknownData_0x31E9D:
INCBIN "baserom.gbc", $31E9D, $31E9E - $31E9D

LoggedData_0x31E9E:
INCBIN "baserom.gbc", $31E9E, $31EA1 - $31E9E

UnknownData_0x31EA1:
INCBIN "baserom.gbc", $31EA1, $31EA2 - $31EA1

LoggedData_0x31EA2:
INCBIN "baserom.gbc", $31EA2, $31EA5 - $31EA2

UnknownData_0x31EA5:
INCBIN "baserom.gbc", $31EA5, $31EA6 - $31EA5

LoggedData_0x31EA6:
INCBIN "baserom.gbc", $31EA6, $31EA9 - $31EA6

UnknownData_0x31EA9:
INCBIN "baserom.gbc", $31EA9, $31EAA - $31EA9

LoggedData_0x31EAA:
INCBIN "baserom.gbc", $31EAA, $31EAD - $31EAA

UnknownData_0x31EAD:
INCBIN "baserom.gbc", $31EAD, $31EAE - $31EAD

LoggedData_0x31EAE:
INCBIN "baserom.gbc", $31EAE, $31EB1 - $31EAE

UnknownData_0x31EB1:
INCBIN "baserom.gbc", $31EB1, $31EB2 - $31EB1

LoggedData_0x31EB2:
INCBIN "baserom.gbc", $31EB2, $31EB5 - $31EB2

UnknownData_0x31EB5:
INCBIN "baserom.gbc", $31EB5, $31EB6 - $31EB5

LoggedData_0x31EB6:
INCBIN "baserom.gbc", $31EB6, $31EB9 - $31EB6

UnknownData_0x31EB9:
INCBIN "baserom.gbc", $31EB9, $31EBA - $31EB9

LoggedData_0x31EBA:
INCBIN "baserom.gbc", $31EBA, $31EBD - $31EBA

UnknownData_0x31EBD:
INCBIN "baserom.gbc", $31EBD, $31EBE - $31EBD

LoggedData_0x31EBE:
INCBIN "baserom.gbc", $31EBE, $31EC1 - $31EBE

UnknownData_0x31EC1:
INCBIN "baserom.gbc", $31EC1, $31EC2 - $31EC1

LoggedData_0x31EC2:
INCBIN "baserom.gbc", $31EC2, $31EC5 - $31EC2

UnknownData_0x31EC5:
INCBIN "baserom.gbc", $31EC5, $31EC6 - $31EC5

LoggedData_0x31EC6:
INCBIN "baserom.gbc", $31EC6, $31EC9 - $31EC6

UnknownData_0x31EC9:
INCBIN "baserom.gbc", $31EC9, $31ECA - $31EC9

LoggedData_0x31ECA:
INCBIN "baserom.gbc", $31ECA, $31ECD - $31ECA

UnknownData_0x31ECD:
INCBIN "baserom.gbc", $31ECD, $31ECE - $31ECD

LoggedData_0x31ECE:
INCBIN "baserom.gbc", $31ECE, $31ED1 - $31ECE

UnknownData_0x31ED1:
INCBIN "baserom.gbc", $31ED1, $31ED2 - $31ED1

LoggedData_0x31ED2:
INCBIN "baserom.gbc", $31ED2, $31ED5 - $31ED2

UnknownData_0x31ED5:
INCBIN "baserom.gbc", $31ED5, $31ED6 - $31ED5

LoggedData_0x31ED6:
INCBIN "baserom.gbc", $31ED6, $31ED9 - $31ED6

UnknownData_0x31ED9:
INCBIN "baserom.gbc", $31ED9, $31EDA - $31ED9

LoggedData_0x31EDA:
INCBIN "baserom.gbc", $31EDA, $31EDD - $31EDA

UnknownData_0x31EDD:
INCBIN "baserom.gbc", $31EDD, $31EDE - $31EDD

LoggedData_0x31EDE:
INCBIN "baserom.gbc", $31EDE, $31EE1 - $31EDE

UnknownData_0x31EE1:
INCBIN "baserom.gbc", $31EE1, $31EE2 - $31EE1

LoggedData_0x31EE2:
INCBIN "baserom.gbc", $31EE2, $31EE5 - $31EE2

UnknownData_0x31EE5:
INCBIN "baserom.gbc", $31EE5, $31EE6 - $31EE5

LoggedData_0x31EE6:
INCBIN "baserom.gbc", $31EE6, $31EE9 - $31EE6

UnknownData_0x31EE9:
INCBIN "baserom.gbc", $31EE9, $31EEA - $31EE9

LoggedData_0x31EEA:
INCBIN "baserom.gbc", $31EEA, $31EED - $31EEA

UnknownData_0x31EED:
INCBIN "baserom.gbc", $31EED, $31EEE - $31EED

LoggedData_0x31EEE:
INCBIN "baserom.gbc", $31EEE, $31EF1 - $31EEE

UnknownData_0x31EF1:
INCBIN "baserom.gbc", $31EF1, $31EF2 - $31EF1

LoggedData_0x31EF2:
INCBIN "baserom.gbc", $31EF2, $31EF5 - $31EF2

UnknownData_0x31EF5:
INCBIN "baserom.gbc", $31EF5, $31EF6 - $31EF5

LoggedData_0x31EF6:
INCBIN "baserom.gbc", $31EF6, $31EF9 - $31EF6

UnknownData_0x31EF9:
INCBIN "baserom.gbc", $31EF9, $31EFA - $31EF9

LoggedData_0x31EFA:
INCBIN "baserom.gbc", $31EFA, $31EFD - $31EFA

UnknownData_0x31EFD:
INCBIN "baserom.gbc", $31EFD, $31EFE - $31EFD

LoggedData_0x31EFE:
INCBIN "baserom.gbc", $31EFE, $31F01 - $31EFE

UnknownData_0x31F01:
INCBIN "baserom.gbc", $31F01, $31F02 - $31F01

LoggedData_0x31F02:
INCBIN "baserom.gbc", $31F02, $31F05 - $31F02

UnknownData_0x31F05:
INCBIN "baserom.gbc", $31F05, $31F06 - $31F05

LoggedData_0x31F06:
INCBIN "baserom.gbc", $31F06, $31F09 - $31F06

UnknownData_0x31F09:
INCBIN "baserom.gbc", $31F09, $31F0A - $31F09

LoggedData_0x31F0A:
INCBIN "baserom.gbc", $31F0A, $31F0D - $31F0A

UnknownData_0x31F0D:
INCBIN "baserom.gbc", $31F0D, $31F16 - $31F0D

LoggedData_0x31F16:
INCBIN "baserom.gbc", $31F16, $31F19 - $31F16

UnknownData_0x31F19:
INCBIN "baserom.gbc", $31F19, $31F1A - $31F19

LoggedData_0x31F1A:
INCBIN "baserom.gbc", $31F1A, $31F1D - $31F1A

UnknownData_0x31F1D:
INCBIN "baserom.gbc", $31F1D, $31F1E - $31F1D

LoggedData_0x31F1E:
INCBIN "baserom.gbc", $31F1E, $31F21 - $31F1E

UnknownData_0x31F21:
INCBIN "baserom.gbc", $31F21, $31F22 - $31F21

LoggedData_0x31F22:
INCBIN "baserom.gbc", $31F22, $31F25 - $31F22

UnknownData_0x31F25:
INCBIN "baserom.gbc", $31F25, $31F26 - $31F25

LoggedData_0x31F26:
INCBIN "baserom.gbc", $31F26, $31F29 - $31F26

UnknownData_0x31F29:
INCBIN "baserom.gbc", $31F29, $31F2A - $31F29

LoggedData_0x31F2A:
INCBIN "baserom.gbc", $31F2A, $31F2D - $31F2A

UnknownData_0x31F2D:
INCBIN "baserom.gbc", $31F2D, $31F2E - $31F2D

LoggedData_0x31F2E:
INCBIN "baserom.gbc", $31F2E, $31F31 - $31F2E

UnknownData_0x31F31:
INCBIN "baserom.gbc", $31F31, $31F32 - $31F31

LoggedData_0x31F32:
INCBIN "baserom.gbc", $31F32, $31F35 - $31F32

UnknownData_0x31F35:
INCBIN "baserom.gbc", $31F35, $31F36 - $31F35

LoggedData_0x31F36:
INCBIN "baserom.gbc", $31F36, $31F39 - $31F36

UnknownData_0x31F39:
INCBIN "baserom.gbc", $31F39, $31F3A - $31F39

LoggedData_0x31F3A:
INCBIN "baserom.gbc", $31F3A, $31F3D - $31F3A

UnknownData_0x31F3D:
INCBIN "baserom.gbc", $31F3D, $31F3E - $31F3D

LoggedData_0x31F3E:
INCBIN "baserom.gbc", $31F3E, $31F41 - $31F3E

UnknownData_0x31F41:
INCBIN "baserom.gbc", $31F41, $31F42 - $31F41

LoggedData_0x31F42:
INCBIN "baserom.gbc", $31F42, $31F45 - $31F42

UnknownData_0x31F45:
INCBIN "baserom.gbc", $31F45, $31F46 - $31F45

LoggedData_0x31F46:
INCBIN "baserom.gbc", $31F46, $31F49 - $31F46

UnknownData_0x31F49:
INCBIN "baserom.gbc", $31F49, $31F4A - $31F49

LoggedData_0x31F4A:
INCBIN "baserom.gbc", $31F4A, $31F4D - $31F4A

UnknownData_0x31F4D:
INCBIN "baserom.gbc", $31F4D, $31F4E - $31F4D

LoggedData_0x31F4E:
INCBIN "baserom.gbc", $31F4E, $31F51 - $31F4E

UnknownData_0x31F51:
INCBIN "baserom.gbc", $31F51, $31F52 - $31F51

LoggedData_0x31F52:
INCBIN "baserom.gbc", $31F52, $31F55 - $31F52

UnknownData_0x31F55:
INCBIN "baserom.gbc", $31F55, $31F56 - $31F55

LoggedData_0x31F56:
INCBIN "baserom.gbc", $31F56, $31F59 - $31F56

UnknownData_0x31F59:
INCBIN "baserom.gbc", $31F59, $31F5A - $31F59

LoggedData_0x31F5A:
INCBIN "baserom.gbc", $31F5A, $31F5D - $31F5A

UnknownData_0x31F5D:
INCBIN "baserom.gbc", $31F5D, $31F5E - $31F5D

LoggedData_0x31F5E:
INCBIN "baserom.gbc", $31F5E, $31F61 - $31F5E

UnknownData_0x31F61:
INCBIN "baserom.gbc", $31F61, $31F62 - $31F61

LoggedData_0x31F62:
INCBIN "baserom.gbc", $31F62, $31F65 - $31F62

UnknownData_0x31F65:
INCBIN "baserom.gbc", $31F65, $31F66 - $31F65

LoggedData_0x31F66:
INCBIN "baserom.gbc", $31F66, $31F69 - $31F66

UnknownData_0x31F69:
INCBIN "baserom.gbc", $31F69, $31F6A - $31F69

LoggedData_0x31F6A:
INCBIN "baserom.gbc", $31F6A, $31F6D - $31F6A

UnknownData_0x31F6D:
INCBIN "baserom.gbc", $31F6D, $31F6E - $31F6D

LoggedData_0x31F6E:
INCBIN "baserom.gbc", $31F6E, $31F71 - $31F6E

UnknownData_0x31F71:
INCBIN "baserom.gbc", $31F71, $31F72 - $31F71

LoggedData_0x31F72:
INCBIN "baserom.gbc", $31F72, $31F75 - $31F72

UnknownData_0x31F75:
INCBIN "baserom.gbc", $31F75, $31F76 - $31F75

LoggedData_0x31F76:
INCBIN "baserom.gbc", $31F76, $31F79 - $31F76

UnknownData_0x31F79:
INCBIN "baserom.gbc", $31F79, $31F7A - $31F79

LoggedData_0x31F7A:
INCBIN "baserom.gbc", $31F7A, $31F7D - $31F7A

UnknownData_0x31F7D:
INCBIN "baserom.gbc", $31F7D, $31F7E - $31F7D

LoggedData_0x31F7E:
INCBIN "baserom.gbc", $31F7E, $31F81 - $31F7E

UnknownData_0x31F81:
INCBIN "baserom.gbc", $31F81, $31F82 - $31F81

LoggedData_0x31F82:
INCBIN "baserom.gbc", $31F82, $31F85 - $31F82

UnknownData_0x31F85:
INCBIN "baserom.gbc", $31F85, $31F86 - $31F85

LoggedData_0x31F86:
INCBIN "baserom.gbc", $31F86, $31F89 - $31F86

UnknownData_0x31F89:
INCBIN "baserom.gbc", $31F89, $31F8A - $31F89

LoggedData_0x31F8A:
INCBIN "baserom.gbc", $31F8A, $31F8D - $31F8A

UnknownData_0x31F8D:
INCBIN "baserom.gbc", $31F8D, $31F8E - $31F8D

LoggedData_0x31F8E:
INCBIN "baserom.gbc", $31F8E, $31F91 - $31F8E

UnknownData_0x31F91:
INCBIN "baserom.gbc", $31F91, $31F92 - $31F91

LoggedData_0x31F92:
INCBIN "baserom.gbc", $31F92, $31F95 - $31F92

UnknownData_0x31F95:
INCBIN "baserom.gbc", $31F95, $31F96 - $31F95

LoggedData_0x31F96:
INCBIN "baserom.gbc", $31F96, $31F99 - $31F96

UnknownData_0x31F99:
INCBIN "baserom.gbc", $31F99, $31F9A - $31F99

LoggedData_0x31F9A:
INCBIN "baserom.gbc", $31F9A, $31F9D - $31F9A

UnknownData_0x31F9D:
INCBIN "baserom.gbc", $31F9D, $31F9E - $31F9D

LoggedData_0x31F9E:
INCBIN "baserom.gbc", $31F9E, $31FA1 - $31F9E

UnknownData_0x31FA1:
INCBIN "baserom.gbc", $31FA1, $31FA2 - $31FA1

LoggedData_0x31FA2:
INCBIN "baserom.gbc", $31FA2, $31FA5 - $31FA2

UnknownData_0x31FA5:
INCBIN "baserom.gbc", $31FA5, $31FA6 - $31FA5

LoggedData_0x31FA6:
INCBIN "baserom.gbc", $31FA6, $31FA9 - $31FA6

UnknownData_0x31FA9:
INCBIN "baserom.gbc", $31FA9, $31FAA - $31FA9

LoggedData_0x31FAA:
INCBIN "baserom.gbc", $31FAA, $31FAD - $31FAA

UnknownData_0x31FAD:
INCBIN "baserom.gbc", $31FAD, $31FAE - $31FAD

LoggedData_0x31FAE:
INCBIN "baserom.gbc", $31FAE, $31FB1 - $31FAE

UnknownData_0x31FB1:
INCBIN "baserom.gbc", $31FB1, $31FB2 - $31FB1

LoggedData_0x31FB2:
INCBIN "baserom.gbc", $31FB2, $31FB5 - $31FB2

UnknownData_0x31FB5:
INCBIN "baserom.gbc", $31FB5, $31FB6 - $31FB5

LoggedData_0x31FB6:
INCBIN "baserom.gbc", $31FB6, $31FB9 - $31FB6

UnknownData_0x31FB9:
INCBIN "baserom.gbc", $31FB9, $31FBA - $31FB9

LoggedData_0x31FBA:
INCBIN "baserom.gbc", $31FBA, $31FBD - $31FBA

UnknownData_0x31FBD:
INCBIN "baserom.gbc", $31FBD, $31FBE - $31FBD

LoggedData_0x31FBE:
INCBIN "baserom.gbc", $31FBE, $31FC1 - $31FBE

UnknownData_0x31FC1:
INCBIN "baserom.gbc", $31FC1, $31FC2 - $31FC1

LoggedData_0x31FC2:
INCBIN "baserom.gbc", $31FC2, $31FC5 - $31FC2

UnknownData_0x31FC5:
INCBIN "baserom.gbc", $31FC5, $32066 - $31FC5

LoggedData_0x32066:
INCBIN "baserom.gbc", $32066, $32069 - $32066

UnknownData_0x32069:
INCBIN "baserom.gbc", $32069, $3206A - $32069

LoggedData_0x3206A:
INCBIN "baserom.gbc", $3206A, $3206D - $3206A

UnknownData_0x3206D:
INCBIN "baserom.gbc", $3206D, $3206E - $3206D

LoggedData_0x3206E:
INCBIN "baserom.gbc", $3206E, $32071 - $3206E

UnknownData_0x32071:
INCBIN "baserom.gbc", $32071, $32072 - $32071

LoggedData_0x32072:
INCBIN "baserom.gbc", $32072, $32075 - $32072

UnknownData_0x32075:
INCBIN "baserom.gbc", $32075, $32076 - $32075

LoggedData_0x32076:
INCBIN "baserom.gbc", $32076, $32079 - $32076

UnknownData_0x32079:
INCBIN "baserom.gbc", $32079, $3207A - $32079

LoggedData_0x3207A:
INCBIN "baserom.gbc", $3207A, $3207D - $3207A

UnknownData_0x3207D:
INCBIN "baserom.gbc", $3207D, $3207E - $3207D

LoggedData_0x3207E:
INCBIN "baserom.gbc", $3207E, $32081 - $3207E

UnknownData_0x32081:
INCBIN "baserom.gbc", $32081, $32082 - $32081

LoggedData_0x32082:
INCBIN "baserom.gbc", $32082, $32085 - $32082

UnknownData_0x32085:
INCBIN "baserom.gbc", $32085, $32086 - $32085

LoggedData_0x32086:
INCBIN "baserom.gbc", $32086, $32089 - $32086

UnknownData_0x32089:
INCBIN "baserom.gbc", $32089, $3208A - $32089

LoggedData_0x3208A:
INCBIN "baserom.gbc", $3208A, $3208D - $3208A

UnknownData_0x3208D:
INCBIN "baserom.gbc", $3208D, $3208E - $3208D

LoggedData_0x3208E:
INCBIN "baserom.gbc", $3208E, $32091 - $3208E

UnknownData_0x32091:
INCBIN "baserom.gbc", $32091, $32092 - $32091

LoggedData_0x32092:
INCBIN "baserom.gbc", $32092, $32095 - $32092

UnknownData_0x32095:
INCBIN "baserom.gbc", $32095, $32096 - $32095

LoggedData_0x32096:
INCBIN "baserom.gbc", $32096, $32099 - $32096

UnknownData_0x32099:
INCBIN "baserom.gbc", $32099, $3209A - $32099

LoggedData_0x3209A:
INCBIN "baserom.gbc", $3209A, $3209D - $3209A

UnknownData_0x3209D:
INCBIN "baserom.gbc", $3209D, $3209E - $3209D

LoggedData_0x3209E:
INCBIN "baserom.gbc", $3209E, $320A1 - $3209E

UnknownData_0x320A1:
INCBIN "baserom.gbc", $320A1, $320A2 - $320A1

LoggedData_0x320A2:
INCBIN "baserom.gbc", $320A2, $320A5 - $320A2

UnknownData_0x320A5:
INCBIN "baserom.gbc", $320A5, $320A6 - $320A5

LoggedData_0x320A6:
INCBIN "baserom.gbc", $320A6, $320A9 - $320A6

UnknownData_0x320A9:
INCBIN "baserom.gbc", $320A9, $320AA - $320A9

LoggedData_0x320AA:
INCBIN "baserom.gbc", $320AA, $320AD - $320AA

UnknownData_0x320AD:
INCBIN "baserom.gbc", $320AD, $320AE - $320AD

LoggedData_0x320AE:
INCBIN "baserom.gbc", $320AE, $320B1 - $320AE

UnknownData_0x320B1:
INCBIN "baserom.gbc", $320B1, $320B2 - $320B1

LoggedData_0x320B2:
INCBIN "baserom.gbc", $320B2, $320B5 - $320B2

UnknownData_0x320B5:
INCBIN "baserom.gbc", $320B5, $320B6 - $320B5

LoggedData_0x320B6:
INCBIN "baserom.gbc", $320B6, $320B9 - $320B6

UnknownData_0x320B9:
INCBIN "baserom.gbc", $320B9, $320BA - $320B9

LoggedData_0x320BA:
INCBIN "baserom.gbc", $320BA, $320BD - $320BA

UnknownData_0x320BD:
INCBIN "baserom.gbc", $320BD, $320BE - $320BD

LoggedData_0x320BE:
INCBIN "baserom.gbc", $320BE, $320C1 - $320BE

UnknownData_0x320C1:
INCBIN "baserom.gbc", $320C1, $320C2 - $320C1

LoggedData_0x320C2:
INCBIN "baserom.gbc", $320C2, $320C5 - $320C2

UnknownData_0x320C5:
INCBIN "baserom.gbc", $320C5, $320C6 - $320C5

LoggedData_0x320C6:
INCBIN "baserom.gbc", $320C6, $320C9 - $320C6

UnknownData_0x320C9:
INCBIN "baserom.gbc", $320C9, $320CA - $320C9

LoggedData_0x320CA:
INCBIN "baserom.gbc", $320CA, $320CD - $320CA

UnknownData_0x320CD:
INCBIN "baserom.gbc", $320CD, $320D6 - $320CD

LoggedData_0x320D6:
INCBIN "baserom.gbc", $320D6, $320D9 - $320D6

UnknownData_0x320D9:
INCBIN "baserom.gbc", $320D9, $320DA - $320D9

LoggedData_0x320DA:
INCBIN "baserom.gbc", $320DA, $320DD - $320DA

UnknownData_0x320DD:
INCBIN "baserom.gbc", $320DD, $320DE - $320DD

LoggedData_0x320DE:
INCBIN "baserom.gbc", $320DE, $320E1 - $320DE

UnknownData_0x320E1:
INCBIN "baserom.gbc", $320E1, $320E2 - $320E1

LoggedData_0x320E2:
INCBIN "baserom.gbc", $320E2, $320E5 - $320E2

UnknownData_0x320E5:
INCBIN "baserom.gbc", $320E5, $320E6 - $320E5

LoggedData_0x320E6:
INCBIN "baserom.gbc", $320E6, $320E9 - $320E6

UnknownData_0x320E9:
INCBIN "baserom.gbc", $320E9, $320EA - $320E9

LoggedData_0x320EA:
INCBIN "baserom.gbc", $320EA, $320ED - $320EA

UnknownData_0x320ED:
INCBIN "baserom.gbc", $320ED, $320EE - $320ED

LoggedData_0x320EE:
INCBIN "baserom.gbc", $320EE, $320F1 - $320EE

UnknownData_0x320F1:
INCBIN "baserom.gbc", $320F1, $320F2 - $320F1

LoggedData_0x320F2:
INCBIN "baserom.gbc", $320F2, $320F5 - $320F2

UnknownData_0x320F5:
INCBIN "baserom.gbc", $320F5, $320F6 - $320F5

LoggedData_0x320F6:
INCBIN "baserom.gbc", $320F6, $320F9 - $320F6

UnknownData_0x320F9:
INCBIN "baserom.gbc", $320F9, $320FA - $320F9

LoggedData_0x320FA:
INCBIN "baserom.gbc", $320FA, $320FD - $320FA

UnknownData_0x320FD:
INCBIN "baserom.gbc", $320FD, $320FE - $320FD

LoggedData_0x320FE:
INCBIN "baserom.gbc", $320FE, $32101 - $320FE

UnknownData_0x32101:
INCBIN "baserom.gbc", $32101, $32102 - $32101

LoggedData_0x32102:
INCBIN "baserom.gbc", $32102, $32105 - $32102

UnknownData_0x32105:
INCBIN "baserom.gbc", $32105, $32106 - $32105

LoggedData_0x32106:
INCBIN "baserom.gbc", $32106, $32109 - $32106

UnknownData_0x32109:
INCBIN "baserom.gbc", $32109, $3210A - $32109

LoggedData_0x3210A:
INCBIN "baserom.gbc", $3210A, $3210D - $3210A

UnknownData_0x3210D:
INCBIN "baserom.gbc", $3210D, $3210E - $3210D

LoggedData_0x3210E:
INCBIN "baserom.gbc", $3210E, $32111 - $3210E

UnknownData_0x32111:
INCBIN "baserom.gbc", $32111, $32112 - $32111

LoggedData_0x32112:
INCBIN "baserom.gbc", $32112, $32115 - $32112

UnknownData_0x32115:
INCBIN "baserom.gbc", $32115, $32116 - $32115

LoggedData_0x32116:
INCBIN "baserom.gbc", $32116, $32119 - $32116

UnknownData_0x32119:
INCBIN "baserom.gbc", $32119, $3211A - $32119

LoggedData_0x3211A:
INCBIN "baserom.gbc", $3211A, $3211D - $3211A

UnknownData_0x3211D:
INCBIN "baserom.gbc", $3211D, $3211E - $3211D

LoggedData_0x3211E:
INCBIN "baserom.gbc", $3211E, $32121 - $3211E

UnknownData_0x32121:
INCBIN "baserom.gbc", $32121, $32122 - $32121

LoggedData_0x32122:
INCBIN "baserom.gbc", $32122, $32125 - $32122

UnknownData_0x32125:
INCBIN "baserom.gbc", $32125, $32126 - $32125

LoggedData_0x32126:
INCBIN "baserom.gbc", $32126, $32129 - $32126

UnknownData_0x32129:
INCBIN "baserom.gbc", $32129, $3212A - $32129

LoggedData_0x3212A:
INCBIN "baserom.gbc", $3212A, $3212D - $3212A

UnknownData_0x3212D:
INCBIN "baserom.gbc", $3212D, $3212E - $3212D

LoggedData_0x3212E:
INCBIN "baserom.gbc", $3212E, $32131 - $3212E

UnknownData_0x32131:
INCBIN "baserom.gbc", $32131, $32132 - $32131

LoggedData_0x32132:
INCBIN "baserom.gbc", $32132, $32135 - $32132

UnknownData_0x32135:
INCBIN "baserom.gbc", $32135, $32136 - $32135

LoggedData_0x32136:
INCBIN "baserom.gbc", $32136, $32139 - $32136

UnknownData_0x32139:
INCBIN "baserom.gbc", $32139, $3213A - $32139

LoggedData_0x3213A:
INCBIN "baserom.gbc", $3213A, $3213D - $3213A

UnknownData_0x3213D:
INCBIN "baserom.gbc", $3213D, $3213E - $3213D

LoggedData_0x3213E:
INCBIN "baserom.gbc", $3213E, $32141 - $3213E

UnknownData_0x32141:
INCBIN "baserom.gbc", $32141, $32142 - $32141

LoggedData_0x32142:
INCBIN "baserom.gbc", $32142, $32145 - $32142

UnknownData_0x32145:
INCBIN "baserom.gbc", $32145, $32146 - $32145

LoggedData_0x32146:
INCBIN "baserom.gbc", $32146, $32149 - $32146

UnknownData_0x32149:
INCBIN "baserom.gbc", $32149, $3214A - $32149

LoggedData_0x3214A:
INCBIN "baserom.gbc", $3214A, $3214D - $3214A

UnknownData_0x3214D:
INCBIN "baserom.gbc", $3214D, $3214E - $3214D

LoggedData_0x3214E:
INCBIN "baserom.gbc", $3214E, $32151 - $3214E

UnknownData_0x32151:
INCBIN "baserom.gbc", $32151, $32152 - $32151

LoggedData_0x32152:
INCBIN "baserom.gbc", $32152, $32155 - $32152

UnknownData_0x32155:
INCBIN "baserom.gbc", $32155, $32156 - $32155

LoggedData_0x32156:
INCBIN "baserom.gbc", $32156, $32159 - $32156

UnknownData_0x32159:
INCBIN "baserom.gbc", $32159, $3215A - $32159

LoggedData_0x3215A:
INCBIN "baserom.gbc", $3215A, $3215D - $3215A

UnknownData_0x3215D:
INCBIN "baserom.gbc", $3215D, $3215E - $3215D

LoggedData_0x3215E:
INCBIN "baserom.gbc", $3215E, $32161 - $3215E

UnknownData_0x32161:
INCBIN "baserom.gbc", $32161, $32162 - $32161

LoggedData_0x32162:
INCBIN "baserom.gbc", $32162, $32165 - $32162

UnknownData_0x32165:
INCBIN "baserom.gbc", $32165, $32166 - $32165

LoggedData_0x32166:
INCBIN "baserom.gbc", $32166, $32169 - $32166

UnknownData_0x32169:
INCBIN "baserom.gbc", $32169, $3216A - $32169

LoggedData_0x3216A:
INCBIN "baserom.gbc", $3216A, $3216D - $3216A

UnknownData_0x3216D:
INCBIN "baserom.gbc", $3216D, $3216E - $3216D

LoggedData_0x3216E:
INCBIN "baserom.gbc", $3216E, $32171 - $3216E

UnknownData_0x32171:
INCBIN "baserom.gbc", $32171, $32172 - $32171

LoggedData_0x32172:
INCBIN "baserom.gbc", $32172, $32175 - $32172

UnknownData_0x32175:
INCBIN "baserom.gbc", $32175, $32176 - $32175

LoggedData_0x32176:
INCBIN "baserom.gbc", $32176, $32179 - $32176

UnknownData_0x32179:
INCBIN "baserom.gbc", $32179, $3217A - $32179

LoggedData_0x3217A:
INCBIN "baserom.gbc", $3217A, $3217D - $3217A

UnknownData_0x3217D:
INCBIN "baserom.gbc", $3217D, $3217E - $3217D

LoggedData_0x3217E:
INCBIN "baserom.gbc", $3217E, $32181 - $3217E

UnknownData_0x32181:
INCBIN "baserom.gbc", $32181, $32182 - $32181

LoggedData_0x32182:
INCBIN "baserom.gbc", $32182, $32185 - $32182

UnknownData_0x32185:
INCBIN "baserom.gbc", $32185, $32186 - $32185

LoggedData_0x32186:
INCBIN "baserom.gbc", $32186, $32189 - $32186

UnknownData_0x32189:
INCBIN "baserom.gbc", $32189, $3218A - $32189

LoggedData_0x3218A:
INCBIN "baserom.gbc", $3218A, $3218D - $3218A

UnknownData_0x3218D:
INCBIN "baserom.gbc", $3218D, $3218E - $3218D

LoggedData_0x3218E:
INCBIN "baserom.gbc", $3218E, $32191 - $3218E

UnknownData_0x32191:
INCBIN "baserom.gbc", $32191, $32192 - $32191

LoggedData_0x32192:
INCBIN "baserom.gbc", $32192, $32195 - $32192

UnknownData_0x32195:
INCBIN "baserom.gbc", $32195, $32196 - $32195

LoggedData_0x32196:
INCBIN "baserom.gbc", $32196, $32199 - $32196

UnknownData_0x32199:
INCBIN "baserom.gbc", $32199, $3219A - $32199

LoggedData_0x3219A:
INCBIN "baserom.gbc", $3219A, $3219D - $3219A

UnknownData_0x3219D:
INCBIN "baserom.gbc", $3219D, $3219E - $3219D

LoggedData_0x3219E:
INCBIN "baserom.gbc", $3219E, $321A1 - $3219E

UnknownData_0x321A1:
INCBIN "baserom.gbc", $321A1, $321A2 - $321A1

LoggedData_0x321A2:
INCBIN "baserom.gbc", $321A2, $321A5 - $321A2

UnknownData_0x321A5:
INCBIN "baserom.gbc", $321A5, $321A6 - $321A5

LoggedData_0x321A6:
INCBIN "baserom.gbc", $321A6, $321A9 - $321A6

UnknownData_0x321A9:
INCBIN "baserom.gbc", $321A9, $321AA - $321A9

LoggedData_0x321AA:
INCBIN "baserom.gbc", $321AA, $321AD - $321AA

UnknownData_0x321AD:
INCBIN "baserom.gbc", $321AD, $321AE - $321AD

LoggedData_0x321AE:
INCBIN "baserom.gbc", $321AE, $321B1 - $321AE

UnknownData_0x321B1:
INCBIN "baserom.gbc", $321B1, $321B2 - $321B1

LoggedData_0x321B2:
INCBIN "baserom.gbc", $321B2, $321B5 - $321B2

UnknownData_0x321B5:
INCBIN "baserom.gbc", $321B5, $321B6 - $321B5

LoggedData_0x321B6:
INCBIN "baserom.gbc", $321B6, $321B9 - $321B6

UnknownData_0x321B9:
INCBIN "baserom.gbc", $321B9, $321BA - $321B9

LoggedData_0x321BA:
INCBIN "baserom.gbc", $321BA, $321BD - $321BA

UnknownData_0x321BD:
INCBIN "baserom.gbc", $321BD, $321BE - $321BD

LoggedData_0x321BE:
INCBIN "baserom.gbc", $321BE, $321C1 - $321BE

UnknownData_0x321C1:
INCBIN "baserom.gbc", $321C1, $321C2 - $321C1

LoggedData_0x321C2:
INCBIN "baserom.gbc", $321C2, $321C5 - $321C2

UnknownData_0x321C5:
INCBIN "baserom.gbc", $321C5, $321C6 - $321C5

LoggedData_0x321C6:
INCBIN "baserom.gbc", $321C6, $321C9 - $321C6

UnknownData_0x321C9:
INCBIN "baserom.gbc", $321C9, $321CA - $321C9

LoggedData_0x321CA:
INCBIN "baserom.gbc", $321CA, $321CD - $321CA

UnknownData_0x321CD:
INCBIN "baserom.gbc", $321CD, $321CE - $321CD

LoggedData_0x321CE:
INCBIN "baserom.gbc", $321CE, $321D1 - $321CE

UnknownData_0x321D1:
INCBIN "baserom.gbc", $321D1, $321D2 - $321D1

LoggedData_0x321D2:
INCBIN "baserom.gbc", $321D2, $321D5 - $321D2

UnknownData_0x321D5:
INCBIN "baserom.gbc", $321D5, $321D6 - $321D5

LoggedData_0x321D6:
INCBIN "baserom.gbc", $321D6, $321D9 - $321D6

UnknownData_0x321D9:
INCBIN "baserom.gbc", $321D9, $321DA - $321D9

LoggedData_0x321DA:
INCBIN "baserom.gbc", $321DA, $321DD - $321DA

UnknownData_0x321DD:
INCBIN "baserom.gbc", $321DD, $32266 - $321DD

LoggedData_0x32266:
INCBIN "baserom.gbc", $32266, $32269 - $32266

UnknownData_0x32269:
INCBIN "baserom.gbc", $32269, $3226A - $32269

LoggedData_0x3226A:
INCBIN "baserom.gbc", $3226A, $3226D - $3226A

UnknownData_0x3226D:
INCBIN "baserom.gbc", $3226D, $3226E - $3226D

LoggedData_0x3226E:
INCBIN "baserom.gbc", $3226E, $32271 - $3226E

UnknownData_0x32271:
INCBIN "baserom.gbc", $32271, $32272 - $32271

LoggedData_0x32272:
INCBIN "baserom.gbc", $32272, $32275 - $32272

UnknownData_0x32275:
INCBIN "baserom.gbc", $32275, $32276 - $32275

LoggedData_0x32276:
INCBIN "baserom.gbc", $32276, $32279 - $32276

UnknownData_0x32279:
INCBIN "baserom.gbc", $32279, $3227A - $32279

LoggedData_0x3227A:
INCBIN "baserom.gbc", $3227A, $3227D - $3227A

UnknownData_0x3227D:
INCBIN "baserom.gbc", $3227D, $3227E - $3227D

LoggedData_0x3227E:
INCBIN "baserom.gbc", $3227E, $32281 - $3227E

UnknownData_0x32281:
INCBIN "baserom.gbc", $32281, $32282 - $32281

LoggedData_0x32282:
INCBIN "baserom.gbc", $32282, $32285 - $32282

UnknownData_0x32285:
INCBIN "baserom.gbc", $32285, $32286 - $32285

LoggedData_0x32286:
INCBIN "baserom.gbc", $32286, $32289 - $32286

UnknownData_0x32289:
INCBIN "baserom.gbc", $32289, $3228A - $32289

LoggedData_0x3228A:
INCBIN "baserom.gbc", $3228A, $3228D - $3228A

UnknownData_0x3228D:
INCBIN "baserom.gbc", $3228D, $3228E - $3228D

LoggedData_0x3228E:
INCBIN "baserom.gbc", $3228E, $32291 - $3228E

UnknownData_0x32291:
INCBIN "baserom.gbc", $32291, $32292 - $32291

LoggedData_0x32292:
INCBIN "baserom.gbc", $32292, $32295 - $32292

UnknownData_0x32295:
INCBIN "baserom.gbc", $32295, $32296 - $32295

LoggedData_0x32296:
INCBIN "baserom.gbc", $32296, $32299 - $32296

UnknownData_0x32299:
INCBIN "baserom.gbc", $32299, $3229A - $32299

LoggedData_0x3229A:
INCBIN "baserom.gbc", $3229A, $3229D - $3229A

UnknownData_0x3229D:
INCBIN "baserom.gbc", $3229D, $3229E - $3229D

LoggedData_0x3229E:
INCBIN "baserom.gbc", $3229E, $322A1 - $3229E

UnknownData_0x322A1:
INCBIN "baserom.gbc", $322A1, $322A2 - $322A1

LoggedData_0x322A2:
INCBIN "baserom.gbc", $322A2, $322A5 - $322A2

UnknownData_0x322A5:
INCBIN "baserom.gbc", $322A5, $322A6 - $322A5

LoggedData_0x322A6:
INCBIN "baserom.gbc", $322A6, $322A9 - $322A6

UnknownData_0x322A9:
INCBIN "baserom.gbc", $322A9, $322AA - $322A9

LoggedData_0x322AA:
INCBIN "baserom.gbc", $322AA, $322AD - $322AA

UnknownData_0x322AD:
INCBIN "baserom.gbc", $322AD, $322AE - $322AD

LoggedData_0x322AE:
INCBIN "baserom.gbc", $322AE, $322B1 - $322AE

UnknownData_0x322B1:
INCBIN "baserom.gbc", $322B1, $322B2 - $322B1

LoggedData_0x322B2:
INCBIN "baserom.gbc", $322B2, $322B5 - $322B2

UnknownData_0x322B5:
INCBIN "baserom.gbc", $322B5, $322B6 - $322B5

LoggedData_0x322B6:
INCBIN "baserom.gbc", $322B6, $322B9 - $322B6

UnknownData_0x322B9:
INCBIN "baserom.gbc", $322B9, $322BA - $322B9

LoggedData_0x322BA:
INCBIN "baserom.gbc", $322BA, $322BD - $322BA

UnknownData_0x322BD:
INCBIN "baserom.gbc", $322BD, $322BE - $322BD

LoggedData_0x322BE:
INCBIN "baserom.gbc", $322BE, $322C1 - $322BE

UnknownData_0x322C1:
INCBIN "baserom.gbc", $322C1, $322C2 - $322C1

LoggedData_0x322C2:
INCBIN "baserom.gbc", $322C2, $322C5 - $322C2

UnknownData_0x322C5:
INCBIN "baserom.gbc", $322C5, $322C6 - $322C5

LoggedData_0x322C6:
INCBIN "baserom.gbc", $322C6, $322C9 - $322C6

UnknownData_0x322C9:
INCBIN "baserom.gbc", $322C9, $322CA - $322C9

LoggedData_0x322CA:
INCBIN "baserom.gbc", $322CA, $322CD - $322CA

UnknownData_0x322CD:
INCBIN "baserom.gbc", $322CD, $322D6 - $322CD

LoggedData_0x322D6:
INCBIN "baserom.gbc", $322D6, $322D9 - $322D6

UnknownData_0x322D9:
INCBIN "baserom.gbc", $322D9, $322DA - $322D9

LoggedData_0x322DA:
INCBIN "baserom.gbc", $322DA, $322DD - $322DA

UnknownData_0x322DD:
INCBIN "baserom.gbc", $322DD, $322DE - $322DD

LoggedData_0x322DE:
INCBIN "baserom.gbc", $322DE, $322E1 - $322DE

UnknownData_0x322E1:
INCBIN "baserom.gbc", $322E1, $322E2 - $322E1

LoggedData_0x322E2:
INCBIN "baserom.gbc", $322E2, $322E5 - $322E2

UnknownData_0x322E5:
INCBIN "baserom.gbc", $322E5, $322E6 - $322E5

LoggedData_0x322E6:
INCBIN "baserom.gbc", $322E6, $322E9 - $322E6

UnknownData_0x322E9:
INCBIN "baserom.gbc", $322E9, $322EA - $322E9

LoggedData_0x322EA:
INCBIN "baserom.gbc", $322EA, $322ED - $322EA

UnknownData_0x322ED:
INCBIN "baserom.gbc", $322ED, $322EE - $322ED

LoggedData_0x322EE:
INCBIN "baserom.gbc", $322EE, $322F1 - $322EE

UnknownData_0x322F1:
INCBIN "baserom.gbc", $322F1, $322F2 - $322F1

LoggedData_0x322F2:
INCBIN "baserom.gbc", $322F2, $322F5 - $322F2

UnknownData_0x322F5:
INCBIN "baserom.gbc", $322F5, $322F6 - $322F5

LoggedData_0x322F6:
INCBIN "baserom.gbc", $322F6, $322F9 - $322F6

UnknownData_0x322F9:
INCBIN "baserom.gbc", $322F9, $322FA - $322F9

LoggedData_0x322FA:
INCBIN "baserom.gbc", $322FA, $322FD - $322FA

UnknownData_0x322FD:
INCBIN "baserom.gbc", $322FD, $322FE - $322FD

LoggedData_0x322FE:
INCBIN "baserom.gbc", $322FE, $32301 - $322FE

UnknownData_0x32301:
INCBIN "baserom.gbc", $32301, $32302 - $32301

LoggedData_0x32302:
INCBIN "baserom.gbc", $32302, $32305 - $32302

UnknownData_0x32305:
INCBIN "baserom.gbc", $32305, $32306 - $32305

LoggedData_0x32306:
INCBIN "baserom.gbc", $32306, $32309 - $32306

UnknownData_0x32309:
INCBIN "baserom.gbc", $32309, $3230A - $32309

LoggedData_0x3230A:
INCBIN "baserom.gbc", $3230A, $3230D - $3230A

UnknownData_0x3230D:
INCBIN "baserom.gbc", $3230D, $3230E - $3230D

LoggedData_0x3230E:
INCBIN "baserom.gbc", $3230E, $32311 - $3230E

UnknownData_0x32311:
INCBIN "baserom.gbc", $32311, $32312 - $32311

LoggedData_0x32312:
INCBIN "baserom.gbc", $32312, $32315 - $32312

UnknownData_0x32315:
INCBIN "baserom.gbc", $32315, $3231E - $32315

LoggedData_0x3231E:
INCBIN "baserom.gbc", $3231E, $32321 - $3231E

UnknownData_0x32321:
INCBIN "baserom.gbc", $32321, $32322 - $32321

LoggedData_0x32322:
INCBIN "baserom.gbc", $32322, $32325 - $32322

UnknownData_0x32325:
INCBIN "baserom.gbc", $32325, $32326 - $32325

LoggedData_0x32326:
INCBIN "baserom.gbc", $32326, $32329 - $32326

UnknownData_0x32329:
INCBIN "baserom.gbc", $32329, $3232A - $32329

LoggedData_0x3232A:
INCBIN "baserom.gbc", $3232A, $3232D - $3232A

UnknownData_0x3232D:
INCBIN "baserom.gbc", $3232D, $3232E - $3232D

LoggedData_0x3232E:
INCBIN "baserom.gbc", $3232E, $32331 - $3232E

UnknownData_0x32331:
INCBIN "baserom.gbc", $32331, $32332 - $32331

LoggedData_0x32332:
INCBIN "baserom.gbc", $32332, $32335 - $32332

UnknownData_0x32335:
INCBIN "baserom.gbc", $32335, $32336 - $32335

LoggedData_0x32336:
INCBIN "baserom.gbc", $32336, $32339 - $32336

UnknownData_0x32339:
INCBIN "baserom.gbc", $32339, $3233A - $32339

LoggedData_0x3233A:
INCBIN "baserom.gbc", $3233A, $3233D - $3233A

UnknownData_0x3233D:
INCBIN "baserom.gbc", $3233D, $3233E - $3233D

LoggedData_0x3233E:
INCBIN "baserom.gbc", $3233E, $32341 - $3233E

UnknownData_0x32341:
INCBIN "baserom.gbc", $32341, $32342 - $32341

LoggedData_0x32342:
INCBIN "baserom.gbc", $32342, $32345 - $32342

UnknownData_0x32345:
INCBIN "baserom.gbc", $32345, $32346 - $32345

LoggedData_0x32346:
INCBIN "baserom.gbc", $32346, $32349 - $32346

UnknownData_0x32349:
INCBIN "baserom.gbc", $32349, $3234A - $32349

LoggedData_0x3234A:
INCBIN "baserom.gbc", $3234A, $3234D - $3234A

UnknownData_0x3234D:
INCBIN "baserom.gbc", $3234D, $3234E - $3234D

LoggedData_0x3234E:
INCBIN "baserom.gbc", $3234E, $32351 - $3234E

UnknownData_0x32351:
INCBIN "baserom.gbc", $32351, $32352 - $32351

LoggedData_0x32352:
INCBIN "baserom.gbc", $32352, $32355 - $32352

UnknownData_0x32355:
INCBIN "baserom.gbc", $32355, $32356 - $32355

LoggedData_0x32356:
INCBIN "baserom.gbc", $32356, $32359 - $32356

UnknownData_0x32359:
INCBIN "baserom.gbc", $32359, $3235A - $32359

LoggedData_0x3235A:
INCBIN "baserom.gbc", $3235A, $3235D - $3235A

UnknownData_0x3235D:
INCBIN "baserom.gbc", $3235D, $3235E - $3235D

LoggedData_0x3235E:
INCBIN "baserom.gbc", $3235E, $32361 - $3235E

UnknownData_0x32361:
INCBIN "baserom.gbc", $32361, $32362 - $32361

LoggedData_0x32362:
INCBIN "baserom.gbc", $32362, $32365 - $32362

UnknownData_0x32365:
INCBIN "baserom.gbc", $32365, $32366 - $32365

LoggedData_0x32366:
INCBIN "baserom.gbc", $32366, $32369 - $32366

UnknownData_0x32369:
INCBIN "baserom.gbc", $32369, $3236A - $32369

LoggedData_0x3236A:
INCBIN "baserom.gbc", $3236A, $3236D - $3236A

UnknownData_0x3236D:
INCBIN "baserom.gbc", $3236D, $3236E - $3236D

LoggedData_0x3236E:
INCBIN "baserom.gbc", $3236E, $32371 - $3236E

UnknownData_0x32371:
INCBIN "baserom.gbc", $32371, $32372 - $32371

LoggedData_0x32372:
INCBIN "baserom.gbc", $32372, $32375 - $32372

UnknownData_0x32375:
INCBIN "baserom.gbc", $32375, $32376 - $32375

LoggedData_0x32376:
INCBIN "baserom.gbc", $32376, $32379 - $32376

UnknownData_0x32379:
INCBIN "baserom.gbc", $32379, $3237A - $32379

LoggedData_0x3237A:
INCBIN "baserom.gbc", $3237A, $3237D - $3237A

UnknownData_0x3237D:
INCBIN "baserom.gbc", $3237D, $3237E - $3237D

LoggedData_0x3237E:
INCBIN "baserom.gbc", $3237E, $32381 - $3237E

UnknownData_0x32381:
INCBIN "baserom.gbc", $32381, $32382 - $32381

LoggedData_0x32382:
INCBIN "baserom.gbc", $32382, $32385 - $32382

UnknownData_0x32385:
INCBIN "baserom.gbc", $32385, $32386 - $32385

LoggedData_0x32386:
INCBIN "baserom.gbc", $32386, $32389 - $32386

UnknownData_0x32389:
INCBIN "baserom.gbc", $32389, $3238A - $32389

LoggedData_0x3238A:
INCBIN "baserom.gbc", $3238A, $3238D - $3238A

UnknownData_0x3238D:
INCBIN "baserom.gbc", $3238D, $3238E - $3238D

LoggedData_0x3238E:
INCBIN "baserom.gbc", $3238E, $32391 - $3238E

UnknownData_0x32391:
INCBIN "baserom.gbc", $32391, $32392 - $32391

LoggedData_0x32392:
INCBIN "baserom.gbc", $32392, $32395 - $32392

UnknownData_0x32395:
INCBIN "baserom.gbc", $32395, $32396 - $32395

LoggedData_0x32396:
INCBIN "baserom.gbc", $32396, $32399 - $32396

UnknownData_0x32399:
INCBIN "baserom.gbc", $32399, $3239A - $32399

LoggedData_0x3239A:
INCBIN "baserom.gbc", $3239A, $3239D - $3239A

UnknownData_0x3239D:
INCBIN "baserom.gbc", $3239D, $3239E - $3239D

LoggedData_0x3239E:
INCBIN "baserom.gbc", $3239E, $323A1 - $3239E

UnknownData_0x323A1:
INCBIN "baserom.gbc", $323A1, $323A2 - $323A1

LoggedData_0x323A2:
INCBIN "baserom.gbc", $323A2, $323A5 - $323A2

UnknownData_0x323A5:
INCBIN "baserom.gbc", $323A5, $323AE - $323A5

LoggedData_0x323AE:
INCBIN "baserom.gbc", $323AE, $323B1 - $323AE

UnknownData_0x323B1:
INCBIN "baserom.gbc", $323B1, $323B2 - $323B1

LoggedData_0x323B2:
INCBIN "baserom.gbc", $323B2, $323B5 - $323B2

UnknownData_0x323B5:
INCBIN "baserom.gbc", $323B5, $323B6 - $323B5

LoggedData_0x323B6:
INCBIN "baserom.gbc", $323B6, $323B9 - $323B6

UnknownData_0x323B9:
INCBIN "baserom.gbc", $323B9, $323BA - $323B9

LoggedData_0x323BA:
INCBIN "baserom.gbc", $323BA, $323BD - $323BA

UnknownData_0x323BD:
INCBIN "baserom.gbc", $323BD, $323BE - $323BD

LoggedData_0x323BE:
INCBIN "baserom.gbc", $323BE, $323C1 - $323BE

UnknownData_0x323C1:
INCBIN "baserom.gbc", $323C1, $323C2 - $323C1

LoggedData_0x323C2:
INCBIN "baserom.gbc", $323C2, $323C5 - $323C2

UnknownData_0x323C5:
INCBIN "baserom.gbc", $323C5, $323C6 - $323C5

LoggedData_0x323C6:
INCBIN "baserom.gbc", $323C6, $323C9 - $323C6

UnknownData_0x323C9:
INCBIN "baserom.gbc", $323C9, $323CA - $323C9

LoggedData_0x323CA:
INCBIN "baserom.gbc", $323CA, $323CD - $323CA

UnknownData_0x323CD:
INCBIN "baserom.gbc", $323CD, $323CE - $323CD

LoggedData_0x323CE:
INCBIN "baserom.gbc", $323CE, $323D1 - $323CE

UnknownData_0x323D1:
INCBIN "baserom.gbc", $323D1, $323D2 - $323D1

LoggedData_0x323D2:
INCBIN "baserom.gbc", $323D2, $323D5 - $323D2

UnknownData_0x323D5:
INCBIN "baserom.gbc", $323D5, $323D6 - $323D5

LoggedData_0x323D6:
INCBIN "baserom.gbc", $323D6, $323D9 - $323D6

UnknownData_0x323D9:
INCBIN "baserom.gbc", $323D9, $323DA - $323D9

LoggedData_0x323DA:
INCBIN "baserom.gbc", $323DA, $323DD - $323DA

UnknownData_0x323DD:
INCBIN "baserom.gbc", $323DD, $323DE - $323DD

LoggedData_0x323DE:
INCBIN "baserom.gbc", $323DE, $323E1 - $323DE

UnknownData_0x323E1:
INCBIN "baserom.gbc", $323E1, $323E2 - $323E1

LoggedData_0x323E2:
INCBIN "baserom.gbc", $323E2, $323E5 - $323E2

UnknownData_0x323E5:
INCBIN "baserom.gbc", $323E5, $323E6 - $323E5

LoggedData_0x323E6:
INCBIN "baserom.gbc", $323E6, $323E9 - $323E6

UnknownData_0x323E9:
INCBIN "baserom.gbc", $323E9, $323EA - $323E9

LoggedData_0x323EA:
INCBIN "baserom.gbc", $323EA, $323ED - $323EA

UnknownData_0x323ED:
INCBIN "baserom.gbc", $323ED, $32466 - $323ED

LoggedData_0x32466:
INCBIN "baserom.gbc", $32466, $32469 - $32466

UnknownData_0x32469:
INCBIN "baserom.gbc", $32469, $3246A - $32469

LoggedData_0x3246A:
INCBIN "baserom.gbc", $3246A, $3246D - $3246A

UnknownData_0x3246D:
INCBIN "baserom.gbc", $3246D, $3246E - $3246D

LoggedData_0x3246E:
INCBIN "baserom.gbc", $3246E, $32471 - $3246E

UnknownData_0x32471:
INCBIN "baserom.gbc", $32471, $32472 - $32471

LoggedData_0x32472:
INCBIN "baserom.gbc", $32472, $32475 - $32472

UnknownData_0x32475:
INCBIN "baserom.gbc", $32475, $32476 - $32475

LoggedData_0x32476:
INCBIN "baserom.gbc", $32476, $32479 - $32476

UnknownData_0x32479:
INCBIN "baserom.gbc", $32479, $3247A - $32479

LoggedData_0x3247A:
INCBIN "baserom.gbc", $3247A, $3247D - $3247A

UnknownData_0x3247D:
INCBIN "baserom.gbc", $3247D, $3247E - $3247D

LoggedData_0x3247E:
INCBIN "baserom.gbc", $3247E, $32481 - $3247E

UnknownData_0x32481:
INCBIN "baserom.gbc", $32481, $32482 - $32481

LoggedData_0x32482:
INCBIN "baserom.gbc", $32482, $32485 - $32482

UnknownData_0x32485:
INCBIN "baserom.gbc", $32485, $32486 - $32485

LoggedData_0x32486:
INCBIN "baserom.gbc", $32486, $32489 - $32486

UnknownData_0x32489:
INCBIN "baserom.gbc", $32489, $3248A - $32489

LoggedData_0x3248A:
INCBIN "baserom.gbc", $3248A, $3248D - $3248A

UnknownData_0x3248D:
INCBIN "baserom.gbc", $3248D, $3248E - $3248D

LoggedData_0x3248E:
INCBIN "baserom.gbc", $3248E, $32491 - $3248E

UnknownData_0x32491:
INCBIN "baserom.gbc", $32491, $32492 - $32491

LoggedData_0x32492:
INCBIN "baserom.gbc", $32492, $32495 - $32492

UnknownData_0x32495:
INCBIN "baserom.gbc", $32495, $32496 - $32495

LoggedData_0x32496:
INCBIN "baserom.gbc", $32496, $32499 - $32496

UnknownData_0x32499:
INCBIN "baserom.gbc", $32499, $3249A - $32499

LoggedData_0x3249A:
INCBIN "baserom.gbc", $3249A, $3249D - $3249A

UnknownData_0x3249D:
INCBIN "baserom.gbc", $3249D, $3249E - $3249D

LoggedData_0x3249E:
INCBIN "baserom.gbc", $3249E, $324A1 - $3249E

UnknownData_0x324A1:
INCBIN "baserom.gbc", $324A1, $324A2 - $324A1

LoggedData_0x324A2:
INCBIN "baserom.gbc", $324A2, $324A5 - $324A2

UnknownData_0x324A5:
INCBIN "baserom.gbc", $324A5, $324A6 - $324A5

LoggedData_0x324A6:
INCBIN "baserom.gbc", $324A6, $324A9 - $324A6

UnknownData_0x324A9:
INCBIN "baserom.gbc", $324A9, $324AA - $324A9

LoggedData_0x324AA:
INCBIN "baserom.gbc", $324AA, $324AD - $324AA

UnknownData_0x324AD:
INCBIN "baserom.gbc", $324AD, $324AE - $324AD

LoggedData_0x324AE:
INCBIN "baserom.gbc", $324AE, $324B1 - $324AE

UnknownData_0x324B1:
INCBIN "baserom.gbc", $324B1, $324B2 - $324B1

LoggedData_0x324B2:
INCBIN "baserom.gbc", $324B2, $324B5 - $324B2

UnknownData_0x324B5:
INCBIN "baserom.gbc", $324B5, $324B6 - $324B5

LoggedData_0x324B6:
INCBIN "baserom.gbc", $324B6, $324B9 - $324B6

UnknownData_0x324B9:
INCBIN "baserom.gbc", $324B9, $324BA - $324B9

LoggedData_0x324BA:
INCBIN "baserom.gbc", $324BA, $324BD - $324BA

UnknownData_0x324BD:
INCBIN "baserom.gbc", $324BD, $324BE - $324BD

LoggedData_0x324BE:
INCBIN "baserom.gbc", $324BE, $324C1 - $324BE

UnknownData_0x324C1:
INCBIN "baserom.gbc", $324C1, $324C2 - $324C1

LoggedData_0x324C2:
INCBIN "baserom.gbc", $324C2, $324C5 - $324C2

UnknownData_0x324C5:
INCBIN "baserom.gbc", $324C5, $324C6 - $324C5

LoggedData_0x324C6:
INCBIN "baserom.gbc", $324C6, $324C9 - $324C6

UnknownData_0x324C9:
INCBIN "baserom.gbc", $324C9, $324CA - $324C9

LoggedData_0x324CA:
INCBIN "baserom.gbc", $324CA, $324CD - $324CA

UnknownData_0x324CD:
INCBIN "baserom.gbc", $324CD, $324CE - $324CD

LoggedData_0x324CE:
INCBIN "baserom.gbc", $324CE, $324D1 - $324CE

UnknownData_0x324D1:
INCBIN "baserom.gbc", $324D1, $324D2 - $324D1

LoggedData_0x324D2:
INCBIN "baserom.gbc", $324D2, $324D5 - $324D2

UnknownData_0x324D5:
INCBIN "baserom.gbc", $324D5, $324D6 - $324D5

LoggedData_0x324D6:
INCBIN "baserom.gbc", $324D6, $324D9 - $324D6

UnknownData_0x324D9:
INCBIN "baserom.gbc", $324D9, $324DA - $324D9

LoggedData_0x324DA:
INCBIN "baserom.gbc", $324DA, $324DD - $324DA

UnknownData_0x324DD:
INCBIN "baserom.gbc", $324DD, $324DE - $324DD

LoggedData_0x324DE:
INCBIN "baserom.gbc", $324DE, $324E1 - $324DE

UnknownData_0x324E1:
INCBIN "baserom.gbc", $324E1, $324E2 - $324E1

LoggedData_0x324E2:
INCBIN "baserom.gbc", $324E2, $324E5 - $324E2

UnknownData_0x324E5:
INCBIN "baserom.gbc", $324E5, $324E6 - $324E5

LoggedData_0x324E6:
INCBIN "baserom.gbc", $324E6, $324E9 - $324E6

UnknownData_0x324E9:
INCBIN "baserom.gbc", $324E9, $324EA - $324E9

LoggedData_0x324EA:
INCBIN "baserom.gbc", $324EA, $324ED - $324EA

UnknownData_0x324ED:
INCBIN "baserom.gbc", $324ED, $324EE - $324ED

LoggedData_0x324EE:
INCBIN "baserom.gbc", $324EE, $324F1 - $324EE

UnknownData_0x324F1:
INCBIN "baserom.gbc", $324F1, $324F2 - $324F1

LoggedData_0x324F2:
INCBIN "baserom.gbc", $324F2, $324F5 - $324F2

UnknownData_0x324F5:
INCBIN "baserom.gbc", $324F5, $324F6 - $324F5

LoggedData_0x324F6:
INCBIN "baserom.gbc", $324F6, $324F9 - $324F6

UnknownData_0x324F9:
INCBIN "baserom.gbc", $324F9, $324FA - $324F9

LoggedData_0x324FA:
INCBIN "baserom.gbc", $324FA, $324FD - $324FA

UnknownData_0x324FD:
INCBIN "baserom.gbc", $324FD, $324FE - $324FD

LoggedData_0x324FE:
INCBIN "baserom.gbc", $324FE, $32501 - $324FE

UnknownData_0x32501:
INCBIN "baserom.gbc", $32501, $32502 - $32501

LoggedData_0x32502:
INCBIN "baserom.gbc", $32502, $32505 - $32502

UnknownData_0x32505:
INCBIN "baserom.gbc", $32505, $32506 - $32505

LoggedData_0x32506:
INCBIN "baserom.gbc", $32506, $32509 - $32506

UnknownData_0x32509:
INCBIN "baserom.gbc", $32509, $3250A - $32509

LoggedData_0x3250A:
INCBIN "baserom.gbc", $3250A, $3250D - $3250A

UnknownData_0x3250D:
INCBIN "baserom.gbc", $3250D, $3250E - $3250D

LoggedData_0x3250E:
INCBIN "baserom.gbc", $3250E, $32511 - $3250E

UnknownData_0x32511:
INCBIN "baserom.gbc", $32511, $32512 - $32511

LoggedData_0x32512:
INCBIN "baserom.gbc", $32512, $32515 - $32512

UnknownData_0x32515:
INCBIN "baserom.gbc", $32515, $32516 - $32515

LoggedData_0x32516:
INCBIN "baserom.gbc", $32516, $32519 - $32516

UnknownData_0x32519:
INCBIN "baserom.gbc", $32519, $3251A - $32519

LoggedData_0x3251A:
INCBIN "baserom.gbc", $3251A, $3251D - $3251A

UnknownData_0x3251D:
INCBIN "baserom.gbc", $3251D, $3251E - $3251D

LoggedData_0x3251E:
INCBIN "baserom.gbc", $3251E, $32521 - $3251E

UnknownData_0x32521:
INCBIN "baserom.gbc", $32521, $32522 - $32521

LoggedData_0x32522:
INCBIN "baserom.gbc", $32522, $32525 - $32522

UnknownData_0x32525:
INCBIN "baserom.gbc", $32525, $32526 - $32525

LoggedData_0x32526:
INCBIN "baserom.gbc", $32526, $32529 - $32526

UnknownData_0x32529:
INCBIN "baserom.gbc", $32529, $3252A - $32529

LoggedData_0x3252A:
INCBIN "baserom.gbc", $3252A, $3252D - $3252A

UnknownData_0x3252D:
INCBIN "baserom.gbc", $3252D, $3252E - $3252D

LoggedData_0x3252E:
INCBIN "baserom.gbc", $3252E, $32531 - $3252E

UnknownData_0x32531:
INCBIN "baserom.gbc", $32531, $32532 - $32531

LoggedData_0x32532:
INCBIN "baserom.gbc", $32532, $32535 - $32532

UnknownData_0x32535:
INCBIN "baserom.gbc", $32535, $32566 - $32535

LoggedData_0x32566:
INCBIN "baserom.gbc", $32566, $32569 - $32566

UnknownData_0x32569:
INCBIN "baserom.gbc", $32569, $3256A - $32569

LoggedData_0x3256A:
INCBIN "baserom.gbc", $3256A, $3256D - $3256A

UnknownData_0x3256D:
INCBIN "baserom.gbc", $3256D, $3256E - $3256D

LoggedData_0x3256E:
INCBIN "baserom.gbc", $3256E, $32571 - $3256E

UnknownData_0x32571:
INCBIN "baserom.gbc", $32571, $32572 - $32571

LoggedData_0x32572:
INCBIN "baserom.gbc", $32572, $32575 - $32572

UnknownData_0x32575:
INCBIN "baserom.gbc", $32575, $32576 - $32575

LoggedData_0x32576:
INCBIN "baserom.gbc", $32576, $32579 - $32576

UnknownData_0x32579:
INCBIN "baserom.gbc", $32579, $3257A - $32579

LoggedData_0x3257A:
INCBIN "baserom.gbc", $3257A, $3257D - $3257A

UnknownData_0x3257D:
INCBIN "baserom.gbc", $3257D, $3257E - $3257D

LoggedData_0x3257E:
INCBIN "baserom.gbc", $3257E, $32581 - $3257E

UnknownData_0x32581:
INCBIN "baserom.gbc", $32581, $32582 - $32581

LoggedData_0x32582:
INCBIN "baserom.gbc", $32582, $32585 - $32582

UnknownData_0x32585:
INCBIN "baserom.gbc", $32585, $32586 - $32585

LoggedData_0x32586:
INCBIN "baserom.gbc", $32586, $32589 - $32586

UnknownData_0x32589:
INCBIN "baserom.gbc", $32589, $3258A - $32589

LoggedData_0x3258A:
INCBIN "baserom.gbc", $3258A, $3258D - $3258A

UnknownData_0x3258D:
INCBIN "baserom.gbc", $3258D, $3258E - $3258D

LoggedData_0x3258E:
INCBIN "baserom.gbc", $3258E, $32591 - $3258E

UnknownData_0x32591:
INCBIN "baserom.gbc", $32591, $32592 - $32591

LoggedData_0x32592:
INCBIN "baserom.gbc", $32592, $32595 - $32592

UnknownData_0x32595:
INCBIN "baserom.gbc", $32595, $32596 - $32595

LoggedData_0x32596:
INCBIN "baserom.gbc", $32596, $32599 - $32596

UnknownData_0x32599:
INCBIN "baserom.gbc", $32599, $3259A - $32599

LoggedData_0x3259A:
INCBIN "baserom.gbc", $3259A, $3259D - $3259A

UnknownData_0x3259D:
INCBIN "baserom.gbc", $3259D, $3259E - $3259D

LoggedData_0x3259E:
INCBIN "baserom.gbc", $3259E, $325A1 - $3259E

UnknownData_0x325A1:
INCBIN "baserom.gbc", $325A1, $325A2 - $325A1

LoggedData_0x325A2:
INCBIN "baserom.gbc", $325A2, $325A5 - $325A2

UnknownData_0x325A5:
INCBIN "baserom.gbc", $325A5, $325A6 - $325A5

LoggedData_0x325A6:
INCBIN "baserom.gbc", $325A6, $325A9 - $325A6

UnknownData_0x325A9:
INCBIN "baserom.gbc", $325A9, $325AA - $325A9

LoggedData_0x325AA:
INCBIN "baserom.gbc", $325AA, $325AD - $325AA

UnknownData_0x325AD:
INCBIN "baserom.gbc", $325AD, $325AE - $325AD

LoggedData_0x325AE:
INCBIN "baserom.gbc", $325AE, $325B1 - $325AE

UnknownData_0x325B1:
INCBIN "baserom.gbc", $325B1, $325B2 - $325B1

LoggedData_0x325B2:
INCBIN "baserom.gbc", $325B2, $325B5 - $325B2

UnknownData_0x325B5:
INCBIN "baserom.gbc", $325B5, $325B6 - $325B5

LoggedData_0x325B6:
INCBIN "baserom.gbc", $325B6, $325B9 - $325B6

UnknownData_0x325B9:
INCBIN "baserom.gbc", $325B9, $325BA - $325B9

LoggedData_0x325BA:
INCBIN "baserom.gbc", $325BA, $325BD - $325BA

UnknownData_0x325BD:
INCBIN "baserom.gbc", $325BD, $325BE - $325BD

LoggedData_0x325BE:
INCBIN "baserom.gbc", $325BE, $325C1 - $325BE

UnknownData_0x325C1:
INCBIN "baserom.gbc", $325C1, $325C2 - $325C1

LoggedData_0x325C2:
INCBIN "baserom.gbc", $325C2, $325C5 - $325C2

UnknownData_0x325C5:
INCBIN "baserom.gbc", $325C5, $325C6 - $325C5

LoggedData_0x325C6:
INCBIN "baserom.gbc", $325C6, $325C9 - $325C6

UnknownData_0x325C9:
INCBIN "baserom.gbc", $325C9, $325CA - $325C9

LoggedData_0x325CA:
INCBIN "baserom.gbc", $325CA, $325CD - $325CA

UnknownData_0x325CD:
INCBIN "baserom.gbc", $325CD, $325CE - $325CD

LoggedData_0x325CE:
INCBIN "baserom.gbc", $325CE, $325D1 - $325CE

UnknownData_0x325D1:
INCBIN "baserom.gbc", $325D1, $325D2 - $325D1

LoggedData_0x325D2:
INCBIN "baserom.gbc", $325D2, $325D5 - $325D2

UnknownData_0x325D5:
INCBIN "baserom.gbc", $325D5, $325D6 - $325D5

LoggedData_0x325D6:
INCBIN "baserom.gbc", $325D6, $325D9 - $325D6

UnknownData_0x325D9:
INCBIN "baserom.gbc", $325D9, $325DA - $325D9

LoggedData_0x325DA:
INCBIN "baserom.gbc", $325DA, $325DD - $325DA

UnknownData_0x325DD:
INCBIN "baserom.gbc", $325DD, $325DE - $325DD

LoggedData_0x325DE:
INCBIN "baserom.gbc", $325DE, $325E1 - $325DE

UnknownData_0x325E1:
INCBIN "baserom.gbc", $325E1, $325E2 - $325E1

LoggedData_0x325E2:
INCBIN "baserom.gbc", $325E2, $325E5 - $325E2

UnknownData_0x325E5:
INCBIN "baserom.gbc", $325E5, $325E6 - $325E5

LoggedData_0x325E6:
INCBIN "baserom.gbc", $325E6, $325E9 - $325E6

UnknownData_0x325E9:
INCBIN "baserom.gbc", $325E9, $325EA - $325E9

LoggedData_0x325EA:
INCBIN "baserom.gbc", $325EA, $325ED - $325EA

UnknownData_0x325ED:
INCBIN "baserom.gbc", $325ED, $325EE - $325ED

LoggedData_0x325EE:
INCBIN "baserom.gbc", $325EE, $325F1 - $325EE

UnknownData_0x325F1:
INCBIN "baserom.gbc", $325F1, $325F2 - $325F1

LoggedData_0x325F2:
INCBIN "baserom.gbc", $325F2, $325F5 - $325F2

UnknownData_0x325F5:
INCBIN "baserom.gbc", $325F5, $325F6 - $325F5

LoggedData_0x325F6:
INCBIN "baserom.gbc", $325F6, $325F9 - $325F6

UnknownData_0x325F9:
INCBIN "baserom.gbc", $325F9, $325FA - $325F9

LoggedData_0x325FA:
INCBIN "baserom.gbc", $325FA, $325FD - $325FA

UnknownData_0x325FD:
INCBIN "baserom.gbc", $325FD, $325FE - $325FD

LoggedData_0x325FE:
INCBIN "baserom.gbc", $325FE, $32601 - $325FE

UnknownData_0x32601:
INCBIN "baserom.gbc", $32601, $32602 - $32601

LoggedData_0x32602:
INCBIN "baserom.gbc", $32602, $32605 - $32602

UnknownData_0x32605:
INCBIN "baserom.gbc", $32605, $32606 - $32605

LoggedData_0x32606:
INCBIN "baserom.gbc", $32606, $32609 - $32606

UnknownData_0x32609:
INCBIN "baserom.gbc", $32609, $3260A - $32609

LoggedData_0x3260A:
INCBIN "baserom.gbc", $3260A, $3260D - $3260A

UnknownData_0x3260D:
INCBIN "baserom.gbc", $3260D, $3260E - $3260D

LoggedData_0x3260E:
INCBIN "baserom.gbc", $3260E, $32611 - $3260E

UnknownData_0x32611:
INCBIN "baserom.gbc", $32611, $32612 - $32611

LoggedData_0x32612:
INCBIN "baserom.gbc", $32612, $32615 - $32612

UnknownData_0x32615:
INCBIN "baserom.gbc", $32615, $32616 - $32615

LoggedData_0x32616:
INCBIN "baserom.gbc", $32616, $32619 - $32616

UnknownData_0x32619:
INCBIN "baserom.gbc", $32619, $3261A - $32619

LoggedData_0x3261A:
INCBIN "baserom.gbc", $3261A, $3261D - $3261A

UnknownData_0x3261D:
INCBIN "baserom.gbc", $3261D, $3261E - $3261D

LoggedData_0x3261E:
INCBIN "baserom.gbc", $3261E, $32621 - $3261E

UnknownData_0x32621:
INCBIN "baserom.gbc", $32621, $32622 - $32621

LoggedData_0x32622:
INCBIN "baserom.gbc", $32622, $32625 - $32622

UnknownData_0x32625:
INCBIN "baserom.gbc", $32625, $32626 - $32625

LoggedData_0x32626:
INCBIN "baserom.gbc", $32626, $32629 - $32626

UnknownData_0x32629:
INCBIN "baserom.gbc", $32629, $3262A - $32629

LoggedData_0x3262A:
INCBIN "baserom.gbc", $3262A, $3262D - $3262A

UnknownData_0x3262D:
INCBIN "baserom.gbc", $3262D, $3262E - $3262D

LoggedData_0x3262E:
INCBIN "baserom.gbc", $3262E, $32631 - $3262E

UnknownData_0x32631:
INCBIN "baserom.gbc", $32631, $32632 - $32631

LoggedData_0x32632:
INCBIN "baserom.gbc", $32632, $32635 - $32632

UnknownData_0x32635:
INCBIN "baserom.gbc", $32635, $32636 - $32635

LoggedData_0x32636:
INCBIN "baserom.gbc", $32636, $32639 - $32636

UnknownData_0x32639:
INCBIN "baserom.gbc", $32639, $3263A - $32639

LoggedData_0x3263A:
INCBIN "baserom.gbc", $3263A, $3263D - $3263A

UnknownData_0x3263D:
INCBIN "baserom.gbc", $3263D, $3263E - $3263D

LoggedData_0x3263E:
INCBIN "baserom.gbc", $3263E, $32641 - $3263E

UnknownData_0x32641:
INCBIN "baserom.gbc", $32641, $32642 - $32641

LoggedData_0x32642:
INCBIN "baserom.gbc", $32642, $32645 - $32642

UnknownData_0x32645:
INCBIN "baserom.gbc", $32645, $32646 - $32645

LoggedData_0x32646:
INCBIN "baserom.gbc", $32646, $32649 - $32646

UnknownData_0x32649:
INCBIN "baserom.gbc", $32649, $3264A - $32649

LoggedData_0x3264A:
INCBIN "baserom.gbc", $3264A, $3264D - $3264A

UnknownData_0x3264D:
INCBIN "baserom.gbc", $3264D, $3264E - $3264D

LoggedData_0x3264E:
INCBIN "baserom.gbc", $3264E, $32651 - $3264E

UnknownData_0x32651:
INCBIN "baserom.gbc", $32651, $32652 - $32651

LoggedData_0x32652:
INCBIN "baserom.gbc", $32652, $32655 - $32652

UnknownData_0x32655:
INCBIN "baserom.gbc", $32655, $32656 - $32655

LoggedData_0x32656:
INCBIN "baserom.gbc", $32656, $32659 - $32656

UnknownData_0x32659:
INCBIN "baserom.gbc", $32659, $3265A - $32659

LoggedData_0x3265A:
INCBIN "baserom.gbc", $3265A, $3265D - $3265A

UnknownData_0x3265D:
INCBIN "baserom.gbc", $3265D, $3265E - $3265D

LoggedData_0x3265E:
INCBIN "baserom.gbc", $3265E, $32661 - $3265E

UnknownData_0x32661:
INCBIN "baserom.gbc", $32661, $32662 - $32661

LoggedData_0x32662:
INCBIN "baserom.gbc", $32662, $32665 - $32662

UnknownData_0x32665:
INCBIN "baserom.gbc", $32665, $32666 - $32665

LoggedData_0x32666:
INCBIN "baserom.gbc", $32666, $32669 - $32666

UnknownData_0x32669:
INCBIN "baserom.gbc", $32669, $3266A - $32669

LoggedData_0x3266A:
INCBIN "baserom.gbc", $3266A, $3266D - $3266A

UnknownData_0x3266D:
INCBIN "baserom.gbc", $3266D, $3266E - $3266D

LoggedData_0x3266E:
INCBIN "baserom.gbc", $3266E, $32671 - $3266E

UnknownData_0x32671:
INCBIN "baserom.gbc", $32671, $32672 - $32671

LoggedData_0x32672:
INCBIN "baserom.gbc", $32672, $32675 - $32672

UnknownData_0x32675:
INCBIN "baserom.gbc", $32675, $32676 - $32675

LoggedData_0x32676:
INCBIN "baserom.gbc", $32676, $32679 - $32676

UnknownData_0x32679:
INCBIN "baserom.gbc", $32679, $3267A - $32679

LoggedData_0x3267A:
INCBIN "baserom.gbc", $3267A, $3267D - $3267A

UnknownData_0x3267D:
INCBIN "baserom.gbc", $3267D, $3267E - $3267D

LoggedData_0x3267E:
INCBIN "baserom.gbc", $3267E, $32681 - $3267E

UnknownData_0x32681:
INCBIN "baserom.gbc", $32681, $32682 - $32681

LoggedData_0x32682:
INCBIN "baserom.gbc", $32682, $32685 - $32682

UnknownData_0x32685:
INCBIN "baserom.gbc", $32685, $32686 - $32685

LoggedData_0x32686:
INCBIN "baserom.gbc", $32686, $32689 - $32686

UnknownData_0x32689:
INCBIN "baserom.gbc", $32689, $3268A - $32689

LoggedData_0x3268A:
INCBIN "baserom.gbc", $3268A, $3268D - $3268A

UnknownData_0x3268D:
INCBIN "baserom.gbc", $3268D, $3268E - $3268D

LoggedData_0x3268E:
INCBIN "baserom.gbc", $3268E, $32691 - $3268E

UnknownData_0x32691:
INCBIN "baserom.gbc", $32691, $32692 - $32691

LoggedData_0x32692:
INCBIN "baserom.gbc", $32692, $32695 - $32692

UnknownData_0x32695:
INCBIN "baserom.gbc", $32695, $32696 - $32695

LoggedData_0x32696:
INCBIN "baserom.gbc", $32696, $32699 - $32696

UnknownData_0x32699:
INCBIN "baserom.gbc", $32699, $3269A - $32699

LoggedData_0x3269A:
INCBIN "baserom.gbc", $3269A, $3269D - $3269A

UnknownData_0x3269D:
INCBIN "baserom.gbc", $3269D, $3269E - $3269D

LoggedData_0x3269E:
INCBIN "baserom.gbc", $3269E, $326A1 - $3269E

UnknownData_0x326A1:
INCBIN "baserom.gbc", $326A1, $326A2 - $326A1

LoggedData_0x326A2:
INCBIN "baserom.gbc", $326A2, $326A5 - $326A2

UnknownData_0x326A5:
INCBIN "baserom.gbc", $326A5, $326A6 - $326A5

LoggedData_0x326A6:
INCBIN "baserom.gbc", $326A6, $326A9 - $326A6

UnknownData_0x326A9:
INCBIN "baserom.gbc", $326A9, $326AA - $326A9

LoggedData_0x326AA:
INCBIN "baserom.gbc", $326AA, $326AD - $326AA

UnknownData_0x326AD:
INCBIN "baserom.gbc", $326AD, $326AE - $326AD

LoggedData_0x326AE:
INCBIN "baserom.gbc", $326AE, $326B1 - $326AE

UnknownData_0x326B1:
INCBIN "baserom.gbc", $326B1, $326B2 - $326B1

LoggedData_0x326B2:
INCBIN "baserom.gbc", $326B2, $326B5 - $326B2

UnknownData_0x326B5:
INCBIN "baserom.gbc", $326B5, $326BE - $326B5

LoggedData_0x326BE:
INCBIN "baserom.gbc", $326BE, $326C1 - $326BE

UnknownData_0x326C1:
INCBIN "baserom.gbc", $326C1, $326C2 - $326C1

LoggedData_0x326C2:
INCBIN "baserom.gbc", $326C2, $326C5 - $326C2

UnknownData_0x326C5:
INCBIN "baserom.gbc", $326C5, $326C6 - $326C5

LoggedData_0x326C6:
INCBIN "baserom.gbc", $326C6, $326C9 - $326C6

UnknownData_0x326C9:
INCBIN "baserom.gbc", $326C9, $326CA - $326C9

LoggedData_0x326CA:
INCBIN "baserom.gbc", $326CA, $326CD - $326CA

UnknownData_0x326CD:
INCBIN "baserom.gbc", $326CD, $326CE - $326CD

LoggedData_0x326CE:
INCBIN "baserom.gbc", $326CE, $326D1 - $326CE

UnknownData_0x326D1:
INCBIN "baserom.gbc", $326D1, $326D2 - $326D1

LoggedData_0x326D2:
INCBIN "baserom.gbc", $326D2, $326D5 - $326D2

UnknownData_0x326D5:
INCBIN "baserom.gbc", $326D5, $326D6 - $326D5

LoggedData_0x326D6:
INCBIN "baserom.gbc", $326D6, $326D9 - $326D6

UnknownData_0x326D9:
INCBIN "baserom.gbc", $326D9, $326DA - $326D9

LoggedData_0x326DA:
INCBIN "baserom.gbc", $326DA, $326DD - $326DA

UnknownData_0x326DD:
INCBIN "baserom.gbc", $326DD, $326DE - $326DD

LoggedData_0x326DE:
INCBIN "baserom.gbc", $326DE, $326E1 - $326DE

UnknownData_0x326E1:
INCBIN "baserom.gbc", $326E1, $326E2 - $326E1

LoggedData_0x326E2:
INCBIN "baserom.gbc", $326E2, $326E5 - $326E2

UnknownData_0x326E5:
INCBIN "baserom.gbc", $326E5, $326E6 - $326E5

LoggedData_0x326E6:
INCBIN "baserom.gbc", $326E6, $326E9 - $326E6

UnknownData_0x326E9:
INCBIN "baserom.gbc", $326E9, $326EA - $326E9

LoggedData_0x326EA:
INCBIN "baserom.gbc", $326EA, $326ED - $326EA

UnknownData_0x326ED:
INCBIN "baserom.gbc", $326ED, $326EE - $326ED

LoggedData_0x326EE:
INCBIN "baserom.gbc", $326EE, $326F1 - $326EE

UnknownData_0x326F1:
INCBIN "baserom.gbc", $326F1, $326F2 - $326F1

LoggedData_0x326F2:
INCBIN "baserom.gbc", $326F2, $326F5 - $326F2

UnknownData_0x326F5:
INCBIN "baserom.gbc", $326F5, $326F6 - $326F5

LoggedData_0x326F6:
INCBIN "baserom.gbc", $326F6, $326F9 - $326F6

UnknownData_0x326F9:
INCBIN "baserom.gbc", $326F9, $326FA - $326F9

LoggedData_0x326FA:
INCBIN "baserom.gbc", $326FA, $326FD - $326FA

UnknownData_0x326FD:
INCBIN "baserom.gbc", $326FD, $326FE - $326FD

LoggedData_0x326FE:
INCBIN "baserom.gbc", $326FE, $32701 - $326FE

UnknownData_0x32701:
INCBIN "baserom.gbc", $32701, $32702 - $32701

LoggedData_0x32702:
INCBIN "baserom.gbc", $32702, $32705 - $32702

UnknownData_0x32705:
INCBIN "baserom.gbc", $32705, $32706 - $32705

LoggedData_0x32706:
INCBIN "baserom.gbc", $32706, $32709 - $32706

UnknownData_0x32709:
INCBIN "baserom.gbc", $32709, $3270A - $32709

LoggedData_0x3270A:
INCBIN "baserom.gbc", $3270A, $3270D - $3270A

UnknownData_0x3270D:
INCBIN "baserom.gbc", $3270D, $32716 - $3270D

LoggedData_0x32716:
INCBIN "baserom.gbc", $32716, $32719 - $32716

UnknownData_0x32719:
INCBIN "baserom.gbc", $32719, $3271A - $32719

LoggedData_0x3271A:
INCBIN "baserom.gbc", $3271A, $3271D - $3271A

UnknownData_0x3271D:
INCBIN "baserom.gbc", $3271D, $3271E - $3271D

LoggedData_0x3271E:
INCBIN "baserom.gbc", $3271E, $32721 - $3271E

UnknownData_0x32721:
INCBIN "baserom.gbc", $32721, $32722 - $32721

LoggedData_0x32722:
INCBIN "baserom.gbc", $32722, $32725 - $32722

UnknownData_0x32725:
INCBIN "baserom.gbc", $32725, $32726 - $32725

LoggedData_0x32726:
INCBIN "baserom.gbc", $32726, $3285D - $32726

UnknownData_0x3285D:
INCBIN "baserom.gbc", $3285D, $3285E - $3285D

LoggedData_0x3285E:
INCBIN "baserom.gbc", $3285E, $32917 - $3285E

UnknownData_0x32917:
INCBIN "baserom.gbc", $32917, $32918 - $32917

LoggedData_0x32918:
INCBIN "baserom.gbc", $32918, $32A08 - $32918

UnknownData_0x32A08:
INCBIN "baserom.gbc", $32A08, $32A09 - $32A08

LoggedData_0x32A09:
INCBIN "baserom.gbc", $32A09, $32A97 - $32A09

UnknownData_0x32A97:
INCBIN "baserom.gbc", $32A97, $32A9A - $32A97

LoggedData_0x32A9A:
INCBIN "baserom.gbc", $32A9A, $32AA2 - $32A9A

UnknownData_0x32AA2:
INCBIN "baserom.gbc", $32AA2, $32AB2 - $32AA2

LoggedData_0x32AB2:
INCBIN "baserom.gbc", $32AB2, $32BF9 - $32AB2

UnknownData_0x32BF9:
INCBIN "baserom.gbc", $32BF9, $32BFD - $32BF9

LoggedData_0x32BFD:
INCBIN "baserom.gbc", $32BFD, $32C3A - $32BFD

UnknownData_0x32C3A:
INCBIN "baserom.gbc", $32C3A, $32C3B - $32C3A

LoggedData_0x32C3B:
INCBIN "baserom.gbc", $32C3B, $32D26 - $32C3B

UnknownData_0x32D26:
INCBIN "baserom.gbc", $32D26, $32D29 - $32D26

LoggedData_0x32D29:
INCBIN "baserom.gbc", $32D29, $32D2F - $32D29

UnknownData_0x32D2F:
INCBIN "baserom.gbc", $32D2F, $32D3B - $32D2F

LoggedData_0x32D3B:
INCBIN "baserom.gbc", $32D3B, $32E14 - $32D3B

UnknownData_0x32E14:
INCBIN "baserom.gbc", $32E14, $32E15 - $32E14

LoggedData_0x32E15:
INCBIN "baserom.gbc", $32E15, $32EEC - $32E15

UnknownData_0x32EEC:
INCBIN "baserom.gbc", $32EEC, $32EEF - $32EEC

LoggedData_0x32EEF:
INCBIN "baserom.gbc", $32EEF, $32EF3 - $32EEF

UnknownData_0x32EF3:
INCBIN "baserom.gbc", $32EF3, $32EFB - $32EF3

LoggedData_0x32EFB:
INCBIN "baserom.gbc", $32EFB, $3307E - $32EFB

UnknownData_0x3307E:
INCBIN "baserom.gbc", $3307E, $330A1 - $3307E

LoggedData_0x330A1:
INCBIN "baserom.gbc", $330A1, $33241 - $330A1

UnknownData_0x33241:
INCBIN "baserom.gbc", $33241, $33246 - $33241

LoggedData_0x33246:
INCBIN "baserom.gbc", $33246, $332D9 - $33246

UnknownData_0x332D9:
INCBIN "baserom.gbc", $332D9, $332E9 - $332D9

LoggedData_0x332E9:
INCBIN "baserom.gbc", $332E9, $332EF - $332E9

UnknownData_0x332EF:
INCBIN "baserom.gbc", $332EF, $332FB - $332EF

LoggedData_0x332FB:
INCBIN "baserom.gbc", $332FB, $333C7 - $332FB

UnknownData_0x333C7:
INCBIN "baserom.gbc", $333C7, $333C8 - $333C7

LoggedData_0x333C8:
INCBIN "baserom.gbc", $333C8, $334F3 - $333C8

UnknownData_0x334F3:
INCBIN "baserom.gbc", $334F3, $334F4 - $334F3

LoggedData_0x334F4:
INCBIN "baserom.gbc", $334F4, $335AE - $334F4

UnknownData_0x335AE:
INCBIN "baserom.gbc", $335AE, $335B1 - $335AE

LoggedData_0x335B1:
INCBIN "baserom.gbc", $335B1, $335B7 - $335B1

UnknownData_0x335B7:
INCBIN "baserom.gbc", $335B7, $335C3 - $335B7

LoggedData_0x335C3:
INCBIN "baserom.gbc", $335C3, $336D1 - $335C3

UnknownData_0x336D1:
INCBIN "baserom.gbc", $336D1, $336D2 - $336D1

LoggedData_0x336D2:
INCBIN "baserom.gbc", $336D2, $3374A - $336D2

UnknownData_0x3374A:
INCBIN "baserom.gbc", $3374A, $3374B - $3374A

LoggedData_0x3374B:
INCBIN "baserom.gbc", $3374B, $337F8 - $3374B

UnknownData_0x337F8:
INCBIN "baserom.gbc", $337F8, $337FB - $337F8

LoggedData_0x337FB:
INCBIN "baserom.gbc", $337FB, $33801 - $337FB

UnknownData_0x33801:
INCBIN "baserom.gbc", $33801, $3380D - $33801

LoggedData_0x3380D:
INCBIN "baserom.gbc", $3380D, $338E3 - $3380D

UnknownData_0x338E3:
INCBIN "baserom.gbc", $338E3, $338E4 - $338E3

LoggedData_0x338E4:
INCBIN "baserom.gbc", $338E4, $339B4 - $338E4

UnknownData_0x339B4:
INCBIN "baserom.gbc", $339B4, $339B5 - $339B4

LoggedData_0x339B5:
INCBIN "baserom.gbc", $339B5, $33A5D - $339B5

UnknownData_0x33A5D:
INCBIN "baserom.gbc", $33A5D, $33A5E - $33A5D

LoggedData_0x33A5E:
INCBIN "baserom.gbc", $33A5E, $33B2D - $33A5E

UnknownData_0x33B2D:
INCBIN "baserom.gbc", $33B2D, $33B30 - $33B2D

LoggedData_0x33B30:
INCBIN "baserom.gbc", $33B30, $33B38 - $33B30

UnknownData_0x33B38:
INCBIN "baserom.gbc", $33B38, $33B48 - $33B38

LoggedData_0x33B48:
INCBIN "baserom.gbc", $33B48, $33BBD - $33B48

UnknownData_0x33BBD:
INCBIN "baserom.gbc", $33BBD, $33BBE - $33BBD

LoggedData_0x33BBE:
INCBIN "baserom.gbc", $33BBE, $33CC4 - $33BBE

UnknownData_0x33CC4:
INCBIN "baserom.gbc", $33CC4, $33CC5 - $33CC4

LoggedData_0x33CC5:
INCBIN "baserom.gbc", $33CC5, $33DD4 - $33CC5

UnknownData_0x33DD4:
INCBIN "baserom.gbc", $33DD4, $33DD7 - $33DD4

LoggedData_0x33DD7:
INCBIN "baserom.gbc", $33DD7, $33DDD - $33DD7

UnknownData_0x33DDD:
INCBIN "baserom.gbc", $33DDD, $34000 - $33DDD

SECTION "Bank0D", ROMX, BANK[$0D]

LoggedData_0x34000:
INCBIN "baserom.gbc", $34000, $3413C - $34000

UnknownData_0x3413C:
INCBIN "baserom.gbc", $3413C, $34149 - $3413C

LoggedData_0x34149:
INCBIN "baserom.gbc", $34149, $3424D - $34149

UnknownData_0x3424D:
INCBIN "baserom.gbc", $3424D, $34259 - $3424D

LoggedData_0x34259:
INCBIN "baserom.gbc", $34259, $34384 - $34259

UnknownData_0x34384:
INCBIN "baserom.gbc", $34384, $34393 - $34384

LoggedData_0x34393:
INCBIN "baserom.gbc", $34393, $34399 - $34393

UnknownData_0x34399:
INCBIN "baserom.gbc", $34399, $343A5 - $34399

LoggedData_0x343A5:
INCBIN "baserom.gbc", $343A5, $344E8 - $343A5

UnknownData_0x344E8:
INCBIN "baserom.gbc", $344E8, $344E9 - $344E8

LoggedData_0x344E9:
INCBIN "baserom.gbc", $344E9, $3465B - $344E9

UnknownData_0x3465B:
INCBIN "baserom.gbc", $3465B, $3465C - $3465B

LoggedData_0x3465C:
INCBIN "baserom.gbc", $3465C, $3481A - $3465C

UnknownData_0x3481A:
INCBIN "baserom.gbc", $3481A, $3481E - $3481A

LoggedData_0x3481E:
INCBIN "baserom.gbc", $3481E, $34824 - $3481E

UnknownData_0x34824:
INCBIN "baserom.gbc", $34824, $34830 - $34824

LoggedData_0x34830:
INCBIN "baserom.gbc", $34830, $348FA - $34830

UnknownData_0x348FA:
INCBIN "baserom.gbc", $348FA, $348FB - $348FA

LoggedData_0x348FB:
INCBIN "baserom.gbc", $348FB, $349D9 - $348FB

UnknownData_0x349D9:
INCBIN "baserom.gbc", $349D9, $349DA - $349D9

LoggedData_0x349DA:
INCBIN "baserom.gbc", $349DA, $34A4F - $349DA

UnknownData_0x34A4F:
INCBIN "baserom.gbc", $34A4F, $34A52 - $34A4F

LoggedData_0x34A52:
INCBIN "baserom.gbc", $34A52, $34A58 - $34A52

UnknownData_0x34A58:
INCBIN "baserom.gbc", $34A58, $34A64 - $34A58

LoggedData_0x34A64:
INCBIN "baserom.gbc", $34A64, $34BC6 - $34A64

UnknownData_0x34BC6:
INCBIN "baserom.gbc", $34BC6, $34BC7 - $34BC6

LoggedData_0x34BC7:
INCBIN "baserom.gbc", $34BC7, $34CCC - $34BC7

UnknownData_0x34CCC:
INCBIN "baserom.gbc", $34CCC, $34CCD - $34CCC

LoggedData_0x34CCD:
INCBIN "baserom.gbc", $34CCD, $34D68 - $34CCD

UnknownData_0x34D68:
INCBIN "baserom.gbc", $34D68, $34D6B - $34D68

LoggedData_0x34D6B:
INCBIN "baserom.gbc", $34D6B, $34D71 - $34D6B

UnknownData_0x34D71:
INCBIN "baserom.gbc", $34D71, $34D7D - $34D71

LoggedData_0x34D7D:
INCBIN "baserom.gbc", $34D7D, $34EC4 - $34D7D

UnknownData_0x34EC4:
INCBIN "baserom.gbc", $34EC4, $34ECA - $34EC4

LoggedData_0x34ECA:
INCBIN "baserom.gbc", $34ECA, $3500E - $34ECA

UnknownData_0x3500E:
INCBIN "baserom.gbc", $3500E, $3500F - $3500E

LoggedData_0x3500F:
INCBIN "baserom.gbc", $3500F, $35178 - $3500F

UnknownData_0x35178:
INCBIN "baserom.gbc", $35178, $3517B - $35178

LoggedData_0x3517B:
INCBIN "baserom.gbc", $3517B, $35181 - $3517B

UnknownData_0x35181:
INCBIN "baserom.gbc", $35181, $3518D - $35181

LoggedData_0x3518D:
INCBIN "baserom.gbc", $3518D, $3527A - $3518D

UnknownData_0x3527A:
INCBIN "baserom.gbc", $3527A, $35281 - $3527A

LoggedData_0x35281:
INCBIN "baserom.gbc", $35281, $352FF - $35281

UnknownData_0x352FF:
INCBIN "baserom.gbc", $352FF, $3530B - $352FF

LoggedData_0x3530B:
INCBIN "baserom.gbc", $3530B, $353F3 - $3530B

UnknownData_0x353F3:
INCBIN "baserom.gbc", $353F3, $35410 - $353F3

LoggedData_0x35410:
INCBIN "baserom.gbc", $35410, $3546B - $35410

UnknownData_0x3546B:
INCBIN "baserom.gbc", $3546B, $3547C - $3546B

LoggedData_0x3547C:
INCBIN "baserom.gbc", $3547C, $35484 - $3547C

UnknownData_0x35484:
INCBIN "baserom.gbc", $35484, $35494 - $35484

LoggedData_0x35494:
INCBIN "baserom.gbc", $35494, $3551B - $35494

UnknownData_0x3551B:
INCBIN "baserom.gbc", $3551B, $35526 - $3551B

LoggedData_0x35526:
INCBIN "baserom.gbc", $35526, $355AD - $35526

UnknownData_0x355AD:
INCBIN "baserom.gbc", $355AD, $355B8 - $355AD

LoggedData_0x355B8:
INCBIN "baserom.gbc", $355B8, $35679 - $355B8

UnknownData_0x35679:
INCBIN "baserom.gbc", $35679, $35690 - $35679

LoggedData_0x35690:
INCBIN "baserom.gbc", $35690, $35701 - $35690

UnknownData_0x35701:
INCBIN "baserom.gbc", $35701, $3571A - $35701

LoggedData_0x3571A:
INCBIN "baserom.gbc", $3571A, $35722 - $3571A

UnknownData_0x35722:
INCBIN "baserom.gbc", $35722, $35732 - $35722

LoggedData_0x35732:
INCBIN "baserom.gbc", $35732, $3583B - $35732

UnknownData_0x3583B:
INCBIN "baserom.gbc", $3583B, $35852 - $3583B

LoggedData_0x35852:
INCBIN "baserom.gbc", $35852, $35937 - $35852

UnknownData_0x35937:
INCBIN "baserom.gbc", $35937, $3594A - $35937

LoggedData_0x3594A:
INCBIN "baserom.gbc", $3594A, $359D4 - $3594A

UnknownData_0x359D4:
INCBIN "baserom.gbc", $359D4, $359DD - $359D4

LoggedData_0x359DD:
INCBIN "baserom.gbc", $359DD, $35A4D - $359DD

UnknownData_0x35A4D:
INCBIN "baserom.gbc", $35A4D, $35A65 - $35A4D

LoggedData_0x35A65:
INCBIN "baserom.gbc", $35A65, $35A6D - $35A65

UnknownData_0x35A6D:
INCBIN "baserom.gbc", $35A6D, $35A7D - $35A6D

LoggedData_0x35A7D:
INCBIN "baserom.gbc", $35A7D, $35BC0 - $35A7D

UnknownData_0x35BC0:
INCBIN "baserom.gbc", $35BC0, $35BCA - $35BC0

LoggedData_0x35BCA:
INCBIN "baserom.gbc", $35BCA, $35CE9 - $35BCA

UnknownData_0x35CE9:
INCBIN "baserom.gbc", $35CE9, $35CF4 - $35CE9

LoggedData_0x35CF4:
INCBIN "baserom.gbc", $35CF4, $35E9A - $35CF4

UnknownData_0x35E9A:
INCBIN "baserom.gbc", $35E9A, $35EB7 - $35E9A

LoggedData_0x35EB7:
INCBIN "baserom.gbc", $35EB7, $35F30 - $35EB7

UnknownData_0x35F30:
INCBIN "baserom.gbc", $35F30, $35F46 - $35F30

LoggedData_0x35F46:
INCBIN "baserom.gbc", $35F46, $35F4E - $35F46

UnknownData_0x35F4E:
INCBIN "baserom.gbc", $35F4E, $35F5E - $35F4E

LoggedData_0x35F5E:
INCBIN "baserom.gbc", $35F5E, $360BA - $35F5E

UnknownData_0x360BA:
INCBIN "baserom.gbc", $360BA, $360D0 - $360BA

LoggedData_0x360D0:
INCBIN "baserom.gbc", $360D0, $36251 - $360D0

UnknownData_0x36251:
INCBIN "baserom.gbc", $36251, $36266 - $36251

LoggedData_0x36266:
INCBIN "baserom.gbc", $36266, $3641B - $36266

UnknownData_0x3641B:
INCBIN "baserom.gbc", $3641B, $3641F - $3641B

LoggedData_0x3641F:
INCBIN "baserom.gbc", $3641F, $364B8 - $3641F

UnknownData_0x364B8:
INCBIN "baserom.gbc", $364B8, $364C8 - $364B8

LoggedData_0x364C8:
INCBIN "baserom.gbc", $364C8, $364D0 - $364C8

UnknownData_0x364D0:
INCBIN "baserom.gbc", $364D0, $364E0 - $364D0

LoggedData_0x364E0:
INCBIN "baserom.gbc", $364E0, $365B4 - $364E0

UnknownData_0x365B4:
INCBIN "baserom.gbc", $365B4, $365B5 - $365B4

LoggedData_0x365B5:
INCBIN "baserom.gbc", $365B5, $3666A - $365B5

UnknownData_0x3666A:
INCBIN "baserom.gbc", $3666A, $3666B - $3666A

LoggedData_0x3666B:
INCBIN "baserom.gbc", $3666B, $36720 - $3666B

UnknownData_0x36720:
INCBIN "baserom.gbc", $36720, $36721 - $36720

LoggedData_0x36721:
INCBIN "baserom.gbc", $36721, $367CA - $36721

UnknownData_0x367CA:
INCBIN "baserom.gbc", $367CA, $367CD - $367CA

LoggedData_0x367CD:
INCBIN "baserom.gbc", $367CD, $367D5 - $367CD

UnknownData_0x367D5:
INCBIN "baserom.gbc", $367D5, $367E5 - $367D5

LoggedData_0x367E5:
INCBIN "baserom.gbc", $367E5, $36832 - $367E5

UnknownData_0x36832:
INCBIN "baserom.gbc", $36832, $3683F - $36832

LoggedData_0x3683F:
INCBIN "baserom.gbc", $3683F, $3688A - $3683F

UnknownData_0x3688A:
INCBIN "baserom.gbc", $3688A, $36897 - $3688A

LoggedData_0x36897:
INCBIN "baserom.gbc", $36897, $368FE - $36897

UnknownData_0x368FE:
INCBIN "baserom.gbc", $368FE, $36909 - $368FE

LoggedData_0x36909:
INCBIN "baserom.gbc", $36909, $3697D - $36909

UnknownData_0x3697D:
INCBIN "baserom.gbc", $3697D, $36999 - $3697D

LoggedData_0x36999:
INCBIN "baserom.gbc", $36999, $369A1 - $36999

UnknownData_0x369A1:
INCBIN "baserom.gbc", $369A1, $369B1 - $369A1

LoggedData_0x369B1:
INCBIN "baserom.gbc", $369B1, $37451 - $369B1

UnknownData_0x37451:
INCBIN "baserom.gbc", $37451, $37452 - $37451

LoggedData_0x37452:
INCBIN "baserom.gbc", $37452, $374D0 - $37452

UnknownData_0x374D0:
INCBIN "baserom.gbc", $374D0, $374D1 - $374D0

LoggedData_0x374D1:
INCBIN "baserom.gbc", $374D1, $37533 - $374D1

UnknownData_0x37533:
INCBIN "baserom.gbc", $37533, $37534 - $37533

LoggedData_0x37534:
INCBIN "baserom.gbc", $37534, $375C0 - $37534

UnknownData_0x375C0:
INCBIN "baserom.gbc", $375C0, $375C3 - $375C0

LoggedData_0x375C3:
INCBIN "baserom.gbc", $375C3, $375C9 - $375C3

UnknownData_0x375C9:
INCBIN "baserom.gbc", $375C9, $375D5 - $375C9

LoggedData_0x375D5:
INCBIN "baserom.gbc", $375D5, $375F4 - $375D5

UnknownData_0x375F4:
INCBIN "baserom.gbc", $375F4, $37608 - $375F4

LoggedData_0x37608:
INCBIN "baserom.gbc", $37608, $3767B - $37608

UnknownData_0x3767B:
INCBIN "baserom.gbc", $3767B, $376B0 - $3767B

LoggedData_0x376B0:
INCBIN "baserom.gbc", $376B0, $376D0 - $376B0

UnknownData_0x376D0:
INCBIN "baserom.gbc", $376D0, $376E2 - $376D0

LoggedData_0x376E2:
INCBIN "baserom.gbc", $376E2, $376E8 - $376E2

UnknownData_0x376E8:
INCBIN "baserom.gbc", $376E8, $376F4 - $376E8

LoggedData_0x376F4:
INCBIN "baserom.gbc", $376F4, $3778A - $376F4

UnknownData_0x3778A:
INCBIN "baserom.gbc", $3778A, $3778B - $3778A

LoggedData_0x3778B:
INCBIN "baserom.gbc", $3778B, $377C7 - $3778B

UnknownData_0x377C7:
INCBIN "baserom.gbc", $377C7, $377C8 - $377C7

LoggedData_0x377C8:
INCBIN "baserom.gbc", $377C8, $37828 - $377C8

UnknownData_0x37828:
INCBIN "baserom.gbc", $37828, $3782B - $37828

LoggedData_0x3782B:
INCBIN "baserom.gbc", $3782B, $37831 - $3782B

UnknownData_0x37831:
INCBIN "baserom.gbc", $37831, $3783D - $37831

LoggedData_0x3783D:
INCBIN "baserom.gbc", $3783D, $37882 - $3783D

UnknownData_0x37882:
INCBIN "baserom.gbc", $37882, $37883 - $37882

LoggedData_0x37883:
INCBIN "baserom.gbc", $37883, $37900 - $37883

UnknownData_0x37900:
INCBIN "baserom.gbc", $37900, $37903 - $37900

LoggedData_0x37903:
INCBIN "baserom.gbc", $37903, $37907 - $37903

UnknownData_0x37907:
INCBIN "baserom.gbc", $37907, $3790F - $37907

LoggedData_0x3790F:
INCBIN "baserom.gbc", $3790F, $37968 - $3790F

UnknownData_0x37968:
INCBIN "baserom.gbc", $37968, $37969 - $37968

LoggedData_0x37969:
INCBIN "baserom.gbc", $37969, $379A1 - $37969

UnknownData_0x379A1:
INCBIN "baserom.gbc", $379A1, $379A2 - $379A1

LoggedData_0x379A2:
INCBIN "baserom.gbc", $379A2, $379E4 - $379A2

UnknownData_0x379E4:
INCBIN "baserom.gbc", $379E4, $379E7 - $379E4

LoggedData_0x379E7:
INCBIN "baserom.gbc", $379E7, $379ED - $379E7

UnknownData_0x379ED:
INCBIN "baserom.gbc", $379ED, $379F9 - $379ED

LoggedData_0x379F9:
INCBIN "baserom.gbc", $379F9, $37A16 - $379F9

UnknownData_0x37A16:
INCBIN "baserom.gbc", $37A16, $37A6E - $37A16

LoggedData_0x37A6E:
INCBIN "baserom.gbc", $37A6E, $37A86 - $37A6E

UnknownData_0x37A86:
INCBIN "baserom.gbc", $37A86, $37ABE - $37A86

LoggedData_0x37ABE:
INCBIN "baserom.gbc", $37ABE, $37AF4 - $37ABE

UnknownData_0x37AF4:
INCBIN "baserom.gbc", $37AF4, $37B7A - $37AF4

LoggedData_0x37B7A:
INCBIN "baserom.gbc", $37B7A, $37B80 - $37B7A

UnknownData_0x37B80:
INCBIN "baserom.gbc", $37B80, $37B8C - $37B80

LoggedData_0x37B8C:
INCBIN "baserom.gbc", $37B8C, $37C01 - $37B8C

UnknownData_0x37C01:
INCBIN "baserom.gbc", $37C01, $37C02 - $37C01

LoggedData_0x37C02:
INCBIN "baserom.gbc", $37C02, $37C75 - $37C02

UnknownData_0x37C75:
INCBIN "baserom.gbc", $37C75, $37C76 - $37C75

LoggedData_0x37C76:
INCBIN "baserom.gbc", $37C76, $37CEF - $37C76

UnknownData_0x37CEF:
INCBIN "baserom.gbc", $37CEF, $37CF2 - $37CEF

LoggedData_0x37CF2:
INCBIN "baserom.gbc", $37CF2, $37CF8 - $37CF2

UnknownData_0x37CF8:
INCBIN "baserom.gbc", $37CF8, $37D04 - $37CF8

LoggedData_0x37D04:
INCBIN "baserom.gbc", $37D04, $37D62 - $37D04

UnknownData_0x37D62:
INCBIN "baserom.gbc", $37D62, $37D63 - $37D62

LoggedData_0x37D63:
INCBIN "baserom.gbc", $37D63, $37DA1 - $37D63

UnknownData_0x37DA1:
INCBIN "baserom.gbc", $37DA1, $37DA2 - $37DA1

LoggedData_0x37DA2:
INCBIN "baserom.gbc", $37DA2, $37DF7 - $37DA2

UnknownData_0x37DF7:
INCBIN "baserom.gbc", $37DF7, $37DFA - $37DF7

LoggedData_0x37DFA:
INCBIN "baserom.gbc", $37DFA, $37E00 - $37DFA

UnknownData_0x37E00:
INCBIN "baserom.gbc", $37E00, $37E0C - $37E00

LoggedData_0x37E0C:
INCBIN "baserom.gbc", $37E0C, $37E9D - $37E0C

UnknownData_0x37E9D:
INCBIN "baserom.gbc", $37E9D, $37E9E - $37E9D

LoggedData_0x37E9E:
INCBIN "baserom.gbc", $37E9E, $37EE4 - $37E9E

UnknownData_0x37EE4:
INCBIN "baserom.gbc", $37EE4, $37EE5 - $37EE4

LoggedData_0x37EE5:
INCBIN "baserom.gbc", $37EE5, $37F40 - $37EE5

UnknownData_0x37F40:
INCBIN "baserom.gbc", $37F40, $37F43 - $37F40

LoggedData_0x37F43:
INCBIN "baserom.gbc", $37F43, $37F49 - $37F43

UnknownData_0x37F49:
INCBIN "baserom.gbc", $37F49, $38000 - $37F49

SECTION "Bank0E", ROMX, BANK[$0E]

LoggedData_0x38000:
INCBIN "baserom.gbc", $38000, $38101 - $38000

UnknownData_0x38101:
INCBIN "baserom.gbc", $38101, $3815C - $38101

LoggedData_0x3815C:
INCBIN "baserom.gbc", $3815C, $381C1 - $3815C

UnknownData_0x381C1:
INCBIN "baserom.gbc", $381C1, $381E8 - $381C1

LoggedData_0x381E8:
INCBIN "baserom.gbc", $381E8, $381EC - $381E8

UnknownData_0x381EC:
INCBIN "baserom.gbc", $381EC, $381F4 - $381EC

LoggedData_0x381F4:
INCBIN "baserom.gbc", $381F4, $38291 - $381F4

UnknownData_0x38291:
INCBIN "baserom.gbc", $38291, $38295 - $38291

LoggedData_0x38295:
INCBIN "baserom.gbc", $38295, $382CF - $38295

UnknownData_0x382CF:
INCBIN "baserom.gbc", $382CF, $382DD - $382CF

LoggedData_0x382DD:
INCBIN "baserom.gbc", $382DD, $3833D - $382DD

UnknownData_0x3833D:
INCBIN "baserom.gbc", $3833D, $38353 - $3833D

LoggedData_0x38353:
INCBIN "baserom.gbc", $38353, $38359 - $38353

UnknownData_0x38359:
INCBIN "baserom.gbc", $38359, $38365 - $38359

LoggedData_0x38365:
INCBIN "baserom.gbc", $38365, $3841A - $38365

UnknownData_0x3841A:
INCBIN "baserom.gbc", $3841A, $38469 - $3841A

LoggedData_0x38469:
INCBIN "baserom.gbc", $38469, $3850B - $38469

UnknownData_0x3850B:
INCBIN "baserom.gbc", $3850B, $3855B - $3850B

LoggedData_0x3855B:
INCBIN "baserom.gbc", $3855B, $38619 - $3855B

UnknownData_0x38619:
INCBIN "baserom.gbc", $38619, $38651 - $38619

LoggedData_0x38651:
INCBIN "baserom.gbc", $38651, $386C5 - $38651

UnknownData_0x386C5:
INCBIN "baserom.gbc", $386C5, $386F8 - $386C5

LoggedData_0x386F8:
INCBIN "baserom.gbc", $386F8, $38700 - $386F8

UnknownData_0x38700:
INCBIN "baserom.gbc", $38700, $38710 - $38700

LoggedData_0x38710:
INCBIN "baserom.gbc", $38710, $387A7 - $38710

UnknownData_0x387A7:
INCBIN "baserom.gbc", $387A7, $387B9 - $387A7

LoggedData_0x387B9:
INCBIN "baserom.gbc", $387B9, $38844 - $387B9

UnknownData_0x38844:
INCBIN "baserom.gbc", $38844, $38857 - $38844

LoggedData_0x38857:
INCBIN "baserom.gbc", $38857, $3893C - $38857

UnknownData_0x3893C:
INCBIN "baserom.gbc", $3893C, $38953 - $3893C

LoggedData_0x38953:
INCBIN "baserom.gbc", $38953, $38959 - $38953

UnknownData_0x38959:
INCBIN "baserom.gbc", $38959, $38965 - $38959

LoggedData_0x38965:
INCBIN "baserom.gbc", $38965, $389BC - $38965

UnknownData_0x389BC:
INCBIN "baserom.gbc", $389BC, $389BD - $389BC

LoggedData_0x389BD:
INCBIN "baserom.gbc", $389BD, $38A08 - $389BD

UnknownData_0x38A08:
INCBIN "baserom.gbc", $38A08, $38A09 - $38A08

LoggedData_0x38A09:
INCBIN "baserom.gbc", $38A09, $38A62 - $38A09

UnknownData_0x38A62:
INCBIN "baserom.gbc", $38A62, $38A65 - $38A62

LoggedData_0x38A65:
INCBIN "baserom.gbc", $38A65, $38A6B - $38A65

UnknownData_0x38A6B:
INCBIN "baserom.gbc", $38A6B, $38A77 - $38A6B

LoggedData_0x38A77:
INCBIN "baserom.gbc", $38A77, $38B5F - $38A77

UnknownData_0x38B5F:
INCBIN "baserom.gbc", $38B5F, $38B60 - $38B5F

LoggedData_0x38B60:
INCBIN "baserom.gbc", $38B60, $38B93 - $38B60

UnknownData_0x38B93:
INCBIN "baserom.gbc", $38B93, $38B9E - $38B93

LoggedData_0x38B9E:
INCBIN "baserom.gbc", $38B9E, $38BC9 - $38B9E

UnknownData_0x38BC9:
INCBIN "baserom.gbc", $38BC9, $38BD8 - $38BC9

LoggedData_0x38BD8:
INCBIN "baserom.gbc", $38BD8, $38BDC - $38BD8

UnknownData_0x38BDC:
INCBIN "baserom.gbc", $38BDC, $38BE4 - $38BDC

LoggedData_0x38BE4:
INCBIN "baserom.gbc", $38BE4, $38D83 - $38BE4

UnknownData_0x38D83:
INCBIN "baserom.gbc", $38D83, $38D84 - $38D83

LoggedData_0x38D84:
INCBIN "baserom.gbc", $38D84, $38E1B - $38D84

UnknownData_0x38E1B:
INCBIN "baserom.gbc", $38E1B, $38E1C - $38E1B

LoggedData_0x38E1C:
INCBIN "baserom.gbc", $38E1C, $38F12 - $38E1C

UnknownData_0x38F12:
INCBIN "baserom.gbc", $38F12, $38F15 - $38F12

LoggedData_0x38F15:
INCBIN "baserom.gbc", $38F15, $38F1B - $38F15

UnknownData_0x38F1B:
INCBIN "baserom.gbc", $38F1B, $38F27 - $38F1B

LoggedData_0x38F27:
INCBIN "baserom.gbc", $38F27, $39054 - $38F27

UnknownData_0x39054:
INCBIN "baserom.gbc", $39054, $39055 - $39054

LoggedData_0x39055:
INCBIN "baserom.gbc", $39055, $3911D - $39055

UnknownData_0x3911D:
INCBIN "baserom.gbc", $3911D, $3911E - $3911D

LoggedData_0x3911E:
INCBIN "baserom.gbc", $3911E, $3926C - $3911E

UnknownData_0x3926C:
INCBIN "baserom.gbc", $3926C, $3926D - $3926C

LoggedData_0x3926D:
INCBIN "baserom.gbc", $3926D, $39307 - $3926D

UnknownData_0x39307:
INCBIN "baserom.gbc", $39307, $3930A - $39307

LoggedData_0x3930A:
INCBIN "baserom.gbc", $3930A, $39312 - $3930A

UnknownData_0x39312:
INCBIN "baserom.gbc", $39312, $39322 - $39312

LoggedData_0x39322:
INCBIN "baserom.gbc", $39322, $39398 - $39322

UnknownData_0x39398:
INCBIN "baserom.gbc", $39398, $39399 - $39398

LoggedData_0x39399:
INCBIN "baserom.gbc", $39399, $393EA - $39399

UnknownData_0x393EA:
INCBIN "baserom.gbc", $393EA, $393EB - $393EA

LoggedData_0x393EB:
INCBIN "baserom.gbc", $393EB, $3945A - $393EB

UnknownData_0x3945A:
INCBIN "baserom.gbc", $3945A, $3945B - $3945A

LoggedData_0x3945B:
INCBIN "baserom.gbc", $3945B, $394CB - $3945B

UnknownData_0x394CB:
INCBIN "baserom.gbc", $394CB, $394CE - $394CB

LoggedData_0x394CE:
INCBIN "baserom.gbc", $394CE, $394D6 - $394CE

UnknownData_0x394D6:
INCBIN "baserom.gbc", $394D6, $394E6 - $394D6

LoggedData_0x394E6:
INCBIN "baserom.gbc", $394E6, $39552 - $394E6

UnknownData_0x39552:
INCBIN "baserom.gbc", $39552, $39553 - $39552

LoggedData_0x39553:
INCBIN "baserom.gbc", $39553, $395DB - $39553

UnknownData_0x395DB:
INCBIN "baserom.gbc", $395DB, $395E3 - $395DB

LoggedData_0x395E3:
INCBIN "baserom.gbc", $395E3, $395E7 - $395E3

UnknownData_0x395E7:
INCBIN "baserom.gbc", $395E7, $395EF - $395E7

LoggedData_0x395EF:
INCBIN "baserom.gbc", $395EF, $39642 - $395EF

UnknownData_0x39642:
INCBIN "baserom.gbc", $39642, $39643 - $39642

LoggedData_0x39643:
INCBIN "baserom.gbc", $39643, $396BD - $39643

UnknownData_0x396BD:
INCBIN "baserom.gbc", $396BD, $396BE - $396BD

LoggedData_0x396BE:
INCBIN "baserom.gbc", $396BE, $397F3 - $396BE

UnknownData_0x397F3:
INCBIN "baserom.gbc", $397F3, $397F4 - $397F3

LoggedData_0x397F4:
INCBIN "baserom.gbc", $397F4, $39837 - $397F4

UnknownData_0x39837:
INCBIN "baserom.gbc", $39837, $39856 - $39837

LoggedData_0x39856:
INCBIN "baserom.gbc", $39856, $39893 - $39856

UnknownData_0x39893:
INCBIN "baserom.gbc", $39893, $398B6 - $39893

LoggedData_0x398B6:
INCBIN "baserom.gbc", $398B6, $398BA - $398B6

UnknownData_0x398BA:
INCBIN "baserom.gbc", $398BA, $398C2 - $398BA

LoggedData_0x398C2:
INCBIN "baserom.gbc", $398C2, $3993D - $398C2

UnknownData_0x3993D:
INCBIN "baserom.gbc", $3993D, $3993E - $3993D

LoggedData_0x3993E:
INCBIN "baserom.gbc", $3993E, $39990 - $3993E

UnknownData_0x39990:
INCBIN "baserom.gbc", $39990, $39993 - $39990

LoggedData_0x39993:
INCBIN "baserom.gbc", $39993, $39997 - $39993

UnknownData_0x39997:
INCBIN "baserom.gbc", $39997, $3999F - $39997

LoggedData_0x3999F:
INCBIN "baserom.gbc", $3999F, $399EA - $3999F

UnknownData_0x399EA:
INCBIN "baserom.gbc", $399EA, $39A29 - $399EA

LoggedData_0x39A29:
INCBIN "baserom.gbc", $39A29, $39A70 - $39A29

UnknownData_0x39A70:
INCBIN "baserom.gbc", $39A70, $39AAD - $39A70

LoggedData_0x39AAD:
INCBIN "baserom.gbc", $39AAD, $39AF8 - $39AAD

UnknownData_0x39AF8:
INCBIN "baserom.gbc", $39AF8, $39B46 - $39AF8

LoggedData_0x39B46:
INCBIN "baserom.gbc", $39B46, $39B92 - $39B46

UnknownData_0x39B92:
INCBIN "baserom.gbc", $39B92, $39BAA - $39B92

LoggedData_0x39BAA:
INCBIN "baserom.gbc", $39BAA, $39BB2 - $39BAA

UnknownData_0x39BB2:
INCBIN "baserom.gbc", $39BB2, $39BC2 - $39BB2

LoggedData_0x39BC2:
INCBIN "baserom.gbc", $39BC2, $39C1F - $39BC2

UnknownData_0x39C1F:
INCBIN "baserom.gbc", $39C1F, $39C63 - $39C1F

LoggedData_0x39C63:
INCBIN "baserom.gbc", $39C63, $39C8E - $39C63

UnknownData_0x39C8E:
INCBIN "baserom.gbc", $39C8E, $39CBA - $39C8E

LoggedData_0x39CBA:
INCBIN "baserom.gbc", $39CBA, $39D11 - $39CBA

UnknownData_0x39D11:
INCBIN "baserom.gbc", $39D11, $39D55 - $39D11

LoggedData_0x39D55:
INCBIN "baserom.gbc", $39D55, $39D5B - $39D55

UnknownData_0x39D5B:
INCBIN "baserom.gbc", $39D5B, $39D67 - $39D5B

LoggedData_0x39D67:
INCBIN "baserom.gbc", $39D67, $39D84 - $39D67

UnknownData_0x39D84:
INCBIN "baserom.gbc", $39D84, $39D85 - $39D84

LoggedData_0x39D85:
INCBIN "baserom.gbc", $39D85, $39DA0 - $39D85

UnknownData_0x39DA0:
INCBIN "baserom.gbc", $39DA0, $39DA1 - $39DA0

LoggedData_0x39DA1:
INCBIN "baserom.gbc", $39DA1, $39DB6 - $39DA1

UnknownData_0x39DB6:
INCBIN "baserom.gbc", $39DB6, $39DB9 - $39DB6

LoggedData_0x39DB9:
INCBIN "baserom.gbc", $39DB9, $39DBF - $39DB9

UnknownData_0x39DBF:
INCBIN "baserom.gbc", $39DBF, $39DCB - $39DBF

LoggedData_0x39DCB:
INCBIN "baserom.gbc", $39DCB, $39E68 - $39DCB

UnknownData_0x39E68:
INCBIN "baserom.gbc", $39E68, $39E69 - $39E68

LoggedData_0x39E69:
INCBIN "baserom.gbc", $39E69, $39F10 - $39E69

UnknownData_0x39F10:
INCBIN "baserom.gbc", $39F10, $39F13 - $39F10

LoggedData_0x39F13:
INCBIN "baserom.gbc", $39F13, $39F17 - $39F13

UnknownData_0x39F17:
INCBIN "baserom.gbc", $39F17, $39F1F - $39F17

LoggedData_0x39F1F:
INCBIN "baserom.gbc", $39F1F, $39F6F - $39F1F

UnknownData_0x39F6F:
INCBIN "baserom.gbc", $39F6F, $39FE5 - $39F6F

LoggedData_0x39FE5:
INCBIN "baserom.gbc", $39FE5, $3A08B - $39FE5

UnknownData_0x3A08B:
INCBIN "baserom.gbc", $3A08B, $3A170 - $3A08B

LoggedData_0x3A170:
INCBIN "baserom.gbc", $3A170, $3A1BA - $3A170

UnknownData_0x3A1BA:
INCBIN "baserom.gbc", $3A1BA, $3A24B - $3A1BA

LoggedData_0x3A24B:
INCBIN "baserom.gbc", $3A24B, $3A2A9 - $3A24B

UnknownData_0x3A2A9:
INCBIN "baserom.gbc", $3A2A9, $3A2F1 - $3A2A9

LoggedData_0x3A2F1:
INCBIN "baserom.gbc", $3A2F1, $3A2F9 - $3A2F1

UnknownData_0x3A2F9:
INCBIN "baserom.gbc", $3A2F9, $3A309 - $3A2F9

LoggedData_0x3A309:
INCBIN "baserom.gbc", $3A309, $3A642 - $3A309

UnknownData_0x3A642:
INCBIN "baserom.gbc", $3A642, $3A643 - $3A642

LoggedData_0x3A643:
INCBIN "baserom.gbc", $3A643, $3A71D - $3A643

UnknownData_0x3A71D:
INCBIN "baserom.gbc", $3A71D, $3A848 - $3A71D

LoggedData_0x3A848:
INCBIN "baserom.gbc", $3A848, $3A8D7 - $3A848

UnknownData_0x3A8D7:
INCBIN "baserom.gbc", $3A8D7, $3AA0B - $3A8D7

LoggedData_0x3AA0B:
INCBIN "baserom.gbc", $3AA0B, $3AAA3 - $3AA0B

UnknownData_0x3AAA3:
INCBIN "baserom.gbc", $3AAA3, $3AB6D - $3AAA3

LoggedData_0x3AB6D:
INCBIN "baserom.gbc", $3AB6D, $3ABDF - $3AB6D

UnknownData_0x3ABDF:
INCBIN "baserom.gbc", $3ABDF, $3AC2D - $3ABDF

LoggedData_0x3AC2D:
INCBIN "baserom.gbc", $3AC2D, $3AC35 - $3AC2D

UnknownData_0x3AC35:
INCBIN "baserom.gbc", $3AC35, $3AC45 - $3AC35

LoggedData_0x3AC45:
INCBIN "baserom.gbc", $3AC45, $3ADCC - $3AC45

UnknownData_0x3ADCC:
INCBIN "baserom.gbc", $3ADCC, $3ADCD - $3ADCC

LoggedData_0x3ADCD:
INCBIN "baserom.gbc", $3ADCD, $3AF7C - $3ADCD

UnknownData_0x3AF7C:
INCBIN "baserom.gbc", $3AF7C, $3AF7D - $3AF7C

LoggedData_0x3AF7D:
INCBIN "baserom.gbc", $3AF7D, $3B0C0 - $3AF7D

UnknownData_0x3B0C0:
INCBIN "baserom.gbc", $3B0C0, $3B0C1 - $3B0C0

LoggedData_0x3B0C1:
INCBIN "baserom.gbc", $3B0C1, $3B151 - $3B0C1

UnknownData_0x3B151:
INCBIN "baserom.gbc", $3B151, $3B154 - $3B151

LoggedData_0x3B154:
INCBIN "baserom.gbc", $3B154, $3B15C - $3B154

UnknownData_0x3B15C:
INCBIN "baserom.gbc", $3B15C, $3B16C - $3B15C

LoggedData_0x3B16C:
INCBIN "baserom.gbc", $3B16C, $3B1B7 - $3B16C

UnknownData_0x3B1B7:
INCBIN "baserom.gbc", $3B1B7, $3B1DA - $3B1B7

LoggedData_0x3B1DA:
INCBIN "baserom.gbc", $3B1DA, $3B223 - $3B1DA

UnknownData_0x3B223:
INCBIN "baserom.gbc", $3B223, $3B246 - $3B223

LoggedData_0x3B246:
INCBIN "baserom.gbc", $3B246, $3B28A - $3B246

UnknownData_0x3B28A:
INCBIN "baserom.gbc", $3B28A, $3B2A8 - $3B28A

LoggedData_0x3B2A8:
INCBIN "baserom.gbc", $3B2A8, $3B2AE - $3B2A8

UnknownData_0x3B2AE:
INCBIN "baserom.gbc", $3B2AE, $3B2BA - $3B2AE

LoggedData_0x3B2BA:
INCBIN "baserom.gbc", $3B2BA, $3B336 - $3B2BA

UnknownData_0x3B336:
INCBIN "baserom.gbc", $3B336, $3B337 - $3B336

LoggedData_0x3B337:
INCBIN "baserom.gbc", $3B337, $3B3B2 - $3B337

UnknownData_0x3B3B2:
INCBIN "baserom.gbc", $3B3B2, $3B3B3 - $3B3B2

LoggedData_0x3B3B3:
INCBIN "baserom.gbc", $3B3B3, $3B48C - $3B3B3

UnknownData_0x3B48C:
INCBIN "baserom.gbc", $3B48C, $3B48F - $3B48C

LoggedData_0x3B48F:
INCBIN "baserom.gbc", $3B48F, $3B495 - $3B48F

UnknownData_0x3B495:
INCBIN "baserom.gbc", $3B495, $3B4A1 - $3B495

LoggedData_0x3B4A1:
INCBIN "baserom.gbc", $3B4A1, $3B4E6 - $3B4A1

UnknownData_0x3B4E6:
INCBIN "baserom.gbc", $3B4E6, $3B4E7 - $3B4E6

LoggedData_0x3B4E7:
INCBIN "baserom.gbc", $3B4E7, $3B55C - $3B4E7

UnknownData_0x3B55C:
INCBIN "baserom.gbc", $3B55C, $3B60A - $3B55C

LoggedData_0x3B60A:
INCBIN "baserom.gbc", $3B60A, $3B677 - $3B60A

UnknownData_0x3B677:
INCBIN "baserom.gbc", $3B677, $3B725 - $3B677

LoggedData_0x3B725:
INCBIN "baserom.gbc", $3B725, $3B74E - $3B725

UnknownData_0x3B74E:
INCBIN "baserom.gbc", $3B74E, $3B7AB - $3B74E

LoggedData_0x3B7AB:
INCBIN "baserom.gbc", $3B7AB, $3B800 - $3B7AB

UnknownData_0x3B800:
INCBIN "baserom.gbc", $3B800, $3B836 - $3B800

LoggedData_0x3B836:
INCBIN "baserom.gbc", $3B836, $3B83E - $3B836

UnknownData_0x3B83E:
INCBIN "baserom.gbc", $3B83E, $3B84E - $3B83E

LoggedData_0x3B84E:
INCBIN "baserom.gbc", $3B84E, $3B85C - $3B84E

UnknownData_0x3B85C:
INCBIN "baserom.gbc", $3B85C, $3B85D - $3B85C

LoggedData_0x3B85D:
INCBIN "baserom.gbc", $3B85D, $3B92F - $3B85D

UnknownData_0x3B92F:
INCBIN "baserom.gbc", $3B92F, $3B930 - $3B92F

LoggedData_0x3B930:
INCBIN "baserom.gbc", $3B930, $3B940 - $3B930

UnknownData_0x3B940:
INCBIN "baserom.gbc", $3B940, $3B941 - $3B940

LoggedData_0x3B941:
INCBIN "baserom.gbc", $3B941, $3B959 - $3B941

UnknownData_0x3B959:
INCBIN "baserom.gbc", $3B959, $3B95A - $3B959

LoggedData_0x3B95A:
INCBIN "baserom.gbc", $3B95A, $3B982 - $3B95A

UnknownData_0x3B982:
INCBIN "baserom.gbc", $3B982, $3B983 - $3B982

LoggedData_0x3B983:
INCBIN "baserom.gbc", $3B983, $3B9BD - $3B983

UnknownData_0x3B9BD:
INCBIN "baserom.gbc", $3B9BD, $3B9BE - $3B9BD

LoggedData_0x3B9BE:
INCBIN "baserom.gbc", $3B9BE, $3B9D4 - $3B9BE

UnknownData_0x3B9D4:
INCBIN "baserom.gbc", $3B9D4, $3B9D5 - $3B9D4

LoggedData_0x3B9D5:
INCBIN "baserom.gbc", $3B9D5, $3B9F8 - $3B9D5

UnknownData_0x3B9F8:
INCBIN "baserom.gbc", $3B9F8, $3B9F9 - $3B9F8

LoggedData_0x3B9F9:
INCBIN "baserom.gbc", $3B9F9, $3BA25 - $3B9F9

UnknownData_0x3BA25:
INCBIN "baserom.gbc", $3BA25, $3BA26 - $3BA25

LoggedData_0x3BA26:
INCBIN "baserom.gbc", $3BA26, $3BA45 - $3BA26

UnknownData_0x3BA45:
INCBIN "baserom.gbc", $3BA45, $3BA46 - $3BA45

LoggedData_0x3BA46:
INCBIN "baserom.gbc", $3BA46, $3BA56 - $3BA46

UnknownData_0x3BA56:
INCBIN "baserom.gbc", $3BA56, $3BA57 - $3BA56

LoggedData_0x3BA57:
INCBIN "baserom.gbc", $3BA57, $3BA59 - $3BA57

UnknownData_0x3BA59:
INCBIN "baserom.gbc", $3BA59, $3BA5B - $3BA59

LoggedData_0x3BA5B:
INCBIN "baserom.gbc", $3BA5B, $3BA69 - $3BA5B

UnknownData_0x3BA69:
INCBIN "baserom.gbc", $3BA69, $3BA6A - $3BA69

LoggedData_0x3BA6A:
INCBIN "baserom.gbc", $3BA6A, $3BAA7 - $3BA6A

UnknownData_0x3BAA7:
INCBIN "baserom.gbc", $3BAA7, $3BAA8 - $3BAA7

LoggedData_0x3BAA8:
INCBIN "baserom.gbc", $3BAA8, $3BAC8 - $3BAA8

UnknownData_0x3BAC8:
INCBIN "baserom.gbc", $3BAC8, $3BAC9 - $3BAC8

LoggedData_0x3BAC9:
INCBIN "baserom.gbc", $3BAC9, $3BADE - $3BAC9

UnknownData_0x3BADE:
INCBIN "baserom.gbc", $3BADE, $3BADF - $3BADE

LoggedData_0x3BADF:
INCBIN "baserom.gbc", $3BADF, $3BAF3 - $3BADF

UnknownData_0x3BAF3:
INCBIN "baserom.gbc", $3BAF3, $3BAF4 - $3BAF3

LoggedData_0x3BAF4:
INCBIN "baserom.gbc", $3BAF4, $3BB06 - $3BAF4

UnknownData_0x3BB06:
INCBIN "baserom.gbc", $3BB06, $3BB07 - $3BB06

LoggedData_0x3BB07:
INCBIN "baserom.gbc", $3BB07, $3BB39 - $3BB07

UnknownData_0x3BB39:
INCBIN "baserom.gbc", $3BB39, $3BB3A - $3BB39

LoggedData_0x3BB3A:
INCBIN "baserom.gbc", $3BB3A, $3BB71 - $3BB3A

UnknownData_0x3BB71:
INCBIN "baserom.gbc", $3BB71, $3BB72 - $3BB71

LoggedData_0x3BB72:
INCBIN "baserom.gbc", $3BB72, $3BB84 - $3BB72

UnknownData_0x3BB84:
INCBIN "baserom.gbc", $3BB84, $3BB85 - $3BB84

LoggedData_0x3BB85:
INCBIN "baserom.gbc", $3BB85, $3BB95 - $3BB85

UnknownData_0x3BB95:
INCBIN "baserom.gbc", $3BB95, $3BB96 - $3BB95

LoggedData_0x3BB96:
INCBIN "baserom.gbc", $3BB96, $3BBA6 - $3BB96

UnknownData_0x3BBA6:
INCBIN "baserom.gbc", $3BBA6, $3BBA7 - $3BBA6

LoggedData_0x3BBA7:
INCBIN "baserom.gbc", $3BBA7, $3BBD0 - $3BBA7

UnknownData_0x3BBD0:
INCBIN "baserom.gbc", $3BBD0, $3BBD1 - $3BBD0

LoggedData_0x3BBD1:
INCBIN "baserom.gbc", $3BBD1, $3BBFE - $3BBD1

UnknownData_0x3BBFE:
INCBIN "baserom.gbc", $3BBFE, $3BBFF - $3BBFE

LoggedData_0x3BBFF:
INCBIN "baserom.gbc", $3BBFF, $3BC0F - $3BBFF

UnknownData_0x3BC0F:
INCBIN "baserom.gbc", $3BC0F, $3BC10 - $3BC0F

LoggedData_0x3BC10:
INCBIN "baserom.gbc", $3BC10, $3BC22 - $3BC10

UnknownData_0x3BC22:
INCBIN "baserom.gbc", $3BC22, $3BC23 - $3BC22

LoggedData_0x3BC23:
INCBIN "baserom.gbc", $3BC23, $3BC86 - $3BC23

UnknownData_0x3BC86:
INCBIN "baserom.gbc", $3BC86, $3BC87 - $3BC86

LoggedData_0x3BC87:
INCBIN "baserom.gbc", $3BC87, $3BCAB - $3BC87

UnknownData_0x3BCAB:
INCBIN "baserom.gbc", $3BCAB, $3BCAC - $3BCAB

LoggedData_0x3BCAC:
INCBIN "baserom.gbc", $3BCAC, $3BCBC - $3BCAC

UnknownData_0x3BCBC:
INCBIN "baserom.gbc", $3BCBC, $3BCBD - $3BCBC

LoggedData_0x3BCBD:
INCBIN "baserom.gbc", $3BCBD, $3BCCD - $3BCBD

UnknownData_0x3BCCD:
INCBIN "baserom.gbc", $3BCCD, $3BCCE - $3BCCD

LoggedData_0x3BCCE:
INCBIN "baserom.gbc", $3BCCE, $3BCE2 - $3BCCE

UnknownData_0x3BCE2:
INCBIN "baserom.gbc", $3BCE2, $3BCE3 - $3BCE2

LoggedData_0x3BCE3:
INCBIN "baserom.gbc", $3BCE3, $3BD05 - $3BCE3

UnknownData_0x3BD05:
INCBIN "baserom.gbc", $3BD05, $3BD06 - $3BD05

LoggedData_0x3BD06:
INCBIN "baserom.gbc", $3BD06, $3BD1E - $3BD06

UnknownData_0x3BD1E:
INCBIN "baserom.gbc", $3BD1E, $3BD1F - $3BD1E

LoggedData_0x3BD1F:
INCBIN "baserom.gbc", $3BD1F, $3BD30 - $3BD1F

UnknownData_0x3BD30:
INCBIN "baserom.gbc", $3BD30, $3BD31 - $3BD30

LoggedData_0x3BD31:
INCBIN "baserom.gbc", $3BD31, $3BD61 - $3BD31

UnknownData_0x3BD61:
INCBIN "baserom.gbc", $3BD61, $3BD62 - $3BD61

LoggedData_0x3BD62:
INCBIN "baserom.gbc", $3BD62, $3BDCD - $3BD62

UnknownData_0x3BDCD:
INCBIN "baserom.gbc", $3BDCD, $3BDCE - $3BDCD

LoggedData_0x3BDCE:
INCBIN "baserom.gbc", $3BDCE, $3BDEB - $3BDCE

UnknownData_0x3BDEB:
INCBIN "baserom.gbc", $3BDEB, $3BDEC - $3BDEB

LoggedData_0x3BDEC:
INCBIN "baserom.gbc", $3BDEC, $3BE16 - $3BDEC

UnknownData_0x3BE16:
INCBIN "baserom.gbc", $3BE16, $3BE17 - $3BE16

LoggedData_0x3BE17:
INCBIN "baserom.gbc", $3BE17, $3BE45 - $3BE17

UnknownData_0x3BE45:
INCBIN "baserom.gbc", $3BE45, $3BE46 - $3BE45

LoggedData_0x3BE46:
INCBIN "baserom.gbc", $3BE46, $3BE64 - $3BE46

UnknownData_0x3BE64:
INCBIN "baserom.gbc", $3BE64, $3BE65 - $3BE64

LoggedData_0x3BE65:
INCBIN "baserom.gbc", $3BE65, $3BE7F - $3BE65

UnknownData_0x3BE7F:
INCBIN "baserom.gbc", $3BE7F, $3BE80 - $3BE7F

LoggedData_0x3BE80:
INCBIN "baserom.gbc", $3BE80, $3BEB0 - $3BE80

UnknownData_0x3BEB0:
INCBIN "baserom.gbc", $3BEB0, $3BEB1 - $3BEB0

LoggedData_0x3BEB1:
INCBIN "baserom.gbc", $3BEB1, $3BFC5 - $3BEB1

UnknownData_0x3BFC5:
INCBIN "baserom.gbc", $3BFC5, $3BFC6 - $3BFC5

LoggedData_0x3BFC6:
INCBIN "baserom.gbc", $3BFC6, $3BFD6 - $3BFC6

UnknownData_0x3BFD6:
INCBIN "baserom.gbc", $3BFD6, $3BFD7 - $3BFD6

LoggedData_0x3BFD7:
INCBIN "baserom.gbc", $3BFD7, $3BFEF - $3BFD7

UnknownData_0x3BFEF:
INCBIN "baserom.gbc", $3BFEF, $3BFF0 - $3BFEF

LoggedData_0x3BFF0:
INCBIN "baserom.gbc", $3BFF0, $3BFF2 - $3BFF0

UnknownData_0x3BFF2:
INCBIN "baserom.gbc", $3BFF2, $3C000 - $3BFF2

SECTION "Bank0F", ROMX, BANK[$0F]

LoggedData_0x3C000:
INCBIN "baserom.gbc", $3C000, $3C016 - $3C000

UnknownData_0x3C016:
INCBIN "baserom.gbc", $3C016, $3C017 - $3C016

LoggedData_0x3C017:
INCBIN "baserom.gbc", $3C017, $3C02B - $3C017

UnknownData_0x3C02B:
INCBIN "baserom.gbc", $3C02B, $3C02C - $3C02B

LoggedData_0x3C02C:
INCBIN "baserom.gbc", $3C02C, $3C03E - $3C02C

UnknownData_0x3C03E:
INCBIN "baserom.gbc", $3C03E, $3C03F - $3C03E

LoggedData_0x3C03F:
INCBIN "baserom.gbc", $3C03F, $3C0AF - $3C03F

UnknownData_0x3C0AF:
INCBIN "baserom.gbc", $3C0AF, $3C0B0 - $3C0AF

LoggedData_0x3C0B0:
INCBIN "baserom.gbc", $3C0B0, $3C150 - $3C0B0

UnknownData_0x3C150:
INCBIN "baserom.gbc", $3C150, $3C151 - $3C150

LoggedData_0x3C151:
INCBIN "baserom.gbc", $3C151, $3C167 - $3C151

UnknownData_0x3C167:
INCBIN "baserom.gbc", $3C167, $3C168 - $3C167

LoggedData_0x3C168:
INCBIN "baserom.gbc", $3C168, $3C1AD - $3C168

UnknownData_0x3C1AD:
INCBIN "baserom.gbc", $3C1AD, $3C1AE - $3C1AD

LoggedData_0x3C1AE:
INCBIN "baserom.gbc", $3C1AE, $3C1C9 - $3C1AE

UnknownData_0x3C1C9:
INCBIN "baserom.gbc", $3C1C9, $3C1CA - $3C1C9

LoggedData_0x3C1CA:
INCBIN "baserom.gbc", $3C1CA, $3C1CC - $3C1CA

UnknownData_0x3C1CC:
INCBIN "baserom.gbc", $3C1CC, $3C1EE - $3C1CC

LoggedData_0x3C1EE:
INCBIN "baserom.gbc", $3C1EE, $3C207 - $3C1EE

UnknownData_0x3C207:
INCBIN "baserom.gbc", $3C207, $3C208 - $3C207

LoggedData_0x3C208:
INCBIN "baserom.gbc", $3C208, $3C229 - $3C208

UnknownData_0x3C229:
INCBIN "baserom.gbc", $3C229, $3C22A - $3C229

LoggedData_0x3C22A:
INCBIN "baserom.gbc", $3C22A, $3C254 - $3C22A

UnknownData_0x3C254:
INCBIN "baserom.gbc", $3C254, $3C255 - $3C254

LoggedData_0x3C255:
INCBIN "baserom.gbc", $3C255, $3C297 - $3C255

UnknownData_0x3C297:
INCBIN "baserom.gbc", $3C297, $3C298 - $3C297

LoggedData_0x3C298:
INCBIN "baserom.gbc", $3C298, $3C2AE - $3C298

UnknownData_0x3C2AE:
INCBIN "baserom.gbc", $3C2AE, $3C2AF - $3C2AE

LoggedData_0x3C2AF:
INCBIN "baserom.gbc", $3C2AF, $3C2D5 - $3C2AF

UnknownData_0x3C2D5:
INCBIN "baserom.gbc", $3C2D5, $3C2D6 - $3C2D5

LoggedData_0x3C2D6:
INCBIN "baserom.gbc", $3C2D6, $3C32A - $3C2D6

UnknownData_0x3C32A:
INCBIN "baserom.gbc", $3C32A, $3C32B - $3C32A

LoggedData_0x3C32B:
INCBIN "baserom.gbc", $3C32B, $3C375 - $3C32B

UnknownData_0x3C375:
INCBIN "baserom.gbc", $3C375, $3C376 - $3C375

LoggedData_0x3C376:
INCBIN "baserom.gbc", $3C376, $3C3DD - $3C376

UnknownData_0x3C3DD:
INCBIN "baserom.gbc", $3C3DD, $3C3DE - $3C3DD

LoggedData_0x3C3DE:
INCBIN "baserom.gbc", $3C3DE, $3C3F2 - $3C3DE

UnknownData_0x3C3F2:
INCBIN "baserom.gbc", $3C3F2, $3C3F3 - $3C3F2

LoggedData_0x3C3F3:
INCBIN "baserom.gbc", $3C3F3, $3C419 - $3C3F3

UnknownData_0x3C419:
INCBIN "baserom.gbc", $3C419, $3C41A - $3C419

LoggedData_0x3C41A:
INCBIN "baserom.gbc", $3C41A, $3C42E - $3C41A

UnknownData_0x3C42E:
INCBIN "baserom.gbc", $3C42E, $3C454 - $3C42E

LoggedData_0x3C454:
INCBIN "baserom.gbc", $3C454, $3C4AA - $3C454

UnknownData_0x3C4AA:
INCBIN "baserom.gbc", $3C4AA, $3C4AB - $3C4AA

LoggedData_0x3C4AB:
INCBIN "baserom.gbc", $3C4AB, $3C521 - $3C4AB

UnknownData_0x3C521:
INCBIN "baserom.gbc", $3C521, $3C522 - $3C521

LoggedData_0x3C522:
INCBIN "baserom.gbc", $3C522, $3C598 - $3C522

UnknownData_0x3C598:
INCBIN "baserom.gbc", $3C598, $3C599 - $3C598

LoggedData_0x3C599:
INCBIN "baserom.gbc", $3C599, $3C618 - $3C599

UnknownData_0x3C618:
INCBIN "baserom.gbc", $3C618, $3C619 - $3C618

LoggedData_0x3C619:
INCBIN "baserom.gbc", $3C619, $3C684 - $3C619

UnknownData_0x3C684:
INCBIN "baserom.gbc", $3C684, $3C685 - $3C684

LoggedData_0x3C685:
INCBIN "baserom.gbc", $3C685, $3C719 - $3C685

UnknownData_0x3C719:
INCBIN "baserom.gbc", $3C719, $3C71A - $3C719

LoggedData_0x3C71A:
INCBIN "baserom.gbc", $3C71A, $3C72E - $3C71A

UnknownData_0x3C72E:
INCBIN "baserom.gbc", $3C72E, $3C72F - $3C72E

LoggedData_0x3C72F:
INCBIN "baserom.gbc", $3C72F, $3C742 - $3C72F

UnknownData_0x3C742:
INCBIN "baserom.gbc", $3C742, $3C743 - $3C742

LoggedData_0x3C743:
INCBIN "baserom.gbc", $3C743, $3C77D - $3C743

UnknownData_0x3C77D:
INCBIN "baserom.gbc", $3C77D, $3C77E - $3C77D

LoggedData_0x3C77E:
INCBIN "baserom.gbc", $3C77E, $3C7A0 - $3C77E

UnknownData_0x3C7A0:
INCBIN "baserom.gbc", $3C7A0, $3C7B6 - $3C7A0

LoggedData_0x3C7B6:
INCBIN "baserom.gbc", $3C7B6, $3C7D2 - $3C7B6

UnknownData_0x3C7D2:
INCBIN "baserom.gbc", $3C7D2, $3C7ED - $3C7D2

LoggedData_0x3C7ED:
INCBIN "baserom.gbc", $3C7ED, $3C810 - $3C7ED

UnknownData_0x3C810:
INCBIN "baserom.gbc", $3C810, $3C811 - $3C810

LoggedData_0x3C811:
INCBIN "baserom.gbc", $3C811, $3C82B - $3C811

UnknownData_0x3C82B:
INCBIN "baserom.gbc", $3C82B, $3C82C - $3C82B

LoggedData_0x3C82C:
INCBIN "baserom.gbc", $3C82C, $3C84D - $3C82C

UnknownData_0x3C84D:
INCBIN "baserom.gbc", $3C84D, $3C84E - $3C84D

LoggedData_0x3C84E:
INCBIN "baserom.gbc", $3C84E, $3C8A2 - $3C84E

UnknownData_0x3C8A2:
INCBIN "baserom.gbc", $3C8A2, $3C8A3 - $3C8A2

LoggedData_0x3C8A3:
INCBIN "baserom.gbc", $3C8A3, $3C8B8 - $3C8A3

UnknownData_0x3C8B8:
INCBIN "baserom.gbc", $3C8B8, $3C8B9 - $3C8B8

LoggedData_0x3C8B9:
INCBIN "baserom.gbc", $3C8B9, $3C8CD - $3C8B9

UnknownData_0x3C8CD:
INCBIN "baserom.gbc", $3C8CD, $3C8CE - $3C8CD

LoggedData_0x3C8CE:
INCBIN "baserom.gbc", $3C8CE, $3C8EC - $3C8CE

UnknownData_0x3C8EC:
INCBIN "baserom.gbc", $3C8EC, $3C8ED - $3C8EC

LoggedData_0x3C8ED:
INCBIN "baserom.gbc", $3C8ED, $3C907 - $3C8ED

UnknownData_0x3C907:
INCBIN "baserom.gbc", $3C907, $3C908 - $3C907

LoggedData_0x3C908:
INCBIN "baserom.gbc", $3C908, $3C91A - $3C908

UnknownData_0x3C91A:
INCBIN "baserom.gbc", $3C91A, $3C91B - $3C91A

LoggedData_0x3C91B:
INCBIN "baserom.gbc", $3C91B, $3C93C - $3C91B

UnknownData_0x3C93C:
INCBIN "baserom.gbc", $3C93C, $3C93D - $3C93C

LoggedData_0x3C93D:
INCBIN "baserom.gbc", $3C93D, $3C953 - $3C93D

UnknownData_0x3C953:
INCBIN "baserom.gbc", $3C953, $3C954 - $3C953

LoggedData_0x3C954:
INCBIN "baserom.gbc", $3C954, $3C9C1 - $3C954

UnknownData_0x3C9C1:
INCBIN "baserom.gbc", $3C9C1, $3C9C2 - $3C9C1

LoggedData_0x3C9C2:
INCBIN "baserom.gbc", $3C9C2, $3C9D6 - $3C9C2

UnknownData_0x3C9D6:
INCBIN "baserom.gbc", $3C9D6, $3C9D7 - $3C9D6

LoggedData_0x3C9D7:
INCBIN "baserom.gbc", $3C9D7, $3C9D9 - $3C9D7

UnknownData_0x3C9D9:
INCBIN "baserom.gbc", $3C9D9, $3C9F7 - $3C9D9

LoggedData_0x3C9F7:
INCBIN "baserom.gbc", $3C9F7, $3CA13 - $3C9F7

UnknownData_0x3CA13:
INCBIN "baserom.gbc", $3CA13, $3CA14 - $3CA13

LoggedData_0x3CA14:
INCBIN "baserom.gbc", $3CA14, $3CA2E - $3CA14

UnknownData_0x3CA2E:
INCBIN "baserom.gbc", $3CA2E, $3CA2F - $3CA2E

LoggedData_0x3CA2F:
INCBIN "baserom.gbc", $3CA2F, $3CA47 - $3CA2F

UnknownData_0x3CA47:
INCBIN "baserom.gbc", $3CA47, $3CA48 - $3CA47

LoggedData_0x3CA48:
INCBIN "baserom.gbc", $3CA48, $3CA7E - $3CA48

UnknownData_0x3CA7E:
INCBIN "baserom.gbc", $3CA7E, $3CA7F - $3CA7E

LoggedData_0x3CA7F:
INCBIN "baserom.gbc", $3CA7F, $3CA93 - $3CA7F

UnknownData_0x3CA93:
INCBIN "baserom.gbc", $3CA93, $3CA94 - $3CA93

LoggedData_0x3CA94:
INCBIN "baserom.gbc", $3CA94, $3CAD1 - $3CA94

UnknownData_0x3CAD1:
INCBIN "baserom.gbc", $3CAD1, $3CAD2 - $3CAD1

LoggedData_0x3CAD2:
INCBIN "baserom.gbc", $3CAD2, $3CAF2 - $3CAD2

UnknownData_0x3CAF2:
INCBIN "baserom.gbc", $3CAF2, $3CAF3 - $3CAF2

LoggedData_0x3CAF3:
INCBIN "baserom.gbc", $3CAF3, $3CB0B - $3CAF3

UnknownData_0x3CB0B:
INCBIN "baserom.gbc", $3CB0B, $3CB0C - $3CB0B

LoggedData_0x3CB0C:
INCBIN "baserom.gbc", $3CB0C, $3CB31 - $3CB0C

UnknownData_0x3CB31:
INCBIN "baserom.gbc", $3CB31, $3CB32 - $3CB31

LoggedData_0x3CB32:
INCBIN "baserom.gbc", $3CB32, $3CB45 - $3CB32

UnknownData_0x3CB45:
INCBIN "baserom.gbc", $3CB45, $3CB46 - $3CB45

LoggedData_0x3CB46:
INCBIN "baserom.gbc", $3CB46, $3CB7B - $3CB46

UnknownData_0x3CB7B:
INCBIN "baserom.gbc", $3CB7B, $3CB7C - $3CB7B

LoggedData_0x3CB7C:
INCBIN "baserom.gbc", $3CB7C, $3CB98 - $3CB7C

UnknownData_0x3CB98:
INCBIN "baserom.gbc", $3CB98, $3CB99 - $3CB98

LoggedData_0x3CB99:
INCBIN "baserom.gbc", $3CB99, $3CBAF - $3CB99

UnknownData_0x3CBAF:
INCBIN "baserom.gbc", $3CBAF, $3CBB0 - $3CBAF

LoggedData_0x3CBB0:
INCBIN "baserom.gbc", $3CBB0, $3CC85 - $3CBB0

UnknownData_0x3CC85:
INCBIN "baserom.gbc", $3CC85, $3CC86 - $3CC85

LoggedData_0x3CC86:
INCBIN "baserom.gbc", $3CC86, $3CC9E - $3CC86

UnknownData_0x3CC9E:
INCBIN "baserom.gbc", $3CC9E, $3CC9F - $3CC9E

LoggedData_0x3CC9F:
INCBIN "baserom.gbc", $3CC9F, $3CCB3 - $3CC9F

UnknownData_0x3CCB3:
INCBIN "baserom.gbc", $3CCB3, $3CCB4 - $3CCB3

LoggedData_0x3CCB4:
INCBIN "baserom.gbc", $3CCB4, $3CCE8 - $3CCB4

UnknownData_0x3CCE8:
INCBIN "baserom.gbc", $3CCE8, $3CCE9 - $3CCE8

LoggedData_0x3CCE9:
INCBIN "baserom.gbc", $3CCE9, $3CD09 - $3CCE9

UnknownData_0x3CD09:
INCBIN "baserom.gbc", $3CD09, $3CD0A - $3CD09

LoggedData_0x3CD0A:
INCBIN "baserom.gbc", $3CD0A, $3CD78 - $3CD0A

UnknownData_0x3CD78:
INCBIN "baserom.gbc", $3CD78, $3CD79 - $3CD78

LoggedData_0x3CD79:
INCBIN "baserom.gbc", $3CD79, $3CE0B - $3CD79

UnknownData_0x3CE0B:
INCBIN "baserom.gbc", $3CE0B, $3CE0C - $3CE0B

LoggedData_0x3CE0C:
INCBIN "baserom.gbc", $3CE0C, $3CE5B - $3CE0C

UnknownData_0x3CE5B:
INCBIN "baserom.gbc", $3CE5B, $3CE5C - $3CE5B

LoggedData_0x3CE5C:
INCBIN "baserom.gbc", $3CE5C, $3CE7C - $3CE5C

UnknownData_0x3CE7C:
INCBIN "baserom.gbc", $3CE7C, $3CE7D - $3CE7C

LoggedData_0x3CE7D:
INCBIN "baserom.gbc", $3CE7D, $3CE91 - $3CE7D

UnknownData_0x3CE91:
INCBIN "baserom.gbc", $3CE91, $3CE92 - $3CE91

LoggedData_0x3CE92:
INCBIN "baserom.gbc", $3CE92, $3CEAE - $3CE92

UnknownData_0x3CEAE:
INCBIN "baserom.gbc", $3CEAE, $3CEAF - $3CEAE

LoggedData_0x3CEAF:
INCBIN "baserom.gbc", $3CEAF, $3CEC3 - $3CEAF

UnknownData_0x3CEC3:
INCBIN "baserom.gbc", $3CEC3, $3CEC4 - $3CEC3

LoggedData_0x3CEC4:
INCBIN "baserom.gbc", $3CEC4, $3CF37 - $3CEC4

UnknownData_0x3CF37:
INCBIN "baserom.gbc", $3CF37, $3CF38 - $3CF37

LoggedData_0x3CF38:
INCBIN "baserom.gbc", $3CF38, $3CF58 - $3CF38

UnknownData_0x3CF58:
INCBIN "baserom.gbc", $3CF58, $3CF59 - $3CF58

LoggedData_0x3CF59:
INCBIN "baserom.gbc", $3CF59, $3CFD6 - $3CF59

UnknownData_0x3CFD6:
INCBIN "baserom.gbc", $3CFD6, $3CFD7 - $3CFD6

LoggedData_0x3CFD7:
INCBIN "baserom.gbc", $3CFD7, $3D001 - $3CFD7

UnknownData_0x3D001:
INCBIN "baserom.gbc", $3D001, $3D002 - $3D001

LoggedData_0x3D002:
INCBIN "baserom.gbc", $3D002, $3D02E - $3D002

UnknownData_0x3D02E:
INCBIN "baserom.gbc", $3D02E, $3D02F - $3D02E

LoggedData_0x3D02F:
INCBIN "baserom.gbc", $3D02F, $3D08D - $3D02F

UnknownData_0x3D08D:
INCBIN "baserom.gbc", $3D08D, $3D08E - $3D08D

LoggedData_0x3D08E:
INCBIN "baserom.gbc", $3D08E, $3D0FA - $3D08E

UnknownData_0x3D0FA:
INCBIN "baserom.gbc", $3D0FA, $3D0FB - $3D0FA

LoggedData_0x3D0FB:
INCBIN "baserom.gbc", $3D0FB, $3D11F - $3D0FB

UnknownData_0x3D11F:
INCBIN "baserom.gbc", $3D11F, $3D120 - $3D11F

LoggedData_0x3D120:
INCBIN "baserom.gbc", $3D120, $3D164 - $3D120

UnknownData_0x3D164:
INCBIN "baserom.gbc", $3D164, $3D165 - $3D164

LoggedData_0x3D165:
INCBIN "baserom.gbc", $3D165, $3D1B4 - $3D165

UnknownData_0x3D1B4:
INCBIN "baserom.gbc", $3D1B4, $3D1B5 - $3D1B4

LoggedData_0x3D1B5:
INCBIN "baserom.gbc", $3D1B5, $3D1C7 - $3D1B5

UnknownData_0x3D1C7:
INCBIN "baserom.gbc", $3D1C7, $3D1C8 - $3D1C7

LoggedData_0x3D1C8:
INCBIN "baserom.gbc", $3D1C8, $3D1F6 - $3D1C8

UnknownData_0x3D1F6:
INCBIN "baserom.gbc", $3D1F6, $3D1F7 - $3D1F6

LoggedData_0x3D1F7:
INCBIN "baserom.gbc", $3D1F7, $3D207 - $3D1F7

UnknownData_0x3D207:
INCBIN "baserom.gbc", $3D207, $3D208 - $3D207

LoggedData_0x3D208:
INCBIN "baserom.gbc", $3D208, $3D24C - $3D208

UnknownData_0x3D24C:
INCBIN "baserom.gbc", $3D24C, $3D24D - $3D24C

LoggedData_0x3D24D:
INCBIN "baserom.gbc", $3D24D, $3D2A9 - $3D24D

UnknownData_0x3D2A9:
INCBIN "baserom.gbc", $3D2A9, $3D2AA - $3D2A9

LoggedData_0x3D2AA:
INCBIN "baserom.gbc", $3D2AA, $3D2F3 - $3D2AA

UnknownData_0x3D2F3:
INCBIN "baserom.gbc", $3D2F3, $3D2F4 - $3D2F3

LoggedData_0x3D2F4:
INCBIN "baserom.gbc", $3D2F4, $3D356 - $3D2F4

UnknownData_0x3D356:
INCBIN "baserom.gbc", $3D356, $3D357 - $3D356

LoggedData_0x3D357:
INCBIN "baserom.gbc", $3D357, $3D386 - $3D357

UnknownData_0x3D386:
INCBIN "baserom.gbc", $3D386, $3D387 - $3D386

LoggedData_0x3D387:
INCBIN "baserom.gbc", $3D387, $3D3AA - $3D387

UnknownData_0x3D3AA:
INCBIN "baserom.gbc", $3D3AA, $3D3AB - $3D3AA

LoggedData_0x3D3AB:
INCBIN "baserom.gbc", $3D3AB, $3D4BB - $3D3AB

UnknownData_0x3D4BB:
INCBIN "baserom.gbc", $3D4BB, $3D4BC - $3D4BB

LoggedData_0x3D4BC:
INCBIN "baserom.gbc", $3D4BC, $3D4D1 - $3D4BC

UnknownData_0x3D4D1:
INCBIN "baserom.gbc", $3D4D1, $3D4D2 - $3D4D1

LoggedData_0x3D4D2:
INCBIN "baserom.gbc", $3D4D2, $3D4D4 - $3D4D2

UnknownData_0x3D4D4:
INCBIN "baserom.gbc", $3D4D4, $3D4EB - $3D4D4

LoggedData_0x3D4EB:
INCBIN "baserom.gbc", $3D4EB, $3D4FA - $3D4EB

UnknownData_0x3D4FA:
INCBIN "baserom.gbc", $3D4FA, $3D500 - $3D4FA

LoggedData_0x3D500:
INCBIN "baserom.gbc", $3D500, $3D644 - $3D500

UnknownData_0x3D644:
INCBIN "baserom.gbc", $3D644, $3D645 - $3D644

LoggedData_0x3D645:
INCBIN "baserom.gbc", $3D645, $3D685 - $3D645

UnknownData_0x3D685:
INCBIN "baserom.gbc", $3D685, $3D686 - $3D685

LoggedData_0x3D686:
INCBIN "baserom.gbc", $3D686, $3D727 - $3D686

UnknownData_0x3D727:
INCBIN "baserom.gbc", $3D727, $3D728 - $3D727

LoggedData_0x3D728:
INCBIN "baserom.gbc", $3D728, $3D75C - $3D728

UnknownData_0x3D75C:
INCBIN "baserom.gbc", $3D75C, $3D75D - $3D75C

LoggedData_0x3D75D:
INCBIN "baserom.gbc", $3D75D, $3D831 - $3D75D

UnknownData_0x3D831:
INCBIN "baserom.gbc", $3D831, $3D832 - $3D831

LoggedData_0x3D832:
INCBIN "baserom.gbc", $3D832, $3D847 - $3D832

UnknownData_0x3D847:
INCBIN "baserom.gbc", $3D847, $3D851 - $3D847

LoggedData_0x3D851:
INCBIN "baserom.gbc", $3D851, $3D86E - $3D851

UnknownData_0x3D86E:
INCBIN "baserom.gbc", $3D86E, $3D86F - $3D86E

LoggedData_0x3D86F:
INCBIN "baserom.gbc", $3D86F, $3D8AD - $3D86F

UnknownData_0x3D8AD:
INCBIN "baserom.gbc", $3D8AD, $3D8AE - $3D8AD

LoggedData_0x3D8AE:
INCBIN "baserom.gbc", $3D8AE, $3D8B2 - $3D8AE

UnknownData_0x3D8B2:
INCBIN "baserom.gbc", $3D8B2, $3D8F1 - $3D8B2

LoggedData_0x3D8F1:
INCBIN "baserom.gbc", $3D8F1, $3D92B - $3D8F1

UnknownData_0x3D92B:
INCBIN "baserom.gbc", $3D92B, $3D92C - $3D92B

LoggedData_0x3D92C:
INCBIN "baserom.gbc", $3D92C, $3D94C - $3D92C

UnknownData_0x3D94C:
INCBIN "baserom.gbc", $3D94C, $3D94D - $3D94C

LoggedData_0x3D94D:
INCBIN "baserom.gbc", $3D94D, $3D96E - $3D94D

UnknownData_0x3D96E:
INCBIN "baserom.gbc", $3D96E, $3D96F - $3D96E

LoggedData_0x3D96F:
INCBIN "baserom.gbc", $3D96F, $3D9B4 - $3D96F

UnknownData_0x3D9B4:
INCBIN "baserom.gbc", $3D9B4, $3D9B5 - $3D9B4

LoggedData_0x3D9B5:
INCBIN "baserom.gbc", $3D9B5, $3D9F0 - $3D9B5

UnknownData_0x3D9F0:
INCBIN "baserom.gbc", $3D9F0, $3D9F1 - $3D9F0

LoggedData_0x3D9F1:
INCBIN "baserom.gbc", $3D9F1, $3DA98 - $3D9F1

UnknownData_0x3DA98:
INCBIN "baserom.gbc", $3DA98, $3DA99 - $3DA98

LoggedData_0x3DA99:
INCBIN "baserom.gbc", $3DA99, $3DACB - $3DA99

UnknownData_0x3DACB:
INCBIN "baserom.gbc", $3DACB, $3DACC - $3DACB

LoggedData_0x3DACC:
INCBIN "baserom.gbc", $3DACC, $3DB18 - $3DACC

UnknownData_0x3DB18:
INCBIN "baserom.gbc", $3DB18, $3DB19 - $3DB18

LoggedData_0x3DB19:
INCBIN "baserom.gbc", $3DB19, $3DB77 - $3DB19

UnknownData_0x3DB77:
INCBIN "baserom.gbc", $3DB77, $3DB78 - $3DB77

LoggedData_0x3DB78:
INCBIN "baserom.gbc", $3DB78, $3DB97 - $3DB78

UnknownData_0x3DB97:
INCBIN "baserom.gbc", $3DB97, $3DB98 - $3DB97

LoggedData_0x3DB98:
INCBIN "baserom.gbc", $3DB98, $3DBE9 - $3DB98

UnknownData_0x3DBE9:
INCBIN "baserom.gbc", $3DBE9, $3DBEA - $3DBE9

LoggedData_0x3DBEA:
INCBIN "baserom.gbc", $3DBEA, $3DBFA - $3DBEA

UnknownData_0x3DBFA:
INCBIN "baserom.gbc", $3DBFA, $3DBFB - $3DBFA

LoggedData_0x3DBFB:
INCBIN "baserom.gbc", $3DBFB, $3DC0B - $3DBFB

UnknownData_0x3DC0B:
INCBIN "baserom.gbc", $3DC0B, $3DC0C - $3DC0B

LoggedData_0x3DC0C:
INCBIN "baserom.gbc", $3DC0C, $3DC1E - $3DC0C

UnknownData_0x3DC1E:
INCBIN "baserom.gbc", $3DC1E, $3DC1F - $3DC1E

LoggedData_0x3DC1F:
INCBIN "baserom.gbc", $3DC1F, $3DC35 - $3DC1F

UnknownData_0x3DC35:
INCBIN "baserom.gbc", $3DC35, $3DC36 - $3DC35

LoggedData_0x3DC36:
INCBIN "baserom.gbc", $3DC36, $3DCBD - $3DC36

UnknownData_0x3DCBD:
INCBIN "baserom.gbc", $3DCBD, $3DCBE - $3DCBD

LoggedData_0x3DCBE:
INCBIN "baserom.gbc", $3DCBE, $3DDB0 - $3DCBE

UnknownData_0x3DDB0:
INCBIN "baserom.gbc", $3DDB0, $3DDD3 - $3DDB0

LoggedData_0x3DDD3:
INCBIN "baserom.gbc", $3DDD3, $3DDD5 - $3DDD3

UnknownData_0x3DDD5:
INCBIN "baserom.gbc", $3DDD5, $3DDE8 - $3DDD5

LoggedData_0x3DDE8:
INCBIN "baserom.gbc", $3DDE8, $3DE43 - $3DDE8

UnknownData_0x3DE43:
INCBIN "baserom.gbc", $3DE43, $3DE44 - $3DE43

LoggedData_0x3DE44:
INCBIN "baserom.gbc", $3DE44, $3DE7D - $3DE44

UnknownData_0x3DE7D:
INCBIN "baserom.gbc", $3DE7D, $3DE7E - $3DE7D

LoggedData_0x3DE7E:
INCBIN "baserom.gbc", $3DE7E, $3DF78 - $3DE7E

UnknownData_0x3DF78:
INCBIN "baserom.gbc", $3DF78, $3DF79 - $3DF78

LoggedData_0x3DF79:
INCBIN "baserom.gbc", $3DF79, $3DF7D - $3DF79

UnknownData_0x3DF7D:
INCBIN "baserom.gbc", $3DF7D, $3DFBA - $3DF7D

LoggedData_0x3DFBA:
INCBIN "baserom.gbc", $3DFBA, $3E033 - $3DFBA

UnknownData_0x3E033:
INCBIN "baserom.gbc", $3E033, $3E036 - $3E033

LoggedData_0x3E036:
INCBIN "baserom.gbc", $3E036, $3E0C2 - $3E036

UnknownData_0x3E0C2:
INCBIN "baserom.gbc", $3E0C2, $3E0C3 - $3E0C2

LoggedData_0x3E0C3:
INCBIN "baserom.gbc", $3E0C3, $3E180 - $3E0C3

UnknownData_0x3E180:
INCBIN "baserom.gbc", $3E180, $3E181 - $3E180

LoggedData_0x3E181:
INCBIN "baserom.gbc", $3E181, $3E23B - $3E181

UnknownData_0x3E23B:
INCBIN "baserom.gbc", $3E23B, $3E23C - $3E23B

LoggedData_0x3E23C:
INCBIN "baserom.gbc", $3E23C, $3E25A - $3E23C

UnknownData_0x3E25A:
INCBIN "baserom.gbc", $3E25A, $3E25B - $3E25A

LoggedData_0x3E25B:
INCBIN "baserom.gbc", $3E25B, $3E29F - $3E25B

UnknownData_0x3E29F:
INCBIN "baserom.gbc", $3E29F, $3E2A0 - $3E29F

LoggedData_0x3E2A0:
INCBIN "baserom.gbc", $3E2A0, $3E2B8 - $3E2A0

UnknownData_0x3E2B8:
INCBIN "baserom.gbc", $3E2B8, $3E2B9 - $3E2B8

LoggedData_0x3E2B9:
INCBIN "baserom.gbc", $3E2B9, $3E2C9 - $3E2B9

UnknownData_0x3E2C9:
INCBIN "baserom.gbc", $3E2C9, $3E2CA - $3E2C9

LoggedData_0x3E2CA:
INCBIN "baserom.gbc", $3E2CA, $3E2E9 - $3E2CA

UnknownData_0x3E2E9:
INCBIN "baserom.gbc", $3E2E9, $3E2EA - $3E2E9

LoggedData_0x3E2EA:
INCBIN "baserom.gbc", $3E2EA, $3E304 - $3E2EA

UnknownData_0x3E304:
INCBIN "baserom.gbc", $3E304, $3E305 - $3E304

LoggedData_0x3E305:
INCBIN "baserom.gbc", $3E305, $3E334 - $3E305

UnknownData_0x3E334:
INCBIN "baserom.gbc", $3E334, $3E335 - $3E334

LoggedData_0x3E335:
INCBIN "baserom.gbc", $3E335, $3E357 - $3E335

UnknownData_0x3E357:
INCBIN "baserom.gbc", $3E357, $3E358 - $3E357

LoggedData_0x3E358:
INCBIN "baserom.gbc", $3E358, $3E377 - $3E358

UnknownData_0x3E377:
INCBIN "baserom.gbc", $3E377, $3E378 - $3E377

LoggedData_0x3E378:
INCBIN "baserom.gbc", $3E378, $3E413 - $3E378

UnknownData_0x3E413:
INCBIN "baserom.gbc", $3E413, $3E414 - $3E413

LoggedData_0x3E414:
INCBIN "baserom.gbc", $3E414, $3E441 - $3E414

UnknownData_0x3E441:
INCBIN "baserom.gbc", $3E441, $3E442 - $3E441

LoggedData_0x3E442:
INCBIN "baserom.gbc", $3E442, $3E46F - $3E442

UnknownData_0x3E46F:
INCBIN "baserom.gbc", $3E46F, $3E470 - $3E46F

LoggedData_0x3E470:
INCBIN "baserom.gbc", $3E470, $3E4C0 - $3E470

UnknownData_0x3E4C0:
INCBIN "baserom.gbc", $3E4C0, $3E4C1 - $3E4C0

LoggedData_0x3E4C1:
INCBIN "baserom.gbc", $3E4C1, $3E4D5 - $3E4C1

UnknownData_0x3E4D5:
INCBIN "baserom.gbc", $3E4D5, $3E4D6 - $3E4D5

LoggedData_0x3E4D6:
INCBIN "baserom.gbc", $3E4D6, $3E507 - $3E4D6

UnknownData_0x3E507:
INCBIN "baserom.gbc", $3E507, $3E508 - $3E507

LoggedData_0x3E508:
INCBIN "baserom.gbc", $3E508, $3E559 - $3E508

UnknownData_0x3E559:
INCBIN "baserom.gbc", $3E559, $3E55A - $3E559

LoggedData_0x3E55A:
INCBIN "baserom.gbc", $3E55A, $3E57C - $3E55A

UnknownData_0x3E57C:
INCBIN "baserom.gbc", $3E57C, $3E57D - $3E57C

LoggedData_0x3E57D:
INCBIN "baserom.gbc", $3E57D, $3E5B5 - $3E57D

UnknownData_0x3E5B5:
INCBIN "baserom.gbc", $3E5B5, $3E5B6 - $3E5B5

LoggedData_0x3E5B6:
INCBIN "baserom.gbc", $3E5B6, $3E5CA - $3E5B6

UnknownData_0x3E5CA:
INCBIN "baserom.gbc", $3E5CA, $3E5CB - $3E5CA

LoggedData_0x3E5CB:
INCBIN "baserom.gbc", $3E5CB, $3E5DD - $3E5CB

UnknownData_0x3E5DD:
INCBIN "baserom.gbc", $3E5DD, $3E5DE - $3E5DD

LoggedData_0x3E5DE:
INCBIN "baserom.gbc", $3E5DE, $3E5F0 - $3E5DE

UnknownData_0x3E5F0:
INCBIN "baserom.gbc", $3E5F0, $3E5F1 - $3E5F0

LoggedData_0x3E5F1:
INCBIN "baserom.gbc", $3E5F1, $3E611 - $3E5F1

UnknownData_0x3E611:
INCBIN "baserom.gbc", $3E611, $3E612 - $3E611

LoggedData_0x3E612:
INCBIN "baserom.gbc", $3E612, $3E63E - $3E612

UnknownData_0x3E63E:
INCBIN "baserom.gbc", $3E63E, $3E63F - $3E63E

LoggedData_0x3E63F:
INCBIN "baserom.gbc", $3E63F, $3E655 - $3E63F

UnknownData_0x3E655:
INCBIN "baserom.gbc", $3E655, $3E656 - $3E655

LoggedData_0x3E656:
INCBIN "baserom.gbc", $3E656, $3E66C - $3E656

UnknownData_0x3E66C:
INCBIN "baserom.gbc", $3E66C, $3E66D - $3E66C

LoggedData_0x3E66D:
INCBIN "baserom.gbc", $3E66D, $3E683 - $3E66D

UnknownData_0x3E683:
INCBIN "baserom.gbc", $3E683, $3E684 - $3E683

LoggedData_0x3E684:
INCBIN "baserom.gbc", $3E684, $3E6A6 - $3E684

UnknownData_0x3E6A6:
INCBIN "baserom.gbc", $3E6A6, $3E6A7 - $3E6A6

LoggedData_0x3E6A7:
INCBIN "baserom.gbc", $3E6A7, $3E740 - $3E6A7

UnknownData_0x3E740:
INCBIN "baserom.gbc", $3E740, $3E741 - $3E740

LoggedData_0x3E741:
INCBIN "baserom.gbc", $3E741, $3E78D - $3E741

UnknownData_0x3E78D:
INCBIN "baserom.gbc", $3E78D, $3E78E - $3E78D

LoggedData_0x3E78E:
INCBIN "baserom.gbc", $3E78E, $3E7C2 - $3E78E

UnknownData_0x3E7C2:
INCBIN "baserom.gbc", $3E7C2, $3E7C3 - $3E7C2

LoggedData_0x3E7C3:
INCBIN "baserom.gbc", $3E7C3, $3E7DB - $3E7C3

UnknownData_0x3E7DB:
INCBIN "baserom.gbc", $3E7DB, $3E7DC - $3E7DB

LoggedData_0x3E7DC:
INCBIN "baserom.gbc", $3E7DC, $3E83A - $3E7DC

UnknownData_0x3E83A:
INCBIN "baserom.gbc", $3E83A, $3E83B - $3E83A

LoggedData_0x3E83B:
INCBIN "baserom.gbc", $3E83B, $3E973 - $3E83B

UnknownData_0x3E973:
INCBIN "baserom.gbc", $3E973, $3E974 - $3E973

LoggedData_0x3E974:
INCBIN "baserom.gbc", $3E974, $3E989 - $3E974

UnknownData_0x3E989:
INCBIN "baserom.gbc", $3E989, $3E98A - $3E989

LoggedData_0x3E98A:
INCBIN "baserom.gbc", $3E98A, $3E9A2 - $3E98A

UnknownData_0x3E9A2:
INCBIN "baserom.gbc", $3E9A2, $3E9A3 - $3E9A2

LoggedData_0x3E9A3:
INCBIN "baserom.gbc", $3E9A3, $3EA0A - $3E9A3

UnknownData_0x3EA0A:
INCBIN "baserom.gbc", $3EA0A, $3EA0B - $3EA0A

LoggedData_0x3EA0B:
INCBIN "baserom.gbc", $3EA0B, $3EA2A - $3EA0B

UnknownData_0x3EA2A:
INCBIN "baserom.gbc", $3EA2A, $3EA2B - $3EA2A

LoggedData_0x3EA2B:
INCBIN "baserom.gbc", $3EA2B, $3EA4D - $3EA2B

UnknownData_0x3EA4D:
INCBIN "baserom.gbc", $3EA4D, $3EA4F - $3EA4D

LoggedData_0x3EA4F:
INCBIN "baserom.gbc", $3EA4F, $3EA5F - $3EA4F

UnknownData_0x3EA5F:
INCBIN "baserom.gbc", $3EA5F, $3EA60 - $3EA5F

LoggedData_0x3EA60:
INCBIN "baserom.gbc", $3EA60, $3EAC6 - $3EA60

UnknownData_0x3EAC6:
INCBIN "baserom.gbc", $3EAC6, $3EAC7 - $3EAC6

LoggedData_0x3EAC7:
INCBIN "baserom.gbc", $3EAC7, $3EAE3 - $3EAC7

UnknownData_0x3EAE3:
INCBIN "baserom.gbc", $3EAE3, $3EAE4 - $3EAE3

LoggedData_0x3EAE4:
INCBIN "baserom.gbc", $3EAE4, $3EB58 - $3EAE4

UnknownData_0x3EB58:
INCBIN "baserom.gbc", $3EB58, $3EB59 - $3EB58

LoggedData_0x3EB59:
INCBIN "baserom.gbc", $3EB59, $3EB73 - $3EB59

UnknownData_0x3EB73:
INCBIN "baserom.gbc", $3EB73, $3EB74 - $3EB73

LoggedData_0x3EB74:
INCBIN "baserom.gbc", $3EB74, $3EBA3 - $3EB74

UnknownData_0x3EBA3:
INCBIN "baserom.gbc", $3EBA3, $3EBA4 - $3EBA3

LoggedData_0x3EBA4:
INCBIN "baserom.gbc", $3EBA4, $3EBBA - $3EBA4

UnknownData_0x3EBBA:
INCBIN "baserom.gbc", $3EBBA, $3EBBC - $3EBBA

LoggedData_0x3EBBC:
INCBIN "baserom.gbc", $3EBBC, $3EC4A - $3EBBC

UnknownData_0x3EC4A:
INCBIN "baserom.gbc", $3EC4A, $3EC4B - $3EC4A

LoggedData_0x3EC4B:
INCBIN "baserom.gbc", $3EC4B, $3EC71 - $3EC4B

UnknownData_0x3EC71:
INCBIN "baserom.gbc", $3EC71, $3EC72 - $3EC71

LoggedData_0x3EC72:
INCBIN "baserom.gbc", $3EC72, $3EC86 - $3EC72

UnknownData_0x3EC86:
INCBIN "baserom.gbc", $3EC86, $3EC88 - $3EC86

LoggedData_0x3EC88:
INCBIN "baserom.gbc", $3EC88, $3EC9C - $3EC88

UnknownData_0x3EC9C:
INCBIN "baserom.gbc", $3EC9C, $3EC9E - $3EC9C

LoggedData_0x3EC9E:
INCBIN "baserom.gbc", $3EC9E, $3ECB3 - $3EC9E

UnknownData_0x3ECB3:
INCBIN "baserom.gbc", $3ECB3, $3ECB4 - $3ECB3

LoggedData_0x3ECB4:
INCBIN "baserom.gbc", $3ECB4, $3ECF6 - $3ECB4

UnknownData_0x3ECF6:
INCBIN "baserom.gbc", $3ECF6, $3ECF7 - $3ECF6

LoggedData_0x3ECF7:
INCBIN "baserom.gbc", $3ECF7, $3ED33 - $3ECF7

UnknownData_0x3ED33:
INCBIN "baserom.gbc", $3ED33, $3ED34 - $3ED33

LoggedData_0x3ED34:
INCBIN "baserom.gbc", $3ED34, $3ED7D - $3ED34

UnknownData_0x3ED7D:
INCBIN "baserom.gbc", $3ED7D, $3ED7E - $3ED7D

LoggedData_0x3ED7E:
INCBIN "baserom.gbc", $3ED7E, $3ED9E - $3ED7E

UnknownData_0x3ED9E:
INCBIN "baserom.gbc", $3ED9E, $3ED9F - $3ED9E

LoggedData_0x3ED9F:
INCBIN "baserom.gbc", $3ED9F, $3EEF3 - $3ED9F

UnknownData_0x3EEF3:
INCBIN "baserom.gbc", $3EEF3, $3EEF4 - $3EEF3

LoggedData_0x3EEF4:
INCBIN "baserom.gbc", $3EEF4, $3EF2E - $3EEF4

UnknownData_0x3EF2E:
INCBIN "baserom.gbc", $3EF2E, $3EF2F - $3EF2E

LoggedData_0x3EF2F:
INCBIN "baserom.gbc", $3EF2F, $3EF95 - $3EF2F

UnknownData_0x3EF95:
INCBIN "baserom.gbc", $3EF95, $3EF96 - $3EF95

LoggedData_0x3EF96:
INCBIN "baserom.gbc", $3EF96, $3EFCC - $3EF96

UnknownData_0x3EFCC:
INCBIN "baserom.gbc", $3EFCC, $3EFCD - $3EFCC

LoggedData_0x3EFCD:
INCBIN "baserom.gbc", $3EFCD, $3F00A - $3EFCD

UnknownData_0x3F00A:
INCBIN "baserom.gbc", $3F00A, $3F00B - $3F00A

LoggedData_0x3F00B:
INCBIN "baserom.gbc", $3F00B, $3F043 - $3F00B

UnknownData_0x3F043:
INCBIN "baserom.gbc", $3F043, $3F044 - $3F043

LoggedData_0x3F044:
INCBIN "baserom.gbc", $3F044, $3F080 - $3F044

UnknownData_0x3F080:
INCBIN "baserom.gbc", $3F080, $3F081 - $3F080

LoggedData_0x3F081:
INCBIN "baserom.gbc", $3F081, $3F0A5 - $3F081

UnknownData_0x3F0A5:
INCBIN "baserom.gbc", $3F0A5, $3F0A6 - $3F0A5

LoggedData_0x3F0A6:
INCBIN "baserom.gbc", $3F0A6, $3F0CE - $3F0A6

UnknownData_0x3F0CE:
INCBIN "baserom.gbc", $3F0CE, $3F0CF - $3F0CE

LoggedData_0x3F0CF:
INCBIN "baserom.gbc", $3F0CF, $3F0FF - $3F0CF

UnknownData_0x3F0FF:
INCBIN "baserom.gbc", $3F0FF, $3F100 - $3F0FF

LoggedData_0x3F100:
INCBIN "baserom.gbc", $3F100, $3F110 - $3F100

UnknownData_0x3F110:
INCBIN "baserom.gbc", $3F110, $3F111 - $3F110

LoggedData_0x3F111:
INCBIN "baserom.gbc", $3F111, $3F121 - $3F111

UnknownData_0x3F121:
INCBIN "baserom.gbc", $3F121, $3F122 - $3F121

LoggedData_0x3F122:
INCBIN "baserom.gbc", $3F122, $3F155 - $3F122

UnknownData_0x3F155:
INCBIN "baserom.gbc", $3F155, $3F156 - $3F155

LoggedData_0x3F156:
INCBIN "baserom.gbc", $3F156, $3F1A8 - $3F156

UnknownData_0x3F1A8:
INCBIN "baserom.gbc", $3F1A8, $3F1A9 - $3F1A8

LoggedData_0x3F1A9:
INCBIN "baserom.gbc", $3F1A9, $3F1C1 - $3F1A9

UnknownData_0x3F1C1:
INCBIN "baserom.gbc", $3F1C1, $3F1C2 - $3F1C1

LoggedData_0x3F1C2:
INCBIN "baserom.gbc", $3F1C2, $3F1DA - $3F1C2

UnknownData_0x3F1DA:
INCBIN "baserom.gbc", $3F1DA, $3F1DB - $3F1DA

LoggedData_0x3F1DB:
INCBIN "baserom.gbc", $3F1DB, $3F1DD - $3F1DB

UnknownData_0x3F1DD:
INCBIN "baserom.gbc", $3F1DD, $3F1EE - $3F1DD

LoggedData_0x3F1EE:
INCBIN "baserom.gbc", $3F1EE, $3F20B - $3F1EE

UnknownData_0x3F20B:
INCBIN "baserom.gbc", $3F20B, $3F20C - $3F20B

LoggedData_0x3F20C:
INCBIN "baserom.gbc", $3F20C, $3F22A - $3F20C

UnknownData_0x3F22A:
INCBIN "baserom.gbc", $3F22A, $3F22B - $3F22A

LoggedData_0x3F22B:
INCBIN "baserom.gbc", $3F22B, $3F2A6 - $3F22B

UnknownData_0x3F2A6:
INCBIN "baserom.gbc", $3F2A6, $3F2A7 - $3F2A6

LoggedData_0x3F2A7:
INCBIN "baserom.gbc", $3F2A7, $3F2CA - $3F2A7

UnknownData_0x3F2CA:
INCBIN "baserom.gbc", $3F2CA, $3F2CB - $3F2CA

LoggedData_0x3F2CB:
INCBIN "baserom.gbc", $3F2CB, $3F2DF - $3F2CB

UnknownData_0x3F2DF:
INCBIN "baserom.gbc", $3F2DF, $3F2E0 - $3F2DF

LoggedData_0x3F2E0:
INCBIN "baserom.gbc", $3F2E0, $3F2F4 - $3F2E0

UnknownData_0x3F2F4:
INCBIN "baserom.gbc", $3F2F4, $3F2F5 - $3F2F4

LoggedData_0x3F2F5:
INCBIN "baserom.gbc", $3F2F5, $3F309 - $3F2F5

UnknownData_0x3F309:
INCBIN "baserom.gbc", $3F309, $3F30A - $3F309

LoggedData_0x3F30A:
INCBIN "baserom.gbc", $3F30A, $3F31C - $3F30A

UnknownData_0x3F31C:
INCBIN "baserom.gbc", $3F31C, $3F31D - $3F31C

LoggedData_0x3F31D:
INCBIN "baserom.gbc", $3F31D, $3F32D - $3F31D

UnknownData_0x3F32D:
INCBIN "baserom.gbc", $3F32D, $3F32E - $3F32D

LoggedData_0x3F32E:
INCBIN "baserom.gbc", $3F32E, $3F34D - $3F32E

UnknownData_0x3F34D:
INCBIN "baserom.gbc", $3F34D, $3F34F - $3F34D

LoggedData_0x3F34F:
INCBIN "baserom.gbc", $3F34F, $3F351 - $3F34F

UnknownData_0x3F351:
INCBIN "baserom.gbc", $3F351, $3F366 - $3F351

LoggedData_0x3F366:
INCBIN "baserom.gbc", $3F366, $3F376 - $3F366

UnknownData_0x3F376:
INCBIN "baserom.gbc", $3F376, $3F377 - $3F376

LoggedData_0x3F377:
INCBIN "baserom.gbc", $3F377, $3F38F - $3F377

UnknownData_0x3F38F:
INCBIN "baserom.gbc", $3F38F, $3F390 - $3F38F

LoggedData_0x3F390:
INCBIN "baserom.gbc", $3F390, $3F392 - $3F390

UnknownData_0x3F392:
INCBIN "baserom.gbc", $3F392, $3FE02 - $3F392

LoggedData_0x3FE02:
INCBIN "baserom.gbc", $3FE02, $3FE0B - $3FE02

UnknownData_0x3FE0B:
INCBIN "baserom.gbc", $3FE0B, $3FE0C - $3FE0B

LoggedData_0x3FE0C:
INCBIN "baserom.gbc", $3FE0C, $3FE0F - $3FE0C

UnknownData_0x3FE0F:
INCBIN "baserom.gbc", $3FE0F, $3FE10 - $3FE0F

LoggedData_0x3FE10:
INCBIN "baserom.gbc", $3FE10, $3FE19 - $3FE10

UnknownData_0x3FE19:
INCBIN "baserom.gbc", $3FE19, $3FE1A - $3FE19

LoggedData_0x3FE1A:
INCBIN "baserom.gbc", $3FE1A, $3FE1B - $3FE1A

UnknownData_0x3FE1B:
INCBIN "baserom.gbc", $3FE1B, $3FE1C - $3FE1B

LoggedData_0x3FE1C:
INCBIN "baserom.gbc", $3FE1C, $3FE1F - $3FE1C

UnknownData_0x3FE1F:
INCBIN "baserom.gbc", $3FE1F, $3FE20 - $3FE1F

LoggedData_0x3FE20:
INCBIN "baserom.gbc", $3FE20, $3FE23 - $3FE20

UnknownData_0x3FE23:
INCBIN "baserom.gbc", $3FE23, $3FE24 - $3FE23

LoggedData_0x3FE24:
INCBIN "baserom.gbc", $3FE24, $3FE25 - $3FE24

UnknownData_0x3FE25:
INCBIN "baserom.gbc", $3FE25, $3FE26 - $3FE25

LoggedData_0x3FE26:
INCBIN "baserom.gbc", $3FE26, $3FE27 - $3FE26

UnknownData_0x3FE27:
INCBIN "baserom.gbc", $3FE27, $3FE40 - $3FE27

LoggedData_0x3FE40:
INCBIN "baserom.gbc", $3FE40, $3FE42 - $3FE40

UnknownData_0x3FE42:
INCBIN "baserom.gbc", $3FE42, $3FE46 - $3FE42

LoggedData_0x3FE46:
INCBIN "baserom.gbc", $3FE46, $3FE48 - $3FE46

UnknownData_0x3FE48:
INCBIN "baserom.gbc", $3FE48, $3FE4A - $3FE48

LoggedData_0x3FE4A:
INCBIN "baserom.gbc", $3FE4A, $3FE52 - $3FE4A

UnknownData_0x3FE52:
INCBIN "baserom.gbc", $3FE52, $3FE56 - $3FE52

LoggedData_0x3FE56:
INCBIN "baserom.gbc", $3FE56, $3FE58 - $3FE56

UnknownData_0x3FE58:
INCBIN "baserom.gbc", $3FE58, $3FE5C - $3FE58

LoggedData_0x3FE5C:
INCBIN "baserom.gbc", $3FE5C, $3FE60 - $3FE5C

UnknownData_0x3FE60:
INCBIN "baserom.gbc", $3FE60, $3FE62 - $3FE60

LoggedData_0x3FE62:
INCBIN "baserom.gbc", $3FE62, $3FE66 - $3FE62

UnknownData_0x3FE66:
INCBIN "baserom.gbc", $3FE66, $3FE68 - $3FE66

LoggedData_0x3FE68:
INCBIN "baserom.gbc", $3FE68, $3FE6A - $3FE68

UnknownData_0x3FE6A:
INCBIN "baserom.gbc", $3FE6A, $3FE6E - $3FE6A

LoggedData_0x3FE6E:
INCBIN "baserom.gbc", $3FE6E, $3FE72 - $3FE6E

UnknownData_0x3FE72:
INCBIN "baserom.gbc", $3FE72, $3FE74 - $3FE72

LoggedData_0x3FE74:
INCBIN "baserom.gbc", $3FE74, $3FE78 - $3FE74

UnknownData_0x3FE78:
INCBIN "baserom.gbc", $3FE78, $3FE7E - $3FE78

LoggedData_0x3FE7E:
INCBIN "baserom.gbc", $3FE7E, $3FE80 - $3FE7E

UnknownData_0x3FE80:
INCBIN "baserom.gbc", $3FE80, $3FE82 - $3FE80

LoggedData_0x3FE82:
INCBIN "baserom.gbc", $3FE82, $3FE84 - $3FE82

UnknownData_0x3FE84:
INCBIN "baserom.gbc", $3FE84, $3FE88 - $3FE84

LoggedData_0x3FE88:
INCBIN "baserom.gbc", $3FE88, $3FE8A - $3FE88

UnknownData_0x3FE8A:
INCBIN "baserom.gbc", $3FE8A, $3FE8C - $3FE8A

LoggedData_0x3FE8C:
INCBIN "baserom.gbc", $3FE8C, $3FE90 - $3FE8C

UnknownData_0x3FE90:
INCBIN "baserom.gbc", $3FE90, $3FE94 - $3FE90

LoggedData_0x3FE94:
INCBIN "baserom.gbc", $3FE94, $3FE9A - $3FE94

UnknownData_0x3FE9A:
INCBIN "baserom.gbc", $3FE9A, $3FE9C - $3FE9A

LoggedData_0x3FE9C:
INCBIN "baserom.gbc", $3FE9C, $3FE9E - $3FE9C

UnknownData_0x3FE9E:
INCBIN "baserom.gbc", $3FE9E, $3FEA2 - $3FE9E

LoggedData_0x3FEA2:
INCBIN "baserom.gbc", $3FEA2, $3FEA4 - $3FEA2

UnknownData_0x3FEA4:
INCBIN "baserom.gbc", $3FEA4, $3FEA6 - $3FEA4

LoggedData_0x3FEA6:
INCBIN "baserom.gbc", $3FEA6, $3FEA8 - $3FEA6

UnknownData_0x3FEA8:
INCBIN "baserom.gbc", $3FEA8, $3FEAA - $3FEA8

LoggedData_0x3FEAA:
INCBIN "baserom.gbc", $3FEAA, $3FEAC - $3FEAA

UnknownData_0x3FEAC:
INCBIN "baserom.gbc", $3FEAC, $3FEAE - $3FEAC

LoggedData_0x3FEAE:
INCBIN "baserom.gbc", $3FEAE, $3FEB0 - $3FEAE

UnknownData_0x3FEB0:
INCBIN "baserom.gbc", $3FEB0, $3FEB4 - $3FEB0

LoggedData_0x3FEB4:
INCBIN "baserom.gbc", $3FEB4, $3FEB6 - $3FEB4

UnknownData_0x3FEB6:
INCBIN "baserom.gbc", $3FEB6, $3FEB8 - $3FEB6

LoggedData_0x3FEB8:
INCBIN "baserom.gbc", $3FEB8, $3FEBC - $3FEB8

UnknownData_0x3FEBC:
INCBIN "baserom.gbc", $3FEBC, $3FEBE - $3FEBC

LoggedData_0x3FEBE:
INCBIN "baserom.gbc", $3FEBE, $3FEC4 - $3FEBE

UnknownData_0x3FEC4:
INCBIN "baserom.gbc", $3FEC4, $3FECA - $3FEC4

LoggedData_0x3FECA:
INCBIN "baserom.gbc", $3FECA, $3FED0 - $3FECA

UnknownData_0x3FED0:
INCBIN "baserom.gbc", $3FED0, $3FED4 - $3FED0

LoggedData_0x3FED4:
INCBIN "baserom.gbc", $3FED4, $3FEDE - $3FED4

UnknownData_0x3FEDE:
INCBIN "baserom.gbc", $3FEDE, $3FEE0 - $3FEDE

LoggedData_0x3FEE0:
INCBIN "baserom.gbc", $3FEE0, $3FEE2 - $3FEE0

UnknownData_0x3FEE2:
INCBIN "baserom.gbc", $3FEE2, $3FEE4 - $3FEE2

LoggedData_0x3FEE4:
INCBIN "baserom.gbc", $3FEE4, $3FEE8 - $3FEE4

UnknownData_0x3FEE8:
INCBIN "baserom.gbc", $3FEE8, $3FEEC - $3FEE8

LoggedData_0x3FEEC:
INCBIN "baserom.gbc", $3FEEC, $3FEEE - $3FEEC

UnknownData_0x3FEEE:
INCBIN "baserom.gbc", $3FEEE, $3FEF4 - $3FEEE

LoggedData_0x3FEF4:
INCBIN "baserom.gbc", $3FEF4, $3FEF6 - $3FEF4

UnknownData_0x3FEF6:
INCBIN "baserom.gbc", $3FEF6, $3FEF8 - $3FEF6

LoggedData_0x3FEF8:
INCBIN "baserom.gbc", $3FEF8, $3FEFC - $3FEF8

UnknownData_0x3FEFC:
INCBIN "baserom.gbc", $3FEFC, $3FEFE - $3FEFC

LoggedData_0x3FEFE:
INCBIN "baserom.gbc", $3FEFE, $3FF04 - $3FEFE

UnknownData_0x3FF04:
INCBIN "baserom.gbc", $3FF04, $3FF0C - $3FF04

LoggedData_0x3FF0C:
INCBIN "baserom.gbc", $3FF0C, $3FF10 - $3FF0C

UnknownData_0x3FF10:
INCBIN "baserom.gbc", $3FF10, $3FF18 - $3FF10

LoggedData_0x3FF18:
INCBIN "baserom.gbc", $3FF18, $3FF1A - $3FF18

UnknownData_0x3FF1A:
INCBIN "baserom.gbc", $3FF1A, $3FF1C - $3FF1A

LoggedData_0x3FF1C:
INCBIN "baserom.gbc", $3FF1C, $3FF24 - $3FF1C

UnknownData_0x3FF24:
INCBIN "baserom.gbc", $3FF24, $3FF26 - $3FF24

LoggedData_0x3FF26:
INCBIN "baserom.gbc", $3FF26, $3FF28 - $3FF26

UnknownData_0x3FF28:
INCBIN "baserom.gbc", $3FF28, $3FF2C - $3FF28

LoggedData_0x3FF2C:
INCBIN "baserom.gbc", $3FF2C, $3FF2E - $3FF2C

UnknownData_0x3FF2E:
INCBIN "baserom.gbc", $3FF2E, $3FF30 - $3FF2E

LoggedData_0x3FF30:
INCBIN "baserom.gbc", $3FF30, $3FF32 - $3FF30

UnknownData_0x3FF32:
INCBIN "baserom.gbc", $3FF32, $3FF36 - $3FF32

LoggedData_0x3FF36:
INCBIN "baserom.gbc", $3FF36, $3FF38 - $3FF36

UnknownData_0x3FF38:
INCBIN "baserom.gbc", $3FF38, $3FF3A - $3FF38

LoggedData_0x3FF3A:
INCBIN "baserom.gbc", $3FF3A, $3FF42 - $3FF3A

UnknownData_0x3FF42:
INCBIN "baserom.gbc", $3FF42, $3FF44 - $3FF42

LoggedData_0x3FF44:
INCBIN "baserom.gbc", $3FF44, $3FF46 - $3FF44

UnknownData_0x3FF46:
INCBIN "baserom.gbc", $3FF46, $3FF4C - $3FF46

LoggedData_0x3FF4C:
INCBIN "baserom.gbc", $3FF4C, $3FF50 - $3FF4C

UnknownData_0x3FF50:
INCBIN "baserom.gbc", $3FF50, $3FF52 - $3FF50

LoggedData_0x3FF52:
INCBIN "baserom.gbc", $3FF52, $3FF58 - $3FF52

UnknownData_0x3FF58:
INCBIN "baserom.gbc", $3FF58, $3FF5A - $3FF58

LoggedData_0x3FF5A:
INCBIN "baserom.gbc", $3FF5A, $3FF5C - $3FF5A

UnknownData_0x3FF5C:
INCBIN "baserom.gbc", $3FF5C, $3FF5E - $3FF5C

LoggedData_0x3FF5E:
INCBIN "baserom.gbc", $3FF5E, $3FF60 - $3FF5E

UnknownData_0x3FF60:
INCBIN "baserom.gbc", $3FF60, $3FF66 - $3FF60

LoggedData_0x3FF66:
INCBIN "baserom.gbc", $3FF66, $3FF6E - $3FF66

UnknownData_0x3FF6E:
INCBIN "baserom.gbc", $3FF6E, $3FF76 - $3FF6E

LoggedData_0x3FF76:
INCBIN "baserom.gbc", $3FF76, $3FF7A - $3FF76

UnknownData_0x3FF7A:
INCBIN "baserom.gbc", $3FF7A, $3FF7C - $3FF7A

LoggedData_0x3FF7C:
INCBIN "baserom.gbc", $3FF7C, $3FF80 - $3FF7C

UnknownData_0x3FF80:
INCBIN "baserom.gbc", $3FF80, $3FF84 - $3FF80

LoggedData_0x3FF84:
INCBIN "baserom.gbc", $3FF84, $3FF86 - $3FF84

UnknownData_0x3FF86:
INCBIN "baserom.gbc", $3FF86, $3FF88 - $3FF86

LoggedData_0x3FF88:
INCBIN "baserom.gbc", $3FF88, $3FF8A - $3FF88

UnknownData_0x3FF8A:
INCBIN "baserom.gbc", $3FF8A, $3FF8C - $3FF8A

LoggedData_0x3FF8C:
INCBIN "baserom.gbc", $3FF8C, $3FF90 - $3FF8C

UnknownData_0x3FF90:
INCBIN "baserom.gbc", $3FF90, $3FF94 - $3FF90

LoggedData_0x3FF94:
INCBIN "baserom.gbc", $3FF94, $3FF9A - $3FF94

UnknownData_0x3FF9A:
INCBIN "baserom.gbc", $3FF9A, $3FF9E - $3FF9A

LoggedData_0x3FF9E:
INCBIN "baserom.gbc", $3FF9E, $3FFA0 - $3FF9E

UnknownData_0x3FFA0:
INCBIN "baserom.gbc", $3FFA0, $3FFA4 - $3FFA0

LoggedData_0x3FFA4:
INCBIN "baserom.gbc", $3FFA4, $3FFAA - $3FFA4

UnknownData_0x3FFAA:
INCBIN "baserom.gbc", $3FFAA, $3FFAE - $3FFAA

LoggedData_0x3FFAE:
INCBIN "baserom.gbc", $3FFAE, $3FFB4 - $3FFAE

UnknownData_0x3FFB4:
INCBIN "baserom.gbc", $3FFB4, $3FFB6 - $3FFB4

LoggedData_0x3FFB6:
INCBIN "baserom.gbc", $3FFB6, $3FFB8 - $3FFB6

UnknownData_0x3FFB8:
INCBIN "baserom.gbc", $3FFB8, $3FFBA - $3FFB8

LoggedData_0x3FFBA:
INCBIN "baserom.gbc", $3FFBA, $3FFBE - $3FFBA

UnknownData_0x3FFBE:
INCBIN "baserom.gbc", $3FFBE, $3FFC2 - $3FFBE

LoggedData_0x3FFC2:
INCBIN "baserom.gbc", $3FFC2, $3FFC6 - $3FFC2

UnknownData_0x3FFC6:
INCBIN "baserom.gbc", $3FFC6, $3FFCC - $3FFC6

LoggedData_0x3FFCC:
INCBIN "baserom.gbc", $3FFCC, $3FFD2 - $3FFCC

UnknownData_0x3FFD2:
INCBIN "baserom.gbc", $3FFD2, $40000 - $3FFD2

SECTION "Bank10", ROMX, BANK[$10]

LoggedData_0x40000:
INCBIN "baserom.gbc", $40000, $40040 - $40000
	ld hl,$D11F
	ld a,$40
	ld [hld],a
	ld a,$4E
	ld [hld],a
	xor a
	ld [$D117],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$40
	ld [hld],a
	ld a,$69
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld a,[$CA3B]
	rra
	jp c,Logged_0x40165
	jp Logged_0x4021B
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x4021B
	dw Logged_0x402D8
	dw Logged_0x403C2
	dw Logged_0x403D6
	dw Logged_0x405FC
	dw Logged_0x40606
	dw Logged_0x40620
	dw Logged_0x40633
	dw Logged_0x4056B
	dw Logged_0x40575
	dw Logged_0x3182
	dw Logged_0x405AA
	dw Logged_0x405B1
	dw Logged_0x4021B
	dw Logged_0x4021B
	dw Logged_0x404A2
	dw Logged_0x404CB
	dw Logged_0x4025D
	dw Logged_0x406AF
	dw Logged_0x404EB
	dw Logged_0x4046A
	dw Logged_0x40472
	dw Logged_0x40404
	dw Logged_0x40437
	dw Logged_0x4067A
	dw Logged_0x40646
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x4021B
	dw Logged_0x4021B
	dw Logged_0x4021B
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Logged_0x405F2
	dw Logged_0x405E8
	dw Logged_0x4021B
	dw Logged_0x4021B
	dw Logged_0x4021B
	dw Logged_0x40182
	dw Logged_0x402AA
	dw Logged_0x40213
	dw Logged_0x3290
	dw Logged_0x4030F
	dw Logged_0x33DA
	dw Logged_0x33E9
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x4021B
	dw Logged_0x405C2
	dw Logged_0x405D5
	dw Logged_0x4021B
	dw Logged_0x4021B
	dw Logged_0x404B1
	dw Logged_0x404D9
	dw Logged_0x329F
	dw Logged_0x3371
	dw Logged_0x4050A
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x40429
	dw Logged_0x4045C
	dw Logged_0x4069E
	dw Logged_0x4066A
	dw Logged_0x3380
	dw Logged_0x338F
	dw Logged_0x4012D
	dw Logged_0x40149
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x4021B
	dw Logged_0x4021B
	dw Logged_0x4021B
	dw Logged_0x4021B
	dw Logged_0x33BC
	dw Logged_0x33CB

Logged_0x4012D:
	ld hl,$D11B
	ld a,$5E
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x40140
	ld de,$4292
	call Logged_0x30F0
	jp Logged_0x33BC

Logged_0x40140:
	ld de,$429B
	call Logged_0x30F0
	jp Logged_0x33BC

Logged_0x40149:
	ld hl,$D11B
	ld a,$5F
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x4015C
	ld de,$4292
	call Logged_0x30F0
	jp Logged_0x33CB

Unknown_0x4015C:
	ld de,$429B
	call Logged_0x30F0
	jp Logged_0x33CB

Logged_0x40165:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$2D
	ld [hld],a
	ld de,$4234
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ret

Logged_0x40182:
	ld hl,$D11A
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x40197
	set 7,[hl]
	jr Logged_0x40199

Logged_0x40197:
	res 7,[hl]

Logged_0x40199:
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $20
	jr c,Logged_0x401AD
	cp $E0
	jr c,Logged_0x401BF

Logged_0x401AD:
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $E0
	jr nc,Logged_0x401F5
	cp $20
	jr c,Logged_0x401F5

Logged_0x401BF:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x401D0
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x401D0:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x401EB
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x401EB:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ret

Logged_0x401F5:
	ld a,[hli]
	rlca
	ld a,$2F
	ld [hl],a
	jr c,Logged_0x40201
	ld de,$427C
	jr Logged_0x4020C

Logged_0x40201:
	ld l,$0C
	ld a,$09
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld de,$4287

Logged_0x4020C:
	call Logged_0x30F0
	ld a,$20
	ld [hli],a
	ret

Logged_0x40213:
	ld hl,$D116
	dec [hl]
	ret nz
	jp Logged_0x404EB

Logged_0x4021B:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$30
	ld [hld],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x4024A
	res 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F6
	ld [hld],a
	ld de,$41D2
	jp Logged_0x30F0

Logged_0x4024A:
	set 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld l,$0C
	ld a,$09
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld de,$41DB
	jp Logged_0x30F0

Logged_0x4025D:
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x40270
	xor a
	ld [hld],a
	ld de,$41D2
	call Logged_0x30F0
	ret

Logged_0x40270:
	xor a
	ld [hld],a
	ld de,$41DB
	call Logged_0x30F0
	ret

Logged_0x40279:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $02
	ld [hld],a
	ld l,$1B
	ld a,$2E
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x40298
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F6
	ld [hld],a
	ld de,$4208
	jr Logged_0x402A3

Logged_0x40298:
	ld l,$0C
	ld a,$09
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld de,$4213

Logged_0x402A3:
	call Logged_0x30F0
	ld a,$20
	ld [hli],a
	ret

Logged_0x402AA:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x402BB
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x402BB:
	ld hl,$D116
	dec [hl]
	ret nz
	inc l
	xor a
	ld [hl],a
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x402D1
	ld de,$41D2
	jr Logged_0x402D4

Logged_0x402D1:
	ld de,$41DB

Logged_0x402D4:
	call Logged_0x30F0
	ret

Logged_0x402D8:
	ld a,[$D117]
	inc a
	jr z,Logged_0x40279
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x402FD
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F6
	ld [hld],a
	ld de,$41D2
	jr Logged_0x40308

Logged_0x402FD:
	ld l,$0C
	ld a,$09
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld de,$41DB

Logged_0x40308:
	call Logged_0x30F0
	ld a,$0A
	ld [hli],a
	ret

Logged_0x4030F:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x40320
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x40320:
	ld hl,$D116
	ld a,[hl]
	and a
	jr z,Logged_0x40332
	dec [hl]
	ret nz
	ld l,$08
	ld a,[hl]
	and $80
	or $02
	ld [hld],a
	ret

Logged_0x40332:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x4034D
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x4034D:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x4038E
	ld a,[hl]
	and $0F
	sub $0A
	jr nc,Logged_0x4036A
	call Logged_0x355B
	and $0F
	jr z,Logged_0x40388

Logged_0x4036A:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $0A
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30C5

Logged_0x40388:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x4038E:
	ld a,[hl]
	and $0F
	add a,$09
	cp $10
	jr c,Logged_0x4039E
	call Logged_0x3573
	and $0F
	jr z,Logged_0x403BC

Logged_0x4039E:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$09
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30B8

Logged_0x403BC:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x403C2:
	ld hl,$D11B
	ld a,$32
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x403D1
	ld de,$426E
	jr Logged_0x403E8

Logged_0x403D1:
	ld de,$41F6
	jr Logged_0x403E8

Logged_0x403D6:
	ld hl,$D11B
	ld a,$33
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x403E5
	ld de,$41FF
	jr Logged_0x403E8

Logged_0x403E5:
	ld de,$4265

Logged_0x403E8:
	call Logged_0x30F0
	ld a,$0C
	ld [hld],a
	ld a,$02
	ld [$D118],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ret

Logged_0x40404:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x40413
	ld de,$41E4
	jr Logged_0x40416

Logged_0x40413:
	ld de,$41ED

Logged_0x40416:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x40429:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x40437:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x40446
	ld de,$41E4
	jr Logged_0x40449

Logged_0x40446:
	ld de,$41ED

Logged_0x40449:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x4045C:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x4046A:
	ld hl,$D11B
	ld a,$44
	ld [hld],a
	jr Logged_0x40478

Logged_0x40472:
	ld hl,$D11B
	ld a,$45
	ld [hld],a

Logged_0x40478:
	ld a,[hld]
	rlca
	jr c,Logged_0x40484
	ld de,$41E4
	call Logged_0x30F0
	jr Logged_0x4048A

Logged_0x40484:
	ld de,$41ED
	call Logged_0x30F0

Logged_0x4048A:
	inc l
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x404A2:
	ld a,$3F
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld hl,$D100
	res 2,[hl]

Logged_0x404B1:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x404BE
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x404BE:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x404CB:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld a,$07
	ld [$D116],a

Logged_0x404D9:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32F9
	ld a,$00
	ld [$D11B],a
	ld a,$FF
	ld [$D117],a
	ret

Logged_0x404EB:
	ld hl,$D11B
	ld a,$43
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x404FD
	ld de,$424F
	call Logged_0x30F0
	jr Logged_0x40503

Logged_0x404FD:
	ld de,$425A
	call Logged_0x30F0

Logged_0x40503:
	ld a,$30
	ld [hli],a
	ld a,$1C
	ld [hl],a
	ret

Logged_0x4050A:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x4051B
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x4051B:
	ld hl,$D116
	ld a,[hl]
	and a
	jr z,Logged_0x4054E
	dec [hl]
	jp nz,Logged_0x3308
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x40545
	ld de,$421E
	call Logged_0x30F0
	jp Logged_0x3308

Logged_0x40545:
	ld de,$4229
	call Logged_0x30F0
	jp Logged_0x3308

Logged_0x4054E:
	inc l
	dec [hl]
	jp nz,Logged_0x3308
	ld a,[$D11A]
	rlca
	jr c,Logged_0x40562
	ld hl,$D11B
	ld a,$01
	ld [hld],a
	set 7,[hl]
	ret

Logged_0x40562:
	ld hl,$D11B
	ld a,$01
	ld [hld],a
	res 7,[hl]
	ret

Logged_0x4056B:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x4057D

Logged_0x40575:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x4057D:
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4058A
	ld de,$41E4
	call Logged_0x30F0
	jr Logged_0x40590

Logged_0x4058A:
	ld de,$41ED
	call Logged_0x30F0

Logged_0x40590:
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x405AA:
	ld a,$3B
	ld [$D11B],a
	jr Logged_0x405B6

Logged_0x405B1:
	ld a,$3C
	ld [$D11B],a

Logged_0x405B6:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$02
	ld [$D118],a
	ret

Logged_0x405C2:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$18
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x405D5:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$18
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x405E8:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Logged_0x4060E

Logged_0x405F2:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Logged_0x4060E

Logged_0x405FC:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$02
	jr Logged_0x4060E

Logged_0x40606:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$02

Logged_0x4060E:
	ld a,[hl]
	and $F0
	ld [hld],a
	xor a
	ld [hld],a
	ld [hl],b
	ld a,$81
	ld [$D11C],a
	ld de,$4277
	jp Logged_0x30F0

Logged_0x40620:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Logged_0x40633:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Logged_0x40646:
	ld hl,$D11B
	ld a,$49
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x40658
	ld de,$41E4
	call Logged_0x30F0
	jr Logged_0x4065E

Logged_0x40658:
	ld de,$41ED
	call Logged_0x30F0

Logged_0x4065E:
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x4066A:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Logged_0x4067A

Logged_0x4067A:
	ld hl,$D11B
	ld a,$48
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4068C
	ld de,$41E4
	call Logged_0x30F0
	jr Logged_0x40692

Logged_0x4068C:
	ld de,$41ED
	call Logged_0x30F0

Logged_0x40692:
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x4069E:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Logged_0x40646

Logged_0x406AF:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$47
	ld [hld],a
	ld a,$43
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld de,$4319
	call Logged_0x30F0
	inc l
	ld a,[$D103]
	ld [hli],a
	ld a,[$D104]
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$EB
	ld [hld],a
	ld a,$04
	ld [hl],a
	ret

Logged_0x406F0:
	ld a,[$CA97]
	cp $10
	jp nc,Unknown_0x4076E
	ld l,$17
	ld c,[hl]
	ld a,[$D103]
	cp c
	jr nz,Logged_0x40709
	inc l
	ld b,[hl]
	ld a,[$D104]
	cp b
	jr z,Logged_0x40734

Logged_0x40709:
	ld l,$00
	bit 5,[hl]
	jr z,Logged_0x40721
	res 5,[hl]
	ld a,[$C08F]
	rra
	ret nc
	ld b,$01
	call Logged_0x129E
	call Logged_0x1197
	jp Logged_0x30E6

Logged_0x40721:
	ld l,$14
	ld a,[hl]
	and a
	jr z,Logged_0x40728
	dec [hl]

Logged_0x40728:
	jp Logged_0x30E6

Logged_0x4072B:
	ld l,$00
	bit 5,[hl]
	jr z,Logged_0x40734
	res 5,[hl]
	ret

Logged_0x40734:
	ld de,$4319
	call Logged_0x30F0
	ld l,$00
	res 3,[hl]
	xor a
	ld [$D11B],a
	ret
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x40767
	cp $2F
	jr z,Logged_0x406F0
	cp $2E
	jr z,Logged_0x4072B
	cp $34
	jr z,Unknown_0x407B8
	cp $0A
	jr z,Logged_0x407BF
	cp $3A
	jp z,Logged_0x407D4
	and $FE
	cp $04
	jr z,Unknown_0x407AB
	jr Logged_0x40734

Logged_0x40767:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x4077B

Unknown_0x4076E:
	ld a,$34
	ld [hl],a
	ld de,$4348
	call Logged_0x30F0
	ld a,$20
	ld [hli],a
	ret

Logged_0x4077B:
	ld l,$17
	ld c,[hl]
	ld a,[$D103]
	cp c
	jr nz,Logged_0x4078C
	inc l
	ld b,[hl]
	ld a,[$D104]
	cp b
	jr z,Logged_0x4079A

Logged_0x4078C:
	ld l,$1B
	ld a,$2F
	ld [hld],a
	res 7,[hl]
	ld de,$4336
	call Logged_0x30F0
	ret

Logged_0x4079A:
	ld l,$00
	bit 5,[hl]
	ret z
	ld a,$2E
	ld [$D11B],a
	ld de,$4343
	call Logged_0x30F0
	ret

Unknown_0x407AB:
	ld a,$34
	ld [hl],a
	ld de,$4351
	call Logged_0x30F0
	ld a,$10
	ld [hli],a
	ret

Unknown_0x407B8:
	ld l,$16
	dec [hl]
	ret nz
	jp Logged_0x40734

Logged_0x407BF:
	dec l
	ld a,[hli]
	rlca
	jr c,Unknown_0x4081A
	ld a,$3A
	ld [hld],a
	dec l
	xor a
	ld [hl],a
	ld de,$4348
	call Logged_0x30F0
	ld a,$30
	ld [hli],a
	ret

Logged_0x407D4:
	ld l,$16
	dec [hl]
	jp z,Logged_0x40734
	ld l,$1A
	ld a,[hl]
	rlca
	ret c
	ld a,[$D14A]
	cp $06
	jr nc,Logged_0x407EB
	ld bc,$43F0
	jr Logged_0x407EE

Logged_0x407EB:
	ld bc,$4490

Logged_0x407EE:
	call Logged_0x34B7
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	ret z
	ld a,[$D14A]
	cp $06
	jr nc,Unknown_0x4081A
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hl],a
	ld l,$1A
	set 7,[hl]
	ret

Unknown_0x4081A:
	ld a,$08
	ld [$D118],a
	call Logged_0x305C
	jp Unknown_0x34E5
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$48
	ld [hld],a
	ld a,$95
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$FE
	ld [hld],a
	ld a,$F0
	ld [hld],a
	ld a,$FC
	ld [hl],a
	ld l,$17
	ld a,[$D103]
	ld [hli],a
	ld a,[$D104]
	ld [hli],a
	ld a,$04
	ld [hl],a
	jp Logged_0x40A41

Logged_0x40851:
	ld a,$33
	ld c,$26
	ld b,$02
	ld de,$42C2
	jr Logged_0x40865

Unknown_0x4085C:
	ld a,$33
	ld c,$17
	ld b,$02
	ld de,$42C5

Logged_0x40865:
	ld l,$1F
	ld [hld],a
	ld [hl],c
	call Logged_0x30F0
	ld l,$1A
	ld a,[hl]
	and $F0
	ld [hld],a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld a,$81
	ld [$D11C],a
	ret

Unknown_0x4087C:
	xor a
	ld [hld],a
	ld a,[hl]
	rlca
	jp c,Unknown_0x34E5
	ld a,[hl]
	and $F0
	or $05
	ld [hld],a
	xor a
	ld [hl],a
	ld de,$42A9
	call Logged_0x30F0
	ld a,$30
	ld [hli],a
	ret
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x408BD
	cp $04
	jr z,Logged_0x40851
	cp $05
	jr z,Unknown_0x4085C
	cp $0A
	jr z,Unknown_0x4087C
	xor a
	ld [hld],a
	ld a,[hl]
	and $F0
	or $06
	ld [hld],a
	ld de,$42D1
	call Logged_0x30F0
	ld a,$32
	ld [hli],a
	ld l,$00
	res 3,[hl]

Logged_0x408BD:
	ld l,$1A
	ld a,[hl]
	and $0F
	rst JumpList
	dw Logged_0x409AC
	dw Logged_0x409AC
	dw Logged_0x40A54
	dw Unknown_0x408E7
	dw Unknown_0x4096E
	dw Unknown_0x409F1
	dw Unknown_0x40A6D
	dw Unknown_0x409E6
	dw Logged_0x40A88

Logged_0x408D5:
	ld hl,$D11A
	ld a,[hl]
	and $70
	or $03
	ld [hld],a
	ld a,$05
	ld [hl],a
	ld de,$42B2
	jp Logged_0x30F0

Unknown_0x408E7:
	ld a,[$CA97]
	cp $10
	jp nc,Unknown_0x40959
	ld hl,$D117
	ld e,[hl]
	inc l
	ld d,[hl]
	ld l,$04
	ld a,[hld]
	cp d
	jr z,Unknown_0x408FF
	jr nc,Unknown_0x40915
	jr Unknown_0x40937

Unknown_0x408FF:
	ld a,[hl]
	cp e
	jr z,Logged_0x40907
	jr nc,Unknown_0x40915
	jr Unknown_0x40937

Logged_0x40907:
	ld l,$1A
	ld a,[hl]
	and $F0
	or $01
	ld [hld],a
	ld de,$42A4
	jp Logged_0x30F0

Unknown_0x40915:
	ld hl,$D100
	bit 5,[hl]
	jr z,Unknown_0x4092D
	res 5,[hl]
	ld a,[$C08F]
	rra
	ret nc
	ld b,$01
	call Logged_0x129E
	call Logged_0x1197
	jr Unknown_0x40934

Unknown_0x4092D:
	ld l,$14
	ld a,[hl]
	and a
	jr z,Unknown_0x40934
	dec [hl]

Unknown_0x40934:
	jp Logged_0x30E6

Unknown_0x40937:
	ld hl,$D100
	bit 5,[hl]
	jr z,Unknown_0x4094F
	res 5,[hl]
	ld a,[$C08F]
	rra
	ret nc
	ld b,$01
	call Logged_0x1287
	call Logged_0x1169
	jr Unknown_0x40956

Unknown_0x4094F:
	ld l,$14
	ld a,[hl]
	and a
	jr z,Unknown_0x40956
	dec [hl]

Unknown_0x40956:
	jp Logged_0x30D9

Unknown_0x40959:
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $04
	ld [hld],a
	xor a
	ld [hl],a
	ld de,$42A9
	call Logged_0x30F0
	ld a,$30
	ld [hli],a
	ret

Unknown_0x4096E:
	ld a,[$D119]
	cp $0F
	jr z,Unknown_0x4099C
	ld bc,$44A0
	call Logged_0x34B7
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	ret z
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hl],a
	ld l,$1A
	set 7,[hl]

Unknown_0x4099C:
	ld hl,$D116
	dec [hl]
	jp z,Logged_0x408D5
	ld a,[$CA97]
	cp $11
	jp nc,Unknown_0x40959
	ret

Logged_0x409AC:
	ld a,[$CA97]
	cp $10
	jp nc,Unknown_0x40959
	ld hl,$D100
	bit 5,[hl]
	jr z,Logged_0x409C9
	ld l,$1A
	ld a,[hl]
	and $F0
	or $07
	ld [hld],a
	ld de,$42D6
	jp Logged_0x30F0

Logged_0x409C9:
	ld a,[$C08F]
	and $7F
	ret nz
	ld l,$19
	dec [hl]
	jp nz,Logged_0x40A41
	inc l
	ld a,[hl]
	and $F0
	or $08
	ld [hld],a
	ld de,$42E2
	call Logged_0x30F0
	ld a,$A2
	ld [hli],a
	ret

Unknown_0x409E6:
	ld hl,$D100
	bit 5,[hl]
	jp z,Logged_0x408D5
	res 5,[hl]
	ret

Unknown_0x409F1:
	ld a,[$CA97]
	cp $10
	jp nc,Unknown_0x40959
	ld hl,$D116
	dec [hl]
	jp z,Logged_0x408D5
	ld l,$1A
	ld a,[hl]
	rlca
	ret c
	ld a,[$D14A]
	cp $06
	jr nc,Unknown_0x40A11
	ld bc,$43F0
	jr Unknown_0x40A14

Unknown_0x40A11:
	ld bc,$4490

Unknown_0x40A14:
	call Logged_0x34B7
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	ret z
	ld a,[$D14A]
	cp $06
	jp nc,Unknown_0x34E5
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hl],a
	ld l,$1A
	set 7,[hl]
	ret

Logged_0x40A41:
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $02
	ld [hld],a
	ld de,$42B7
	call Logged_0x30F0
	ld a,$40
	ld [hli],a
	ret

Logged_0x40A54:
	ld a,[$CA97]
	cp $10
	jp nc,Unknown_0x40959
	ld hl,$D116
	dec [hl]
	jp z,Logged_0x40907
	ld a,[hl]
	cp $28
	ret nz
	ld bc,$47A0
	jp Logged_0x3416

Unknown_0x40A6D:
	ld a,$81
	ld [$D11C],a
	ld a,[$CA97]
	cp $10
	jp nc,Unknown_0x40959
	ld hl,$D116
	dec [hl]
	jp z,Logged_0x408D5
	ld a,[hl]
	cp $14
	jp nc,Logged_0x30E6
	ret

Logged_0x40A88:
	ld hl,$D116
	dec [hl]
	jr z,Logged_0x40AA9
	ld a,[$CA97]
	cp $10
	jp nc,Unknown_0x40959
	ld l,$00
	bit 5,[hl]
	ret z
	ld l,$1A
	ld a,[hl]
	and $F0
	or $07
	ld [hld],a
	ld de,$42D6
	jp Logged_0x30F0

Logged_0x40AA9:
	ld a,$05
	ld [$D119],a
	jp Logged_0x40907
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x40AC4
	call Logged_0x30C5
	jr Logged_0x40AC7

Logged_0x40AC4:
	call Logged_0x30B8

Logged_0x40AC7:
	call Logged_0x30D9
	ld hl,$D100
	set 3,[hl]
	ld a,[$D11B]
	and a
	jr nz,Logged_0x40AF2
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	ret z
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hl],a

Logged_0x40AF2:
	ld hl,$D11F
	ld a,$4B
	ld [hld],a
	ld a,$05
	ld [hld],a
	ld de,$42DB
	call Logged_0x30F0
	ld a,$18
	ld [hli],a
	ret
	ld a,$81
	ld [$D11C],a
	ld hl,$D116
	dec [hl]
	ret nz
	xor a
	ld [$D100],a
	ret
	ld hl,$D11B
	ld a,[hl]
	and a
	ret z
	xor a
	ld [hld],a
	set 4,[hl]
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$73
	ld [$FF00+$B6],a
	ld l,$1F
	ld a,$4B
	ld [hld],a
	ld a,$52
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $0E
	ld [hld],a
	ld de,$4360
	call Logged_0x30F0
	xor a
	ld [hli],a
	ld a,$02
	ld [hl],a
	ld hl,$D143
	inc [hl]
	ld a,[hl]
	cp $03
	ret nz
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$FA
	ld [$FF00+$B6],a
	ret
	ld a,[$D143]
	cp $03
	ret z
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x40B6F
	xor a
	ld [hl],a
	ld l,$16
	ld [hli],a
	ld a,$02
	ld [hl],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$73
	ld [$FF00+$B6],a

Logged_0x40B6F:
	ld l,$16
	dec [hl]
	ret nz
	inc l
	dec [hl]
	ret nz
	ld l,$02
	ld a,$02
	ld [$FF00+$85],a
	ld a,$EE
	ld [$FF00+$8D],a
	ld a,$7A
	ld [$FF00+$8E],a
	call $FF80
	ld hl,$D143
	dec [hl]
	ret
	ld hl,$D11F
	ld a,$4B
	ld [hld],a
	ld a,$14
	ld [hld],a
	ld de,$4369
	call Logged_0x30F0
	jr Logged_0x40BB8
	ld hl,$D11F
	ld a,$4B
	ld [hld],a
	ld a,$A8
	ld [hld],a
	jr Logged_0x40BB2
	ret
	ld hl,$D11F
	ld a,$4B
	ld [hld],a
	ld a,$D1
	ld [hld],a

Logged_0x40BB2:
	ld de,$4360
	call Logged_0x30F0

Logged_0x40BB8:
	xor a
	ld [hl],a
	ld hl,$D100
	res 4,[hl]
	set 3,[hl]
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld a,$FD
	ld [hl],a
	ret
	ld a,[$D116]
	and a
	jr z,Logged_0x40BE5
	cp $01
	jr z,Logged_0x40BF2
	cp $02
	jr z,Logged_0x40BF9
	xor a
	ld bc,$4EB9
	jr Logged_0x40C04

Logged_0x40BE5:
	ld a,[$C08F]
	and $7F
	ret nz
	ld a,$01
	ld bc,$4E80
	jr Logged_0x40C04

Logged_0x40BF2:
	ld a,$02
	ld bc,$4E93
	jr Logged_0x40C04

Logged_0x40BF9:
	ld a,[$C08F]
	and $7F
	ret nz
	ld a,$03
	ld bc,$4EA6

Logged_0x40C04:
	ld [$D116],a
	ld hl,$D100
	bit 1,[hl]
	jr z,Logged_0x40C16
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$73
	ld [$FF00+$B6],a

Logged_0x40C16:
	jp Logged_0x342D

UnknownData_0x40C19:
INCBIN "baserom.gbc", $40C19, $40C3F - $40C19
	call Logged_0x30CA
	jr Logged_0x40C51
	call Logged_0x30BD
	jr Logged_0x40C51
	call Logged_0x30C5
	jr Logged_0x40C51
	call Logged_0x30B8

Logged_0x40C51:
	ld bc,$4320
	call Logged_0x34B7
	ld hl,$D100
	set 3,[hl]
	ld a,[$D11B]
	and a
	jr nz,Logged_0x40C7F
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	ret z
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hl],a

Logged_0x40C7F:
	ld hl,$D11F
	ld a,$4C
	ld [hld],a
	ld a,$92
	ld [hld],a
	ld de,$4359
	call Logged_0x30F0
	ld a,$18
	ld [hli],a
	ret
	ld a,$81
	ld [$D11C],a
	ld hl,$D116
	dec [hl]
	ret nz
	xor a
	ld [$D100],a
	ret

UnknownData_0x40CA1:
INCBIN "baserom.gbc", $40CA1, $40E12 - $40CA1
	ld hl,$D100
	res 4,[hl]
	ld l,$1A
	res 5,[hl]
	ld l,$1F
	ld a,$4E
	ld [hld],a
	ld a,$31
	ld [hld],a
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld a,$FC
	ld [hl],a
	jp Logged_0x40F7E
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x40F7E
	dw Logged_0x40FA6
	dw Logged_0x4102A
	dw Logged_0x4102A
	dw Unknown_0x41282
	dw Unknown_0x412B7
	dw Unknown_0x412DB
	dw Unknown_0x412EE
	dw Logged_0x41243
	dw Logged_0x4124D
	dw Unknown_0x40EEF
	dw Logged_0x40F27
	dw Unknown_0x40F2F
	dw Logged_0x40F7E
	dw Logged_0x40F7E
	dw Logged_0x411EF
	dw Logged_0x4120B
	dw Unknown_0x40F96
	dw Unknown_0x41342
	dw Unknown_0x41226
	dw Unknown_0x411CB
	dw Unknown_0x411D3
	dw Logged_0x41187
	dw Logged_0x411A9
	dw Unknown_0x41321
	dw Unknown_0x41301
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x40F7E
	dw Logged_0x40F7E
	dw Logged_0x40F7E
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Unknown_0x41278
	dw Unknown_0x4126E
	dw Logged_0x40F37
	dw Logged_0x40F7E
	dw Logged_0x40F7E
	dw Logged_0x4103E
	dw Logged_0x410CD
	dw Logged_0x41163
	dw Logged_0x3290
	dw Logged_0x40FBE
	dw Logged_0x33DA
	dw Logged_0x33E9
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x40F7E
	dw Logged_0x40F7E
	dw Logged_0x40F7E
	dw Logged_0x40F7E
	dw Logged_0x40F7E
	dw Logged_0x411FE
	dw Logged_0x41219
	dw Logged_0x329F
	dw Logged_0x3371
	dw Unknown_0x41236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x4119B
	dw Logged_0x411BD
	dw Unknown_0x41331
	dw Unknown_0x41311
	dw Logged_0x3380
	dw Logged_0x338F
	dw Logged_0x33BC
	dw Logged_0x33CB
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x40F54
	dw Logged_0x40F7E
	dw Logged_0x40F7E

Unknown_0x40EEF:
	ld a,[$D11C]
	and a
	jp z,Logged_0x3182
	ld a,[$CA8E]
	and a
	jp nz,Logged_0x3182
	ld a,[$D14A]
	cp $06
	jp nc,Logged_0x3182
	ld a,[$D108]
	and $7F
	jp z,Logged_0x3182
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$14
	ld [$FF00+$B6],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jp nc,Logged_0x41243
	jp Logged_0x4124D

Logged_0x40F27:
	ld hl,$D11A
	set 7,[hl]
	jp Logged_0x41044

Unknown_0x40F2F:
	ld hl,$D11A
	res 7,[hl]
	jp Logged_0x41044

Logged_0x40F37:
	ld de,$43D4
	call Logged_0x30F0
	ld a,$14
	ld [hli],a
	ld l,$1B
	ld a,$5A
	ld [hld],a
	ld l,$03
	ld a,[$CA62]
	sub $08
	ld [hli],a
	ld a,[$CA61]
	sbc a,$00
	ld [hli],a
	ret

Logged_0x40F54:
	ld hl,$D116
	ld a,[hl]
	cp $14
	jr nz,Logged_0x40F72
	ld a,[$CA9B]
	and a
	jp nz,Logged_0x30A4
	ld hl,$D103
	ld a,[$CA62]
	sub $08
	ld [hli],a
	ld a,[$CA61]
	sbc a,$00
	ld [hli],a

Logged_0x40F72:
	ld l,$16
	dec [hl]
	ret nz
	ld a,$9F
	ld [$D11C],a
	jp Logged_0x40FE9

Logged_0x40F7E:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $0F
	ld [hld],a
	ld l,$1B
	ld a,$30
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld de,$43E1
	call Logged_0x30F0
	ret

Unknown_0x40F96:
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld de,$43DE
	call Logged_0x30F0
	ret

Logged_0x40FA6:
	ld a,[$D100]
	and $03
	cp $03
	ret nz
	ld hl,$D11B
	ld a,$31
	ld [hld],a
	ld de,$43BC
	call Logged_0x30F0
	ld a,$2C
	ld [hli],a
	ret

Logged_0x40FBE:
	ld hl,$D116
	dec [hl]
	jr z,Logged_0x40FE9
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x40FDF
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x40FDF:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ret

Logged_0x40FE9:
	ld l,$1B
	ld a,$2D
	ld [hld],a
	ld a,[$CA8E]
	cp $42
	jr nz,Logged_0x40FFA
	ld a,[hl]
	rlca
	ccf
	jr Logged_0x41006

Logged_0x40FFA:
	ld c,$2A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b

Logged_0x41006:
	jr c,Logged_0x41012
	res 7,[hl]
	ld de,$43C1
	call Logged_0x30F0
	jr Logged_0x4101A

Logged_0x41012:
	set 7,[hl]
	ld de,$43C4
	call Logged_0x30F0

Logged_0x4101A:
	ld a,$16
	ld [hli],a
	ld l,$19
	xor a
	ld [hld],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$66
	ld [$FF00+$B6],a
	ret

Logged_0x4102A:
	ld hl,$D11B
	ld a,$2D
	ld [hld],a
	ld c,$2A
	ld a,[$D10E]
	add a,c
	ld b,a
	ld a,[$CA88]
	add a,c
	sub b
	jr Logged_0x41006

Logged_0x4103E:
	ld hl,$D116
	dec [hl]
	jr nz,Logged_0x41053

Logged_0x41044:
	ld de,$43C7
	call Logged_0x30F0
	ld l,$1B
	ld a,$2E
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ret

Logged_0x41053:
	ld l,$03
	ld a,[hli]
	sub $12
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hli]
	ld [$FF00+$AA],a
	call Logged_0x358B
	and $0F
	jr z,Logged_0x4107A
	ld hl,$D118
	ld a,$01
	ld [hl],a
	ld l,$1A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Logged_0x41044

Logged_0x4107A:
	ld bc,$43D0
	call Logged_0x34B7
	ld hl,$D103
	ld a,[hli]
	sub $0A
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x410B0
	ld a,[hli]
	sub $08
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and $0F
	jp z,Logged_0x30CA
	ld de,$43C4
	call Logged_0x30F0
	ld l,$1A
	set 7,[hl]
	ret

Logged_0x410B0:
	ld a,[hli]
	add a,$07
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and $0F
	jp z,Logged_0x30BD
	ld de,$43C1
	call Logged_0x30F0
	ld l,$1A
	res 7,[hl]
	ret

Logged_0x410CD:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	jr z,Logged_0x41109
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hl],a
	ld l,$1B
	ld a,$2F
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld de,$43D4
	call Logged_0x30F0
	ld a,$18
	ld [hli],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$75
	ld [$FF00+$B6],a
	ld b,$18
	jp Logged_0x12B5

Logged_0x41109:
	ld a,[$C0DD]
	and a
	jp nz,Logged_0x3182
	ld bc,$43E0
	call Logged_0x34B7
	ld hl,$D103
	ld a,[hli]
	sub $0A
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x41146
	ld a,[hli]
	sub $08
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and $0F
	jp z,Logged_0x30CA
	ld de,$43C4
	call Logged_0x30F0
	ld l,$1A
	set 7,[hl]
	ret

Logged_0x41146:
	ld a,[hli]
	add a,$07
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and $0F
	jp z,Logged_0x30BD
	ld de,$43C1
	call Logged_0x30F0
	ld l,$1A
	res 7,[hl]
	ret

Logged_0x41163:
	ld a,[$D119]
	cp $0F
	jr z,Logged_0x4117C
	cp $0E
	jr z,Logged_0x41174

Logged_0x4116E:
	ld bc,$44B0
	jp Logged_0x34B7

Logged_0x41174:
	ld de,$43E1
	call Logged_0x30F0
	jr Logged_0x4116E

Logged_0x4117C:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x41187:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	ld de,$43D9
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x4119B:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x411A9:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	ld de,$43D9
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x411BD:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Unknown_0x411CB:
	ld hl,$D11B
	ld a,$44
	ld [hld],a
	jr Unknown_0x411D9

Unknown_0x411D3:
	ld hl,$D11B
	ld a,$45
	ld [hld],a

Unknown_0x411D9:
	ld de,$43D9
	call Logged_0x30F0
	inc l
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x411EF:
	ld a,$3F
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld hl,$D100
	res 2,[hl]

Logged_0x411FE:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x4120B:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld a,$07
	ld [$D116],a

Logged_0x41219:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32F9
	ld a,$00
	ld [$D11B],a
	ret

Unknown_0x41226:
	ld hl,$D11B
	ld a,$43
	ld [hld],a
	ld de,$43E1
	call Logged_0x30F0
	ld a,$30
	ld [hli],a
	ret

Unknown_0x41236:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x3308
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x41243:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x41255

Logged_0x4124D:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x41255:
	ld [hld],a
	ld de,$43D9
	call Logged_0x30F0
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Unknown_0x4126E:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Unknown_0x412A4

Unknown_0x41278:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Unknown_0x412A4

Unknown_0x41282:
	ld a,[$CA8E]
	and a
	jr nz,Unknown_0x4129C
	ld a,[$D14A]
	cp $05
	jr nc,Unknown_0x4129C
	ld a,[$D108]
	and $7F
	jr z,Unknown_0x4129C
	ld a,$08
	ld [$D11B],a
	ret

Unknown_0x4129C:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$01

Unknown_0x412A4:
	ld a,$81
	ld [$D11C],a
	ld a,[hl]
	and $F0
	ld [hld],a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld de,$43CA
	jp Logged_0x30F0

Unknown_0x412B7:
	ld a,[$CA8E]
	and a
	jr nz,Unknown_0x412D1
	ld a,[$D14A]
	cp $05
	jr nc,Unknown_0x412D1
	ld a,[$D108]
	and $7F
	jr z,Unknown_0x412D1
	ld a,$09
	ld [$D11B],a
	ret

Unknown_0x412D1:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$01
	jr Unknown_0x412A4

Unknown_0x412DB:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$D0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Unknown_0x412EE:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$F0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Unknown_0x41301:
	ld hl,$D11B
	ld a,$49
	ld [hld],a
	ld de,$43D9
	call Logged_0x30F0
	ld l,$00
	set 2,[hl]

Unknown_0x41311:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Unknown_0x41321

Unknown_0x41321:
	ld hl,$D11B
	ld a,$48
	ld [hld],a
	ld de,$43D9
	call Logged_0x30F0
	ld l,$00
	set 2,[hl]

Unknown_0x41331:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Unknown_0x41301

Unknown_0x41342:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret
	ld hl,$D11F
	ld a,$53
	ld [hld],a
	ld a,$61
	ld [hld],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$53
	ld [hld],a
	ld a,$75
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	jp Logged_0x41455
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x41455
	dw Logged_0x41567
	dw Logged_0x416B0
	dw Logged_0x416B8
	dw Logged_0x419A6
	dw Logged_0x419B0
	dw Logged_0x419D5
	dw Logged_0x419E8
	dw Logged_0x41912
	dw Logged_0x4191C
	dw Logged_0x3182
	dw Logged_0x41954
	dw Logged_0x4195B
	dw Logged_0x41904
	dw Logged_0x41455
	dw Logged_0x417A2
	dw Logged_0x417CB
	dw Logged_0x414C0
	dw Logged_0x41A64
	dw Logged_0x4188B
	dw Logged_0x41767
	dw Logged_0x4176F
	dw Logged_0x416FB
	dw Logged_0x41731
	dw Logged_0x41A2F
	dw Logged_0x419FB
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x41455
	dw Logged_0x41455
	dw Logged_0x41455
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Logged_0x4199C
	dw Logged_0x41992
	dw Logged_0x41455
	dw Logged_0x41455
	dw Logged_0x41455
	dw Logged_0x4152F
	dw Unknown_0x41517
	dw Logged_0x41455
	dw Logged_0x3290
	dw Logged_0x41598
	dw Logged_0x33DA
	dw Logged_0x33E9
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x41455
	dw Logged_0x4196C
	dw Logged_0x4197F
	dw Logged_0x41455
	dw Logged_0x41455
	dw Logged_0x417B1
	dw Logged_0x417E8
	dw Logged_0x414FB
	dw Logged_0x3371
	dw Logged_0x418C4
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x41723
	dw Logged_0x41759
	dw Logged_0x41A53
	dw Logged_0x41A1F
	dw Logged_0x3380
	dw Logged_0x338F
	dw Logged_0x41439
	dw Logged_0x41447
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x4181C
	dw Logged_0x41830
	dw Logged_0x4186F
	dw Logged_0x41455
	dw Logged_0x33BC
	dw Logged_0x33CB

Logged_0x41439:
	ld a,$5E
	ld [$D11B],a
	ld de,$44A1
	call Logged_0x30F0
	jp Logged_0x33BC

Logged_0x41447:
	ld a,$5F
	ld [$D11B],a
	ld de,$44A1
	call Logged_0x30F0
	jp Logged_0x33CB

Logged_0x41455:
	xor a
	ld [$D117],a
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hli],a
	ld a,$F4
	ld [hl],a
	ld l,$1B
	ld a,$30
	ld [hld],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x4148D
	res 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4439
	call Logged_0x30F0
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F6
	ld [hld],a
	jr Logged_0x414A0

Logged_0x4148D:
	set 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4442
	call Logged_0x30F0
	ld l,$0C
	ld a,$09
	ld [hld],a
	ld a,$F9
	ld [hld],a

Logged_0x414A0:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	ret nz
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	xor a
	ld [$D116],a
	jr Logged_0x41505

Logged_0x414C0:
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	ld a,[$D109]
	cp $EF
	jr z,Unknown_0x414E4
	ld a,[hld]
	rlca
	jr c,Logged_0x414D8
	xor a
	ld [hld],a
	ld de,$44E7
	jr Logged_0x414DD

Logged_0x414D8:
	xor a
	ld [hld],a
	ld de,$450A

Logged_0x414DD:
	call Logged_0x30F0
	ld a,$38
	ld [hld],a
	ret

Unknown_0x414E4:
	ld a,[hld]
	rlca
	jr c,Unknown_0x414EF
	xor a
	ld [hld],a
	ld de,$452D
	jr Unknown_0x414F4

Unknown_0x414EF:
	xor a
	ld [hld],a
	ld de,$4546

Unknown_0x414F4:
	call Logged_0x30F0
	ld a,$29
	ld [hld],a
	ret

Logged_0x414FB:
	ld hl,$D116
	ld a,[hl]
	and a
	jp z,Logged_0x41830
	dec [hl]
	ret nz

Logged_0x41505:
	ld de,$44BA
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $04
	ld [hli],a
	ld a,$EF
	ld [hl],a
	ret

Unknown_0x41517:
	ld a,[$CA97]
	cp $10
	jr c,Unknown_0x41528
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Unknown_0x41528:
	ld hl,$D116
	dec [hl]
	ret nz
	jr Logged_0x41570

Logged_0x4152F:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x41540
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x41540:
	ld hl,$D116
	dec [hl]
	ret nz

Logged_0x41545:
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41553
	ld de,$444B
	jr Logged_0x41556

Logged_0x41553:
	ld de,$4454

Logged_0x41556:
	call Logged_0x30F0
	xor a
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $04
	ld [hli],a
	ld a,$EF
	ld [hl],a
	ret

Logged_0x41567:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a

Logged_0x41570:
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41586
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F6
	ld [hld],a
	ld de,$4439
	jr Logged_0x41591

Logged_0x41586:
	ld l,$0C
	ld a,$09
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld de,$4442

Logged_0x41591:
	call Logged_0x30F0
	ld a,$0A
	ld [hli],a
	ret

Logged_0x41598:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x415A9
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x415A9:
	ld hl,$D116
	ld a,[hl]
	and a
	jr z,Logged_0x415BB
	dec [hl]
	ret nz
	ld l,$08
	ld a,[hl]
	and $80
	or $02
	ld [hld],a
	ret

Logged_0x415BB:
	inc l
	inc [hl]
	jr nz,Logged_0x41611
	ld a,[$D109]
	cp $EF
	jr nz,Logged_0x415E9
	ld l,$1B
	ld a,$2E
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x415D4
	ld de,$446E
	jr Unknown_0x415D7

Unknown_0x415D4:
	ld de,$4490

Unknown_0x415D7:
	call Logged_0x30F0
	ld a,$A3
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hli],a
	ld a,$F4
	ld [hl],a
	ret

Logged_0x415E9:
	ld l,$1B
	ld a,$2D
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x415F7
	ld de,$445D
	jr Logged_0x415FA

Logged_0x415F7:
	ld de,$447F

Logged_0x415FA:
	call Logged_0x30F0
	ld a,$A3
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ret

Logged_0x41611:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x4162C
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x4162C:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x41677
	ld a,[$D10B]
	cpl
	inc a
	ld b,a
	ld a,[hl]
	and $0F
	sub b
	jr nc,Logged_0x4164E
	call Logged_0x355B
	and $0F
	jr z,Logged_0x41671

Logged_0x4164E:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[$D10B]
	cpl
	inc a
	ld b,a
	ld a,[hli]
	sub b
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30C5

Logged_0x41671:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x41677:
	ld a,[$D10C]
	ld b,a
	ld a,[hl]
	and $0F
	add a,b
	cp $10
	jr c,Logged_0x4168A
	call Logged_0x3573
	and $0F
	jr z,Logged_0x416AA

Logged_0x4168A:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[$D10C]
	add a,[hl]
	ld [$FF00+$AB],a
	inc l
	ld a,[hl]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30B8

Logged_0x416AA:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x416B0:
	ld hl,$D11B
	ld a,$32
	ld [hld],a
	jr Logged_0x416BE

Logged_0x416B8:
	ld hl,$D11B
	ld a,$33
	ld [hld],a

Logged_0x416BE:
	ld a,[$D109]
	cp $EF
	jr z,Logged_0x416ED
	ld a,[hld]
	rlca
	jr c,Logged_0x416CE
	ld de,$4439
	jr Logged_0x416D1

Logged_0x416CE:
	ld de,$4442

Logged_0x416D1:
	call Logged_0x30F0
	ld a,$0C
	ld [hld],a
	ld a,$02
	ld [$D118],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ret

Logged_0x416ED:
	ld a,[hld]
	rlca
	jr c,Logged_0x416F6
	ld de,$444B
	jr Logged_0x416D1

Logged_0x416F6:
	ld de,$4454
	jr Logged_0x416D1

Logged_0x416FB:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4170A
	ld de,$44AA
	jr Logged_0x4170D

Logged_0x4170A:
	ld de,$44AF

Logged_0x4170D:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hli],a
	ld a,$F4
	ld [hl],a

Logged_0x41723:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x41731:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41740
	ld de,$44AA
	jr Logged_0x41743

Logged_0x41740:
	ld de,$44AF

Logged_0x41743:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hli],a
	ld a,$F4
	ld [hl],a

Logged_0x41759:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x41767:
	ld hl,$D11B
	ld a,$44
	ld [hld],a
	jr Logged_0x41775

Logged_0x4176F:
	ld hl,$D11B
	ld a,$45
	ld [hld],a

Logged_0x41775:
	ld a,[hld]
	rlca
	jr c,Logged_0x41781
	ld de,$44AA
	call Logged_0x30F0
	jr Logged_0x41787

Logged_0x41781:
	ld de,$44AF
	call Logged_0x30F0

Logged_0x41787:
	inc l
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hli],a
	ld a,$F4
	ld [hl],a
	ret

Logged_0x417A2:
	ld a,$3F
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld hl,$D100
	res 2,[hl]

Logged_0x417B1:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x417BE
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x417BE:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x417CB:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld de,$44B4
	call Logged_0x30F0
	ld a,$08
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $04
	ld [hli],a
	ld a,$EF
	ld [hl],a

Logged_0x417E8:
	ld hl,$D116
	dec [hl]
	jr z,Logged_0x4180D
	ld l,$03
	ld a,[hli]
	sub $08
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hli]
	ld [$FF00+$AA],a
	call Logged_0x358B
	and $0F
	jr nz,Logged_0x4180D
	ld bc,$4530
	jp Logged_0x34B7

Logged_0x4180D:
	ld a,$5A
	ld [$D11B],a
	ld de,$44B7
	call Logged_0x30F0
	ld a,$04
	ld [hli],a
	ret

Logged_0x4181C:
	ld hl,$D116
	dec [hl]
	ret nz
	ld l,$1B
	ld a,$5B
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld de,$44BA
	call Logged_0x30F0
	ret

Logged_0x41830:
	call Logged_0x30D4
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	xor a
	ld [$C18C],a
	call Logged_0x352B
	and a
	jr nz,Logged_0x41857
	ld a,[$C0DD]
	and a
	ret z
	ld a,$0A
	ld [$D11B],a
	ret

Logged_0x41857:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hl],a
	ld l,$1B
	ld a,$5C
	ld [hld],a
	ld de,$455F
	call Logged_0x30F0
	ld a,$0A
	ld [hli],a
	ret

Logged_0x4186F:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x41880
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x41880:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$00
	ld [$D11B],a
	ret

Logged_0x4188B:
	ld hl,$D11B
	ld a,$43
	ld [hld],a
	ld a,[$D109]
	cp $EF
	jr z,Logged_0x418AE
	ld a,[hld]
	rlca
	jr c,Logged_0x418A4
	ld de,$44CB
	call Logged_0x30F0
	jr Logged_0x418AA

Logged_0x418A4:
	ld de,$44D2
	call Logged_0x30F0

Logged_0x418AA:
	ld a,$44
	ld [hli],a
	ret

Logged_0x418AE:
	ld a,[hld]
	rlca
	jr c,Logged_0x418BA
	ld de,$44D9
	call Logged_0x30F0
	jr Logged_0x418C0

Logged_0x418BA:
	ld de,$44E0
	call Logged_0x30F0

Logged_0x418C0:
	ld a,$44
	ld [hli],a
	ret

Logged_0x418C4:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x418D5
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x418D5:
	ld hl,$D116
	ld a,[hl]
	cp $27
	jr z,Logged_0x418EF
	dec [hl]
	jp nz,Logged_0x3308
	ld a,[$D109]
	cp $EF
	jp z,Logged_0x41545
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x418EF:
	dec [hl]
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x41901
	set 7,[hl]
	ret

Logged_0x41901:
	res 7,[hl]
	ret

Logged_0x41904:
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x4191C

Logged_0x41912:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x41924

Logged_0x4191C:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x41924:
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41931
	ld de,$44AA
	call Logged_0x30F0
	jr Logged_0x41937

Logged_0x41931:
	ld de,$44AF
	call Logged_0x30F0

Logged_0x41937:
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hli],a
	ld a,$F4
	ld [hl],a
	ret

Logged_0x41954:
	ld a,$3B
	ld [$D11B],a
	jr Logged_0x41960

Logged_0x4195B:
	ld a,$3C
	ld [$D11B],a

Logged_0x41960:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$02
	ld [$D118],a
	ret

Logged_0x4196C:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$18
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x4197F:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$18
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x41992:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Logged_0x419B8

Logged_0x4199C:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Logged_0x419B8

Logged_0x419A6:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$02
	jr Logged_0x419B8

Logged_0x419B0:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$02

Logged_0x419B8:
	ld a,$81
	ld [$D11C],a
	ld a,[hl]
	and $F0
	ld [hld],a
	ld c,a
	xor a
	ld [hld],a
	ld [hl],b
	ld a,c
	rlca
	jr c,Logged_0x419CF
	ld de,$44AA
	jp Logged_0x30F0

Logged_0x419CF:
	ld de,$44AF
	jp Logged_0x30F0

Logged_0x419D5:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Logged_0x419E8:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Logged_0x419FB:
	ld hl,$D11B
	ld a,$49
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41A0D
	ld de,$44AA
	call Logged_0x30F0
	jr Logged_0x41A13

Logged_0x41A0D:
	ld de,$44AF
	call Logged_0x30F0

Logged_0x41A13:
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x41A1F:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Logged_0x41A2F

Logged_0x41A2F:
	ld hl,$D11B
	ld a,$48
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41A41
	ld de,$44AA
	call Logged_0x30F0
	jr Logged_0x41A47

Logged_0x41A41:
	ld de,$44AF
	call Logged_0x30F0

Logged_0x41A47:
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x41A53:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Logged_0x419FB

Logged_0x41A64:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hli],a
	ld a,$F4
	ld [hl],a
	ret
	ld hl,$D11F
	ld a,$5A
	ld [hld],a
	ld a,$86
	ld [hld],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$5A
	ld [hld],a
	ld a,$9A
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	jp Logged_0x41CDB
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x41CDB
	dw Logged_0x41D36
	dw Logged_0x41E3A
	dw Logged_0x41E7C
	dw Logged_0x42034
	dw Logged_0x4203E
	dw Logged_0x42064
	dw Logged_0x42077
	dw Logged_0x41FE9
	dw Logged_0x41FF3
	dw Logged_0x3182
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x41F5D
	dw Logged_0x41F86
	dw Logged_0x41D1A
	dw Unknown_0x420E3
	dw Logged_0x41FA1
	dw Logged_0x41F2D
	dw Logged_0x41F35
	dw Logged_0x41ED7
	dw Logged_0x41F02
	dw Logged_0x420B6
	dw Logged_0x4208A
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Unknown_0x4202A
	dw Unknown_0x42020
	dw Logged_0x41CDB
	dw Logged_0x41BAE
	dw Logged_0x41C8B
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x3290
	dw Logged_0x41D56
	dw Logged_0x41E53
	dw Logged_0x41EAE
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x41CDB
	dw Logged_0x41F6C
	dw Logged_0x41F94
	dw Logged_0x329F
	dw Logged_0x3371
	dw Logged_0x41FBD
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x41EF4
	dw Logged_0x41F1F
	dw Logged_0x420D2
	dw Logged_0x420A6
	dw Logged_0x3380
	dw Logged_0x338F
	dw Logged_0x33BC
	dw Logged_0x33CB
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x41B58
	dw Logged_0x41BDC
	dw Logged_0x41CC1

Logged_0x41B58:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x41B65
	ld a,$1A
	ld [$D11B],a
	ret

Logged_0x41B65:
	ld hl,$D116
	ld a,[hl]
	cp $1A
	jr z,Logged_0x41B8E
	dec [hl]
	jp nz,Logged_0x3308
	ld l,$1B
	ld a,$2B
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41B84
	ld de,$45FE
	call Logged_0x30F0
	ld a,$1A
	ld [hli],a
	ret

Logged_0x41B84:
	ld de,$4605
	call Logged_0x30F0
	ld a,$1A
	ld [hli],a
	ret

Logged_0x41B8E:
	dec [hl]
	ld l,$00
	bit 1,[hl]
	jr z,Logged_0x41B9D
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$67
	ld [$FF00+$B6],a

Logged_0x41B9D:
	ld a,[$D11A]
	rlca
	jr c,Logged_0x41BA8
	ld bc,$481E
	jr Logged_0x41BAB

Logged_0x41BA8:
	ld bc,$4833

Logged_0x41BAB:
	jp Logged_0x3416

Logged_0x41BAE:
	ld hl,$D116
	ld a,[hl]
	cp $08
	jr z,Logged_0x41BCF
	dec [hl]
	jp nz,Logged_0x3308
	ld l,$1B
	ld a,$5B
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41BC9
	ld de,$4574
	jp Logged_0x30F0

Logged_0x41BC9:
	ld de,$457D
	jp Logged_0x30F0

Logged_0x41BCF:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x41BD9
	set 7,[hl]
	ret

Logged_0x41BD9:
	res 7,[hl]
	ret

Logged_0x41BDC:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x41BE9
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x41BE9:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x41C04
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x41C04:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x41C4E
	ld a,[hl]
	and $0F
	sub $06
	jr nc,Logged_0x41C21
	call Logged_0x355B
	and $0F
	jr z,Logged_0x41C3F

Logged_0x41C21:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $06
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30CA

Logged_0x41C3F:
	ld a,$2C
	ld [$D11B],a
	ld de,$45FE
	call Logged_0x30F0
	ld a,$1A
	ld [hli],a
	ret

Logged_0x41C4E:
	ld a,[hl]
	and $0F
	add a,$05
	cp $10
	jr c,Logged_0x41C5E
	call Logged_0x3573
	and $0F
	jr z,Logged_0x41C7C

Logged_0x41C5E:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$05
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30BD

Logged_0x41C7C:
	ld a,$2C
	ld [$D11B],a
	ld de,$4605
	call Logged_0x30F0
	ld a,$1A
	ld [hli],a
	ret

Logged_0x41C8B:
	ld hl,$D116
	ld a,[hl]
	cp $08
	jr z,Logged_0x41CB4
	dec [hl]
	jp nz,Logged_0x3308
	ld l,$1B
	ld a,$5C
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41CAA
	ld de,$45C4
	call Logged_0x30F0
	ld a,$37
	ld [hli],a
	ret

Logged_0x41CAA:
	ld de,$45D7
	call Logged_0x30F0
	ld a,$37
	ld [hli],a
	ret

Logged_0x41CB4:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x41CBE
	set 7,[hl]
	ret

Logged_0x41CBE:
	res 7,[hl]
	ret

Logged_0x41CC1:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x41CCE
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x41CCE:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x3308
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x41CDB:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld a,$FF
	ld [hl],a
	ld l,$1B
	ld a,$30
	ld [hld],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x41D0E
	res 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4562
	call Logged_0x30F0
	ret

Logged_0x41D0E:
	set 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$456B
	call Logged_0x30F0
	ret

Logged_0x41D1A:
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41D2D
	xor a
	ld [hld],a
	ld de,$4562
	call Logged_0x30F0
	ret

Logged_0x41D2D:
	xor a
	ld [hld],a
	ld de,$456B
	call Logged_0x30F0
	ret

Logged_0x41D36:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41D4F
	ld de,$4562
	call Logged_0x30F0
	ret

Logged_0x41D4F:
	ld de,$456B
	call Logged_0x30F0
	ret

Logged_0x41D56:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x41D63
	ld a,$1A
	ld [$D11B],a
	ret

Logged_0x41D63:
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $20
	jr c,Logged_0x41D77
	cp $E0
	jr c,Logged_0x41DAA

Logged_0x41D77:
	ld hl,$D11A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $C0
	jr nc,Logged_0x41D99
	cp $40
	jr nc,Logged_0x41DAA
	ld a,[hli]
	rlca
	jr c,Logged_0x41D95
	ld de,$4586
	jr Logged_0x41DA0

Logged_0x41D95:
	ld a,$13
	ld [hl],a
	ret

Logged_0x41D99:
	ld a,[hli]
	rlca
	jr nc,Logged_0x41D95
	ld de,$4597

Logged_0x41DA0:
	ld a,$5A
	ld [hl],a
	call Logged_0x30F0
	ld a,$33
	ld [hli],a
	ret

Logged_0x41DAA:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x41DC5
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x41DC5:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x41E06
	ld a,[hl]
	and $0F
	sub $06
	jr nc,Logged_0x41DE2
	call Logged_0x355B
	and $0F
	jr z,Logged_0x41E00

Logged_0x41DE2:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $06
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30C5

Logged_0x41E00:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x41E06:
	ld a,[hl]
	and $0F
	add a,$05
	cp $10
	jr c,Logged_0x41E16
	call Logged_0x3573
	and $0F
	jr z,Logged_0x41E34

Logged_0x41E16:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$05
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30B8

Logged_0x41E34:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x41E3A:
	ld a,[$D10F]
	cp $24
	jr nc,Logged_0x41E45
	cp $06
	jr nc,Logged_0x41E4B

Logged_0x41E45:
	ld bc,$4848
	call Logged_0x3416

Logged_0x41E4B:
	ld hl,$D11B
	ld a,$32
	ld [hld],a
	jr Logged_0x41E93

Logged_0x41E53:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x33DA
	dec l
	dec l
	dec [hl]
	ret nz
	ld l,$1A
	ld a,[hli]
	rlca
	jr c,Logged_0x41E72
	ld a,$2B
	ld [hl],a
	ld de,$45FE
	call Logged_0x30F0
	ld a,$1A
	ld [hli],a
	ret

Logged_0x41E72:
	ld a,$5B
	ld [hl],a
	ld de,$457D
	call Logged_0x30F0
	ret

Logged_0x41E7C:
	ld a,[$D10F]
	cp $24
	jr nc,Logged_0x41E87
	cp $06
	jr nc,Logged_0x41E8D

Logged_0x41E87:
	ld bc,$485D
	call Logged_0x3416

Logged_0x41E8D:
	ld hl,$D11B
	ld a,$33
	ld [hld],a

Logged_0x41E93:
	ld a,[hld]
	rlca
	jr c,Logged_0x41E9F
	ld de,$45A8
	call Logged_0x30F0
	jr Logged_0x41EA5

Logged_0x41E9F:
	ld de,$45AD
	call Logged_0x30F0

Logged_0x41EA5:
	ld a,$0C
	ld [hld],a
	ld a,$02
	ld [$D118],a
	ret

Logged_0x41EAE:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x33E9
	dec l
	dec l
	dec [hl]
	ret nz
	ld l,$1A
	ld a,[hli]
	rlca
	jr c,Logged_0x41ECA
	ld a,$5B
	ld [hl],a
	ld de,$4574
	call Logged_0x30F0
	ret

Logged_0x41ECA:
	ld a,$2B
	ld [hl],a
	ld de,$4605
	call Logged_0x30F0
	ld a,$1A
	ld [hli],a
	ret

Logged_0x41ED7:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41EE6
	ld de,$45B2
	jr Logged_0x41EE9

Logged_0x41EE6:
	ld de,$45BB

Logged_0x41EE9:
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x41EF4:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x41F02:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41F11
	ld de,$45B2
	jr Logged_0x41F14

Logged_0x41F11:
	ld de,$45BB

Logged_0x41F14:
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x41F1F:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x41F2D:
	ld hl,$D11B
	ld a,$44
	ld [hld],a
	jr Logged_0x41F3B

Logged_0x41F35:
	ld hl,$D11B
	ld a,$45
	ld [hld],a

Logged_0x41F3B:
	ld a,[hld]
	rlca
	jr c,Logged_0x41F47
	ld de,$45B2
	call Logged_0x30F0
	jr Logged_0x41F4D

Logged_0x41F47:
	ld de,$45BB
	call Logged_0x30F0

Logged_0x41F4D:
	inc l
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x41F5D:
	ld a,$3F
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld hl,$D100
	res 2,[hl]

Logged_0x41F6C:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x41F79
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x41F79:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x41F86:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld a,$07
	ld [$D116],a

Logged_0x41F94:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32F9
	ld a,$00
	ld [$D11B],a
	ret

Logged_0x41FA1:
	ld hl,$D11B
	ld a,$43
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x41FB3
	ld de,$45F0
	call Logged_0x30F0
	jr Logged_0x41FB9

Logged_0x41FB3:
	ld de,$45F7
	call Logged_0x30F0

Logged_0x41FB9:
	ld a,$1A
	ld [hli],a
	ret

Logged_0x41FBD:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x41FCA
	ld a,$1A
	ld [$D11B],a
	ret

Logged_0x41FCA:
	ld hl,$D116
	ld a,[hl]
	cp $08
	jr z,Logged_0x41FDC
	dec [hl]
	jp nz,Logged_0x3308
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x41FDC:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x41FE6
	set 7,[hl]
	ret

Logged_0x41FE6:
	res 7,[hl]
	ret

Logged_0x41FE9:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x41FFB

Logged_0x41FF3:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x41FFB:
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x42008
	ld de,$45B2
	call Logged_0x30F0
	jr Logged_0x4200E

Logged_0x42008:
	ld de,$45BB
	call Logged_0x30F0

Logged_0x4200E:
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Unknown_0x42020:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Logged_0x42046

Unknown_0x4202A:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Logged_0x42046

Logged_0x42034:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$02
	jr Logged_0x42046

Logged_0x4203E:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$02

Logged_0x42046:
	ld a,$81
	ld [$D11C],a
	ld a,[hl]
	and $F0
	ld [hld],a
	ld c,a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld a,c
	rlca
	jr c,Logged_0x4205E
	ld de,$45B2
	jp Logged_0x30F0

Logged_0x4205E:
	ld de,$45BB
	jp Logged_0x30F0

Logged_0x42064:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Logged_0x42077:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Logged_0x4208A:
	ld hl,$D11B
	ld a,$49
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4209C
	ld de,$45B2
	call Logged_0x30F0
	jr Logged_0x420A2

Logged_0x4209C:
	ld de,$45BB
	call Logged_0x30F0

Logged_0x420A2:
	ld l,$00
	set 2,[hl]

Logged_0x420A6:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Logged_0x420B6

Logged_0x420B6:
	ld hl,$D11B
	ld a,$48
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x420C8
	ld de,$45B2
	call Logged_0x30F0
	jr Logged_0x420CE

Logged_0x420C8:
	ld de,$45BB
	call Logged_0x30F0

Logged_0x420CE:
	ld l,$00
	set 2,[hl]

Logged_0x420D2:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Logged_0x4208A

Unknown_0x420E3:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret
	call Logged_0x3090
	jr Logged_0x42100
	call Logged_0x309A

Logged_0x42100:
	ld l,$00
	set 3,[hl]
	ld a,[$D11B]
	cp $18
	jr z,Logged_0x42137
	cp $19
	jr z,Logged_0x4213C
	ld bc,$4510
	jp Logged_0x34B7
	ld hl,$D11F
	ld a,$61
	ld [hld],a
	ld a,$26
	ld [hld],a
	dec l
	ld a,$8F
	ld [hl],a
	ld l,$00
	set 3,[hl]
	ld a,[$D11B]
	cp $18
	jr z,Logged_0x42137
	cp $19
	jr z,Logged_0x4213C
	ld bc,$4540
	jp Logged_0x34B7

Logged_0x42137:
	xor a
	ld [$D100],a
	ret

Logged_0x4213C:
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x4214F
	ld bc,$6162
	jr Logged_0x42152

Logged_0x4214F:
	ld bc,$615D

Logged_0x42152:
	ld hl,$D11F
	ld a,b
	ld [hld],a
	ld [hl],c
	xor a
	ld [$D119],a
	ret
	call Logged_0x30CA
	jr Logged_0x42165
	call Logged_0x30BD

Logged_0x42165:
	ld a,$81
	ld [$D11C],a
	ld bc,$4040
	jp Logged_0x34B7
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$62
	ld [hld],a
	ld a,$18
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$FD
	ld [hld],a
	ld a,$F3
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld l,$17
	ld a,[$D103]
	ld [hli],a
	ld a,[$D104]
	ld [hli],a
	jp Logged_0x42432

Logged_0x42199:
	xor a
	ld [hl],a
	ld de,$4F14
	call Logged_0x30F0
	ld a,[$CA8E]
	cp $42
	jr nz,Logged_0x421B1
	ld a,$18
	ld [hli],a
	ld e,$07
	ld d,$07
	jr Logged_0x421B5

Logged_0x421B1:
	ld e,$05
	ld d,$1A

Logged_0x421B5:
	ld l,$03
	ld a,[$CA62]
	sub d
	ld [hli],a
	ld a,[$CA61]
	sbc a,$00
	ld [hli],a
	ld a,[hli]
	sub $08
	ld [$CA64],a
	ld a,[hl]
	sbc a,$00
	ld [$CA63],a
	ld l,$1A
	ld a,[hl]
	and $F0
	or e
	ld [hl],a
	ld a,$F9
	ld [$D10A],a
	jr Logged_0x42249

Unknown_0x421DC:
	ld a,$33
	ld c,$F8
	ld b,$02
	jr Unknown_0x421FA

Unknown_0x421E4:
	ld a,$34
	ld c,$07
	ld b,$02
	jr Unknown_0x421FA

Unknown_0x421EC:
	ld a,$33
	ld c,$26
	ld b,$02
	jr Unknown_0x421FA

Unknown_0x421F4:
	ld a,$33
	ld c,$17
	ld b,$02

Unknown_0x421FA:
	ld l,$1F
	ld [hld],a
	ld [hl],c
	ld l,$19
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld de,$4F3D
	call Logged_0x30F0
	ld a,$81
	ld [$D11C],a
	ld a,$3A
	ld [$D11B],a
	ret

Logged_0x42215:
	jp Logged_0x3173
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x42249
	cp $2A
	jp z,Logged_0x42199
	cp $04
	jr z,Unknown_0x421EC
	cp $05
	jr z,Unknown_0x421F4
	cp $28
	jr z,Unknown_0x421DC
	cp $29
	jr z,Unknown_0x421E4
	cp $0A
	jr z,Logged_0x42215
	xor a
	ld [hld],a
	ld a,[hl]
	and $F0
	or $04
	ld [hld],a
	xor a
	ld [hld],a
	ld [hld],a
	ld de,$4F34
	call Logged_0x30F0

Logged_0x42249:
	ld l,$1A
	ld a,[hl]
	and $0F
	rst JumpList
	dw Logged_0x42321
	dw Logged_0x42321
	dw Logged_0x423E1
	dw Logged_0x42420
	dw Logged_0x4244C
	dw Logged_0x42291
	dw Logged_0x422FC
	dw Logged_0x42261
	dw Logged_0x42369

Logged_0x42261:
	ld a,$81
	ld [$D11C],a
	ld a,[$CA9B]
	and a
	jr nz,Logged_0x42271
	inc a
	ld [$D11B],a
	ret

Logged_0x42271:
	ld hl,$D116
	dec [hl]
	ld a,[hl]
	cp $10
	jr nz,Logged_0x4227E
	ld e,$0E
	jr Logged_0x42283

Logged_0x4227E:
	cp $07
	ret nz
	ld e,$16

Logged_0x42283:
	ld l,$03
	ld a,[$CA62]
	sub e
	ld [hli],a
	ld a,[$CA61]
	sbc a,$00
	ld [hli],a
	ret

Logged_0x42291:
	ld a,$81
	ld [$D11C],a
	ld a,[$CA9B]
	and a
	jr nz,Logged_0x422A1
	inc a
	ld [$D11B],a
	ret

Logged_0x422A1:
	ld hl,$D103
	ld a,[hli]
	sub $1D
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hli]
	ld [$FF00+$AA],a
	call Logged_0x358B
	and $0F
	jr nz,Logged_0x422D0
	ld hl,$D117
	ld a,[hli]
	sub $40
	ld e,a
	ld a,[hl]
	sbc a,$00
	ld d,a
	ld l,$04
	ld a,[hld]
	cp d
	jr nz,Logged_0x422E2
	ld a,[hl]
	cp e
	jr nz,Logged_0x422E2

Logged_0x422D0:
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $06
	ld [hld],a
	xor a
	ld [hl],a
	ld de,$4F14
	call Logged_0x30F0
	ret

Logged_0x422E2:
	ld a,[$C08F]
	and $07
	jr nz,Logged_0x422F1
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$87
	ld [$FF00+$B6],a

Logged_0x422F1:
	ld b,$01
	call Logged_0x129E
	call Logged_0x1197
	jp Logged_0x30E6

Logged_0x422FC:
	ld a,$81
	ld [$D11C],a
	ld a,[$CA9B]
	and a
	jr nz,Logged_0x4230C
	inc a
	ld [$D11B],a
	ret

Logged_0x4230C:
	ld bc,$44C0
	call Logged_0x3489
	ld l,$03
	ld a,[hli]
	add a,$1A
	ld [$CA62],a
	ld a,[hli]
	adc a,$00
	ld [$CA61],a
	ret

Logged_0x42321:
	ld bc,$44C0
	call Logged_0x3489
	ld hl,$D100
	bit 1,[hl]
	ret z
	ld a,[$CA8E]
	cp $07
	ret z
	ld c,$2A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,$22
	sub b
	cp $28
	jr c,Logged_0x42347
	cp $D8
	ret c

Logged_0x42347:
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	ret nc
	ld de,$4F1D
	call Logged_0x30F0
	ld l,$1A
	ld a,[hl]
	and $F0
	or $08
	ld [hld],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$8C
	ld [$FF00+$B6],a
	ret

Logged_0x42369:
	ld a,[$C08F]
	and $1F
	jr nz,Logged_0x42378
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$8C
	ld [$FF00+$B6],a

Logged_0x42378:
	ld bc,$44C0
	call Logged_0x3489
	ld c,$2A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,$22
	sub b
	cp $10
	jr c,Logged_0x423B8
	cp $F0
	jr nc,Logged_0x423B8
	cp $28
	jr c,Logged_0x423AB
	cp $D8
	jr nc,Logged_0x423AB

Logged_0x4239B:
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $01
	ld [hld],a
	ld de,$4F0B
	call Logged_0x30F0
	ret

Logged_0x423AB:
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	jr nc,Logged_0x4239B
	ret

Logged_0x423B8:
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	ret nc
	ld de,$4F2B
	call Logged_0x30F0
	ld l,$1A
	ld a,[hl]
	and $F0
	or $02
	ld [hld],a
	xor a
	ld [hl],a
	ld a,$00
	ld [$D10A],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$88
	ld [$FF00+$B6],a
	ret

Logged_0x423E1:
	ld bc,$4500
	call Logged_0x34B7
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	ret z
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hl],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld a,$F9
	ld [$D10A],a
	ld de,$4F14
	call Logged_0x30F0
	ld l,$1A
	ld a,[hl]
	and $F0
	or $03
	ld [hld],a
	ret

Logged_0x42420:
	ld hl,$D117
	ld e,[hl]
	inc l
	ld d,[hl]
	ld l,$04
	ld a,[hld]
	cp d
	jp nz,Logged_0x30E6
	ld a,[hl]
	cp e
	jp nz,Logged_0x30E6

Logged_0x42432:
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $01
	ld [hld],a
	xor a
	ld [hl],a
	ld de,$4F0B
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $18
	ld [hld],a
	ret

Logged_0x4244C:
	ld a,$81
	ld [$D11C],a
	ld bc,$44E0
	call Logged_0x34B7
	ld bc,$4650
	call Logged_0x34A0
	ld a,[$CA8E]
	cp $42
	ret nz
	ld hl,$D117
	ld e,[hl]
	inc l
	ld d,[hl]
	ld l,$04
	ld a,[hld]
	cp d
	ret nz
	ld a,[hl]
	cp e
	ret nz
	ld a,$F9
	ld [$D10A],a
	jr Logged_0x42432
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$64
	ld [hld],a
	ld a,$EA
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$FD
	ld [hld],a
	ld a,$F3
	ld [hld],a
	ld a,$F9
	ld [hld],a
	call Logged_0x3444
	ld a,e
	and a
	jp nz,Logged_0x42559
	ld bc,$4E1B
	call Logged_0x3416
	ld de,$4F14
	call Logged_0x30F0
	ld a,$00
	ld [hli],a
	ld [$D119],a
	jp Logged_0x42535
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$64
	ld [hld],a
	ld a,$EA
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$FD
	ld [hld],a
	ld a,$F3
	ld [hld],a
	ld a,$F9
	ld [hld],a
	call Logged_0x3444
	ld a,e
	and a
	jp nz,Logged_0x42559
	ld bc,$4E06
	call Logged_0x3416
	ld de,$4F14
	call Logged_0x30F0
	ld a,$00
	ld [hli],a
	ld [$D119],a
	jp Logged_0x42535
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x42525
	cp $04
	jp z,Unknown_0x421EC
	cp $05
	jp z,Unknown_0x421F4
	cp $28
	jp z,Unknown_0x421DC
	cp $29
	jp z,Unknown_0x421E4
	cp $0A
	jp z,Logged_0x42215
	ld a,$3A
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld [hld],a
	ld de,$4F34
	call Logged_0x30F0
	ld a,$02
	ld [hli],a
	ld l,$1F
	ld a,$67
	ld [hld],a
	ld a,$14
	ld [hld],a
	jp Logged_0x42714

Logged_0x42525:
	ld l,$1A
	ld a,[hl]
	and $0F
	rst JumpList
	dw Logged_0x42535
	dw Logged_0x42535
	dw Logged_0x42554
	dw Logged_0x4256C
	dw Logged_0x426EE

Logged_0x42535:
	ld a,[$CA8E]
	cp $42
	jp z,Logged_0x42725
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $02
	ld [hld],a
	ld de,$4F26
	call Logged_0x30F0
	ld a,$3C
	ld [hli],a
	ld l,$00
	res 5,[hl]
	ret

Logged_0x42554:
	ld hl,$D116
	dec [hl]
	ret nz

Logged_0x42559:
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $03
	ld [hld],a
	ld de,$4F2B
	call Logged_0x30F0
	ld a,$28
	ld [hli],a
	ret

Logged_0x4256C:
	ld hl,$D116
	ld a,[hl]
	cp $28
	jp nz,Logged_0x42635
	ld l,$01
	ld a,[hli]
	ld c,a
	ld b,[hl]
	ld d,$41
	ld h,$D0
	ld l,$00
	ld a,[hli]
	and d
	cp d
	jr nz,Logged_0x42592
	ld a,[hli]
	cp c
	jr nz,Logged_0x42592
	ld a,[hl]
	cp b
	jr nz,Logged_0x42592
	ld l,$0D
	jp Logged_0x4261F

Logged_0x42592:
	ld l,$20
	ld a,[hli]
	and d
	cp d
	jr nz,Logged_0x425A6
	ld a,[hli]
	cp c
	jr nz,Logged_0x425A6
	ld a,[hl]
	cp b
	jr nz,Logged_0x425A6
	ld l,$2D
	jp Logged_0x4261F

Logged_0x425A6:
	ld l,$40
	ld a,[hli]
	and d
	cp d
	jr nz,Logged_0x425BA
	ld a,[hli]
	cp c
	jr nz,Logged_0x425BA
	ld a,[hl]
	cp b
	jr nz,Logged_0x425BA
	ld l,$4D
	jp Logged_0x4261F

Logged_0x425BA:
	ld l,$60
	ld a,[hli]
	and d
	cp d
	jr nz,Logged_0x425CE
	ld a,[hli]
	cp c
	jr nz,Logged_0x425CE
	ld a,[hl]
	cp b
	jr nz,Logged_0x425CE
	ld l,$6D
	jp Logged_0x4261F

Logged_0x425CE:
	ld l,$80
	ld a,[hli]
	and d
	cp d
	jr nz,Logged_0x425E2
	ld a,[hli]
	cp c
	jr nz,Logged_0x425E2
	ld a,[hl]
	cp b
	jr nz,Logged_0x425E2
	ld l,$8D
	jp Logged_0x4261F

Logged_0x425E2:
	ld l,$A0
	ld a,[hli]
	and d
	cp d
	jr nz,Unknown_0x425F6
	ld a,[hli]
	cp c
	jr nz,Unknown_0x425F6
	ld a,[hl]
	cp b
	jr nz,Unknown_0x425F6
	ld l,$AD
	jp Logged_0x4261F

Unknown_0x425F6:
	ld l,$C0
	ld a,[hli]
	and d
	cp d
	jr nz,Unknown_0x4260A
	ld a,[hli]
	cp c
	jr nz,Unknown_0x4260A
	ld a,[hl]
	cp b
	jr nz,Unknown_0x4260A
	ld l,$CD
	jp Logged_0x4261F

Unknown_0x4260A:
	ld l,$E0
	ld a,[hli]
	and d
	cp d
	jr nz,Unknown_0x4261E
	ld a,[hli]
	cp c
	jr nz,Unknown_0x4261E
	ld a,[hl]
	cp b
	jr nz,Unknown_0x4261E
	ld l,$ED
	jp Logged_0x4261F

Unknown_0x4261E:
	ret

Logged_0x4261F:
	ld a,[$D10D]
	ld c,a
	ld a,[hl]
	sub $10
	cp c
	jr z,Logged_0x42632
	ld a,[hl]
	sub $0F
	cp c
	jr z,Logged_0x42632
	jp Logged_0x30D9

Logged_0x42632:
	ld hl,$D116

Logged_0x42635:
	dec [hl]
	ret nz
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $04
	ld [hld],a
	ld de,$4F14
	call Logged_0x30F0
	ld a,$32
	ld [hli],a
	ld hl,$D101
	ld a,[hli]
	ld e,a
	ld d,[hl]
	ld b,$41
	ld h,$D0
	ld l,$00
	ld a,[hli]
	and b
	cp b
	jr nz,Logged_0x42662
	ld a,[hli]
	cp e
	jr nz,Logged_0x42662
	ld a,[hli]
	cp d
	jr z,Logged_0x426CC

Logged_0x42662:
	ld l,$20
	ld a,[hli]
	and b
	cp b
	jr nz,Logged_0x42671
	ld a,[hli]
	cp e
	jr nz,Logged_0x42671
	ld a,[hli]
	cp d
	jr z,Logged_0x426CC

Logged_0x42671:
	ld l,$40
	ld a,[hli]
	and b
	cp b
	jr nz,Logged_0x42680
	ld a,[hli]
	cp e
	jr nz,Logged_0x42680
	ld a,[hli]
	cp d
	jr z,Logged_0x426CC

Logged_0x42680:
	ld l,$60
	ld a,[hli]
	and b
	cp b
	jr nz,Logged_0x4268F
	ld a,[hli]
	cp e
	jr nz,Logged_0x4268F
	ld a,[hli]
	cp d
	jr z,Logged_0x426CC

Logged_0x4268F:
	ld l,$80
	ld a,[hli]
	and b
	cp b
	jr nz,Logged_0x4269E
	ld a,[hli]
	cp e
	jr nz,Logged_0x4269E
	ld a,[hli]
	cp d
	jr z,Logged_0x426CC

Logged_0x4269E:
	ld l,$A0
	ld a,[hli]
	and b
	cp b
	jr nz,Unknown_0x426AD
	ld a,[hli]
	cp e
	jr nz,Unknown_0x426AD
	ld a,[hli]
	cp d
	jr z,Logged_0x426CC

Unknown_0x426AD:
	ld l,$C0
	ld a,[hli]
	and b
	cp b
	jr nz,Unknown_0x426BC
	ld a,[hli]
	cp e
	jr nz,Unknown_0x426BC
	ld a,[hli]
	cp d
	jr z,Logged_0x426CC

Unknown_0x426BC:
	ld l,$E0
	ld a,[hli]
	and b
	cp b
	jr nz,Unknown_0x426CB
	ld a,[hli]
	cp e
	jr nz,Unknown_0x426CB
	ld a,[hli]
	cp d
	jr z,Logged_0x426CC

Unknown_0x426CB:
	ret

Logged_0x426CC:
	ld a,l
	add a,$18
	ld l,a
	ld a,$2D
	ld [hld],a
	ld a,l
	sub $04
	ld l,a
	ld a,$33
	ld [hld],a
	xor a
	ld [hld],a
	ld [hld],a
	ld a,$4F
	ld [hld],a
	ld a,$42
	ld [hld],a
	ld a,l
	sub $07
	ld l,a
	ld a,$10
	ld [hli],a
	dec [hl]
	inc l
	inc [hl]
	ret

Logged_0x426EE:
	ld hl,$D100
	bit 5,[hl]
	jr z,Logged_0x42702
	ld a,[$C08F]
	rra
	ret c
	ld b,$01
	call Logged_0x129E
	call Logged_0x1197

Logged_0x42702:
	ld l,$16
	dec [hl]
	jp nz,Logged_0x30E6
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $01
	ld [hld],a
	xor a
	ld [hld],a
	ret

Logged_0x42714:
	ld a,$81
	ld [$D11C],a
	ld bc,$44E0
	call Logged_0x34B7
	ld bc,$4650
	jp Logged_0x34A0

Logged_0x42725:
	ld hl,$D119
	ld a,[hl]
	ld b,$40
	add a,$00
	ld c,a
	ld a,[bc]
	cp $80
	jr nz,Logged_0x42740
	ld a,c
	sub $3F
	ld c,a
	ld a,[bc]
	ld c,$01
	ld [hl],c
	ld l,$16
	dec [hl]
	jr Logged_0x42741

Logged_0x42740:
	inc [hl]

Logged_0x42741:
	and a
	ret z
	ld l,$03
	cp $80
	ld c,[hl]
	jr nc,Logged_0x4274F
	add a,c
	ld [hli],a
	ret nc
	inc [hl]
	ret

Logged_0x4274F:
	add a,c
	ld [hli],a
	ret c
	dec [hl]
	ret

Logged_0x42754:
	ld hl,$D100
	res 5,[hl]
	ld l,$16
	ld a,[hl]
	and a
	ret z
	dec [hl]
	ret nz
	ld de,$4F50
	call Logged_0x30F0
	ret

Logged_0x42767:
	ld hl,$D100
	set 3,[hl]
	ld a,[$CA8E]
	cp $42
	jr nz,Logged_0x4277F
	call Logged_0x42725
	call Logged_0x42894
	ld hl,$D100
	res 5,[hl]
	ret

Logged_0x4277F:
	ld hl,$D11B
	ld a,$2E
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld de,$4F42
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $23
	ld [hld],a
	ld l,$0B
	inc [hl]
	inc l
	dec [hl]
	ret
	ld hl,$D100
	set 3,[hl]
	ld l,$1F
	ld a,$67
	ld [hld],a
	ld a,$A9
	ld [hld],a
	call Logged_0x42935
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x42767
	cp $2D
	jr z,Logged_0x427CD
	cp $2E
	jr z,Logged_0x427FE
	cp $2F
	jr z,Logged_0x42754
	cp $2A
	jp z,Logged_0x4284D
	cp $5A
	jp z,Logged_0x4286B
	xor a
	ld [hl],a
	jr Logged_0x42767

Logged_0x427CD:
	call Logged_0x42894
	ld hl,$D116
	ld a,[hl]
	cp $33
	jr nz,Logged_0x427DA
	dec [hl]
	ret

Logged_0x427DA:
	ld l,$00
	bit 5,[hl]
	jr z,Logged_0x427E5
	ld a,[$C08F]
	rra
	ret c

Logged_0x427E5:
	ld l,$16
	dec [hl]
	jp nz,Logged_0x30E6
	ld de,$4F50
	call Logged_0x30F0
	ld l,$1B
	xor a
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld a,$0B
	ld [$D10A],a
	ret

Logged_0x427FE:
	ld bc,$45E0
	call Logged_0x34B7
	ld hl,$D103
	ld a,[hli]
	add a,$0F
	ld [$FF00+$A9],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hli]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	ret z
	ld hl,$D103
	ld a,[$FF00+$A9]
	sub $0F
	ld [hli],a
	ld a,[$FF00+$A8]
	sbc a,$00
	ld [hl],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$63
	ld [$FF00+$B6],a
	ld b,$18
	call Logged_0x12B5
	ld de,$4F45
	call Logged_0x30F0

Logged_0x4283C:
	ld a,$1C
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $22
	ld [hld],a
	ld a,$2F
	ld [$D11B],a
	ret

Logged_0x4284D:
	ld de,$4F45
	call Logged_0x30F0
	ld a,$14
	ld [hli],a
	ld a,$5A
	ld [$D11B],a
	ld hl,$D103
	ld a,[$CA62]
	sub $18
	ld [hli],a
	ld a,[$CA61]
	sbc a,$00
	ld [hli],a
	ret

Logged_0x4286B:
	ld hl,$D116
	ld a,[hl]
	cp $14
	jr nz,Logged_0x42889
	ld a,[$CA9B]
	and a
	jp nz,Logged_0x30A4
	ld hl,$D103
	ld a,[$CA62]
	sub $18
	ld [hli],a
	ld a,[$CA61]
	sbc a,$00
	ld [hli],a

Logged_0x42889:
	ld l,$16
	dec [hl]
	ret nz
	ld a,$9F
	ld [$D11C],a
	jr Logged_0x4283C

Logged_0x42894:
	ld hl,$D101
	ld a,[hli]
	ld c,a
	ld b,[hl]
	ld d,$43
	ld e,$03
	ld h,$D0
	ld l,$00
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x428AF
	ld a,[hli]
	cp c
	jr nz,Logged_0x428AF
	ld a,[hld]
	cp b
	jr z,Logged_0x42919

Logged_0x428AF:
	ld l,$20
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x428BE
	ld a,[hli]
	cp c
	jr nz,Logged_0x428BE
	ld a,[hld]
	cp b
	jr z,Logged_0x42919

Logged_0x428BE:
	ld l,$40
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x428CD
	ld a,[hli]
	cp c
	jr nz,Logged_0x428CD
	ld a,[hld]
	cp b
	jr z,Logged_0x42919

Logged_0x428CD:
	ld l,$60
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x428DC
	ld a,[hli]
	cp c
	jr nz,Logged_0x428DC
	ld a,[hld]
	cp b
	jr z,Logged_0x42919

Logged_0x428DC:
	ld l,$80
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x428EB
	ld a,[hli]
	cp c
	jr nz,Logged_0x428EB
	ld a,[hld]
	cp b
	jr z,Logged_0x42919

Logged_0x428EB:
	ld l,$A0
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x428FA
	ld a,[hli]
	cp c
	jr nz,Logged_0x428FA
	ld a,[hld]
	cp b
	jr z,Logged_0x42919

Logged_0x428FA:
	ld l,$C0
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x42909
	ld a,[hli]
	cp c
	jr nz,Logged_0x42909
	ld a,[hld]
	cp b
	jr z,Logged_0x42919

Logged_0x42909:
	ld l,$E0
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x42918
	ld a,[hli]
	cp c
	jr nz,Logged_0x42918
	ld a,[hld]
	cp b
	jr z,Logged_0x42919

Logged_0x42918:
	ret

Logged_0x42919:
	ld a,[$D100]
	rlca
	rlca
	ld e,a
	dec l
	ld a,[hl]
	rla
	rla
	rla
	sla e
	rra
	rra
	rra
	ld [hl],a
	ld a,l
	add a,$1B
	ld l,a
	ld a,[hl]
	cp $3A
	ret nz
	jp Logged_0x4277F

Logged_0x42935:
	ld hl,$D101
	ld a,[hli]
	ld c,a
	ld b,[hl]
	ld d,$41
	ld e,$01
	ld h,$D0
	ld l,$00
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x42950
	ld a,[hli]
	cp c
	jr nz,Logged_0x42950
	ld a,[hld]
	cp b
	jr z,Logged_0x429BE

Logged_0x42950:
	ld l,$20
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x4295F
	ld a,[hli]
	cp c
	jr nz,Logged_0x4295F
	ld a,[hld]
	cp b
	jr z,Logged_0x429BE

Logged_0x4295F:
	ld l,$40
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x4296E
	ld a,[hli]
	cp c
	jr nz,Logged_0x4296E
	ld a,[hld]
	cp b
	jr z,Logged_0x429BE

Logged_0x4296E:
	ld l,$60
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x4297D
	ld a,[hli]
	cp c
	jr nz,Logged_0x4297D
	ld a,[hld]
	cp b
	jr z,Logged_0x429BE

Logged_0x4297D:
	ld l,$80
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x4298C
	ld a,[hli]
	cp c
	jr nz,Logged_0x4298C
	ld a,[hld]
	cp b
	jr z,Logged_0x429BE

Logged_0x4298C:
	ld l,$A0
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x4299B
	ld a,[hli]
	cp c
	jr nz,Logged_0x4299B
	ld a,[hld]
	cp b
	jr z,Logged_0x429BE

Logged_0x4299B:
	ld l,$C0
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x429AA
	ld a,[hli]
	cp c
	jr nz,Logged_0x429AA
	ld a,[hld]
	cp b
	jr z,Logged_0x429BE

Logged_0x429AA:
	ld l,$E0
	ld a,[hli]
	and d
	cp e
	jr nz,Logged_0x429B9
	ld a,[hli]
	cp c
	jr nz,Logged_0x429B9
	ld a,[hld]
	cp b
	jr z,Logged_0x429BE

Logged_0x429B9:
	xor a
	ld [$D11A],a
	ret

Logged_0x429BE:
	ld a,$10
	ld [$D11A],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$69
	ld [hld],a
	ld a,$ED
	ld [hld],a
	ld de,$461B
	call Logged_0x30F0
	ld a,$60
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$03
	ld [hld],a
	ld a,$FC
	ld [hld],a
	ld a,$FD
	ld [hl],a
	ret
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x42A68
	cp $0E
	jr z,Unknown_0x42A16
	cp $0D
	jr z,Unknown_0x42A16
	cp $0A
	jp z,Logged_0x3182
	cp $28
	jr z,Logged_0x42A2D
	cp $29
	jr z,Logged_0x42A35
	cp $04
	jr z,Logged_0x42A45
	cp $05
	jr z,Unknown_0x42A3D
	rra
	jr nc,Logged_0x42A35
	jr Logged_0x42A2D

Unknown_0x42A16:
	xor a
	ld [hl],a
	ld l,$18
	ld a,$3C
	ld [hld],a
	ld a,[hl]
	and a
	jr z,Unknown_0x42A27
	ld de,$462A
	jp Logged_0x30F0

Unknown_0x42A27:
	ld de,$462F
	jp Logged_0x30F0

Logged_0x42A2D:
	ld a,$33
	ld c,$F8
	ld b,$02
	jr Logged_0x42A4B

Logged_0x42A35:
	ld a,$34
	ld c,$07
	ld b,$02
	jr Logged_0x42A4B

Unknown_0x42A3D:
	ld a,$33
	ld c,$17
	ld b,$02
	jr Logged_0x42A4B

Logged_0x42A45:
	ld a,$33
	ld c,$26
	ld b,$02

Logged_0x42A4B:
	ld l,$00
	set 3,[hl]
	ld l,$1F
	ld [hld],a
	ld [hl],c
	ld l,$1A
	ld a,[hl]
	and $F0
	ld [hld],a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld a,$81
	ld [$D11C],a
	ld de,$4698
	jp Logged_0x30F0

Logged_0x42A68:
	ld l,$18
	ld a,[hl]
	and a
	jr z,Logged_0x42A75
	dec [hl]
	ld a,$02
	ld [$D114],a
	ret

Logged_0x42A75:
	ld a,[$C08F]
	rra
	ret c
	ld l,$17
	ld a,[hld]
	and a
	jr z,Logged_0x42A8D
	cp $01
	jr z,Logged_0x42A9C
	cp $02
	jr z,Logged_0x42AA9
	cp $03
	jr z,Logged_0x42AB8
	ret

Logged_0x42A8D:
	dec [hl]
	jp nz,Logged_0x30D9
	ld de,$463F
	ld b,$01
	ld c,$01
	ld a,$16
	jr Logged_0x42AC3

Logged_0x42A9C:
	dec [hl]
	ret nz
	ld de,$4616
	ld b,$02
	ld c,$04
	ld a,$60
	jr Logged_0x42AC3

Logged_0x42AA9:
	dec [hl]
	jp nz,Logged_0x30E6
	ld de,$4634
	ld b,$03
	ld c,$01
	ld a,$16
	jr Logged_0x42AC3

Logged_0x42AB8:
	dec [hl]
	ret nz
	ld de,$461B
	ld b,$00
	ld c,$4C
	ld a,$60

Logged_0x42AC3:
	ld [hli],a
	ld [hl],b
	ld l,$08
	ld a,[hl]
	and $80
	or c
	ld [hl],a
	jp Logged_0x30F0
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x42B15
	cp $0B
	jr z,Logged_0x42AFE
	cp $0C
	jr z,Logged_0x42AFE
	cp $0A
	jp z,Logged_0x3182
	cp $28
	jp z,Logged_0x42A2D
	cp $29
	jp z,Logged_0x42A35
	cp $04
	jp z,Logged_0x42A45
	cp $05
	jp z,Unknown_0x42A3D
	rra
	jp nc,Logged_0x42A35
	jp Logged_0x42A2D

Logged_0x42AFE:
	xor a
	ld [hl],a
	ld l,$18
	ld a,$3C
	ld [hld],a
	ld a,[hl]
	and a
	jr z,Unknown_0x42B0F
	ld de,$4620
	jp Logged_0x30F0

Unknown_0x42B0F:
	ld de,$4625
	jp Logged_0x30F0

Logged_0x42B15:
	ld l,$18
	ld a,[hl]
	and a
	jr z,Logged_0x42B1D
	dec [hl]
	ret

Logged_0x42B1D:
	ld a,[$C08F]
	rra
	ret c
	ld l,$17
	ld a,[hld]
	and a
	jr z,Logged_0x42B35
	cp $01
	jr z,Logged_0x42B44
	cp $02
	jr z,Logged_0x42B4F
	cp $03
	jr z,Logged_0x42B5E
	ret

Logged_0x42B35:
	dec [hl]
	jp nz,Logged_0x30BD
	ld de,$4655
	ld b,$01
	ld c,$01
	ld a,$16
	jr Logged_0x42B71

Logged_0x42B44:
	dec [hl]
	ret nz
	ld de,$460C
	ld b,$02
	ld c,$02
	jr Logged_0x42B67

Logged_0x42B4F:
	dec [hl]
	jp nz,Logged_0x30CA
	ld de,$464A
	ld b,$03
	ld c,$01
	ld a,$16
	jr Logged_0x42B71

Logged_0x42B5E:
	dec [hl]
	ret nz
	ld de,$4611
	ld b,$00
	ld c,$02

Logged_0x42B67:
	ld l,$1A
	ld a,[hl]
	xor $80
	ld [hl],a
	ld l,$16
	ld a,$60

Logged_0x42B71:
	ld [hli],a
	ld [hl],b
	ld l,$08
	ld a,[hl]
	and $80
	or c
	ld [hl],a
	jp Logged_0x30F0
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$6A
	ld [hld],a
	ld a,$CF
	ld [hld],a
	ld de,$4611
	call Logged_0x30F0
	ld a,$60
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$1A
	res 5,[hl]
	set 7,[hl]
	ld l,$0C
	ld a,$04
	ld [hld],a
	ld a,$FB
	ld [hld],a
	ld a,$FC
	ld [hl],a
	ret
	ld hl,$D11F
	ld a,$6B
	ld [hld],a
	ld a,$BF
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld a,$14
	ld [$D116],a
	ld l,$00
	set 3,[hl]
	ret
	ld a,$81
	ld [$D11C],a
	ld a,$02
	ld [$D114],a
	ld hl,$D105
	ld a,[hli]
	add a,$16
	ld e,a
	ld a,[hl]
	jr nc,Logged_0x42BD4
	inc a

Logged_0x42BD4:
	ld d,a
	ld a,[$CA63]
	cp d
	jr c,Logged_0x42BE1
	ret nz
	ld a,[$CA64]
	cp e
	ret nc

Logged_0x42BE1:
	ld l,$16
	ld a,[hl]
	and a
	jr z,Logged_0x42BE9
	dec [hl]
	ret

Logged_0x42BE9:
	ld hl,$D11F
	ld a,$6C
	ld [hld],a
	ld a,$03
	ld [hld],a
	ld a,$A0
	ld [$D116],a
	ld bc,$47DF
	call Logged_0x3416
	ld bc,$4809
	jp Logged_0x3416
	ld a,$81
	ld [$D11C],a
	ld a,$02
	ld [$D114],a
	ld hl,$D116
	dec [hl]
	ret nz
	ld l,$1F
	ld a,$6B
	ld [hld],a
	ld a,$BF
	ld [hld],a
	ld a,$50
	ld [$D116],a
	ld bc,$47F4
	jp Logged_0x3416
	ld a,$81
	ld [$D11C],a
	ld hl,$D100
	set 4,[hl]
	set 3,[hl]
	ld l,$16
	dec [hl]
	ret nz
	ld a,$12
	ld [hl],a
	ld l,$1F
	ld a,$6C
	ld [hld],a
	ld a,$4C
	ld [hld],a
	ld hl,$D100
	res 4,[hl]
	ld de,$4732
	call Logged_0x30F0
	ret
	ld a,$81
	ld [$D11C],a
	ld hl,$D100
	set 3,[hl]
	ld l,$16
	dec [hl]
	ret nz
	ld l,$1F
	ld a,$6C
	ld [hld],a
	ld a,$6E
	ld [hld],a
	ld de,$4729
	call Logged_0x30F0
	ret

Unknown_0x42C69:
	xor a
	ld [$D100],a
	ret
	call Logged_0x3655
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x42C9A
	cp $0A
	jp z,Logged_0x3182
	cp $0B
	jr c,Unknown_0x42C69
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Unknown_0x42C93
	ld a,$01
	jr Unknown_0x42C95

Unknown_0x42C93:
	ld a,$02

Unknown_0x42C95:
	ld [$D116],a
	xor a
	ld [hl],a

Logged_0x42C9A:
	ld a,[$D116]
	and a
	jr z,Logged_0x42CAB
	dec a
	jr nz,Unknown_0x42CA8
	call Logged_0x30BD
	jr Logged_0x42CAB

Unknown_0x42CA8:
	call Logged_0x30CA

Logged_0x42CAB:
	ld l,$00
	bit 5,[hl]
	jr z,Logged_0x42CC5
	res 5,[hl]
	ld a,[$C08F]
	rra
	ret nc
	ld b,$01
	call Logged_0x1287
	call Logged_0x1169
	call Logged_0x30D9
	jr Logged_0x42CCD

Logged_0x42CC5:
	ld a,[$C08F]
	rra
	ret nc
	call Logged_0x30D9

Logged_0x42CCD:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	ld a,[$C0DD]
	and a
	ret z
	ld a,$81
	ld [$D11C],a
	ld hl,$D11F
	ld a,$6D
	ld [hld],a
	ld a,$0E
	ld [hld],a
	ld de,$473B
	call Logged_0x30F0
	ld a,$14
	ld [hli],a
	ld l,$0D
	ld a,[hli]
	cp $B8
	ret nc
	ld a,[hl]
	cp $B8
	ret nc
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$8F
	ld [$FF00+$B6],a
	ret
	ld a,$81
	ld [$D11C],a
	ld hl,$D116
	dec [hl]
	ret nz
	xor a
	ld [$D100],a
	ret
	ld hl,$D11F
	ld a,$6D
	ld [hld],a
	ld a,$27
	ld [hld],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$6D
	ld [hld],a
	ld a,$3B
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	jp Logged_0x42E37
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x42E37
	dw Logged_0x42ECA
	dw Logged_0x43126
	dw Logged_0x43130
	dw Logged_0x431B4
	dw Logged_0x431BE
	dw Logged_0x431DA
	dw Logged_0x431ED
	dw Logged_0x43126
	dw Logged_0x43130
	dw Logged_0x3182
	dw Logged_0x43162
	dw Logged_0x43169
	dw Logged_0x42E37
	dw Logged_0x42E37
	dw Logged_0x43083
	dw Logged_0x430BA
	dw Unknown_0x42E7B
	dw Logged_0x43263
	dw Logged_0x430D5
	dw Logged_0x4304B
	dw Logged_0x43053
	dw Logged_0x42FE5
	dw Logged_0x43018
	dw Logged_0x43231
	dw Logged_0x43200
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x42E37
	dw Logged_0x42E37
	dw Logged_0x42E37
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Unknown_0x431AA
	dw Unknown_0x431A0
	dw Logged_0x42E37
	dw Logged_0x42E37
	dw Logged_0x42E37
	dw Logged_0x42E95
	dw Logged_0x42E37
	dw Logged_0x42E37
	dw Logged_0x3290
	dw Logged_0x42EF8
	dw Logged_0x33DA
	dw Logged_0x33E9
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x42E37
	dw Logged_0x4317A
	dw Logged_0x4318D
	dw Logged_0x42E37
	dw Logged_0x42E37
	dw Logged_0x430A0
	dw Logged_0x430C8
	dw Logged_0x329F
	dw Logged_0x3371
	dw Logged_0x430F6
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x4300A
	dw Logged_0x4303D
	dw Logged_0x43252
	dw Logged_0x43221
	dw Logged_0x3380
	dw Logged_0x338F
	dw Unknown_0x42DFF
	dw Unknown_0x42E1B
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x42E37
	dw Logged_0x42E37
	dw Logged_0x42E37
	dw Logged_0x42E37
	dw Logged_0x33BC
	dw Logged_0x33CB

Unknown_0x42DFF:
	ld hl,$D11B
	ld a,$5E
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x42E12
	ld de,$479E
	call Logged_0x30F0
	jp Logged_0x33BC

Unknown_0x42E12:
	ld de,$47A7
	call Logged_0x30F0
	jp Logged_0x33BC

Unknown_0x42E1B:
	ld hl,$D11B
	ld a,$5F
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x42E2E
	ld de,$479E
	call Logged_0x30F0
	jp Logged_0x33CB

Unknown_0x42E2E:
	ld de,$47A7
	call Logged_0x30F0
	jp Logged_0x33CB

Logged_0x42E37:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$30
	ld [hld],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x42E67
	res 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4744
	call Logged_0x30F0
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ret

Logged_0x42E67:
	set 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$474D
	call Logged_0x30F0
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ret

Unknown_0x42E7B:
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x42E8D
	xor a
	ld [hld],a
	ld de,$4744
	jp Logged_0x30F0

Unknown_0x42E8D:
	xor a
	ld [hld],a
	ld de,$474D
	jp Logged_0x30F0

Logged_0x42E95:
	ld hl,$D116
	ld a,[hl]
	and a
	jp z,Logged_0x42F44
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x42EAE
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x42EAE:
	dec [hl]
	ret nz
	ld l,$08
	ld a,[hl]
	and $80
	or $19
	ld [hld],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x42EC4
	ld de,$4756
	jp Logged_0x30F0

Logged_0x42EC4:
	ld de,$475F
	jp Logged_0x30F0

Logged_0x42ECA:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x42EEA
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld de,$4744
	jp Logged_0x30F0

Logged_0x42EEA:
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld de,$474D
	jp Logged_0x30F0

Logged_0x42EF8:
	ld a,[$CA8E]
	cp $C3
	jr z,Logged_0x42F44
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $0F
	jr c,Logged_0x42F13
	cp $F1
	jr c,Logged_0x42F44

Logged_0x42F13:
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	cp b
	ld hl,$D11A
	bit 7,[hl]
	jr c,Logged_0x42F2B
	jr nz,Logged_0x42F32
	ld de,$47B0
	jr Logged_0x42F38

Logged_0x42F2B:
	jr z,Logged_0x42F32
	ld de,$47BB
	jr Logged_0x42F38

Logged_0x42F32:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x42F38:
	call Logged_0x30F0
	ld a,$23
	ld [hli],a
	ld a,$2D
	ld [$D11B],a
	ret

Logged_0x42F44:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x42F55
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x42F55:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x42F70
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x42F70:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x42FB1
	ld a,[hl]
	and $0F
	sub $08
	jr nc,Logged_0x42F8D
	call Logged_0x355B
	and $0F
	jr z,Logged_0x42FAB

Logged_0x42F8D:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $08
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30C5

Logged_0x42FAB:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x42FB1:
	ld a,[hl]
	and $0F
	add a,$07
	cp $10
	jr c,Logged_0x42FC1
	call Logged_0x3573
	and $0F
	jr z,Logged_0x42FDF

Logged_0x42FC1:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$07
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30B8

Logged_0x42FDF:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x42FE5:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x42FF4
	ld de,$477A
	jr Logged_0x42FF7

Logged_0x42FF4:
	ld de,$4783

Logged_0x42FF7:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x4300A:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x43018:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x43027
	ld de,$477A
	jr Logged_0x4302A

Logged_0x43027:
	ld de,$4783

Logged_0x4302A:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x4303D:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x4304B:
	ld hl,$D11B
	ld a,$44
	ld [hld],a
	jr Logged_0x43059

Logged_0x43053:
	ld hl,$D11B
	ld a,$45
	ld [hld],a

Logged_0x43059:
	ld a,[hld]
	rlca
	jr c,Logged_0x43065
	ld de,$477A
	call Logged_0x30F0
	jr Logged_0x4306B

Logged_0x43065:
	ld de,$4783
	call Logged_0x30F0

Logged_0x4306B:
	inc l
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x43083:
	ld hl,$D11B
	ld a,$3F
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x43092
	ld de,$477A
	jr Logged_0x43095

Logged_0x43092:
	ld de,$4783

Logged_0x43095:
	call Logged_0x30F0
	ld a,$64
	ld [hli],a
	ld hl,$D100
	res 2,[hl]

Logged_0x430A0:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x430AD
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x430AD:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x430BA:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld a,$07
	ld [$D116],a

Logged_0x430C8:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32F9
	ld a,$00
	ld [$D11B],a
	ret

Logged_0x430D5:
	ld hl,$D11B
	ld a,$43
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x430E4
	ld de,$4768
	jr Logged_0x430E7

Logged_0x430E4:
	ld de,$4771

Logged_0x430E7:
	call Logged_0x30F0
	ld a,$23
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ret

Logged_0x430F6:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x43107
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x43107:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x3308
	ld a,[$D11A]
	rlca
	jr c,Logged_0x4311D
	ld hl,$D11B
	ld a,$01
	ld [hld],a
	set 7,[hl]
	ret

Logged_0x4311D:
	ld hl,$D11B
	ld a,$01
	ld [hld],a
	res 7,[hl]
	ret

Logged_0x43126:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x43138

Logged_0x43130:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x43138:
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x43142
	ld de,$478C
	jr Logged_0x43145

Logged_0x43142:
	ld de,$4795

Logged_0x43145:
	call Logged_0x30F0
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x43162:
	ld a,$3B
	ld [$D11B],a
	jr Logged_0x4316E

Logged_0x43169:
	ld a,$3C
	ld [$D11B],a

Logged_0x4316E:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$02
	ld [$D118],a
	ret

Logged_0x4317A:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$18
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x4318D:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$18
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$13
	ld [$D11B],a
	ret

Unknown_0x431A0:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Logged_0x431C6

Unknown_0x431AA:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Logged_0x431C6

Logged_0x431B4:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$02
	jr Logged_0x431C6

Logged_0x431BE:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$02

Logged_0x431C6:
	ld a,[hl]
	and $F0
	ld [hld],a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld de,$47C6
	call Logged_0x30F0
	ld a,$81
	ld [$D11C],a
	ret

Logged_0x431DA:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Logged_0x431ED:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Logged_0x43200:
	ld hl,$D11B
	ld a,$49
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4320F
	ld de,$477A
	jr Logged_0x43212

Logged_0x4320F:
	ld de,$4783

Logged_0x43212:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x43221:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Logged_0x43231

Logged_0x43231:
	ld hl,$D11B
	ld a,$48
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x43240
	ld de,$477A
	jr Logged_0x43243

Logged_0x43240:
	ld de,$4783

Logged_0x43243:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x43252:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Logged_0x43200

Logged_0x43263:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret
	ld hl,$D11F
	ld a,$72
	ld [hld],a
	ld a,$82
	ld [hld],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$73
	ld [hld],a
	ld a,$62
	ld [hld],a
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld a,$FA
	ld [hl],a
	xor a
	ld [$D116],a
	ld l,$1A
	res 5,[hl]
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x432B9
	res 7,[hl]
	ld de,$47D3
	call Logged_0x30F0
	ret

Logged_0x432B9:
	set 7,[hl]
	ld de,$47E4
	call Logged_0x30F0
	ret

Logged_0x432C2:
	ld l,$00
	bit 1,[hl]
	ret z
	ld l,$16
	ld a,[hl]
	and a
	jr z,Logged_0x432E7
	dec [hl]
	ret nz
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x432DF
	set 7,[hl]
	ld de,$47E4
	call Logged_0x30F0
	jr Logged_0x432E7

Logged_0x432DF:
	res 7,[hl]
	ld de,$47D3
	call Logged_0x30F0

Logged_0x432E7:
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $18
	jr c,Logged_0x432FA
	cp $E8
	ret c

Logged_0x432FA:
	ld l,$1A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	ld b,a
	jr c,Logged_0x43319
	bit 7,[hl]
	jr nz,Logged_0x43338
	ld a,b
	cp $70
	ret nc
	ld de,$47C9
	call Logged_0x30F0
	jr Logged_0x43327

Logged_0x43319:
	bit 7,[hl]
	jr z,Logged_0x43338
	ld a,b
	cp $90
	ret c
	ld de,$47CE
	call Logged_0x30F0

Logged_0x43327:
	ld a,$23
	ld [hli],a
	ld a,$2F
	ld [$D11B],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$6F
	ld [$FF00+$B6],a
	ret

Logged_0x43338:
	ld de,$47FF
	call Logged_0x30F0
	ld a,$0C
	ld [hli],a
	ret

Logged_0x43342:
	ld l,$16
	ld a,[hl]
	and a
	jr z,Logged_0x43358
	dec [hl]
	ret nz
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$70
	ld [$FF00+$B6],a
	ret
	ld a,$81
	ld [$D11C],a

Logged_0x43358:
	ld a,[$D11A]
	rlca
	jp c,Logged_0x309A
	jp Logged_0x3090
	ld hl,$D11B
	ld a,[hl]
	and a
	jp z,Logged_0x432C2
	cp $2F
	jr z,Logged_0x43342
	cp $0B
	jr z,Logged_0x4338F
	cp $0C
	jr z,Logged_0x43394
	cp $0A
	jr z,Logged_0x433C7
	cp $28
	jr z,Logged_0x433CA
	cp $29
	jr z,Logged_0x433D2
	cp $04
	jr z,Unknown_0x433E2
	cp $05
	jr z,Unknown_0x433DA
	rra
	jr nc,Logged_0x433D2
	jr Logged_0x433CA

Logged_0x4338F:
	ld bc,$49C2
	jr Logged_0x43397

Logged_0x43394:
	ld bc,$49D7

Logged_0x43397:
	xor a
	ld [hl],a
	ld l,$00
	bit 3,[hl]
	jr z,Logged_0x433A7
	ld l,$1A
	bit 7,[hl]
	jr z,Logged_0x433D2
	jr Logged_0x433CA

Logged_0x433A7:
	set 3,[hl]
	ld l,$1F
	ld a,[$D107]
	cp $0D
	jr z,Logged_0x433BB
	ld a,$73
	ld [hld],a
	ld a,$53
	ld [hld],a
	jp Logged_0x3416

Logged_0x433BB:
	ld a,$74
	ld [hld],a
	ld a,$0B
	ld [hld],a
	ld a,$14
	ld [$D116],a
	ret

Logged_0x433C7:
	jp Logged_0x3173

Logged_0x433CA:
	ld a,$33
	ld c,$F8
	ld b,$02
	jr Logged_0x433E8

Logged_0x433D2:
	ld a,$34
	ld c,$07
	ld b,$02
	jr Logged_0x433E8

Unknown_0x433DA:
	ld a,$33
	ld c,$17
	ld b,$02
	jr Logged_0x433E8

Unknown_0x433E2:
	ld a,$33
	ld c,$26
	ld b,$02

Logged_0x433E8:
	ld l,$00
	set 3,[hl]
	ld l,$1F
	ld [hld],a
	ld [hl],c
	ld l,$18
	ld a,b
	ld [hli],a
	xor a
	ld [hli],a
	ld a,$81
	ld [$D11C],a
	ld a,[hl]
	rlca
	jr c,Logged_0x43405
	ld de,$47F5
	jp Logged_0x30F0

Logged_0x43405:
	ld de,$47FA
	jp Logged_0x30F0
	ld hl,$D11C
	ld a,$81
	ld [hld],a
	ld l,$16
	dec [hl]
	ret nz
	ld de,$47FF
	call Logged_0x30F0
	ld a,$0C
	ld [hli],a
	ld l,$1F
	ld a,$74
	ld [hld],a
	ld a,$27
	ld [hld],a
	ret
	ld hl,$D11C
	ld a,$81
	ld [hld],a
	ld a,[hl]
	and a
	jp nz,Logged_0x43342
	ld l,$16
	dec [hl]
	ret nz
	ld l,$1B
	ld a,$01
	ld [hld],a
	ld a,[hl]
	rlca
	jr c,Logged_0x43448
	set 7,[hl]
	ld de,$47CE
	call Logged_0x30F0
	ret

Logged_0x43448:
	res 7,[hl]
	ld de,$47C9
	call Logged_0x30F0
	ret
	ld hl,$D100
	res 4,[hl]
	set 3,[hl]
	ld l,$1F
	ld a,$74
	ld [hld],a
	ld a,$79
	ld [hld],a
	ld de,$4A7B
	call Logged_0x30F0
	ld a,$0A
	ld [hli],a
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld a,$F7
	ld [hl],a
	ret
	ld hl,$D100
	bit 5,[hl]
	jr z,Logged_0x4349C
	res 5,[hl]
	ld l,$16
	dec [hl]
	ret nz
	ld de,$4A7E
	call Logged_0x30F0
	ld a,$11
	ld [hli],a
	ld l,$1F
	ld a,$74
	ld [hld],a
	ld a,$A2
	ld [hld],a
	xor a
	ld [$D119],a
	ret

Logged_0x4349C:
	ld a,$0A
	ld [$D116],a
	ret
	ld hl,$D116
	ld a,[hl]
	and a
	jr z,Logged_0x434B4
	dec [hl]
	ret nz
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$86
	ld [$FF00+$B6],a
	ret

Logged_0x434B4:
	ld bc,$4A50
	jp Logged_0x34FC
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$74
	ld [hld],a
	ld a,$E2
	ld [hld],a
	ld de,$4A78
	call Logged_0x30F0
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld a,$00
	ld [hl],a
	ld a,$31
	ld [$D11B],a
	ret
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435DF
	dw Logged_0x435E7
	dw Unknown_0x436CF
	dw Logged_0x436C1
	dw Logged_0x4360B
	dw Logged_0x43624
	dw Logged_0x435DF
	dw Logged_0x435E7
	dw Logged_0x3173
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x4367C
	dw Logged_0x435DE
	dw Logged_0x435F8
	dw Logged_0x435FC
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x4365C
	dw Logged_0x4363D
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x436A5
	dw Logged_0x436B3
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435C2
	dw Logged_0x435A6
	dw Logged_0x435DE
	dw Logged_0x33DA
	dw Logged_0x33E9
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x3371
	dw Logged_0x435A6
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x4366B
	dw Logged_0x4364C
	dw Logged_0x3380
	dw Logged_0x338F
	dw Unknown_0x43689
	dw Logged_0x43697
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x435A6
	dw Logged_0x33BC
	dw Logged_0x33CB

Logged_0x435A6:
	ld a,$2F
	ld [$D11B],a
	ld de,$4A8B
	call Logged_0x30F0
	ld a,$0E
	ld [hli],a
	ld l,$00
	res 2,[hl]
	set 3,[hl]
	ld a,$02
	ld [$FF00+$B5],a
	ld a,$0D
	ld [$FF00+$B6],a

Logged_0x435C2:
	ld a,$81
	ld [$D11C],a
	ld hl,$D116
	dec [hl]
	ret nz
	ld l,$02
	ld a,$02
	ld [$FF00+$85],a
	ld a,$EE
	ld [$FF00+$8D],a
	ld a,$7A
	ld [$FF00+$8E],a
	call $FF80
	ret

Logged_0x435DE:
	ret

Logged_0x435DF:
	ld hl,$D11B
	ld a,$32
	ld [hld],a
	jr Logged_0x435ED

Logged_0x435E7:
	ld hl,$D11B
	ld a,$33
	ld [hld],a

Logged_0x435ED:
	ld a,$0C
	ld [$D116],a
	ld a,$02
	ld [$D118],a
	ret

Logged_0x435F8:
	ld a,$44
	jr Logged_0x435FE

Logged_0x435FC:
	ld a,$45

Logged_0x435FE:
	ld [$D11B],a
	xor a
	ld [$D119],a
	ld a,$02
	ld [$D118],a
	ret

Logged_0x4360B:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	ld de,$4A78
	call Logged_0x30F0
	jp Logged_0x3335

Logged_0x43624:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	ld de,$4A78
	call Logged_0x30F0
	jp Logged_0x3344

Logged_0x4363D:
	ld a,$49
	ld [$D11B],a
	ld de,$4A78
	call Logged_0x30F0
	ld l,$00
	set 2,[hl]

Logged_0x4364C:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Logged_0x4365C

Logged_0x4365C:
	ld a,$48
	ld [$D11B],a
	ld de,$4A78
	call Logged_0x30F0
	ld l,$00
	set 2,[hl]

Logged_0x4366B:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Logged_0x4363D

Logged_0x4367C:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hl],a
	ret

Unknown_0x43689:
	ld a,$5E
	ld [$D11B],a
	ld de,$4A6F
	call Logged_0x30F0
	jp Logged_0x33BC

Logged_0x43697:
	ld a,$5F
	ld [$D11B],a
	ld de,$4A66
	call Logged_0x30F0
	jp Logged_0x33CB

Logged_0x436A5:
	ld de,$4A6F
	call Logged_0x30F0
	ld a,$33
	ld c,$F8
	ld b,$02
	jr Logged_0x436DB

Logged_0x436B3:
	ld de,$4A66
	call Logged_0x30F0
	ld a,$34
	ld c,$07
	ld b,$02
	jr Logged_0x436DB

Logged_0x436C1:
	ld de,$4A6F
	call Logged_0x30F0
	ld a,$33
	ld c,$17
	ld b,$02
	jr Logged_0x436DB

Unknown_0x436CF:
	ld de,$4A66
	call Logged_0x30F0
	ld a,$33
	ld c,$26
	ld b,$02

Logged_0x436DB:
	ld l,$1F
	ld [hld],a
	ld [hl],c
	ld l,$19
	xor a
	ld [hld],a
	ld [hl],b
	ld a,$81
	ld [$D11C],a
	ret
	ld hl,$D100
	res 4,[hl]
	set 3,[hl]
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld a,$F3
	ld [hl],a
	ld l,$1F
	ld a,$77
	ld [hld],a
	ld a,$1B
	ld [hld],a
	ld de,$4A9F
	call Logged_0x30F0
	ret

UnknownData_0x4370F:
INCBIN "baserom.gbc", $4370F, $4371B - $4370F
	call Logged_0x3655
	ld hl,$D11B
	ld a,[hl]
	cp $0A
	jr z,Unknown_0x43747
	and $FE
	cp $04
	jr z,Unknown_0x43747
	xor a
	ld [hl],a
	ld l,$00
	bit 5,[hl]
	ret z
	res 5,[hl]
	ld de,$4AA8
	call Logged_0x30F0
	ld a,$28
	ld [hli],a
	ld l,$1F
	ld a,$77
	ld [hld],a
	ld a,$4A
	ld [hld],a
	ret

Unknown_0x43747:
	jp Logged_0x3173

UnknownData_0x4374A:
INCBIN "baserom.gbc", $4374A, $4379B - $4374A
	ld de,$58AE
	jr Logged_0x437A8
	ld de,$58AB
	jr Logged_0x437A8
	ld de,$58A8

Logged_0x437A8:
	call Logged_0x30F0
	ld hl,$D100
	res 4,[hl]
	set 3,[hl]
	ld l,$1F
	ld a,$77
	ld [hld],a
	ld a,$D6
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$EA
	ld [hld],a
	ld a,$FE
	ld [hl],a
	ld a,[$CAC1]
	and a
	ret z
	ld a,$20
	ld [$D118],a
	jp Logged_0x3076
	ret
	ld hl,$D100
	res 4,[hl]
	set 3,[hl]
	ld l,$1F
	ld a,$78
	ld [hld],a
	ld a,$0E
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld a,[$D107]
	cp $0A
	jr nz,Logged_0x437F5
	res 7,[hl]
	jr Logged_0x437F7

Logged_0x437F5:
	set 7,[hl]

Logged_0x437F7:
	ld l,$0A
	ld a,$FC
	ld [hli],a
	ld a,$FD
	ld [hli],a
	ld a,$02
	ld [hl],a
	ld de,$58FF
	call Logged_0x30F0
	ld a,$3C
	ld [hli],a
	xor a
	ld [hl],a
	ret
	ld a,[$D117]
	rst JumpList
	dw Logged_0x4382E
	dw Logged_0x43876
	dw Logged_0x438A0
	dw Logged_0x438C5
	dw Logged_0x438EA
	dw Logged_0x43910
	dw Logged_0x43936
	dw Logged_0x43956
	dw Logged_0x4396E
	dw Logged_0x43994
	dw Logged_0x439BA
	dw Logged_0x439E0
	dw Logged_0x43A06
	dw Logged_0x43A2C

Logged_0x4382E:
	ld a,$81
	ld [$D11C],a
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$79
	ld [$FF00+$B6],a
	ld a,$0C
	ld [$D118],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x43857
	call Logged_0x305C
	ld de,$58D8
	ld a,$FF
	ld c,$02
	jr Logged_0x43861

Logged_0x43857:
	call Logged_0x3069
	ld de,$58B1
	ld a,$FD
	ld c,$00

Logged_0x43861:
	ld l,$08
	ld a,[hl]
	and $80
	or $05
	ld [hld],a
	ld b,$02

Logged_0x4386B:
	ld l,$0B
	ld [hli],a
	ld [hl],c

Logged_0x4386F:
	call Logged_0x30F0
	ld a,b
	ld [hli],a
	inc [hl]
	ret

Logged_0x43876:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$04
	ld [$D118],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x43892
	call Logged_0x305C
	ld de,$58DB
	ld a,$FC
	ld c,$07
	jr Logged_0x4389C

Logged_0x43892:
	call Logged_0x3069
	ld de,$58B4
	ld a,$F8
	ld c,$03

Logged_0x4389C:
	ld b,$02
	jr Logged_0x4386B

Logged_0x438A0:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x438B7
	call Logged_0x305C
	ld de,$58DE
	ld a,$F8
	ld c,$0B
	jr Logged_0x438C1

Logged_0x438B7:
	call Logged_0x3069
	ld de,$58B7
	ld a,$F4
	ld c,$07

Logged_0x438C1:
	ld b,$02
	jr Logged_0x4386B

Logged_0x438C5:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x438DC
	call Logged_0x305C
	ld de,$58E1
	ld a,$F4
	ld c,$0F
	jr Logged_0x438E6

Logged_0x438DC:
	call Logged_0x3069
	ld de,$58BA
	ld a,$F0
	ld c,$0B

Logged_0x438E6:
	ld b,$02
	jr Logged_0x4386B

Logged_0x438EA:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x43901
	call Logged_0x305C
	ld de,$58E4
	ld a,$F0
	ld c,$13
	jr Logged_0x4390B

Logged_0x43901:
	call Logged_0x3069
	ld de,$58BD
	ld a,$EC
	ld c,$0F

Logged_0x4390B:
	ld b,$02
	jp Logged_0x4386B

Logged_0x43910:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x43927
	call Logged_0x305C
	ld de,$58E7
	ld a,$EC
	ld c,$17
	jr Logged_0x43931

Logged_0x43927:
	call Logged_0x3069
	ld de,$58C0
	ld a,$E8
	ld c,$13

Logged_0x43931:
	ld b,$14
	jp Logged_0x4386B

Logged_0x43936:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x43946
	ld de,$58EA
	jr Logged_0x43949

Logged_0x43946:
	ld de,$58C3

Logged_0x43949:
	ld l,$08
	ld a,[hl]
	and $80
	or $0B
	ld [hld],a
	ld b,$08
	jp Logged_0x4386F

Logged_0x43956:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x43966
	ld de,$58ED
	jr Logged_0x43969

Logged_0x43966:
	ld de,$58C6

Logged_0x43969:
	ld b,$14
	jp Logged_0x4386F

Logged_0x4396E:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x43985
	call Logged_0x3069
	ld de,$58F0
	ld a,$F0
	ld c,$13
	jr Logged_0x4398F

Logged_0x43985:
	call Logged_0x305C
	ld de,$58C9
	ld a,$EC
	ld c,$0F

Logged_0x4398F:
	ld b,$02
	jp Logged_0x4386B

Logged_0x43994:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x439AB
	call Logged_0x3069
	ld de,$58F3
	ld a,$F4
	ld c,$0F
	jr Logged_0x439B5

Logged_0x439AB:
	call Logged_0x305C
	ld de,$58CC
	ld a,$F0
	ld c,$0B

Logged_0x439B5:
	ld b,$02
	jp Logged_0x4386B

Logged_0x439BA:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x439D1
	call Logged_0x3069
	ld de,$58F6
	ld a,$F8
	ld c,$0B
	jr Logged_0x439DB

Logged_0x439D1:
	call Logged_0x305C
	ld de,$58CF
	ld a,$F4
	ld c,$07

Logged_0x439DB:
	ld b,$02
	jp Logged_0x4386B

Logged_0x439E0:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x439F7
	call Logged_0x3069
	ld de,$58F9
	ld a,$FC
	ld c,$07
	jr Logged_0x43A01

Logged_0x439F7:
	call Logged_0x305C
	ld de,$58D2
	ld a,$F8
	ld c,$03

Logged_0x43A01:
	ld b,$02
	jp Logged_0x4386B

Logged_0x43A06:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x43A1D
	call Logged_0x3069
	ld de,$58FC
	ld a,$FF
	ld c,$02
	jr Logged_0x43A27

Logged_0x43A1D:
	call Logged_0x305C
	ld de,$58D5
	ld a,$FD
	ld c,$00

Logged_0x43A27:
	ld b,$02
	jp Logged_0x4386B

Logged_0x43A2C:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$0C
	ld [$D118],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x43A42
	call Logged_0x3069
	jp Logged_0x437F7

Logged_0x43A42:
	call Logged_0x305C
	jp Logged_0x437F7

UnknownData_0x43A48:
INCBIN "baserom.gbc", $43A48, $44000 - $43A48

SECTION "Bank11", ROMX, BANK[$11]

LoggedData_0x44000:
INCBIN "baserom.gbc", $44000, $4404F - $44000

UnknownData_0x4404F:
INCBIN "baserom.gbc", $4404F, $44050 - $4404F

LoggedData_0x44050:
INCBIN "baserom.gbc", $44050, $4407F - $44050

UnknownData_0x4407F:
INCBIN "baserom.gbc", $4407F, $44080 - $4407F
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$41
	ld [hld],a
	ld a,$A5
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$03
	ld [hld],a
	ld a,$EC
	ld [hld],a
	ld a,$00
	ld [hld],a
	ld l,$1B
	jp Logged_0x441DC
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$40
	ld [hld],a
	ld a,$F4
	ld [hld],a
	ld de,$4AC6
	call Logged_0x30F0
	ld l,$1A
	res 5,[hl]
	ld l,$0C
	ld a,$03
	ld [hld],a
	ld a,$EC
	ld [hld],a
	ld a,$00
	ld [hld],a
	ret

Unknown_0x440C4:
	ld a,$33
	ld c,$F8
	jr Logged_0x440DA

Unknown_0x440CA:
	ld a,$34
	ld c,$07
	jr Logged_0x440DA

Unknown_0x440D0:
	ld a,$33
	ld c,$26
	jr Logged_0x440DA

Logged_0x440D6:
	ld a,$33
	ld c,$17

Logged_0x440DA:
	ld l,$1F
	ld [hld],a
	ld [hl],c
	ld l,$1A
	ld a,[hl]
	and $F0
	ld [hld],a
	xor a
	ld [hld],a
	ld a,$01
	ld [hld],a
	ld a,$81
	ld [$D11C],a
	ld de,$4AE6
	jp Logged_0x30F0
	ld hl,$D11B
	ld a,[hl]
	and a
	jr nz,Logged_0x44113
	ld l,$00
	bit 5,[hl]
	jp z,Logged_0x44185
	res 5,[hl]
	ld a,$5A
	ld [$D11B],a
	ld de,$4ADD
	call Logged_0x30F0
	ld a,$6F
	ld [hli],a
	ret

Logged_0x44113:
	cp $1B
	jp z,Logged_0x3272
	cp $41
	jp z,Logged_0x329F
	cp $13
	jr z,Logged_0x44144
	cp $11
	jr z,Logged_0x44151
	cp $5A
	jr z,Unknown_0x44158
	cp $3B
	jr z,Logged_0x44161
	cp $28
	jr z,Unknown_0x440C4
	cp $29
	jr z,Unknown_0x440CA
	cp $04
	jr z,Unknown_0x440D0
	cp $05
	jr z,Logged_0x440D6
	cp $0A
	jp z,Logged_0x4420A
	jr Logged_0x44172

Logged_0x44144:
	ld l,$1F
	ld a,$41
	ld [hld],a
	ld a,$A5
	ld [hld],a
	ld l,$1B
	jp Logged_0x441DC

Logged_0x44151:
	ld a,$41
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ret

Unknown_0x44158:
	ld l,$00
	bit 5,[hl]
	jr z,Logged_0x44166
	res 5,[hl]
	ret

Logged_0x44161:
	ld l,$16
	dec [hl]
	jr nz,Logged_0x44185

Logged_0x44166:
	xor a
	ld [$D11B],a
	ld de,$4AC6
	call Logged_0x30F0
	jr Logged_0x44185

Logged_0x44172:
	ld a,$3B
	ld [$D11B],a
	ld de,$4AF2
	call Logged_0x30F0
	ld a,$28
	ld [hli],a
	ld l,$00
	res 3,[hl]
	ret

Logged_0x44185:
	ld a,[$CA97]
	cp $10
	ret c
	ld l,$1B
	ld a,$1B
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld de,$4AE6
	call Logged_0x30F0
	ld a,$0D
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $0B
	ld [hli],a
	ret
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x44185
	cp $11
	jr z,Logged_0x44151
	cp $1B
	jp z,Logged_0x3272
	cp $41
	jp z,Logged_0x329F
	cp $28
	jp z,Unknown_0x440C4
	cp $29
	jp z,Unknown_0x440CA
	cp $04
	jp z,Unknown_0x440D0
	cp $05
	jp z,Logged_0x440D6
	cp $13
	jr z,Logged_0x441DC
	cp $43
	jr z,Logged_0x441F8
	cp $0A
	jr z,Logged_0x4420A
	xor a
	ld [hl],a

Logged_0x441DC:
	ld a,$43
	ld [hl],a
	ld de,$4B01
	call Logged_0x30F0
	ld a,$49
	ld [hli],a
	ld l,$00
	res 3,[hl]
	ld l,$08
	ld a,[hl]
	and $80
	or $3E
	ld [hli],a
	ld a,$E6
	ld [hl],a
	ret

Logged_0x441F8:
	ld l,$16
	dec [hl]
	jr nz,Logged_0x44185
	xor a
	ld [$D11B],a
	ld de,$4AE9
	call Logged_0x30F0
	jp Logged_0x44185

Logged_0x4420A:
	ld l,$1F
	ld a,$42
	ld [hld],a
	ld a,$20
	ld [hld],a
	ld de,$4AE6
	call Logged_0x30F0
	ld a,$10
	ld [hli],a
	xor a
	ld [$D119],a
	ret
	ld a,$81
	ld [$D11C],a
	ld bc,$4040
	call Logged_0x34B7
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$08
	ld [$D118],a
	call Logged_0x305C
	jp Logged_0x3182
	ld hl,$D11F
	ld a,$42
	ld [hld],a
	ld a,$45
	ld [hld],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$42
	ld [hld],a
	ld a,$59
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	jp Logged_0x4434F
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x4434F
	dw Logged_0x4446C
	dw Logged_0x445C1
	dw Logged_0x445C9
	dw Logged_0x447D5
	dw Logged_0x447F9
	dw Logged_0x44839
	dw Logged_0x4484C
	dw Logged_0x4472F
	dw Logged_0x44739
	dw Logged_0x44317
	dw Logged_0x4476B
	dw Logged_0x44778
	dw Logged_0x4434F
	dw Logged_0x4434F
	dw Logged_0x44692
	dw Logged_0x446BB
	dw Logged_0x4438B
	dw Logged_0x448C2
	dw Logged_0x446D6
	dw Logged_0x4465D
	dw Logged_0x44665
	dw Logged_0x445F7
	dw Logged_0x4462A
	dw Logged_0x44890
	dw Logged_0x4485F
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x4434F
	dw Logged_0x4434F
	dw Logged_0x4434F
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Unknown_0x447CB
	dw Unknown_0x447C1
	dw Logged_0x4434F
	dw Logged_0x4434F
	dw Logged_0x4434F
	dw Logged_0x443A7
	dw Logged_0x443BF
	dw Logged_0x4434F
	dw Logged_0x3290
	dw Logged_0x4448C
	dw Logged_0x33DA
	dw Logged_0x33E9
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x4434F
	dw Logged_0x4479D
	dw Logged_0x447AF
	dw Logged_0x4434F
	dw Logged_0x4434F
	dw Logged_0x446A1
	dw Logged_0x446C9
	dw Logged_0x329F
	dw Logged_0x3371
	dw Logged_0x44703
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x4461C
	dw Logged_0x4464F
	dw Logged_0x448B1
	dw Logged_0x44880
	dw Logged_0x3380
	dw Logged_0x338F
	dw Logged_0x33BC
	dw Logged_0x33CB
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x4434F
	dw Logged_0x4434F
	dw Logged_0x4434F

Logged_0x44317:
	ld a,[$D11C]
	and a
	jp z,Logged_0x3182
	ld a,[$CA8E]
	and a
	jp nz,Logged_0x3182
	ld a,[$D14A]
	cp $06
	jp nc,Logged_0x3182
	ld a,[$D108]
	and $7F
	jp z,Logged_0x3182
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$14
	ld [$FF00+$B6],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jp nc,Logged_0x4472F
	jp Logged_0x44739

Logged_0x4434F:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld l,$1B
	ld a,$30
	ld [hld],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x4437F
	res 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4B12
	call Logged_0x30F0
	ret

Logged_0x4437F:
	set 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4B17
	call Logged_0x30F0
	ret

Logged_0x4438B:
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4439E
	xor a
	ld [hld],a
	ld de,$4B12
	call Logged_0x30F0
	ret

Logged_0x4439E:
	xor a
	ld [hld],a
	ld de,$4B17
	call Logged_0x30F0
	ret

Logged_0x443A7:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x443B4
	ld a,$1A
	ld [$D11B],a
	ret

Logged_0x443B4:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$2E
	ld [$D11B],a
	ret

Logged_0x443BF:
	ld a,[$C08F]
	ld b,a
	and $0F
	jr nz,Logged_0x443CF
	ld a,$02
	ld [$FF00+$B5],a
	ld a,$07
	ld [$FF00+$B6],a

Logged_0x443CF:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x443DC
	ld a,$1A
	ld [$D11B],a
	ret

Logged_0x443DC:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x443F7
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x443F7:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x44438
	ld a,[hl]
	and $0F
	sub $10
	jr nc,Logged_0x44414
	call Logged_0x355B
	and $0F
	jr z,Logged_0x44432

Logged_0x44414:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $10
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30CA

Logged_0x44432:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x44438:
	ld a,[hl]
	and $0F
	add a,$0F
	cp $10
	jr c,Logged_0x44448
	call Logged_0x3573
	and $0F
	jr z,Logged_0x44466

Logged_0x44448:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$0F
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30BD

Logged_0x44466:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x4446C:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x44485
	ld de,$4B12
	call Logged_0x30F0
	ret

Logged_0x44485:
	ld de,$4B17
	call Logged_0x30F0
	ret

Logged_0x4448C:
	ld hl,$D100
	bit 1,[hl]
	jr z,Logged_0x444A3
	ld a,[$C08F]
	ld b,a
	and $1F
	jr nz,Logged_0x444A3
	ld a,$02
	ld [$FF00+$B5],a
	ld a,$07
	ld [$FF00+$B6],a

Logged_0x444A3:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x444B0
	ld a,$1A
	ld [$D11B],a
	ret

Logged_0x444B0:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x444CB
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x444CB:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld c,$2A
	ld a,[$D11A]
	rlca
	jp c,Logged_0x4454E
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $18
	jr c,Logged_0x444EF
	cp $E8
	jr c,Logged_0x4451C

Logged_0x444EF:
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $40
	jr nc,Logged_0x4451C
	ld de,$4B1C
	call Logged_0x30F0
	ld a,$14
	ld [hli],a
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F0
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $20
	ld [hld],a
	ld l,$1B
	ld a,$2D
	ld [hld],a
	ret

Logged_0x4451C:
	ld a,[hl]
	and $0F
	sub $08
	jr nc,Logged_0x4452A
	call Logged_0x355B
	and $0F
	jr z,Logged_0x44548

Logged_0x4452A:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $08
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30C5

Logged_0x44548:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x4454E:
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $18
	jr c,Logged_0x44560
	cp $E8
	jr c,Logged_0x4458D

Logged_0x44560:
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $C0
	jr c,Logged_0x4458D
	ld de,$4B25
	call Logged_0x30F0
	ld a,$14
	ld [hli],a
	ld l,$0C
	ld a,$0F
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $20
	ld [hld],a
	ld l,$1B
	ld a,$2D
	ld [hld],a
	ret

Logged_0x4458D:
	ld a,[hl]
	and $0F
	add a,$07
	cp $10
	jr c,Logged_0x4459D
	call Logged_0x3573
	and $0F
	jr z,Logged_0x445BB

Logged_0x4459D:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$07
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30B8

Logged_0x445BB:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x445C1:
	ld hl,$D11B
	ld a,$32
	ld [hld],a
	jr Logged_0x445CF

Logged_0x445C9:
	ld hl,$D11B
	ld a,$33
	ld [hld],a

Logged_0x445CF:
	ld a,[hld]
	rlca
	jr c,Logged_0x445D8
	ld de,$4B58
	jr Logged_0x445DB

Logged_0x445D8:
	ld de,$4B5B

Logged_0x445DB:
	call Logged_0x30F0
	ld a,$0C
	ld [hld],a
	ld a,$02
	ld [$D118],a
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ret

Logged_0x445F7:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x44606
	ld de,$4B2E
	jr Logged_0x44609

Logged_0x44606:
	ld de,$4B37

Logged_0x44609:
	call Logged_0x30F0
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x4461C:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x4462A:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x44639
	ld de,$4B2E
	jr Logged_0x4463C

Logged_0x44639:
	ld de,$4B37

Logged_0x4463C:
	call Logged_0x30F0
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x4464F:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x4465D:
	ld hl,$D11B
	ld a,$44
	ld [hld],a
	jr Logged_0x4466B

Logged_0x44665:
	ld hl,$D11B
	ld a,$45
	ld [hld],a

Logged_0x4466B:
	ld a,[hld]
	rlca
	jr c,Logged_0x44674
	ld de,$4B2E
	jr Logged_0x44677

Logged_0x44674:
	ld de,$4B37

Logged_0x44677:
	call Logged_0x30F0
	inc l
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x44692:
	ld a,$3F
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld hl,$D100
	res 2,[hl]

Logged_0x446A1:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x446AE
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x446AE:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x446BB:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld a,$07
	ld [$D116],a

Logged_0x446C9:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32F9
	ld a,$00
	ld [$D11B],a
	ret

Logged_0x446D6:
	ld hl,$D11B
	ld a,$43
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x446E5
	ld de,$4B4A
	jr Logged_0x446E8

Logged_0x446E5:
	ld de,$4B51

Logged_0x446E8:
	call Logged_0x30F0
	ld a,$1A
	ld [hli],a
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$00
	set 7,[hl]
	ret

Logged_0x44703:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x44710
	ld a,$1A
	ld [$D11B],a
	ret

Logged_0x44710:
	ld hl,$D116
	ld a,[hl]
	cp $09
	jr z,Logged_0x44722
	dec [hl]
	jp nz,Logged_0x3308
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x44722:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x4472C
	set 7,[hl]
	ret

Logged_0x4472C:
	res 7,[hl]
	ret

Logged_0x4472F:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x44741

Logged_0x44739:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x44741:
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4474B
	ld de,$4B2E
	jr Logged_0x4474E

Logged_0x4474B:
	ld de,$4B37

Logged_0x4474E:
	call Logged_0x30F0
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x4476B:
	ld a,$3B
	ld [$D11B],a
	ld bc,$48F0
	ld de,$4B5E
	jr Logged_0x44783

Logged_0x44778:
	ld a,$3C
	ld [$D11B],a
	ld bc,$4905
	ld de,$4B61

Logged_0x44783:
	call Logged_0x30F0
	ld a,$14
	ld [hli],a
	ld a,$02
	ld [$D118],a
	ld l,$00
	res 7,[hl]
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$49
	ld [$FF00+$B6],a
	jp Logged_0x3416

Logged_0x4479D:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld l,$16
	dec [hl]
	ret nz
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x447AF:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld l,$16
	dec [hl]
	ret nz
	ld a,$13
	ld [$D11B],a
	ret

Unknown_0x447C1:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Logged_0x4481B

Unknown_0x447CB:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Logged_0x4481B

Logged_0x447D5:
	ld a,[$CA8E]
	and a
	jr nz,Logged_0x447EF
	ld a,[$D14A]
	cp $05
	jr nc,Logged_0x447EF
	ld a,[$D108]
	and $7F
	jr z,Logged_0x447EF
	ld a,$08
	ld [$D11B],a
	ret

Logged_0x447EF:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$01
	jr Logged_0x4481B

Logged_0x447F9:
	ld a,[$CA8E]
	and a
	jr nz,Logged_0x44813
	ld a,[$D14A]
	cp $05
	jr nc,Logged_0x44813
	ld a,[$D108]
	and $7F
	jr z,Logged_0x44813
	ld a,$09
	ld [$D11B],a
	ret

Logged_0x44813:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$01

Logged_0x4481B:
	ld a,$81
	ld [$D11C],a
	ld a,[hl]
	and $F0
	ld [hld],a
	ld c,a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld a,c
	rlca
	jr c,Logged_0x44833
	ld de,$4B40
	jp Logged_0x30F0

Logged_0x44833:
	ld de,$4B45
	jp Logged_0x30F0

Logged_0x44839:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Logged_0x4484C:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Logged_0x4485F:
	ld hl,$D11B
	ld a,$49
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4486E
	ld de,$4B2E
	jr Logged_0x44871

Logged_0x4486E:
	ld de,$4B37

Logged_0x44871:
	call Logged_0x30F0
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x44880:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Logged_0x44890

Logged_0x44890:
	ld hl,$D11B
	ld a,$48
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4489F
	ld de,$4B2E
	jr Logged_0x448A2

Logged_0x4489F:
	ld de,$4B37

Logged_0x448A2:
	call Logged_0x30F0
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x448B1:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Logged_0x4485F

Logged_0x448C2:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret
	ld hl,$D11F
	ld a,$48
	ld [hld],a
	ld a,$E1
	ld [hld],a
	ret
	ld a,[$CA8E]
	cp $53
	jr z,Logged_0x448ED
	ld hl,$D100
	res 4,[hl]

Logged_0x448ED:
	ld hl,$D11F
	ld a,$49
	ld [hld],a
	ld a,$03
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld a,[hl]
	and $F0
	or $08
	ld [hl],a
	jp Logged_0x44A72
	ld hl,$D100
	ld a,[$CA8E]
	cp $53
	jr nz,Logged_0x44911
	set 4,[hl]
	jr Logged_0x44913

Logged_0x44911:
	res 4,[hl]

Logged_0x44913:
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x44A72
	dw Logged_0x44A97
	dw Logged_0x44C3F
	dw Logged_0x44C49
	dw Logged_0x44C84
	dw Unknown_0x44C8E
	dw Unknown_0x44CAA
	dw Unknown_0x44CBD
	dw Logged_0x44C3F
	dw Logged_0x44C49
	dw Logged_0x3182
	dw Logged_0x44A72
	dw Logged_0x44A72
	dw Logged_0x44A72
	dw Logged_0x449D1
	dw Logged_0x44BE1
	dw Logged_0x44C12
	dw Logged_0x44A72
	dw Unknown_0x44D27
	dw Logged_0x44A72
	dw Logged_0x44BB9
	dw Logged_0x44BC0
	dw Logged_0x44B61
	dw Logged_0x44B8D
	dw Unknown_0x44CFF
	dw Unknown_0x44CD0
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x44A72
	dw Logged_0x44A72
	dw Logged_0x44A72
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Unknown_0x44C7A
	dw Unknown_0x44C70
	dw Logged_0x44A72
	dw Logged_0x44A72
	dw Logged_0x44A72
	dw Logged_0x44A09
	dw Logged_0x44A25
	dw Logged_0x44A5D
	dw Logged_0x3290
	dw Logged_0x44AC1
	dw Logged_0x33DA
	dw Logged_0x33E9
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x44A72
	dw Logged_0x44A72
	dw Logged_0x44A72
	dw Logged_0x44A72
	dw Logged_0x44A72
	dw Logged_0x44BF8
	dw Logged_0x44C32
	dw Logged_0x329F
	dw Logged_0x3371
	dw Logged_0x44A72
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x44B7F
	dw Logged_0x44BAB
	dw Unknown_0x44D16
	dw Unknown_0x44CEF
	dw Logged_0x3380
	dw Logged_0x338F
	dw Logged_0x33BC
	dw Logged_0x33CB
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x44B2D
	dw Logged_0x449D7
	dw Logged_0x44A72

Logged_0x449D1:
	ld a,$5B
	ld [$D11B],a
	ret

Logged_0x449D7:
	ld a,$81
	ld [$D11C],a
	ld a,[$CA8E]
	cp $53
	jr nz,Logged_0x449FF
	ld hl,$D100
	res 4,[hl]
	ld l,$03
	ld a,[$CA62]
	sub $0C
	ld [hli],a
	ld a,[$CA61]
	sbc a,$00
	ld [hli],a
	ld a,[$CA64]
	ld [hli],a
	ld a,[$CA63]
	ld [hli],a
	ret

Logged_0x449FF:
	ld a,[$CA69]
	and a
	jp z,Logged_0x44C3F
	jp Logged_0x44C49

Logged_0x44A09:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$2E
	ld [$D11B],a
	ld de,$4B8B
	call Logged_0x30F0
	ld a,$28
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $38
	ld [hli],a
	ret

Logged_0x44A25:
	ld hl,$D116
	dec [hl]
	jr z,Logged_0x44A46
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr z,Logged_0x44A43
	jr c,Logged_0x44A40
	call Logged_0x30CA
	jr Logged_0x44A43

Logged_0x44A40:
	call Logged_0x30BD

Logged_0x44A43:
	jp Logged_0x30A4

Logged_0x44A46:
	ld a,$2F
	ld [$D11B],a
	ld de,$4BAE
	call Logged_0x30F0
	ld a,$50
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hli],a
	ret

Logged_0x44A5D:
	ld hl,$D116
	ld a,[hl]
	cp $3C
	jr nz,Logged_0x44A6B
	ld de,$4B90
	call Logged_0x30F0

Logged_0x44A6B:
	dec [hl]
	jp nz,Logged_0x30E6
	jp Logged_0x44B4C

Logged_0x44A72:
	ld hl,$D10C
	ld a,$06
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld a,$F1
	ld [hld],a
	ld a,$EC
	ld [hld],a
	ld l,$1A
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x44A95
	res 7,[hl]
	jr Logged_0x44A97

Logged_0x44A95:
	set 7,[hl]

Logged_0x44A97:
	ld hl,$D11B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x44AA6
	ld de,$4B64
	jr Logged_0x44AA9

Logged_0x44AA6:
	ld de,$4B6D

Logged_0x44AA9:
	xor a
	ld [hld],a
	call Logged_0x30F0
	inc l
	ld a,$32
	ld [hl],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hli],a
	ld a,$EC
	ld [hli],a
	ld a,$F1
	ld [hl],a
	ret

Logged_0x44AC1:
	ld a,[$CA8E]
	cp $53
	jr z,Logged_0x44AFD
	ld c,$2A
	ld a,[$D10D]
	add a,c
	ld b,a
	ld a,[$CA87]
	add a,c
	sub b
	cp $18
	jr c,Logged_0x44AFD
	cp $80
	jr nc,Logged_0x44AFD
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $E8
	jr nc,Logged_0x44AEE
	cp $18
	jr nc,Logged_0x44AFD

Logged_0x44AEE:
	ld a,$2D
	ld [$D11B],a
	ld de,$4B84
	call Logged_0x30F0
	ld a,$14
	ld [hli],a
	ret

Logged_0x44AFD:
	ld bc,$44C0
	call Logged_0x3489
	ld hl,$D117
	ld a,[$D11A]
	rlca
	jr c,Logged_0x44B17
	dec [hl]
	ld a,[hl]
	and a
	jp nz,Logged_0x30CA
	ld de,$4B76
	jr Logged_0x44B21

Logged_0x44B17:
	inc [hl]
	ld a,[hl]
	cp $64
	jp nz,Logged_0x30BD
	ld de,$4B7D

Logged_0x44B21:
	call Logged_0x30F0
	ld a,$1A
	ld [hli],a
	ld a,$5A
	ld [$D11B],a
	ret

Logged_0x44B2D:
	ld bc,$44C0
	call Logged_0x3489
	ld hl,$D116
	ld a,[hl]
	cp $09
	jr z,Logged_0x44B3F
	dec [hl]
	jr z,Logged_0x44B4C
	ret

Logged_0x44B3F:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x44B49
	set 7,[hl]
	ret

Logged_0x44B49:
	res 7,[hl]
	ret

Logged_0x44B4C:
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x44B5B
	ld de,$4B64
	jp Logged_0x30F0

Logged_0x44B5B:
	ld de,$4B6D
	jp Logged_0x30F0

Logged_0x44B61:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	call Logged_0x30FB
	ld a,[hl]
	and $0F
	dec a
	jp z,Logged_0x3182
	ld de,$4BA5
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x44B7F:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x44B8D:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	call Logged_0x30FB
	ld a,[hl]
	and $0F
	dec a
	jp z,Logged_0x3182
	ld de,$4BA5
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x44BAB:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x44BB9:
	ld a,$44
	ld [$D11B],a
	jr Logged_0x44BC5

Logged_0x44BC0:
	ld a,$45
	ld [$D11B],a

Logged_0x44BC5:
	ld de,$4BA5
	call Logged_0x30F0
	ld l,$18
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hli],a
	ld a,$F9
	ld [hli],a
	ld a,$FF
	ld [hl],a
	ret

Logged_0x44BE1:
	ld a,$3F
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld hl,$D100
	res 2,[hl]
	ld l,$1A
	ld a,[hl]
	and $F0
	or $08
	ld [hl],a

Logged_0x44BF8:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x44C05
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x44C05:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x44C12:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld de,$4B99
	call Logged_0x30F0
	ld a,$50
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hli],a
	ld a,$EC
	ld [hli],a
	ld a,$F1
	ld [hl],a

Logged_0x44C32:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x30E6
	ld a,$00
	ld [$D11B],a
	ret

Logged_0x44C3F:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x44C51

Logged_0x44C49:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x44C51:
	ld [hld],a
	ld de,$4BA5
	call Logged_0x30F0
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hli],a
	ld a,$F9
	ld [hli],a
	ld a,$FF
	ld [hl],a
	ret

Unknown_0x44C70:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Logged_0x44C96

Unknown_0x44C7A:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Logged_0x44C96

Logged_0x44C84:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$02
	jr Logged_0x44C96

Unknown_0x44C8E:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$02

Logged_0x44C96:
	ld a,[hl]
	and $F0
	ld [hld],a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld de,$4BA2
	call Logged_0x30F0
	ld a,$81
	ld [$D11C],a
	ret

Unknown_0x44CAA:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Unknown_0x44CBD:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Unknown_0x44CD0:
	ld a,$49
	ld [$D11B],a
	ld de,$4BA5
	call Logged_0x30F0
	ld l,$09
	ld a,$F9
	ld [hli],a
	ld a,$FF
	ld [hl],a
	ld l,$00
	set 2,[hl]
	ld l,$1A
	ld a,[hl]
	and $F0
	or $08
	ld [hl],a

Unknown_0x44CEF:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Unknown_0x44CFF

Unknown_0x44CFF:
	ld a,$48
	ld [$D11B],a
	ld de,$4BA5
	call Logged_0x30F0
	ld l,$09
	ld a,$F9
	ld [hli],a
	ld a,$FF
	ld [hl],a
	ld l,$00
	set 2,[hl]

Unknown_0x44D16:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Unknown_0x44CD0

Unknown_0x44D27:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret
	ld hl,$D11F
	ld a,$4D
	ld [hld],a
	ld a,$46
	ld [hld],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$4D
	ld [hld],a
	ld a,$5A
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	jp Logged_0x44FD9
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x44FD9
	dw Logged_0x45034
	dw Logged_0x45140
	dw Logged_0x45186
	dw Unknown_0x45342
	dw Unknown_0x45366
	dw Unknown_0x453A6
	dw Unknown_0x453B9
	dw Logged_0x452F7
	dw Unknown_0x45301
	dw Unknown_0x44E18
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x4526B
	dw Logged_0x45294
	dw Logged_0x45018
	dw Unknown_0x45425
	dw Logged_0x452AF
	dw Unknown_0x4523B
	dw Unknown_0x45243
	dw Unknown_0x451E5
	dw Logged_0x45210
	dw Unknown_0x453F8
	dw Unknown_0x453CC
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Unknown_0x45338
	dw Unknown_0x4532E
	dw Logged_0x44FD9
	dw Logged_0x44EAA
	dw Logged_0x44F89
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x3290
	dw Logged_0x45054
	dw Logged_0x4515D
	dw Logged_0x451BC
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x44FD9
	dw Logged_0x4527A
	dw Logged_0x452A2
	dw Logged_0x329F
	dw Logged_0x3371
	dw Logged_0x452CB
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Unknown_0x45202
	dw Logged_0x4522D
	dw Unknown_0x45414
	dw Unknown_0x453E8
	dw Logged_0x3380
	dw Logged_0x338F
	dw Logged_0x33BC
	dw Logged_0x33CB
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x44E50
	dw Logged_0x44EDA
	dw Logged_0x44FBF

Unknown_0x44E18:
	ld a,[$D11C]
	and a
	jp z,Logged_0x3182
	ld a,[$CA8E]
	and a
	jp nz,Logged_0x3182
	ld a,[$D14A]
	cp $06
	jp nc,Logged_0x3182
	ld a,[$D108]
	and $7F
	jp z,Logged_0x3182
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$14
	ld [$FF00+$B6],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jp nc,Logged_0x452F7
	jp Unknown_0x45301

Logged_0x44E50:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x44E5D
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x44E5D:
	ld hl,$D116
	ld a,[hl]
	cp $18
	jr z,Logged_0x44E86
	dec [hl]
	jp nz,Logged_0x3308
	ld l,$1B
	ld a,$2B
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x44E7C
	ld de,$4C25
	call Logged_0x30F0
	ld a,$1C
	ld [hli],a
	ret

Logged_0x44E7C:
	ld de,$4C2C
	call Logged_0x30F0
	ld a,$1C
	ld [hli],a
	ret

Logged_0x44E86:
	dec [hl]
	ld l,$00
	bit 1,[hl]
	jr z,Logged_0x44E95
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$67
	ld [$FF00+$B6],a

Logged_0x44E95:
	ld l,$1B
	ld a,$5A
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x44EA4
	ld bc,$4872
	jp Logged_0x3416

Logged_0x44EA4:
	ld bc,$4887
	jp Logged_0x3416

Logged_0x44EAA:
	ld hl,$D116
	ld a,[hl]
	cp $08
	jr z,Logged_0x44ECD
	dec [hl]
	jp nz,Logged_0x3308
	ld l,$1B
	ld a,$5B
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x44EC6
	ld de,$4BD1
	call Logged_0x30F0
	ret

Logged_0x44EC6:
	ld de,$4BDA
	call Logged_0x30F0
	ret

Logged_0x44ECD:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x44ED7
	set 7,[hl]
	ret

Logged_0x44ED7:
	res 7,[hl]
	ret

Logged_0x44EDA:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x44EE7
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x44EE7:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x44F02
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x44F02:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x44F4C
	ld a,[hl]
	and $0F
	sub $07
	jr nc,Logged_0x44F1F
	call Logged_0x355B
	and $0F
	jr z,Logged_0x44F3D

Logged_0x44F1F:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $07
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30CA

Logged_0x44F3D:
	ld a,$2C
	ld [$D11B],a
	ld de,$4C25
	call Logged_0x30F0
	ld a,$1C
	ld [hli],a
	ret

Logged_0x44F4C:
	ld a,[hl]
	and $0F
	add a,$06
	cp $10
	jr c,Logged_0x44F5C
	call Logged_0x3573
	and $0F
	jr z,Logged_0x44F7A

Logged_0x44F5C:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$06
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30BD

Logged_0x44F7A:
	ld a,$2C
	ld [$D11B],a
	ld de,$4C2C
	call Logged_0x30F0
	ld a,$1C
	ld [hli],a
	ret

Logged_0x44F89:
	ld hl,$D116
	ld a,[hl]
	cp $08
	jr z,Logged_0x44FB2
	dec [hl]
	jp nz,Logged_0x3308
	ld l,$1B
	ld a,$5C
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x44FA8
	ld de,$4BFF
	call Logged_0x30F0
	ld a,$3F
	ld [hli],a
	ret

Logged_0x44FA8:
	ld de,$4C08
	call Logged_0x30F0
	ld a,$3F
	ld [hli],a
	ret

Logged_0x44FB2:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x44FBC
	set 7,[hl]
	ret

Logged_0x44FBC:
	res 7,[hl]
	ret

Logged_0x44FBF:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x44FCC
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x44FCC:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x3308
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x44FD9:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$0C
	ld a,$06
	ld [hld],a
	ld a,$F9
	ld [hld],a
	ld a,$FF
	ld [hl],a
	ld l,$1B
	ld a,$30
	ld [hld],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x4500C
	res 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4BB5
	call Logged_0x30F0
	ret

Logged_0x4500C:
	set 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4BBE
	call Logged_0x30F0
	ret

Logged_0x45018:
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4502B
	xor a
	ld [hld],a
	ld de,$4BB5
	call Logged_0x30F0
	ret

Logged_0x4502B:
	xor a
	ld [hld],a
	ld de,$4BBE
	call Logged_0x30F0
	ret

Logged_0x45034:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4504D
	ld de,$4BB5
	call Logged_0x30F0
	ret

Logged_0x4504D:
	ld de,$4BBE
	call Logged_0x30F0
	ret

Logged_0x45054:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x45061
	ld a,$1A
	ld [$D11B],a
	ret

Logged_0x45061:
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $20
	jr c,Logged_0x45075
	cp $E0
	jr c,Logged_0x450B0

Logged_0x45075:
	ld hl,$D11A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $C0
	jr nc,Logged_0x4509F
	cp $40
	jr nc,Logged_0x450B0
	ld a,[hli]
	rlca
	jr c,Logged_0x4509B
	ld a,$5A
	ld [hl],a
	ld de,$4BED
	call Logged_0x30F0
	ld a,$3F
	ld [hli],a
	ret

Logged_0x4509B:
	ld a,$13
	ld [hl],a
	ret

Logged_0x4509F:
	ld a,[hli]
	rlca
	jr nc,Logged_0x4509B
	ld a,$5A
	ld [hl],a
	ld de,$4BF6
	call Logged_0x30F0
	ld a,$3F
	ld [hli],a
	ret

Logged_0x450B0:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x450CB
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x450CB:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x4510C
	ld a,[hl]
	and $0F
	sub $07
	jr nc,Logged_0x450E8
	call Logged_0x355B
	and $0F
	jr z,Logged_0x45106

Logged_0x450E8:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $07
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30C5

Logged_0x45106:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x4510C:
	ld a,[hl]
	and $0F
	add a,$06
	cp $10
	jr c,Logged_0x4511C
	call Logged_0x3573
	and $0F
	jr z,Logged_0x4513A

Logged_0x4511C:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$06
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30B8

Logged_0x4513A:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x45140:
	ld a,[$D10F]
	cp $19
	jr nc,Logged_0x45155
	cp $14
	jr nc,Logged_0x4514F
	cp $06
	jr nc,Logged_0x45155

Logged_0x4514F:
	ld bc,$489C
	call Logged_0x3416

Logged_0x45155:
	ld hl,$D11B
	ld a,$32
	ld [hld],a
	jr Logged_0x451A1

Logged_0x4515D:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x33DA
	dec l
	dec l
	dec [hl]
	ret nz
	ld l,$1A
	ld a,[hli]
	rlca
	jr c,Logged_0x4517C
	ld a,$2B
	ld [hl],a
	ld de,$4C25
	call Logged_0x30F0
	ld a,$1C
	ld [hli],a
	ret

Logged_0x4517C:
	ld a,$5B
	ld [hl],a
	ld de,$4BDA
	call Logged_0x30F0
	ret

Logged_0x45186:
	ld a,[$D10F]
	cp $19
	jr nc,Logged_0x4519B
	cp $14
	jr nc,Unknown_0x45195
	cp $06
	jr nc,Logged_0x4519B

Unknown_0x45195:
	ld bc,$48B1
	call Logged_0x3416

Logged_0x4519B:
	ld hl,$D11B
	ld a,$33
	ld [hld],a

Logged_0x451A1:
	ld a,[hld]
	rlca
	jr c,Logged_0x451AD
	ld de,$4BC7
	call Logged_0x30F0
	jr Logged_0x451B3

Logged_0x451AD:
	ld de,$4BCC
	call Logged_0x30F0

Logged_0x451B3:
	ld a,$0C
	ld [hld],a
	ld a,$02
	ld [$D118],a
	ret

Logged_0x451BC:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x33E9
	dec l
	dec l
	dec [hl]
	ret nz
	ld l,$1A
	ld a,[hli]
	rlca
	jr c,Logged_0x451D8
	ld a,$5B
	ld [hl],a
	ld de,$4BD1
	call Logged_0x30F0
	ret

Logged_0x451D8:
	ld a,$2B
	ld [hl],a
	ld de,$4C2C
	call Logged_0x30F0
	ld a,$1C
	ld [hli],a
	ret

Unknown_0x451E5:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x451F4
	ld de,$4BE3
	jr Unknown_0x451F7

Unknown_0x451F4:
	ld de,$4BE8

Unknown_0x451F7:
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Unknown_0x45202:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x45210:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x4521F
	ld de,$4BE3
	jr Logged_0x45222

Unknown_0x4521F:
	ld de,$4BE8

Logged_0x45222:
	call Logged_0x30F0
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x4522D:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Unknown_0x4523B:
	ld hl,$D11B
	ld a,$44
	ld [hld],a
	jr Unknown_0x45249

Unknown_0x45243:
	ld hl,$D11B
	ld a,$45
	ld [hld],a

Unknown_0x45249:
	ld a,[hld]
	rlca
	jr c,Unknown_0x45255
	ld de,$4BE3
	call Logged_0x30F0
	jr Unknown_0x4525B

Unknown_0x45255:
	ld de,$4BE8
	call Logged_0x30F0

Unknown_0x4525B:
	inc l
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x4526B:
	ld a,$3F
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld hl,$D100
	res 2,[hl]

Logged_0x4527A:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x45287
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x45287:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x45294:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld a,$07
	ld [$D116],a

Logged_0x452A2:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32F9
	ld a,$00
	ld [$D11B],a
	ret

Logged_0x452AF:
	ld hl,$D11B
	ld a,$43
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x452C1
	ld de,$4C17
	call Logged_0x30F0
	jr Logged_0x452C7

Logged_0x452C1:
	ld de,$4C1E
	call Logged_0x30F0

Logged_0x452C7:
	ld a,$1C
	ld [hli],a
	ret

Logged_0x452CB:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x452D8
	ld a,$1A
	ld [$D11B],a
	ret

Logged_0x452D8:
	ld hl,$D116
	ld a,[hl]
	cp $08
	jr z,Logged_0x452EA
	dec [hl]
	jp nz,Logged_0x3308
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x452EA:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x452F4
	set 7,[hl]
	ret

Logged_0x452F4:
	res 7,[hl]
	ret

Logged_0x452F7:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x45309

Unknown_0x45301:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x45309:
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x45316
	ld de,$4BE3
	call Logged_0x30F0
	jr Logged_0x4531C

Unknown_0x45316:
	ld de,$4BE8
	call Logged_0x30F0

Logged_0x4531C:
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Unknown_0x4532E:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Unknown_0x45388

Unknown_0x45338:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Unknown_0x45388

Unknown_0x45342:
	ld a,[$CA8E]
	and a
	jr nz,Unknown_0x4535C
	ld a,[$D14A]
	cp $05
	jr nc,Unknown_0x4535C
	ld a,[$D108]
	and $7F
	jr z,Unknown_0x4535C
	ld a,$08
	ld [$D11B],a
	ret

Unknown_0x4535C:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$01
	jr Unknown_0x45388

Unknown_0x45366:
	ld a,[$CA8E]
	and a
	jr nz,Unknown_0x45380
	ld a,[$D14A]
	cp $05
	jr nc,Unknown_0x45380
	ld a,[$D108]
	and $7F
	jr z,Unknown_0x45380
	ld a,$09
	ld [$D11B],a
	ret

Unknown_0x45380:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$01

Unknown_0x45388:
	ld a,$81
	ld [$D11C],a
	ld a,[hl]
	and $F0
	ld [hld],a
	ld c,a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld a,c
	rlca
	jr c,Unknown_0x453A0
	ld de,$4C11
	jp Logged_0x30F0

Unknown_0x453A0:
	ld de,$4C14
	jp Logged_0x30F0

Unknown_0x453A6:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Unknown_0x453B9:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Unknown_0x453CC:
	ld hl,$D11B
	ld a,$49
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x453DE
	ld de,$4BE3
	call Logged_0x30F0
	jr Unknown_0x453E4

Unknown_0x453DE:
	ld de,$4BE8
	call Logged_0x30F0

Unknown_0x453E4:
	ld l,$00
	set 2,[hl]

Unknown_0x453E8:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Unknown_0x453F8

Unknown_0x453F8:
	ld hl,$D11B
	ld a,$48
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x4540A
	ld de,$4BE3
	call Logged_0x30F0
	jr Unknown_0x45410

Unknown_0x4540A:
	ld de,$4BE8
	call Logged_0x30F0

Unknown_0x45410:
	ld l,$00
	set 2,[hl]

Unknown_0x45414:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Unknown_0x453CC

Unknown_0x45425:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret
	call Logged_0x3090
	jr Logged_0x45442
	call Logged_0x309A

Logged_0x45442:
	ld l,$00
	set 3,[hl]
	ld a,[$D11B]
	cp $18
	jr z,Logged_0x45470
	ld bc,$4510
	jp Logged_0x34B7

Logged_0x45453:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	ret z
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hl],a

Logged_0x45470:
	ld a,$18
	ld [$FF00+$85],a
	ld a,$A5
	ld [$FF00+$8D],a
	ld a,$58
	ld [$FF00+$8E],a
	call $FF80
	ret
	ld hl,$D11F
	ld a,$54
	ld [hld],a
	ld a,$91
	ld [hld],a
	dec l
	ld a,$8F
	ld [hl],a
	ld l,$00
	set 3,[hl]
	ld a,[$D11B]
	cp $18
	jr z,Logged_0x45470
	ld bc,$4540
	call Logged_0x34B7
	jr Logged_0x45453
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$54
	ld [hld],a
	ld a,$CB
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld a,$18
	ld [$D118],a
	call Logged_0x3083
	ld de,$4C47
	call Logged_0x30F0
	ld l,$0C
	ld a,$02
	ld [hld],a
	ld a,$FD
	ld [hld],a
	ld a,$17
	ld [hl],a
	ret

Logged_0x454CB:
	ld hl,$D11F
	ld a,$55
	ld [hld],a
	ld a,$54
	ld [hld],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x454E9
	ld a,$5A
	ld de,$4C47
	jr Logged_0x454EE

Logged_0x454E9:
	ld a,$2E
	ld de,$4C59

Logged_0x454EE:
	ld [$D117],a
	call Logged_0x30F0
	jr Logged_0x45554
	ld a,$81
	ld [$D11C],a
	ld a,[$CA8E]
	cp $06
	ret z
	ld a,[$D10D]
	sub $19
	ld b,a
	ld a,[$CA87]
	sub b
	cp $36
	ret nc
	jr Logged_0x454CB

Logged_0x45510:
	ld a,[$D117]
	cp $2E
	jr z,Logged_0x45545
	cp $5A
	jr z,Logged_0x45545
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x4552E
	ld de,$4C4A
	jr Logged_0x45531

Logged_0x4552E:
	ld de,$4C56

Logged_0x45531:
	call Logged_0x30F0
	ld a,$08
	ld [hli],a
	ld l,$1F
	ld a,$55
	ld [hld],a
	ld a,$40
	ld [hld],a
	ret
	ld hl,$D116
	dec [hl]
	ret nz

Logged_0x45545:
	ld de,$4C36
	call Logged_0x30F0
	ld l,$1F
	ld a,$54
	ld [hld],a
	ld a,$F6
	ld [hld],a
	ret

Logged_0x45554:
	ld a,[$CA8E]
	cp $06
	jr z,Logged_0x45510
	ld a,[$D10D]
	sub $19
	ld b,a
	ld a,[$CA87]
	sub b
	cp $36
	jr nc,Logged_0x45510
	ld a,[$CA88]
	ld d,a
	ld a,[$D10E]
	ld e,a
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x4557E
	xor a
	ld [hl],a
	ld l,$00
	res 3,[hl]

Logged_0x4557E:
	ld l,$17
	ld a,[hl]
	cp $5C
	jr z,Logged_0x45597
	cp $2D
	jr z,Logged_0x455BA
	cp $2E
	jr z,Logged_0x455E7
	cp $5B
	jr z,Logged_0x45602
	cp $5A
	jp z,Logged_0x4562F
	ret

Logged_0x45597:
	ld a,e
	add a,$17
	cp d
	jr c,Unknown_0x455A9
	ld a,e
	sub $18
	cp d
	ret c
	ld a,$5B
	ld de,$4C4A
	jr Logged_0x455AE

Unknown_0x455A9:
	ld a,$2D
	ld de,$4C56

Logged_0x455AE:
	ld [hl],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$7A
	ld [$FF00+$B6],a
	jp Logged_0x30F0

Logged_0x455BA:
	ld a,e
	add a,$46
	cp d
	jr c,Logged_0x455D6
	ld a,e
	add a,$17
	cp d
	ret c
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$7B
	ld [$FF00+$B6],a
	ld a,$5C
	ld [hl],a
	ld de,$4C50
	jp Logged_0x30F0

Logged_0x455D6:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$7A
	ld [$FF00+$B6],a
	ld a,$2E
	ld [hl],a
	ld de,$4C59
	jp Logged_0x30F0

Logged_0x455E7:
	ld a,$81
	ld [$D11C],a
	ld a,e
	add a,$46
	cp d
	ret c
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$7A
	ld [$FF00+$B6],a
	ld a,$2D
	ld [hl],a
	ld de,$4C56
	jp Logged_0x30F0

Logged_0x45602:
	ld a,e
	sub $18
	cp d
	jr c,Logged_0x4561E
	ld a,e
	sub $47
	cp d
	ret c
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$7A
	ld [$FF00+$B6],a
	ld a,$5A
	ld [hl],a
	ld de,$4C47
	jp Logged_0x30F0

Logged_0x4561E:
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$7B
	ld [$FF00+$B6],a
	ld a,$5C
	ld [hl],a
	ld de,$4C50
	jp Logged_0x30F0

Logged_0x4562F:
	ld a,$81
	ld [$D11C],a
	ld a,e
	sub $47
	cp d
	ret nc
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$7A
	ld [$FF00+$B6],a
	ld a,$5B
	ld [hl],a
	ld de,$4C4A
	jp Logged_0x30F0
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$56
	ld [hld],a
	ld a,$8B
	ld [hld],a
	ld de,$4C5C
	call Logged_0x30F0
	ld l,$1A
	res 5,[hl]
	dec l
	xor a
	ld [hld],a
	dec l
	ld [hld],a
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld a,$02
	ld [hld],a
	ret

Logged_0x45672:
	xor a
	ld [hld],a
	jp Logged_0x4589D

Logged_0x45677:
	xor a
	ld [hld],a
	ld a,[$CA8E]
	cp $07
	jp z,Logged_0x4589D
	ld a,[hl]
	and $0F
	cp $01
	jp z,Logged_0x4589D
	jr Logged_0x456B3
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x456B3
	cp $0E
	jr z,Logged_0x45672
	cp $0A
	jr z,Logged_0x456C7
	cp $04
	jr c,Logged_0x45677
	cp $28
	jr z,Logged_0x456CA
	cp $29
	jr z,Logged_0x456D2
	cp $04
	jr z,Logged_0x456DA
	cp $05
	jr z,Logged_0x456E2
	rra
	jr nc,Logged_0x456D2
	jr Logged_0x456CA

Logged_0x456B3:
	ld l,$1A
	ld a,[hl]
	and $0F
	rst JumpList
	dw Logged_0x4570F
	dw Logged_0x4570F
	dw Logged_0x458C7
	dw Logged_0x457BD
	dw Logged_0x4585C
	dw Unknown_0x45893
	dw Logged_0x45934

Logged_0x456C7:
	jp Logged_0x3173

Logged_0x456CA:
	ld a,$33
	ld c,$F8
	ld b,$02
	jr Logged_0x456E8

Logged_0x456D2:
	ld a,$34
	ld c,$07
	ld b,$02
	jr Logged_0x456E8

Logged_0x456DA:
	ld a,$33
	ld c,$26
	ld b,$02
	jr Logged_0x456E8

Logged_0x456E2:
	ld a,$33
	ld c,$17
	ld b,$02

Logged_0x456E8:
	ld l,$1F
	ld [hld],a
	ld [hl],c
	ld l,$19
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld de,$4C89
	call Logged_0x30F0
	ld a,$81
	ld [$D11C],a
	ret

Logged_0x456FE:
	ld de,$4C5C
	call Logged_0x30F0
	ld l,$1A
	ld a,[hl]
	and $F0
	or $01
	ld [hld],a
	xor a
	ld [hld],a
	ret

Logged_0x4570F:
	ld a,[$D10D]
	add a,$2A
	ld b,a
	ld a,[$CA87]
	add a,$2A
	cp b
	jr c,Logged_0x45739
	cp $61
	jr nc,Logged_0x45739
	ld a,[$CA8E]
	cp $07
	jr z,Logged_0x45739
	ld a,[$C08F]
	and $3F
	jr nz,Logged_0x45739
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $06
	ld [hld],a
	ret

Logged_0x45739:
	ld hl,$D119
	ld a,[hl]
	ld d,$40

Logged_0x4573F:
	add a,$00
	ld e,a
	ld a,[de]
	cp $80
	jr nz,Logged_0x4579C
	ld a,[$CA8E]
	cp $07
	jr z,Logged_0x45798
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $B0
	jr c,Logged_0x45798
	cp $EC
	jr nc,Logged_0x45798
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $60
	jr nc,Logged_0x45782
	cp $10
	ld a,$01
	jr nc,Logged_0x45777
	dec a

Logged_0x45777:
	ld l,$1A
	res 7,[hl]
	ld de,$4C7F
	ld c,$03
	jr Logged_0x457AE

Logged_0x45782:
	cp $A0
	jr c,Logged_0x45798
	cp $F0
	ld a,$01
	jr c,Logged_0x4578D
	dec a

Logged_0x4578D:
	ld l,$1A
	set 7,[hl]
	ld de,$4C84
	ld c,$03
	jr Logged_0x457AE

Logged_0x45798:
	xor a
	ld [hl],a
	jr Logged_0x4573F

Logged_0x4579C:
	inc [hl]
	ld l,$03
	cp $80
	ld c,[hl]
	jr nc,Logged_0x457A9
	add a,c
	ld [hli],a
	ret nc
	inc [hl]
	ret

Logged_0x457A9:
	add a,c
	ld [hli],a
	ret c
	dec [hl]
	ret

Logged_0x457AE:
	ld [$D118],a
	ld a,[hl]
	and $F0
	or c
	ld [hl],a
	call Logged_0x30F0
	ld a,$01
	ld [hli],a
	ret

Logged_0x457BD:
	ld hl,$D116
	ld a,[hl]
	and a
	jr z,Logged_0x457C6
	dec [hl]
	ret

Logged_0x457C6:
	xor a
	ld [$C1CA],a
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	jr z,Logged_0x457E7
	ld a,[$C1CA]
	and a
	jr z,Logged_0x45801
	jr Logged_0x457ED

Logged_0x457E7:
	ld a,[$C0DD]
	and a
	jr nz,Logged_0x45801

Logged_0x457ED:
	ld c,$2A
	ld a,[$D10D]
	add a,c
	ld b,a
	ld a,[$CA87]
	add a,c
	sub b
	cp $14
	jr c,Logged_0x45801
	cp $80
	jr c,Logged_0x45810

Logged_0x45801:
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $04
	ld [hl],a
	ld a,$FF
	ld [$D116],a
	ret

Logged_0x45810:
	ld hl,$D117
	inc [hl]
	ld l,$03
	ld a,[hl]
	add a,$02
	ld [hli],a
	jr nc,Logged_0x4581D
	inc [hl]

Logged_0x4581D:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x45843
	ld a,[hli]
	sub $08
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jr nz,Logged_0x45854
	jp Logged_0x305C

Logged_0x45843:
	ld a,[hli]
	add a,$07
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x3069

Logged_0x45854:
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	ret

Logged_0x4585C:
	ld hl,$D116
	dec [hl]
	jp z,Logged_0x456FE
	ld hl,$D103
	ld a,[hli]
	sub $10
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hli]
	ld [$FF00+$AA],a
	call Logged_0x358B
	and a
	jp nz,Logged_0x4581D
	ld hl,$D117
	ld a,[hl]
	and a
	jp z,Logged_0x456FE
	dec [hl]
	ld l,$03
	ld a,[hl]
	sub $02
	ld [hli],a
	jp nc,Logged_0x4581D
	dec [hl]
	jp Logged_0x4581D

Unknown_0x45893:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x4581D
	jp Logged_0x456FE

Logged_0x4589D:
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $02
	ld [hl],a
	ld c,$2A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	jr c,Logged_0x458B8
	set 7,[hl]
	jr Logged_0x458BA

Logged_0x458B8:
	res 7,[hl]

Logged_0x458BA:
	dec l
	xor a
	ld [hld],a
	ld de,$4C8E
	call Logged_0x30F0
	ld a,$1B
	ld [hli],a
	ret

Logged_0x458C7:
	ld hl,$D116
	dec [hl]
	jp z,Logged_0x4592E
	ld hl,$D103
	ld a,[hli]
	sub $10
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hli]
	ld [$FF00+$AA],a
	call Logged_0x358B
	and a
	jr nz,Logged_0x458ED
	ld bc,$4600
	call Logged_0x34B7

Logged_0x458ED:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x45917
	ld a,[hli]
	sub $08
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x3090
	ld hl,$D11A
	set 7,[hl]
	ret

Logged_0x45917:
	ld a,[hli]
	add a,$07
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x309A
	ld hl,$D11A
	res 7,[hl]
	ret

Logged_0x4592E:
	inc l
	xor a
	ld [hl],a
	jp Logged_0x456FE

Logged_0x45934:
	ld a,[$CA8E]
	cp $07
	jp z,Logged_0x456FE
	ld a,[$CA61]
	ld h,a
	ld a,[$CA62]
	and $FC
	ld l,a
	ld de,$FFB0
	add hl,de
	ld d,h
	ld e,l
	ld a,[$D104]
	cp d
	jr z,Logged_0x45971
	jr c,Unknown_0x4597C

Logged_0x45954:
	ld hl,$D103
	ld a,[hli]
	sub $10
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hli]
	ld [$FF00+$AA],a
	call Logged_0x358B
	and a
	jp nz,Logged_0x4589D
	jp Logged_0x30E6

Logged_0x45971:
	ld a,[$D103]
	and $FC
	cp e
	jp z,Logged_0x456FE
	jr nc,Logged_0x45954

Unknown_0x4597C:
	xor a
	ld [$C1CA],a
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	jr z,Unknown_0x4599F
	ld a,[$C1CA]
	and a
	jp nz,Logged_0x30D4
	jp Logged_0x456FE

Unknown_0x4599F:
	ld a,[$C0DD]
	and a
	jp z,Logged_0x30D9
	jp Logged_0x456FE
	ld hl,$D100
	res 4,[hl]
	set 3,[hl]
	ld l,$1F
	ld a,$59
	ld [hld],a
	ld a,$C3
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld de,$4CC4
	call Logged_0x30F0
	ret
	ld a,$81
	ld [$D11C],a
	ld a,[$C08F]
	and a
	ret nz
	ld de,$4CCD
	call Logged_0x30F0
	ld a,$1E
	ld [hli],a
	ld l,$1F
	ld a,$59
	ld [hld],a
	ld a,$DF
	ld [hld],a
	ret
	ld a,$81
	ld [$D11C],a
	ld hl,$D116
	ld a,[hl]
	and $03
	jr nz,Logged_0x459F4
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$6A
	ld [$FF00+$B6],a

Logged_0x459F4:
	dec [hl]
	ret nz
	ld de,$4CC4
	call Logged_0x30F0
	ld l,$1F
	ld a,$59
	ld [hld],a
	ld a,$C3
	ld [hld],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$6B
	ld [$FF00+$B6],a
	ld bc,$4ECC
	jp Logged_0x342D
	ld hl,$D100
	set 3,[hl]
	ld bc,$4040
	call Logged_0x34B7
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x352B
	and a
	ret z
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hl],a
	ld l,$09
	ld a,$FA
	ld [hli],a
	ld a,$05
	ld [hl],a
	ld de,$4CA0
	call Logged_0x30F0
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x45A5B
	ld de,$5A6C
	jr Logged_0x45A5E

Logged_0x45A5B:
	ld de,$5A78

Logged_0x45A5E:
	ld l,$1F
	ld a,d
	ld [hld],a
	ld [hl],e
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$6C
	ld [$FF00+$B6],a
	ret
	ld hl,$D105
	ld a,[hl]
	sub $02
	ld [hli],a
	jr nc,Logged_0x45A82
	dec [hl]
	jr Logged_0x45A82
	ld hl,$D105
	ld a,[hl]
	add a,$02
	ld [hli],a
	jr nc,Logged_0x45A82
	inc [hl]

Logged_0x45A82:
	ld a,[$D11B]
	and a
	jr nz,Logged_0x45AAF
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr z,Logged_0x45AAF
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	call Logged_0x3513
	and a
	ret z

Logged_0x45AAF:
	xor a
	ld [$D100],a
	ret
	ld a,$81
	ld [$D11C],a
	ld hl,$D11F
	ld a,$5A
	ld [hld],a
	ld a,$D3
	ld [hld],a
	ld l,$0C
	ld a,$03
	ld [hld],a
	ld a,$FC
	ld [hld],a
	ld l,$00
	set 3,[hl]
	xor a
	ld [$D116],a
	ret
	ld a,$81
	ld [$D11C],a
	ld hl,$D11F
	ld a,$5B
	ld [hld],a
	ld a,$03
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x45AFB
	res 7,[hl]
	ld a,$17
	ld [$D10F],a
	ret

Logged_0x45AFB:
	set 7,[hl]
	ld a,$18
	ld [$D10F],a
	ret
	ld a,$81
	ld [$D11C],a
	ld a,$02
	ld [$D114],a
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x45B27
	xor a
	ld [$D100],a
	ret

Logged_0x45B27:
	ld hl,$D105
	ld a,[$D11A]
	rlca
	jr c,Logged_0x45B69
	ld a,[hl]
	and $0F
	sub $04
	jr nc,Logged_0x45B3F
	call Logged_0x355B
	and $0F
	jp z,Logged_0x45B61

Logged_0x45B3F:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $04
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jr nz,Logged_0x45B61
	call Logged_0x30CA
	jr Logged_0x45B99

Logged_0x45B61:
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	ret

Logged_0x45B69:
	ld a,[hl]
	and $0F
	add a,$03
	cp $10
	jr c,Logged_0x45B79
	call Logged_0x3573
	and $0F
	jr z,Logged_0x45B61

Logged_0x45B79:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$03
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jr nz,Logged_0x45B61
	call Logged_0x30BD

Logged_0x45B99:
	ld hl,$D116
	ld a,[hl]
	and a
	jr z,Logged_0x45BA2
	dec [hl]
	ret

Logged_0x45BA2:
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $18
	jr c,Logged_0x45BB5
	cp $E8
	ret c

Logged_0x45BB5:
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $E0
	ret nc
	cp $20
	ret c
	cp $C0
	jr nc,Logged_0x45BCC
	cp $40
	ret nc

Logged_0x45BCC:
	ld hl,$D11F
	ld a,$5B
	ld [hld],a
	ld a,$DB
	ld [hld],a
	ld a,$14
	ld [$D116],a
	ret
	ld a,$81
	ld [$D11C],a
	ld a,$02
	ld [$D114],a
	ld hl,$D116
	dec [hl]
	ret nz
	ld l,$1A
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x45C01
	res 7,[hl]
	ld de,$4D93
	jr Logged_0x45C06

Logged_0x45C01:
	set 7,[hl]
	ld de,$4D9C

Logged_0x45C06:
	call Logged_0x30F0
	ld a,$14
	ld [hli],a
	ld l,$00
	res 4,[hl]
	res 3,[hl]
	ld l,$1F
	ld a,$5C
	ld [hld],a
	ld a,$23
	ld [hld],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$74
	ld [$FF00+$B6],a
	ret
	ld a,[$CA8E]
	cp $48
	jr nz,Logged_0x45C2F
	ld a,$81
	ld [$D11C],a

Logged_0x45C2F:
	ld hl,$D116
	dec [hl]
	ld a,[hl]
	cp $0C
	jr z,Logged_0x45C51
	cp $06
	jr z,Logged_0x45C57
	and a
	ret nz
	ld a,$E8
	ld [$D109],a
	ld l,$1F
	ld a,$5C
	ld [hld],a
	ld a,$5D
	ld [hld],a
	xor a
	ld [$D11B],a
	jr Logged_0x45CCA

Logged_0x45C51:
	ld a,$F4
	ld [$D109],a
	ret

Logged_0x45C57:
	ld a,$EE
	ld [$D109],a
	ret
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x45CBC
	ld a,[$CA8E]
	cp $48
	jr nz,Unknown_0x45CB2
	ld a,[hl]
	cp $0A
	jr nz,Logged_0x45CBA

Logged_0x45C70:
	dec l
	ld a,[hl]
	and $0F
	cp $03
	jr z,Logged_0x45C7D
	ld de,$4D1A
	jr Logged_0x45C80

Logged_0x45C7D:
	ld de,$4D1F

Logged_0x45C80:
	call Logged_0x30F0

Logged_0x45C83:
	ld l,$1A
	ld a,[hl]
	and $F0
	ld [hld],a
	xor a
	ld [hld],a
	ld a,$02
	ld [hld],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$17
	ld [$FF00+$B6],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x45CA9
	ld bc,$3407
	jr Logged_0x45CAC

Logged_0x45CA9:
	ld bc,$33F8

Logged_0x45CAC:
	ld l,$1F
	ld a,b
	ld [hld],a
	ld [hl],c
	ret

Unknown_0x45CB2:
	ld a,[hl]
	cp $0A
	jp z,Logged_0x3173
	jr Logged_0x45C70

Logged_0x45CBA:
	xor a
	ld [hl],a

Logged_0x45CBC:
	ld a,[$D11A]
	and $0F
	rst JumpList
	dw Logged_0x45CE2
	dw Logged_0x45CE2
	dw Logged_0x45DDC
	dw Logged_0x45DF8

Logged_0x45CCA:
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $01
	ld [hl],a
	rlca
	jr c,Logged_0x45CDC
	ld de,$4D81
	jp Logged_0x30F0

Logged_0x45CDC:
	ld de,$4D8A
	jp Logged_0x30F0

Logged_0x45CE2:
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $20
	jr c,Logged_0x45CF6
	cp $E0
	jr c,Logged_0x45D32

Logged_0x45CF6:
	ld hl,$D11A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $D0
	jr nc,Logged_0x45D15
	cp $30
	jr nc,Logged_0x45D32
	ld a,[hl]
	rlca
	jp c,Logged_0x45DC4
	ld de,$4DA5
	jr Logged_0x45D1D

Logged_0x45D15:
	ld a,[hl]
	rlca
	jp nc,Logged_0x45DC9
	ld de,$4DAC

Logged_0x45D1D:
	rrca
	and $F0
	or $03
	ld [hl],a
	call Logged_0x30F0
	ld a,$32
	ld [hli],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$64
	ld [$FF00+$B6],a
	ret

Logged_0x45D32:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x45D56
	ld a,$30
	ld [$D116],a
	ld hl,$D11F
	ld a,$5E
	ld [hld],a
	ld a,$25
	ld [hld],a
	ret

Logged_0x45D56:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x45D94
	ld a,[hl]
	and $0F
	sub $04
	jr nc,Logged_0x45D74
	call Logged_0x355B
	and $0F
	jp z,Logged_0x45DC9

Logged_0x45D74:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $04
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x3090
	jr Logged_0x45DC9

Logged_0x45D94:
	ld a,[hl]
	and $0F
	add a,$03
	cp $10
	jr c,Logged_0x45DA4
	call Logged_0x3573
	and $0F
	jr z,Logged_0x45DC4

Logged_0x45DA4:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$03
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x309A
	jr Logged_0x45DC4

Logged_0x45DC4:
	ld de,$4D2B
	jr Logged_0x45DCC

Logged_0x45DC9:
	ld de,$4D24

Logged_0x45DCC:
	ld hl,$D11A
	ld a,[hl]
	and $F0
	or $02
	ld [hl],a
	call Logged_0x30F0
	ld a,$20
	ld [hli],a
	ret

Logged_0x45DDC:
	ld hl,$D116
	ld a,[hl]
	cp $14
	jr z,Logged_0x45DEB
	dec [hl]
	jp nz,Logged_0x3308
	jp Logged_0x45CCA

Logged_0x45DEB:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x45DF5
	set 7,[hl]
	ret

Logged_0x45DF5:
	res 7,[hl]
	ret

Logged_0x45DF8:
	ld hl,$D116
	dec [hl]
	ld a,[hl]
	cp $10
	jr z,Logged_0x45E13
	and a
	ret nz
	ld a,$30
	ld [hl],a
	ld l,$1F
	ld a,$5E
	ld [hld],a
	ld a,$25
	ld [hld],a
	ld l,$00
	set 3,[hl]
	ret

Logged_0x45E13:
	ld a,[$D11A]
	rlca
	jr c,Logged_0x45E1F
	ld bc,$48C6
	jp Logged_0x3416

Logged_0x45E1F:
	ld bc,$48DB
	jp Logged_0x3416
	ld a,$81
	ld [$D11C],a
	ld hl,$D116
	dec [hl]
	ld l,$00
	jr z,Logged_0x45E3D
	ld a,[$C08F]
	and $01
	ret nz
	ld a,[hl]
	xor $10
	ld [hl],a
	ret

Logged_0x45E3D:
	ld hl,$D100
	set 4,[hl]
	xor a
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld l,$1F
	ld a,$5B
	ld [hld],a
	ld a,$03
	ld [hld],a
	ret
	ld hl,$D116
	ld a,[hl]
	and a
	jr nz,Logged_0x45E64
	ld l,$00
	bit 1,[hl]
	jr nz,Logged_0x45E73
	xor a
	ld [hl],a
	ret

Logged_0x45E64:
	dec [hl]
	jr nz,Logged_0x45E73
	ld l,$1A
	ld a,[hl]
	xor $80
	ld [hl],a
	ld de,$4DDA
	call Logged_0x30F0

Logged_0x45E73:
	ld bc,$45A0
	jr Logged_0x45E9A
	ld hl,$D116
	ld a,[hl]
	and a
	jr nz,Logged_0x45E88
	ld l,$00
	bit 1,[hl]
	jr nz,Logged_0x45E97
	xor a
	ld [hl],a
	ret

Logged_0x45E88:
	dec [hl]
	jr nz,Logged_0x45E97
	ld l,$1A
	ld a,[hl]
	xor $80
	ld [hl],a
	ld de,$4DD5
	call Logged_0x30F0

Logged_0x45E97:
	ld bc,$4560

Logged_0x45E9A:
	call Logged_0x34CE
	ld hl,$D11B
	ld a,[hld]
	and a
	ret z
	cp $0B
	jp c,Logged_0x45C83
	cp $0F
	jp nc,Logged_0x45C83
	ld a,[hld]
	rlca
	jr c,Logged_0x45EB6
	ld de,$4DD5
	jr Logged_0x45EB9

Logged_0x45EB6:
	ld de,$4DDA

Logged_0x45EB9:
	call Logged_0x30F0
	ld a,$28
	ld [hli],a
	ld l,$1F
	ld a,$5E
	ld [hld],a
	ld a,$C8
	ld [hld],a
	ret
	ld a,$81
	ld [$D11C],a
	ld hl,$D116
	dec [hl]
	ld l,$00
	jr z,Logged_0x45EE0
	ld a,[$C08F]
	and $01
	ret nz
	ld a,[hl]
	xor $10
	ld [hl],a
	ret

Logged_0x45EE0:
	xor a
	ld [hl],a
	ret
	ld hl,$D11F
	ld a,$5E
	ld [hld],a
	ld a,$ED
	ld [hld],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$5F
	ld [hld],a
	ld a,$01
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	jp Logged_0x45FBF
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x45FBF
	dw Logged_0x461DB
	dw Logged_0x462E3
	dw Logged_0x462EB
	dw Unknown_0x464E7
	dw Logged_0x464F1
	dw Logged_0x46517
	dw Logged_0x4652A
	dw Logged_0x46451
	dw Logged_0x4645B
	dw Logged_0x3182
	dw Logged_0x4648D
	dw Logged_0x46494
	dw Logged_0x45FBF
	dw Logged_0x45FBF
	dw Logged_0x463B4
	dw Logged_0x463DD
	dw Logged_0x45FFB
	dw Logged_0x465A0
	dw Logged_0x463F8
	dw Logged_0x4637F
	dw Logged_0x46387
	dw Logged_0x46319
	dw Logged_0x4634C
	dw Logged_0x4656E
	dw Logged_0x4653D
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x45FBF
	dw Logged_0x45FBF
	dw Logged_0x45FBF
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Unknown_0x464DD
	dw Unknown_0x464D3
	dw Logged_0x45FBF
	dw Logged_0x45FBF
	dw Logged_0x45FBF
	dw Logged_0x4605F
	dw Logged_0x460A6
	dw Logged_0x45FBF
	dw Logged_0x3290
	dw Logged_0x461FB
	dw Logged_0x33DA
	dw Logged_0x33E9
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x45FBF
	dw Logged_0x464A5
	dw Logged_0x464B7
	dw Logged_0x45FBF
	dw Logged_0x45FBF
	dw Logged_0x463C3
	dw Logged_0x463EB
	dw Logged_0x46043
	dw Logged_0x3371
	dw Logged_0x46421
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x4633E
	dw Logged_0x46371
	dw Logged_0x4658F
	dw Logged_0x4655E
	dw Logged_0x3380
	dw Logged_0x338F
	dw Logged_0x33BC
	dw Logged_0x33CB
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x4618C
	dw Logged_0x46170
	dw Logged_0x45FBF

Logged_0x45FBF:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$1B
	ld a,$30
	ld [hld],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x45FEF
	res 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4DDF
	call Logged_0x30F0
	ret

Logged_0x45FEF:
	set 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4DE8
	call Logged_0x30F0
	ret

Logged_0x45FFB:
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x46024
	xor a
	ld [hld],a
	ld l,$0B
	ld a,[hl]
	cp $F6
	jr nz,Logged_0x4601B
	ld a,$FA
	ld [hl],a
	ld de,$4E69
	call Logged_0x30F0
	ld a,$0E
	ld [hli],a
	ret

Logged_0x4601B:
	ld de,$4DDF
	call Logged_0x30F0
	xor a
	ld [hl],a
	ret

Unknown_0x46024:
	xor a
	ld [hld],a
	ld l,$0C
	ld a,[hl]
	cp $09
	jr nz,Unknown_0x4603A
	ld a,$05
	ld [hl],a
	ld de,$4E70
	call Logged_0x30F0
	ld a,$0E
	ld [hli],a
	ret

Unknown_0x4603A:
	ld de,$4DE8
	call Logged_0x30F0
	xor a
	ld [hl],a
	ret

Logged_0x46043:
	ld hl,$D116
	ld a,[hl]
	and a
	jp z,Logged_0x329F
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Unknown_0x46059
	ld de,$4DDF
	jp Logged_0x30F0

Unknown_0x46059:
	ld de,$4DE8
	jp Logged_0x30F0

Logged_0x4605F:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x46070
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x46070:
	ld hl,$D116
	dec [hl]
	ret nz
	ld l,$1B
	ld a,$2E
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4608B
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$F6
	ld [hld],a
	ld de,$4E57
	jr Logged_0x46096

Logged_0x4608B:
	ld l,$0C
	ld a,$09
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld de,$4E60

Logged_0x46096:
	call Logged_0x30F0
	inc l
	ld a,$02
	ld [hl],a
	ld l,$08
	ld a,[hl]
	and $80
	or $02
	ld [hld],a
	ret

Logged_0x460A6:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x460B7
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x460B7:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x460D2
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x460D2:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x4611D
	ld a,[hl]
	and $0F
	sub $06
	jr nc,Logged_0x460EF
	call Logged_0x355B
	and $0F
	jr z,Logged_0x4610D

Logged_0x460EF:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $06
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30CA

Logged_0x4610D:
	ld a,[$D117]
	and a
	jr z,Logged_0x46118
	ld de,$4E41
	jr Logged_0x46154

Logged_0x46118:
	ld de,$4DFF
	jr Logged_0x46164

Logged_0x4611D:
	ld a,[hl]
	and $0F
	add a,$05
	cp $10
	jr c,Logged_0x4612D
	call Logged_0x3573
	and $0F
	jr z,Logged_0x4614B

Logged_0x4612D:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$05
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30BD

Logged_0x4614B:
	ld a,[$D117]
	and a
	jr z,Logged_0x46161
	ld de,$4E4C

Logged_0x46154:
	call Logged_0x30F0
	ld a,$24
	ld [hli],a
	dec [hl]
	ld a,$5A
	ld [$D11B],a
	ret

Logged_0x46161:
	ld de,$4E08

Logged_0x46164:
	call Logged_0x30F0
	ld a,$26
	ld [hli],a
	ld a,$5B
	ld [$D11B],a
	ret

Logged_0x46170:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x46181
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x46181:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x4618C:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x4619D
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x4619D:
	ld hl,$D116
	ld a,[hl]
	cp $0F
	jr z,Logged_0x461BE
	dec [hl]
	jp nz,Logged_0x3308
	ld l,$1B
	ld a,$2E
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x461B8
	ld de,$4E57
	jp Logged_0x30F0

Logged_0x461B8:
	ld de,$4E60
	jp Logged_0x30F0

Logged_0x461BE:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x461D0
	set 7,[hl]
	ld l,$0C
	ld a,$09
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ret

Logged_0x461D0:
	res 7,[hl]
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$F6
	ld [hld],a
	ret

Logged_0x461DB:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x461F4
	ld de,$4DDF
	call Logged_0x30F0
	ret

Logged_0x461F4:
	ld de,$4DE8
	call Logged_0x30F0
	ret

Logged_0x461FB:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x4620C
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x4620C:
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $18
	jr c,Logged_0x46220
	cp $E8
	jr c,Logged_0x46253

Logged_0x46220:
	ld hl,$D11A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $C0
	jr nc,Logged_0x46242
	cp $40
	jr nc,Logged_0x46253
	ld a,[hli]
	rlca
	jr c,Logged_0x4623E
	ld de,$4DF1
	jr Logged_0x46249

Logged_0x4623E:
	ld a,$13
	ld [hl],a
	ret

Logged_0x46242:
	ld a,[hli]
	rlca
	jr nc,Logged_0x4623E
	ld de,$4DF8

Logged_0x46249:
	ld a,$2D
	ld [hl],a
	call Logged_0x30F0
	ld a,$14
	ld [hli],a
	ret

Logged_0x46253:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x4626E
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x4626E:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x462AF
	ld a,[hl]
	and $0F
	sub $06
	jr nc,Logged_0x4628B
	call Logged_0x355B
	and $0F
	jr z,Logged_0x462A9

Logged_0x4628B:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $06
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30C5

Logged_0x462A9:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x462AF:
	ld a,[hl]
	and $0F
	add a,$05
	cp $10
	jr c,Logged_0x462BF
	call Logged_0x3573
	and $0F
	jr z,Logged_0x462DD

Logged_0x462BF:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$05
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30B8

Logged_0x462DD:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x462E3:
	ld hl,$D11B
	ld a,$32
	ld [hld],a
	jr Logged_0x462F1

Logged_0x462EB:
	ld hl,$D11B
	ld a,$33
	ld [hld],a

Logged_0x462F1:
	ld a,[hld]
	rlca
	jr c,Logged_0x462FA
	ld de,$4E11
	jr Logged_0x462FD

Logged_0x462FA:
	ld de,$4E14

Logged_0x462FD:
	call Logged_0x30F0
	ld a,$0C
	ld [hld],a
	ld a,$02
	ld [$D118],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ret

Logged_0x46319:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46328
	ld de,$4E17
	jr Logged_0x4632B

Logged_0x46328:
	ld de,$4E20

Logged_0x4632B:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x4633E:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x4634C:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4635B
	ld de,$4E17
	jr Logged_0x4635E

Logged_0x4635B:
	ld de,$4E20

Logged_0x4635E:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x46371:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x4637F:
	ld hl,$D11B
	ld a,$44
	ld [hld],a
	jr Logged_0x4638D

Logged_0x46387:
	ld hl,$D11B
	ld a,$45
	ld [hld],a

Logged_0x4638D:
	ld a,[hld]
	rlca
	jr c,Logged_0x46396
	ld de,$4E17
	jr Logged_0x46399

Logged_0x46396:
	ld de,$4E20

Logged_0x46399:
	call Logged_0x30F0
	inc l
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x463B4:
	ld a,$3F
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld hl,$D100
	res 2,[hl]

Logged_0x463C3:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x463D0
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x463D0:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x463DD:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld a,$07
	ld [$D116],a

Logged_0x463EB:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32F9
	ld a,$00
	ld [$D11B],a
	ret

Logged_0x463F8:
	ld hl,$D11B
	ld a,$43
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46407
	ld de,$4E33
	jr Logged_0x4640A

Logged_0x46407:
	ld de,$4E3A

Logged_0x4640A:
	call Logged_0x30F0
	ld a,$1A
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ret

Logged_0x46421:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x46432
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x46432:
	ld hl,$D116
	ld a,[hl]
	cp $09
	jr z,Logged_0x46444
	dec [hl]
	jp nz,Logged_0x3308
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x46444:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x4644E
	set 7,[hl]
	ret

Logged_0x4644E:
	res 7,[hl]
	ret

Logged_0x46451:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x46463

Logged_0x4645B:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x46463:
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4646D
	ld de,$4E17
	jr Logged_0x46470

Logged_0x4646D:
	ld de,$4E20

Logged_0x46470:
	call Logged_0x30F0
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x4648D:
	ld a,$3B
	ld [$D11B],a
	jr Logged_0x46499

Logged_0x46494:
	ld a,$3C
	ld [$D11B],a

Logged_0x46499:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$02
	ld [$D118],a
	ret

Logged_0x464A5:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$18
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld de,$4DFF
	jr Logged_0x464C7

Logged_0x464B7:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$18
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld de,$4E08

Logged_0x464C7:
	call Logged_0x30F0
	ld a,$26
	ld [hli],a
	ld a,$5B
	ld [$D11B],a
	ret

Unknown_0x464D3:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Logged_0x464F9

Unknown_0x464DD:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Logged_0x464F9

Unknown_0x464E7:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$02
	jr Logged_0x464F9

Logged_0x464F1:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$02

Logged_0x464F9:
	ld a,$81
	ld [$D11C],a
	ld a,[hl]
	and $F0
	ld [hld],a
	ld c,a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld a,c
	rlca
	jr c,Logged_0x46511
	ld de,$4E29
	jp Logged_0x30F0

Logged_0x46511:
	ld de,$4E2E
	jp Logged_0x30F0

Logged_0x46517:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Logged_0x4652A:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Logged_0x4653D:
	ld hl,$D11B
	ld a,$49
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4654C
	ld de,$4E17
	jr Logged_0x4654F

Logged_0x4654C:
	ld de,$4E20

Logged_0x4654F:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x4655E:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Logged_0x4656E

Logged_0x4656E:
	ld hl,$D11B
	ld a,$48
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4657D
	ld de,$4E17
	jr Logged_0x46580

Logged_0x4657D:
	ld de,$4E20

Logged_0x46580:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x4658F:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Logged_0x4653D

Logged_0x465A0:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret
	ld hl,$D11F
	ld a,$65
	ld [hld],a
	ld a,$BF
	ld [hld],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$65
	ld [hld],a
	ld a,$D3
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	jp Logged_0x46691
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x46691
	dw Logged_0x46748
	dw Logged_0x46874
	dw Logged_0x4687C
	dw Logged_0x46A32
	dw Logged_0x46A3C
	dw Logged_0x46A62
	dw Logged_0x46A75
	dw Logged_0x469E2
	dw Logged_0x469EC
	dw Logged_0x3182
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x46945
	dw Logged_0x4696E
	dw Logged_0x466CB
	dw Logged_0x46AEB
	dw Logged_0x46989
	dw Logged_0x46910
	dw Logged_0x46918
	dw Logged_0x468AA
	dw Logged_0x468DD
	dw Logged_0x46AB9
	dw Logged_0x46A88
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Logged_0x46A28
	dw Logged_0x46A1E
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x466E7
	dw Logged_0x4672C
	dw Logged_0x46691
	dw Logged_0x3290
	dw Logged_0x46769
	dw Logged_0x33DA
	dw Logged_0x33E9
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x46954
	dw Logged_0x4697C
	dw Logged_0x329F
	dw Logged_0x3371
	dw Logged_0x469B2
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x468CF
	dw Logged_0x46902
	dw Logged_0x46ADA
	dw Logged_0x46AA9
	dw Logged_0x3380
	dw Logged_0x338F
	dw Logged_0x33BC
	dw Logged_0x33CB
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x46691
	dw Logged_0x46691
	dw Logged_0x46691

Logged_0x46691:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$1B
	ld a,$30
	ld [hld],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x466C0
	res 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4E77
	jp Logged_0x30F0

Logged_0x466C0:
	set 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4E80
	jp Logged_0x30F0

Logged_0x466CB:
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x466DE
	xor a
	ld [hld],a
	ld de,$4E77
	call Logged_0x30F0
	ret

Logged_0x466DE:
	xor a
	ld [hld],a
	ld de,$4E80
	call Logged_0x30F0
	ret

Logged_0x466E7:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x466F8
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x466F8:
	ld hl,$D116
	dec [hl]
	jr z,Logged_0x46714
	ld a,[hl]
	cp $19
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Logged_0x4670E
	ld bc,$491A
	jp Logged_0x3416

Logged_0x4670E:
	ld bc,$492F
	jp Logged_0x3416

Logged_0x46714:
	ld l,$1B
	ld a,$2E
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46722
	ld de,$4EA3
	jr Logged_0x46725

Logged_0x46722:
	ld de,$4EAA

Logged_0x46725:
	call Logged_0x30F0
	ld a,$32
	ld [hli],a
	ret

Logged_0x4672C:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x4673D
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x4673D:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x46748:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x4675F
	ld de,$4E77
	jr Logged_0x46762

Logged_0x4675F:
	ld de,$4E80

Logged_0x46762:
	call Logged_0x30F0
	ld a,$64
	ld [hli],a
	ret

Logged_0x46769:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x4677A
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x4677A:
	ld a,[$CA8E]
	cp $51
	jr z,Logged_0x467CF
	ld hl,$D100
	bit 1,[hl]
	jr z,Logged_0x467CF
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $1C
	jr c,Logged_0x4679C
	cp $E4
	jr c,Logged_0x467CF

Logged_0x4679C:
	ld hl,$D11A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $B8
	jr nc,Logged_0x467BE
	cp $48
	jr nc,Logged_0x467CF
	ld a,[hli]
	rlca
	jr c,Logged_0x467BA
	ld de,$4E89
	jr Logged_0x467C5

Logged_0x467BA:
	ld a,$13
	ld [hl],a
	ret

Logged_0x467BE:
	ld a,[hli]
	rlca
	jr nc,Logged_0x467BA
	ld de,$4E96

Logged_0x467C5:
	ld a,$2D
	ld [hl],a
	call Logged_0x30F0
	ld a,$29
	ld [hli],a
	ret

Logged_0x467CF:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x467EA
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x467EA:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x4682B
	ld a,[hl]
	and $0F
	sub $06
	jr nc,Logged_0x46807
	call Logged_0x355B
	and $0F
	jr z,Logged_0x4685F

Logged_0x46807:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $06
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30C5
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x4682B:
	ld a,[hl]
	and $0F
	add a,$05
	cp $10
	jr c,Logged_0x4683B
	call Logged_0x3573
	and $0F
	jr z,Logged_0x4685F

Logged_0x4683B:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$05
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30B8
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x4685F:
	ld a,[$C08F]
	rra
	jr c,Logged_0x46869
	ld hl,$D114
	inc [hl]

Logged_0x46869:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x46874:
	ld hl,$D11B
	ld a,$32
	ld [hld],a
	jr Logged_0x46882

Logged_0x4687C:
	ld hl,$D11B
	ld a,$33
	ld [hld],a

Logged_0x46882:
	ld a,[hld]
	rlca
	jr c,Logged_0x4688B
	ld de,$4EB1
	jr Logged_0x4688E

Logged_0x4688B:
	ld de,$4EB4

Logged_0x4688E:
	call Logged_0x30F0
	ld a,$0C
	ld [hld],a
	ld a,$02
	ld [$D118],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ret

Logged_0x468AA:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x468B9
	ld de,$4EB7
	jr Logged_0x468BC

Logged_0x468B9:
	ld de,$4EC0

Logged_0x468BC:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x468CF:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x468DD:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x468EC
	ld de,$4EB7
	jr Logged_0x468EF

Logged_0x468EC:
	ld de,$4EC0

Logged_0x468EF:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x46902:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x46910:
	ld hl,$D11B
	ld a,$44
	ld [hld],a
	jr Logged_0x4691E

Logged_0x46918:
	ld hl,$D11B
	ld a,$45
	ld [hld],a

Logged_0x4691E:
	ld a,[hld]
	rlca
	jr c,Logged_0x46927
	ld de,$4EB7
	jr Logged_0x4692A

Logged_0x46927:
	ld de,$4EC0

Logged_0x4692A:
	call Logged_0x30F0
	inc l
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x46945:
	ld a,$3F
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld hl,$D100
	res 2,[hl]

Logged_0x46954:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x46961
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x46961:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x4696E:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld a,$07
	ld [$D116],a

Logged_0x4697C:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32F9
	ld a,$00
	ld [$D11B],a
	ret

Logged_0x46989:
	ld hl,$D11B
	ld a,$43
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46998
	ld de,$4ED3
	jr Logged_0x4699B

Logged_0x46998:
	ld de,$4EDA

Logged_0x4699B:
	call Logged_0x30F0
	ld a,$11
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ret

Logged_0x469B2:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x469C3
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x469C3:
	ld hl,$D116
	ld a,[hl]
	cp $06
	jr z,Logged_0x469D5
	dec [hl]
	jp nz,Logged_0x3308
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x469D5:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x469DF
	set 7,[hl]
	ret

Logged_0x469DF:
	res 7,[hl]
	ret

Logged_0x469E2:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x469F4

Logged_0x469EC:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x469F4:
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x469FE
	ld de,$4EB7
	jr Logged_0x46A01

Logged_0x469FE:
	ld de,$4EC0

Logged_0x46A01:
	call Logged_0x30F0
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x46A1E:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Logged_0x46A44

Logged_0x46A28:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Logged_0x46A44

Logged_0x46A32:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$02
	jr Logged_0x46A44

Logged_0x46A3C:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$02

Logged_0x46A44:
	ld a,$81
	ld [$D11C],a
	ld a,[hl]
	and $F0
	ld [hld],a
	ld c,a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld a,c
	rlca
	jr c,Logged_0x46A5C
	ld de,$4EC9
	jp Logged_0x30F0

Logged_0x46A5C:
	ld de,$4ECE
	jp Logged_0x30F0

Logged_0x46A62:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Logged_0x46A75:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Logged_0x46A88:
	ld hl,$D11B
	ld a,$49
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46A97
	ld de,$4EB7
	jr Logged_0x46A9A

Logged_0x46A97:
	ld de,$4EC0

Logged_0x46A9A:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x46AA9:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Logged_0x46AB9

Logged_0x46AB9:
	ld hl,$D11B
	ld a,$48
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46AC8
	ld de,$4EB7
	jr Logged_0x46ACB

Logged_0x46AC8:
	ld de,$4EC0

Logged_0x46ACB:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x46ADA:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Logged_0x46A88

Logged_0x46AEB:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret
	ld hl,$D11F
	ld a,$6B
	ld [hld],a
	ld a,$15
	ld [hld],a
	ld l,$00
	set 3,[hl]
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$7C
	ld [$FF00+$B6],a
	ld hl,$D116
	ld a,[hl]
	and a
	jr z,Logged_0x46B25
	dec [hl]
	jr nz,Logged_0x46B25
	ld de,$4EF3
	call Logged_0x30F0

Logged_0x46B25:
	ld bc,$4610
	jr Logged_0x46B52
	ld hl,$D11F
	ld a,$6B
	ld [hld],a
	ld a,$3F
	ld [hld],a
	ld l,$00
	set 3,[hl]
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$7C
	ld [$FF00+$B6],a
	ld hl,$D116
	ld a,[hl]
	and a
	jr z,Logged_0x46B4F
	dec [hl]
	jr nz,Logged_0x46B4F
	ld de,$4EF8
	call Logged_0x30F0

Logged_0x46B4F:
	ld bc,$4630

Logged_0x46B52:
	ld hl,$D11B
	ld a,[hl]
	and a
	jr z,Logged_0x46B63
	xor a
	ld [hl],a
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$7D
	ld [$FF00+$B6],a

Logged_0x46B63:
	jp Logged_0x34CE
	ld hl,$D11F
	ld a,$6B
	ld [hld],a
	ld a,$70
	ld [hld],a
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$6B
	ld [hld],a
	ld a,$84
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	jp Logged_0x46C42
	ld a,[$D11B]
	rst JumpList
	dw Logged_0x46C42
	dw Logged_0x46E6F
	dw Logged_0x46F7C
	dw Logged_0x46F84
	dw Logged_0x47180
	dw Logged_0x4718A
	dw Logged_0x471B0
	dw Logged_0x471C3
	dw Logged_0x470EA
	dw Logged_0x470F4
	dw Logged_0x3182
	dw Logged_0x47126
	dw Logged_0x4712D
	dw Logged_0x46C42
	dw Logged_0x46C42
	dw Logged_0x4704D
	dw Logged_0x47076
	dw Logged_0x46C7E
	dw Logged_0x47239
	dw Logged_0x47091
	dw Logged_0x47018
	dw Logged_0x47020
	dw Logged_0x46FB2
	dw Logged_0x46FE5
	dw Logged_0x47207
	dw Logged_0x471D6
	dw Logged_0x3263
	dw Logged_0x3272
	dw Logged_0x3281
	dw Logged_0x46C42
	dw Logged_0x46C42
	dw Logged_0x46C42
	dw Logged_0x3191
	dw Logged_0x31AF
	dw Logged_0x31CD
	dw Logged_0x31EB
	dw Logged_0x3209
	dw Logged_0x3227
	dw Logged_0x3245
	dw Logged_0x3254
	dw Logged_0x47176
	dw Logged_0x4716C
	dw Logged_0x46C42
	dw Logged_0x46C42
	dw Logged_0x46C42
	dw Logged_0x46CE4
	dw Logged_0x46D38
	dw Logged_0x46C42
	dw Logged_0x3290
	dw Logged_0x46E8D
	dw Logged_0x33DA
	dw Logged_0x33E9
	dw Logged_0x3326
	dw Logged_0x3317
	dw Logged_0x3335
	dw Logged_0x3344
	dw Logged_0x31FA
	dw Logged_0x31DC
	dw Logged_0x46C42
	dw Logged_0x4713E
	dw Logged_0x47150
	dw Logged_0x46C42
	dw Logged_0x46C42
	dw Logged_0x4705C
	dw Logged_0x47084
	dw Logged_0x46CC6
	dw Logged_0x3371
	dw Logged_0x470BA
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x46FD7
	dw Logged_0x4700A
	dw Logged_0x47228
	dw Logged_0x471F7
	dw Logged_0x3380
	dw Logged_0x338F
	dw Logged_0x33BC
	dw Logged_0x33CB
	dw Logged_0x339E
	dw Logged_0x33AD
	dw Logged_0x31A0
	dw Logged_0x31BE
	dw Logged_0x31DC
	dw Logged_0x31FA
	dw Logged_0x3218
	dw Logged_0x3236
	dw Logged_0x32CC
	dw Logged_0x32DB
	dw Logged_0x33F8
	dw Logged_0x3407
	dw Logged_0x46E1E
	dw Logged_0x46E02
	dw Logged_0x46C42

Logged_0x46C42:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$1B
	ld a,$30
	ld [hld],a
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x46C72
	res 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$493D
	call Logged_0x30F0
	ret

Logged_0x46C72:
	set 7,[hl]
	dec l
	xor a
	ld [hld],a
	ld de,$4946
	call Logged_0x30F0
	ret

Logged_0x46C7E:
	ld hl,$D11B
	ld a,$41
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Unknown_0x46CA7
	xor a
	ld [hld],a
	ld l,$0B
	ld a,[hl]
	cp $F6
	jr nz,Logged_0x46C9E
	ld a,$FA
	ld [hl],a
	ld de,$49DB
	call Logged_0x30F0
	ld a,$0E
	ld [hli],a
	ret

Logged_0x46C9E:
	ld de,$493D
	call Logged_0x30F0
	xor a
	ld [hl],a
	ret

Unknown_0x46CA7:
	xor a
	ld [hld],a
	ld l,$0C
	ld a,[hl]
	cp $09
	jr nz,Unknown_0x46CBD
	ld a,$05
	ld [hl],a
	ld de,$49E2
	call Logged_0x30F0
	ld a,$0E
	ld [hli],a
	ret

Unknown_0x46CBD:
	ld de,$4946
	call Logged_0x30F0
	xor a
	ld [hl],a
	ret

Logged_0x46CC6:
	ld hl,$D116
	ld a,[hl]
	and a
	jp z,Logged_0x329F
	dec [hl]
	ret nz
	ld a,[$D11A]
	rlca
	jr c,Unknown_0x46CDD
	ld de,$493D
	call Logged_0x30F0
	ret

Unknown_0x46CDD:
	ld de,$4946
	call Logged_0x30F0
	ret

Logged_0x46CE4:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x46CF5
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x46CF5:
	ld hl,$D116
	dec [hl]
	ret nz
	ld l,$1B
	ld a,$2E
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46D10
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$F6
	ld [hld],a
	ld de,$49C9
	jr Logged_0x46D1B

Logged_0x46D10:
	ld l,$0C
	ld a,$09
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld de,$49D2

Logged_0x46D1B:
	call Logged_0x30F0
	inc l
	ld a,$02
	ld [hl],a
	ld l,$08
	ld a,[hl]
	and $80
	or $21
	ld [hld],a
	ld l,$00
	bit 1,[hl]
	ret z
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$73
	ld [$FF00+$B6],a
	ret

Logged_0x46D38:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x46D49
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x46D49:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x46D64
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x46D64:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x46DAF
	ld a,[hl]
	and $0F
	sub $06
	jr nc,Logged_0x46D81
	call Logged_0x355B
	and $0F
	jr z,Logged_0x46D9F

Logged_0x46D81:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $06
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30CA

Logged_0x46D9F:
	ld a,[$D117]
	and a
	jr z,Logged_0x46DAA
	ld de,$49B3
	jr Logged_0x46DE6

Logged_0x46DAA:
	ld de,$4969
	jr Logged_0x46DF6

Logged_0x46DAF:
	ld a,[hl]
	and $0F
	add a,$05
	cp $10
	jr c,Logged_0x46DBF
	call Logged_0x3573
	and $0F
	jr z,Logged_0x46DDD

Logged_0x46DBF:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$05
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30BD

Logged_0x46DDD:
	ld a,[$D117]
	and a
	jr z,Logged_0x46DF3
	ld de,$49BE

Logged_0x46DE6:
	call Logged_0x30F0
	ld a,$24
	ld [hli],a
	dec [hl]
	ld a,$5A
	ld [$D11B],a
	ret

Logged_0x46DF3:
	ld de,$4976

Logged_0x46DF6:
	call Logged_0x30F0
	ld a,$3D
	ld [hli],a
	ld a,$5B
	ld [$D11B],a
	ret

Logged_0x46E02:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x46E13
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x46E13:
	ld hl,$D116
	dec [hl]
	ret nz
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x46E1E:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x46E2F
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x46E2F:
	ld hl,$D116
	ld a,[hl]
	cp $0F
	jr z,Logged_0x46E52
	dec [hl]
	jp nz,Logged_0x3308
	ld l,$1B
	ld a,$2E
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46E4B
	ld de,$49C9
	call Logged_0x30F0
	ret

Logged_0x46E4B:
	ld de,$49D2
	call Logged_0x30F0
	ret

Logged_0x46E52:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x46E64
	set 7,[hl]
	ld l,$0C
	ld a,$09
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ret

Logged_0x46E64:
	res 7,[hl]
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$F6
	ld [hld],a
	ret

Logged_0x46E6F:
	ld hl,$D108
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ld l,$1B
	ld a,$31
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46E87
	ld de,$493D
	jp Logged_0x30F0

Logged_0x46E87:
	ld de,$4946
	jp Logged_0x30F0

Logged_0x46E8D:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x46E9E
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x46E9E:
	ld a,[$CA8E]
	cp $C1
	jr z,Logged_0x46EEC
	ld c,$2A
	ld a,[$CA87]
	add a,c
	ld b,a
	ld a,[$D10D]
	add a,c
	sub b
	cp $18
	jr c,Logged_0x46EB9
	cp $E8
	jr c,Logged_0x46EEC

Logged_0x46EB9:
	ld hl,$D11A
	ld a,[$CA88]
	add a,c
	ld b,a
	ld a,[$D10E]
	add a,c
	sub b
	cp $C0
	jr nc,Logged_0x46EDB
	cp $40
	jr nc,Logged_0x46EEC
	ld a,[hli]
	rlca
	jr c,Logged_0x46ED7
	ld de,$494F
	jr Logged_0x46EE2

Logged_0x46ED7:
	ld a,$13
	ld [hl],a
	ret

Logged_0x46EDB:
	ld a,[hli]
	rlca
	jr nc,Logged_0x46ED7
	ld de,$495C

Logged_0x46EE2:
	ld a,$2D
	ld [hl],a
	call Logged_0x30F0
	ld a,$17
	ld [hli],a
	ret

Logged_0x46EEC:
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	call Logged_0x3543
	and a
	jr nz,Logged_0x46F07
	ld a,$11
	ld [$D11B],a
	ret

Logged_0x46F07:
	ld hl,$D103
	ld a,[$FF00+$A9]
	ld [hli],a
	ld a,[$FF00+$A8]
	ld [hli],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x46F48
	ld a,[hl]
	and $0F
	sub $06
	jr nc,Logged_0x46F24
	call Logged_0x355B
	and $0F
	jr z,Logged_0x46F42

Logged_0x46F24:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	sub $06
	ld [$FF00+$AB],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30C5

Logged_0x46F42:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x46F48:
	ld a,[hl]
	and $0F
	add a,$05
	cp $10
	jr c,Logged_0x46F58
	call Logged_0x3573
	and $0F
	jr z,Logged_0x46F76

Logged_0x46F58:
	ld hl,$D103
	ld a,[hli]
	sub $04
	ld [$FF00+$A9],a
	ld a,[hli]
	sbc a,$00
	ld [$FF00+$A8],a
	ld a,[hli]
	add a,$05
	ld [$FF00+$AB],a
	ld a,[hli]
	adc a,$00
	ld [$FF00+$AA],a
	call Logged_0x3513
	and a
	jp z,Logged_0x30B8

Logged_0x46F76:
	ld a,$13
	ld [$D11B],a
	ret

Logged_0x46F7C:
	ld hl,$D11B
	ld a,$32
	ld [hld],a
	jr Logged_0x46F8A

Logged_0x46F84:
	ld hl,$D11B
	ld a,$33
	ld [hld],a

Logged_0x46F8A:
	ld a,[hld]
	rlca
	jr c,Logged_0x46F93
	ld de,$4983
	jr Logged_0x46F96

Logged_0x46F93:
	ld de,$4986

Logged_0x46F96:
	call Logged_0x30F0
	ld a,$0C
	ld [hld],a
	ld a,$02
	ld [$D118],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ret

Logged_0x46FB2:
	ld hl,$D11B
	ld a,$46
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46FC1
	ld de,$4989
	jr Logged_0x46FC4

Logged_0x46FC1:
	ld de,$4992

Logged_0x46FC4:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x46FD7:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x46FE5:
	ld hl,$D11B
	ld a,$47
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x46FF4
	ld de,$4989
	jr Logged_0x46FF7

Logged_0x46FF4:
	ld de,$4992

Logged_0x46FF7:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a

Logged_0x4700A:
	ld hl,$D118
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld a,$0F
	ld [$D11B],a
	ret

Logged_0x47018:
	ld hl,$D11B
	ld a,$44
	ld [hld],a
	jr Logged_0x47026

Logged_0x47020:
	ld hl,$D11B
	ld a,$45
	ld [hld],a

Logged_0x47026:
	ld a,[hld]
	rlca
	jr c,Logged_0x4702F
	ld de,$4989
	jr Logged_0x47032

Logged_0x4702F:
	ld de,$4992

Logged_0x47032:
	call Logged_0x30F0
	inc l
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x4704D:
	ld a,$3F
	ld [$D11B],a
	ld a,$64
	ld [$D116],a
	ld hl,$D100
	res 2,[hl]

Logged_0x4705C:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x47069
	ld a,$1C
	ld [$D11B],a
	ret

Logged_0x47069:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32EA
	ld a,$10
	ld [$D11B],a
	ret

Logged_0x47076:
	ld hl,$D11B
	ld a,$40
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld a,$07
	ld [$D116],a

Logged_0x47084:
	ld hl,$D116
	dec [hl]
	jp nz,Logged_0x32F9
	ld a,$00
	ld [$D11B],a
	ret

Logged_0x47091:
	ld hl,$D11B
	ld a,$43
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x470A0
	ld de,$49A5
	jr Logged_0x470A3

Logged_0x470A0:
	ld de,$49AC

Logged_0x470A3:
	call Logged_0x30F0
	ld a,$1A
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $01
	ld [hld],a
	ret

Logged_0x470BA:
	ld a,[$CA97]
	cp $10
	jr c,Logged_0x470CB
	ld a,[$FF00+$04]
	rra
	ld a,$04
	rla
	ld [$D11B],a
	ret

Logged_0x470CB:
	ld hl,$D116
	ld a,[hl]
	cp $09
	jr z,Logged_0x470DD
	dec [hl]
	jp nz,Logged_0x3308
	ld a,$01
	ld [$D11B],a
	ret

Logged_0x470DD:
	dec [hl]
	ld l,$1A
	ld a,[hl]
	rlca
	jr c,Logged_0x470E7
	set 7,[hl]
	ret

Logged_0x470E7:
	res 7,[hl]
	ret

Logged_0x470EA:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$38
	jr Logged_0x470FC

Logged_0x470F4:
	ld hl,$D11C
	ld a,$8F
	ld [hld],a
	ld a,$39

Logged_0x470FC:
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x47106
	ld de,$4989
	jr Logged_0x47109

Logged_0x47106:
	ld de,$4992

Logged_0x47109:
	call Logged_0x30F0
	ld a,$04
	ld [hli],a
	inc l
	ld a,$02
	ld [hli],a
	xor a
	ld [hli],a
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret

Logged_0x47126:
	ld a,$3B
	ld [$D11B],a
	jr Logged_0x47132

Logged_0x4712D:
	ld a,$3C
	ld [$D11B],a

Logged_0x47132:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld a,$02
	ld [$D118],a
	ret

Logged_0x4713E:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$18
	ld a,[hl]
	and a
	jp nz,Logged_0x32BD
	ld de,$4969
	jr Logged_0x47160

Logged_0x47150:
	ld hl,$D114
	xor a
	ld [hli],a
	ld [hli],a
	ld l,$18
	ld a,[hl]
	and a
	jp nz,Logged_0x32AE
	ld de,$4976

Logged_0x47160:
	call Logged_0x30F0
	ld a,$3D
	ld [hli],a
	ld a,$5B
	ld [$D11B],a
	ret

Logged_0x4716C:
	ld hl,$D11B
	ld a,$59
	ld [hld],a
	ld b,$02
	jr Logged_0x47192

Logged_0x47176:
	ld hl,$D11B
	ld a,$58
	ld [hld],a
	ld b,$02
	jr Logged_0x47192

Logged_0x47180:
	ld hl,$D11B
	ld a,$34
	ld [hld],a
	ld b,$02
	jr Logged_0x47192

Logged_0x4718A:
	ld hl,$D11B
	ld a,$35
	ld [hld],a
	ld b,$02

Logged_0x47192:
	ld a,$81
	ld [$D11C],a
	ld a,[hl]
	and $F0
	ld [hld],a
	ld c,a
	xor a
	ld [hld],a
	ld a,b
	ld [hld],a
	ld a,c
	rlca
	jr c,Logged_0x471AA
	ld de,$499B
	jp Logged_0x30F0

Logged_0x471AA:
	ld de,$49A0
	jp Logged_0x30F0

Logged_0x471B0:
	ld hl,$D11B
	ld a,$36
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$C0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3335

Logged_0x471C3:
	ld hl,$D11B
	ld a,$37
	ld [hld],a
	dec l
	ld a,$41
	ld [hld],a
	ld a,$E0
	ld [hld],a
	ld a,$01
	ld [hld],a
	jp Logged_0x3344

Logged_0x471D6:
	ld hl,$D11B
	ld a,$49
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x471E5
	ld de,$4989
	jr Logged_0x471E8

Logged_0x471E5:
	ld de,$4992

Logged_0x471E8:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x471F7:
	ld a,[$CA69]
	and a
	jp nz,Logged_0x3353
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jr Logged_0x47207

Logged_0x47207:
	ld hl,$D11B
	ld a,$48
	ld [hld],a
	ld a,[hld]
	rlca
	jr c,Logged_0x47216
	ld de,$4989
	jr Logged_0x47219

Logged_0x47216:
	ld de,$4992

Logged_0x47219:
	call Logged_0x30F0
	ld l,$0C
	ld a,$05
	ld [hld],a
	ld a,$FA
	ld [hld],a
	ld l,$00
	set 2,[hl]

Logged_0x47228:
	ld a,[$CA69]
	and a
	jp z,Logged_0x3362
	ld hl,$D11A
	ld a,[hl]
	xor $80
	ld [hl],a
	jp Logged_0x471D6

Logged_0x47239:
	ld hl,$D11C
	ld a,$9F
	ld [hld],a
	ld a,$42
	ld [hld],a
	dec l
	xor a
	ld [hld],a
	ld l,$08
	ld a,[hl]
	and $80
	or $00
	ld [hld],a
	ret
	ld de,$4F6B
	call Logged_0x30F0
	ld l,$1F
	ld a,$72
	ld [hld],a
	ld a,$72
	ld [hld],a
	ld l,$1A
	res 5,[hl]
	set 4,[hl]
	ld l,$0C
	ld a,$07
	ld [hld],a
	ld a,$F8
	ld [hld],a
	ld a,$FC
	ld [hld],a
	ld l,$00
	set 3,[hl]
	ret
	ld hl,$D100
	res 4,[hl]
	ld l,$1F
	ld a,$72
	ld [hld],a
	ld a,$A6
	ld [hld],a
	ld l,$1A
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	cp b
	jr c,Logged_0x47296
	res 7,[hl]
	ld de,$4F74
	jr Logged_0x4729B

Logged_0x47296:
	set 7,[hl]
	ld de,$4F6B

Logged_0x4729B:
	call Logged_0x30F0
	ld a,$32
	ld [hli],a
	xor a
	ld [hli],a
	inc a
	ld [hl],a
	ret
	ld a,$81
	ld [$D11C],a
	ld a,[$D117]
	rst JumpList
	dw Logged_0x4731E
	dw Logged_0x47378
	dw Logged_0x4739C
	dw Logged_0x47388
	dw Logged_0x473AC
	dw Logged_0x472BB

Logged_0x472BB:
	call Logged_0x47453
	ld hl,$D103
	ld a,[hli]
	ld [$FF00+$A9],a
	ld a,[hli]
	ld [$FF00+$A8],a
	ld a,[hli]
	ld [$FF00+$AB],a
	ld a,[hl]
	ld [$FF00+$AA],a
	xor a
	ld [$C1CA],a
	call Logged_0x352B
	and a
	jr z,Logged_0x472DD
	ld a,[$C1CA]
	and a
	jr z,Logged_0x472E3

Logged_0x472DD:
	ld bc,$4690
	call Logged_0x34B7

Logged_0x472E3:
	ld hl,$D116
	dec [hl]
	jr z,Logged_0x47307
	ld a,[hl]
	cp $34
	ret nz
	ld a,$01
	ld [$FF00+$B5],a
	ld a,$68
	ld [$FF00+$B6],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x47301
	ld bc,$496E
	jp Logged_0x3416

Logged_0x47301:
	ld bc,$4983
	jp Logged_0x3416

Logged_0x47307:
	ld a,$32
	ld [hli],a
	xor a
	ld [hl],a
	ld a,[$D11A]
	rlca
	jr c,Logged_0x47318
	ld de,$4F74
	jp Logged_0x30F0

Logged_0x47318:
	ld de,$4F6B
	jp Logged_0x30F0

Logged_0x4731E:
	call Logged_0x473C0
	ld a,[$C094]
	and $F3
	jr z,Logged_0x4732D
	ld a,$32
	ld [$D116],a

Logged_0x4732D:
	ld hl,$D116
	ld a,[hl]
	and a
	jr z,Logged_0x47336
	dec [hl]
	ret

Logged_0x47336:
	ld l,$00
	bit 1,[hl]
	ret z
	ld a,[$CA88]
	add a,$2A
	ld b,a
	ld a,[$D10E]
	add a,$2A
	sub b
	cp $40
	jr c,Logged_0x4734E
	cp $C0
	ret c

Logged_0x4734E:
	ld a,[$D10D]
	add a,$2A
	ld b,a
	ld a,[$CA87]
	add a,$2A
	sub b
	cp $2B
	ret nc
	ld l,$16
	ld a,$52
	ld [hli],a
	ld a,$05
	ld [hli],a
	inc l
	xor a
	ld [hli],a
	ld a,[hld]
	rlca
	jr c,Logged_0x47372
	ld de,$4F9E
	jp Logged_0x30F0

Logged_0x47372:
	ld de,$4F8F
	jp Logged_0x30F0

Logged_0x47378:
	call Logged_0x473C0
	ld de,$4FC0
	call Logged_0x30F0
	ld a,$23
	ld [hli],a
	ld a,$03
	ld [hl],a
	ret

Logged_0x47388:
	call Logged_0x473C0
	ld hl,$D116
	dec [hl]
	ret nz
	ld de,$4F6B
	call Logged_0x30F0
	ld a,$32
	ld [hli],a
	xor a
	ld [hl],a
	ret

Logged_0x4739C:
	call Logged_0x473C0
	ld de,$4FB7
	call Logged_0x30F0
	ld a,$23
	ld [hli],a
	ld a,$04
	ld [hl],a
	ret

Logged_0x473AC:
	call Logged_0x473C0
	ld hl,$D116
	dec [hl]
	ret nz
	ld de,$4F74
	call Logged_0x30F0
	ld a,$32
	ld [hli],a
	xor a
	ld [hl],a
	ret

Logged_0x473C0:
	ld hl,$D100
	bit 1,[hl]
	jr nz,Logged_0x473CC
	ld a,$02
	ld [$D118],a

Logged_0x473CC:
	ld l,$05
	ld a,[hli]
	ld e,a
	ld d,[hl]
	ld a,[$CA63]
	ld b,a
	ld a,[$CA64]
	ld c,a
	ld a,b
	cp d
	jr c,Logged_0x4740B
	jr nz,Logged_0x473E3
	ld a,c
	cp e
	jr c,Logged_0x4740B

Logged_0x473E3:
	ld hl,$0020
	add hl,de
	ld a,b
	cp h
	jr c,Logged_0x473F1
	jr nz,Logged_0x473F8
	ld a,c
	cp l
	jr nc,Logged_0x473F8

Logged_0x473F1:
	ld a,$01
	ld [$D118],a
	jr Logged_0x473FB

Logged_0x473F8:
	call Logged_0x4749A

Logged_0x473FB:
	ld hl,$D11A
	bit 7,[hl]
	jr nz,Logged_0x47431
	set 7,[hl]
	ld a,$01
	ld [$D117],a
	jr Logged_0x47431

Logged_0x4740B:
	ld hl,$FFE0
	add hl,de
	ld a,b
	cp h
	jr c,Logged_0x47420
	jr nz,Logged_0x47419
	ld a,c
	cp l
	jr c,Logged_0x47420

Logged_0x47419:
	ld a,$01
	ld [$D118],a
	jr Logged_0x47423


