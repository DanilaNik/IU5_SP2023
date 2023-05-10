MYCODE segment 'CODE'
assume cs:MYCODE, ds:MYCODE
	; Работу выполлнил Никулин Данила ИУ5-41Б
	HEX_STRING DB '0123456789ABCDEF'
	Welcome DB 'Введите строки | Нажмите * для выхода$'
	StringLimit DB 'Достигнуто предельное число символов$'       
	QuitSym DB '*'
	StrTerm DB '$'
	Buf DB 21 DUP ('$')

start:
    	push CS
    	pop  DS
main:
	call clrscr
	mov DX, offset Welcome
	call printstr
	call clrf

GetString:
	mov SI, 0
	lea BX, Buf
	         
	;	check 1 sym for being *
	call getch
   	mov BX[SI], AX
   	
	cmp AL, QuitSym
	je Exit
	cmp AL, '$'
	je PrintString                  
	
	;	if not * || $ => print  	
	mov DX, AX   
	call putch
	inc SI
		
GetSym:	
	;	read sym by sym
	call getch
	mov BX[SI], AX
	
	cmp AL, StrTerm
	je PrintString
	
	mov DX, AX
	call putch

	cmp SI, 19
	je strlim
	
	;	loop back
	inc SI
	jmp GetSym
	
PrintString:   	 
	;	empty line guard
	mov AX, [BX]
	cmp AL, '$'
	je Handler$
	
	mov DX, 32
	call putch
	mov DX, '='
	call putch
	 
PrintHex:
	; 	output sym by sym
	xor SI, SI
PrintHexSym:
	; 	endline check '$'
	mov Al, BX[SI]
	cmp AL, '$'
	je Handler$ 
	;	print space ' ' 
	mov DX, 32
	call putch
	mov AX, BX[SI]
	push BX
	mov BX, offset HEX_STRING
	call hex
	pop BX	  
	
	;	cycle back
	inc SI
	jmp PrintHexSym  
	
Handler$: 
	call clrf
	jmp GetString
    
strlim:
	mov AX, '$'
	mov BX[SI], AX
	call clrf
	mov DX, offset StringLimit
	call printstr
	call clrf
	je PrintHex   
	
Exit:
	;call clrscr
	mov al, 0
	mov ah, 4ch
	int 021h
	
; print string
	printstr proc
		mov ah, 09h
		int 021h
		ret
	printstr endp
	
	putch proc
		mov ah, 02h
		int 021h
		ret
	putch endp
	
	getch proc   
		mov ah, 08h
		int 021h
        		ret
	getch endp

	; /n/r
	clrf proc
		mov dl, 10
		call putch
		mov dl, 13
		call putch
		ret
	clrf endp 

; Clean Srcreen
	clrscr proc   
		mov ah, 00h 
		mov al, 02
		int 10h
		ret
	clrscr endp
	
	hex proc
         		push AX
         		shr al, 4
         		xlat 
         		mov dl, al
		call putch
		
         		pop ax
		and al, 00001111b
         		xlat 
         		mov dl, al
		call putch
		mov dx, 104 ; h
    		call putch
   		ret
	hex endp

MYCODE ends
end start
	