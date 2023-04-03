; libreria para str
; bloque de rutinas de entrada y salida de args

%include 	'stdio32.asm'

;=============== Funcion converir a minusculas ================
; void strLocase(cadena)
strLocase:
	push 	ebx
	push	eax

	mov 	ebx, eax

siguiente1:
	cmp	byte [ebx], 0
	jz	finCiclo1
	cmp	byte [ebx], 32
	je	espacioMinus
	cmp	byte [ebx], 10
	je	espacioMinus
	cmp	byte [ebx], 'A'
	jl	espacioMinus
	cmp	byte [ebx], 'Z'
	jle	sigueMayus
	inc 	ebx
	jmp	siguiente1

espacioMinus:
	inc 	ebx
	jmp	siguiente1

sigueMayus:
	add 	byte [ebx], 32
	inc 	ebx
	jmp	siguiente1

finCiclo1:
	call	printStr

	pop	eax
	pop	ebx
	int	80h
	ret

;============== Funcion converir a mayusculas ==============
; void strUpcase(cadena)
strUpcase:
	push 	ebx
	push	eax

	mov 	ebx, eax

siguiente2:
	cmp	byte [ebx], 0
	jz	finCiclo2
	cmp	byte [ebx], 32
	je	espacioMayus
	cmp	byte [ebx], 10
	je	espacioMayus
	cmp	byte [ebx], 'z'
	jg	espacioMayus
	cmp	byte [ebx], 'a'
	jge	sigueMinus
	inc 	ebx
	jmp	siguiente2

espacioMayus:
	inc 	ebx
	jmp	siguiente2

sigueMinus:
	sub 	byte [ebx], 32
	inc 	ebx
	jmp	siguiente2

finCiclo2:
	call	printStr

	pop	eax
	pop	ebx
	int	80h
	ret

;================= Funcion invertir cadena ================
; void strInverir(cadena)
strInvertir:
	push 	ebp
	mov	ebp, esp
	mov	eax, [ebp+8]
cadena_pila:
	mov 	bl, byte [eax]
	cmp	bl, 0
	jz	fin_cadena_pila
	push	bx
	inc 	eax
	jmp	cadena_pila

fin_cadena_pila:
	mov	eax, [ebp+8]
	jmp	invert

invert:
	pop 	bx
	mov	byte [eax], bl
	cmp	bl, 0
	jz	fin_invert
	inc	eax
	jmp	invert

fin_invert:
	leave
	ret
