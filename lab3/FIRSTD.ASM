; Работу выполнил Никулин ИУ5-41Б Лаборатрная работа №3

MYCODE SEGMENT 'CODE'
    ASSUME CS:MYCODE, DS:MYCODE
LET  DB 'N'
START:
; Загрузка сегментного регистра данных DS
     PUSH CS
     POP  DS
; Вывод одного символа на экран
     CALL PRINTLET
	 CALL CRLF
	 ADD LET, 1
; Вывод второго символа на экран
	 CALL PRINTLET
	 CALL CRLF
	 ADD LET, 1
; Вывод третьего символа на экран
	 CALL PRINTLET
	 CALL CRLF
	 ADD LET, 1
; Выход из программы
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