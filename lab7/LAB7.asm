MYCODE segment 'CODE'
assume cs:MYCODE, ds:MYCODE
;Работу выполнил Никулин Данила ИУ5-41Б Лабараторная работа №7
	Buf_Hex DB 5 DUP ('$')
	Welcome DB 'Введите число (нажмите * для выхода)$'    
start:
    	push CS
    	POP  DS
main:
	CALL clrscr
	MOV DX, offset Welcome
	CALL printstr
	CALL clrf

GetString:
	MOV SI, 0
	lea BX, Buf_Hex
	MOV CX, 4; 4 разряда
	CALL clrf
GetSym:	
	xor AX, AX; Очищаем 
	CALL getch
	cmp AL, '*'; Выходим если символ *
	je Exit 
	Check_if_in_hex: ; Выходим если символ не подходит под требования
		cmp AL, 'F'
		jg GetSym
		cmp AL, '0'
		jl GetSym
	jmp Remember_numbers
AfterCheck:
	MOV BX[SI], AL
	MOV DL,AL
	CALL putch
	ADD SI,1
	LOOP GetSym
	MOV DL, '='
	CALL putch
	jmp Translate_to_dec
Exit:
CALL exit_f
JmpFar:
jmp GetString
Translate_to_dec:
;Соединяем в AX все число в hex. Алгоритм такой - добавляем число, а потом сдвигаем и так пока не получим в AX изначальное число
	POP AX
	ROR AX,4
	POP SI
	ADD AX,SI
	ROR AX,4
	POP SI
	ADD AX,SI
	ROR AX,4
	POP SI
	ADD AX,SI
	ROR AX,4
	
;Теперь переводим и выводим число в dec виде, но предворительно выведем hex вид числа и пробел
	push AX
	MOV CX, 10
	MOV SI, 0
	lea DX, Buf_Hex
	CALL printstr
	MOV DX, 'h'
	CALL putch
	MOV DX, ' '
	CALL putch
	POP AX
Convert: ; Делим на 10 число в шестнадцетеричной системе, пока полностью не получим его в десятичной системе
	xor DX,DX
	DIV CX
	push DX
	ADD SI,1
	CMP AX, 0
	je Print_dec
	JMP Convert
Print_dec:; А теперь выводим записанное в стеке число, добавляя 48 и получая соответсвующий символ из таблицы ASCII
	pop DX
	ADD DL,48
	call putch
	DEC SI
	cmp SI, 0
	je JmpFar
	jmp Print_dec
	
	
Remember_numbers:
		;Запоминаем цифры (не символы) шестднадцетеричных чисел
		cmp AL, 'A'
		jl if_less_then_A
		push AX
		sub AL,55;(Пример для символа F(код ASCII - 70, а в HEX-46): 46 - 55 = -15 = -F (тк. минус не учитывается) = F)
		MOV DL,AL
		POP AX
		push DX
		jmp AfterCheck
		if_less_then_A:
			push AX
			sub AL,48
			MOV DL,AL
			POP AX
			push DX
		jmp AfterCheck

	printstr proc
		MOV ah, 09h
		int 021h
		ret
	printstr endp
	
	putch proc
		MOV ah, 02h
		int 021h
		ret
	putch endp
	
	getch proc   
		MOV ah, 08h
		int 021h
        		ret
	getch endp

	clrf proc
		MOV dl, 10
		CALL putch
		MOV dl, 13
		CALL putch
		ret
	clrf endp 

	clrscr proc   
		MOV ah, 00h 
		MOV al, 02
		int 10h
		ret
	clrscr endp
	
	exit_f proc
		MOV al, 0
		MOV ah, 4ch
		int 021h
	exit_f endp

MYCODE ends
end start
	