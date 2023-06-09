MYCODE SEGMENT 'CODE'
	; ĄŽâã ĸë¯ŽĢ­¨Ģ ¨ĒãĢ¨­  ­¨Ģ  5-41  ĄŽāŽâŽ­ā­ ī 4
	
	ASSUME CS:MYCODE, DS:MYCODE
	HEX_TABLE DB '0123456789ABCDEF'
	WELCOME DB ' $'
	QUIT DB '* - $'
	DASH DB ' - $'
	QUIT_SYMBOL DB '*'

START:
	PUSH CS
	POP  DS
	MOV DX, OFFSET WELCOME	;  WELCOME
	CALL PRINT				;  WELCOME
	CALL CRLF

	CALL GETCH
	CALL CLRSCR
L:
	MOV CX, 20
	CYCLE:
		CALL PUTCH
		PUSH DX
		MOV DX, OFFSET DASH
		CALL PRINT
		POP DX
		CALL HEX 	;  DX
		CALL CRLF
		ADD DL, 1
	LOOP CYCLE

	MOV DX, OFFSET QUIT
	CALL PRINT
	CALL CRLF

	CALL GETCH
	CMP AL, '*'
	JE EXIT
	CALL CLRSCR
	JMP L

	EXIT:
		MOV AL, 0
		MOV AH, 4CH
		INT 21H
		RETN
	

	HEX PROC NEAR
		PUSH DX
		LEA BX, HEX_TABLE
		; A = 41H
		MOV DH, DL			;DH = DL
		SHR DH, 4			;     DH
		AND DL, 00001111B	;     DL
		MOV AL, DH			;   HEX_TABLE
		MOV DH, DL			;  
		XLATB				;   AL
		MOV DL, AL			;   
		CALL PUTCH

		MOV AL, DH
		XLATB
		MOV DL, AL
		CALL PUTCH	
		MOV DL, 'H'
		CALL PUTCH
		POP DX
		RETN
	HEX ENDP

	PUTCH PROC NEAR
		MOV AH, 02H
		INT 021H
		RETN
	PUTCH ENDP

	CRLF PROC NEAR
		PUSH DX
		MOV DL, 10
		CALL PUTCH
		MOV DL, 13
		CALL PUTCH
		POP DX
		RETN
	CRLF ENDP

	GETCH PROC NEAR
		MOV AH, 01H
		INT 21H
		MOV DL, AL
		RETN
	GETCH ENDP

	CLRSCR PROC NEAR
		PUSH DX
		MOV AX, 03
		INT 10H
		POP DX
		RETN
	CLRSCR ENDP


	PRINT PROC NEAR
		MOV AH, 09h
		INT 21H
		RETN
	PRINT ENDP

MYCODE ENDS
END START