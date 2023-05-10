MYCODE segment 'CODE'
assume cs:MYCODE, ds:MYCODE
;������ �믮���� ���㫨� ������ ��5-41� ������ୠ� ࠡ�� �7
	Buf_Hex DB 5 DUP ('$')
	Welcome DB '������ �᫮ (������ * ��� ��室�)$'    
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
	MOV CX, 4; 4 ࠧ�鸞
	CALL clrf
GetSym:	
	xor AX, AX; ��頥� 
	CALL getch
	cmp AL, '*'; ��室�� �᫨ ᨬ��� *
	je Exit 
	Check_if_in_hex: ; ��室�� �᫨ ᨬ��� �� ���室�� ��� �ॡ������
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
;������塞 � AX �� �᫮ � hex. ������ ⠪�� - ������塞 �᫮, � ��⮬ ᤢ����� � ⠪ ���� �� ����稬 � AX ����砫쭮� �᫮
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
	
;������ ��ॢ���� � �뢮��� �᫮ � dec ����, �� �।���⥫쭮 �뢥��� hex ��� �᫠ � �஡��
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
Convert: ; ����� �� 10 �᫮ � ��⭠����筮� ��⥬�, ���� ��������� �� ����稬 ��� � �����筮� ��⥬�
	xor DX,DX
	DIV CX
	push DX
	ADD SI,1
	CMP AX, 0
	je Print_dec
	JMP Convert
Print_dec:; � ⥯��� �뢮��� ����ᠭ��� � �⥪� �᫮, �������� 48 � ������ ᮮ⢥����騩 ᨬ��� �� ⠡���� ASCII
	pop DX
	ADD DL,48
	call putch
	DEC SI
	cmp SI, 0
	je JmpFar
	jmp Print_dec
	
	
Remember_numbers:
		;���������� ���� (�� ᨬ����) ��⤭�������� �ᥫ
		cmp AL, 'A'
		jl if_less_then_A
		push AX
		sub AL,55;(�ਬ�� ��� ᨬ���� F(��� ASCII - 70, � � HEX-46): 46 - 55 = -15 = -F (�. ����� �� ���뢠����) = F)
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
	