; ������ �믮���� ���㫨� ��5-41� ������ୠ� ࠡ�� �3

MYCODE SEGMENT 'CODE'
    ASSUME CS:MYCODE, DS:MYCODE
LET  DB 'N'
START:
; ����㧪� ᥣ���⭮�� ॣ���� ������ DS
     PUSH CS
     POP  DS
; �뢮� ������ ᨬ���� �� ��࠭
     CALL PRINTLET
	 CALL CRLF
	 ADD LET, 1
; �뢮� ��ண� ᨬ���� �� ��࠭
	 CALL PRINTLET
	 CALL CRLF
	 ADD LET, 1
; �뢮� ���쥣� ᨬ���� �� ��࠭
	 CALL PRINTLET
	 CALL CRLF
	 ADD LET, 1
; ��室 �� �ணࠬ��
     MOV AL, 0
     MOV AH, 4CH
     INT 21H
	 
PRINTLET PROC NEAR
	MOV AH, 02
	MOV DL, LET
	INT 21H
	RETN
PRINTLET ENDP

CRLF PROC NEAR
	MOV AH, 02
	MOV DL, 10
	INT 21H
	MOV AH, 02
	MOV DL, 13
	INT 21H
	RETN
CRLF ENDP

MYCODE ENDS
END START