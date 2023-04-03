; libreria para str
; bloque de rutinas de entrada y salida de args

%include	'stdio-args32.asm'

;=============================Funcion de aumento mayus =========
; void mayus(cadena)

SECTION .data
	msg 	db 	'Ingrese texto: ', 0h
	msg2	db	'Texto en minusculas es: ', 0h

SECTION .bss
	texto:	resb	50

SECTION .text
	global	_start

_start:
	mov 	eax, msg
	call	printStrLn

	mov	eax, 50
	mov	ebx, texto
	call	input

	mov	eax, msg2
	call	printStrLn

	mov	eax, texto
	call	strLocase

	call	endP
