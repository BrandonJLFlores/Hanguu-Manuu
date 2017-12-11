TITLE HANGMAN (SIMPLFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 100H
;---------------------------------------------
.DATA
	TEMP DB 32 DUP('$') 

	PROMPT3 DB 0DH,0AH,'What letter do you guess?  ', '$'
	PROMPT4 DB 0DH,0AH,'The word is:',0DH,0AH, '$'
	PROMPT5 DB 0DH,0AH,'Congratulations! You won the game',0DH,0AH, '$'
	PROMPT6 DB 0DH,0AH,'Sorry you missed.',0DH,0AH, '$'
	PROMPT7 DB 0DH,0AH,'Sorry, duplicate entry.  Please try again.',0DH,0AH, '$'
	PROMPT8 DB 0DH,0AH,'List of chosen letter(s): ', '$'
	CRLF   DB  0DH, 0AH, '$'
	NEWLINE DB 10,13,'$'
	
	FIG0    DB 0DH,0AH,' +=======+',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
	FIG1    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
	FIG2    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/        |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
	FIG3    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/ \      |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
	FIG4    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/|\      |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
	FIG5    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/|\      |',0DH,0AH,' |       |',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
	FIG6    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/|\      |',0DH,0AH,' |       |',0DH,0AH,'/        |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
	FIG7    DB 0DH,0AH,' +=======+',0DH,0AH,' |       |',0DH,0AH,' O       |',0DH,0AH,'/|\      |',0DH,0AH,' |       |',0DH,0AH,'/ \      |',0DH,0AH,'         |',0DH,0AH,' ========+',0DH,0AH,'$'
	FIG8    DB 0DH,0AH,' +=======+',0DH,0AH,'         |',0DH,0AH,'         |',0DH,0AH,'   \O/   |',0DH,0AH,'    |    |',0DH,0AH,'    |    |',0DH,0AH,'   / \   |',0DH,0AH,' ========+',0DH,0AH,'$'
	
	ERROR1_STR    DB 'Error in opening file.$'
  ERROR2_STR    DB 'Error reading from file.$'
  ERROR3_STR    DB 'No record read from file.$'
	
	PATHFILENAME  DB 'file.txt', 00H
  FILEHANDLE    DW ?

	STACK_INPUT		DB 32 DUP('$') 
	RECORD_STR    DB 32 DUP('$')  ;length = original length of record + 1 (for $)
  TOBESOLVED    DB 32 DUP(' ')  ;length = original length of record + 1 (for $)
	
	
	;TEMP DB ?,'$'
	;STACK_INPUT DB ?,'$'
	CREDIT    DB ?
	correct   DB ?
	incorrect DB ?
	STR_L	  DB ?
	;MSG  DB ?,'$'
	MSG DB 32 DUP('$') 
	
	COUNT DW ?
	COUNT2 DB 0
	TEMPSI DW ?
	
  
;---------------------------------------------
.CODE
;*************************************************************************
;  MACRO FOR PRINTING STRINGS
;*************************************************************************
PRINTSTR MACRO STRING

MOV AH,9
LEA DX, STRING
INT 21H
ENDM

PRINTCH MACRO STRING

MOV AH,2
MOV DL,AL
INT 21H
ENDM

MAIN PROC FAR
  MOV AX, @data
  MOV DS, AX
	XOR BP,BP
	LEA SI, RECORD_STR
	LEA DI, TOBESOLVED
	MOV BP,SI
	
  ;MAINGAME:
;*************************************************************************
;  FILE READING
;*************************************************************************
  ;open file
  MOV AH, 3DH           ;requst open file
  MOV AL, 00            ;read only; 01 (write only); 10 (read/write)
  LEA DX, PATHFILENAME
  INT 21H
  JC DISPLAY_ERROR1
  MOV FILEHANDLE, AX

  ;read file
  MOV AH, 3FH           ;request read record
  MOV BX, FILEHANDLE    ;file handle
  MOV CX, 1000            ;record length
  LEA DX, RECORD_STR    ;address of input area
  INT 21H
  JC DISPLAY_ERROR2
  CMP AX, 00            ;zero bytes read?
  JE DISPLAY_ERROR3
  
	
	
	CALL GETCOUNT ;gets file string length
	
	;PLAY:
	CALL GETLINE ; gets 1 line form file
	
  ;display record
		PRINTSTR TOBESOLVED
	
	CALL TABLE
	CALL matchWord
	
	;PRINTSTR NEWLINE
	
	;LEA DI, TOBESOLVED
	
	;CMP COUNT,0
	;JNE PLAY
	
	;close file handle
  MOV AH, 3EH           ;request close file
  MOV BX, FILEHANDLE    ;file handle
  INT 21H
	;JMP MAINGAME
	
  JMP EXIT

DISPLAY_ERROR1:
  LEA DX, ERROR1_STR
  MOV AH, 09
  INT 21H

  JMP EXIT

DISPLAY_ERROR2:
  LEA DX, ERROR2_STR
  MOV AH, 09
  INT 21H

  JMP EXIT

DISPLAY_ERROR3:
  LEA DX, ERROR3_STR
  MOV AH, 09
  INT 21H

EXIT:
  MOV AH, 4CH
  INT 21H
MAIN ENDP

GETCOUNT PROC
	MOV CX,AX
	MOV COUNT,CX
	RET
GETCOUNT ENDP

GETLINE PROC
	MOV SI,BP
	MOV TEMPSI, SI

	ITERATE:
		MOV AL,[SI]
		CMP AL,'*'
		JE ENDGET
		MOV [DI],AX
		INC SI
		INC DI
		DEC COUNT
	JMP ITERATE	
		
	
	ENDGET:
	DEC COUNT
	MOV AL,10
	MOV [DI],AX
	MOV AL,13
	MOV [DI],AX
	MOV AL,'$'
	MOV [DI],AX
	INC SI
	MOV BP,SI

	RET
GETLINE ENDP

;*************************************************************************
;  table procedure
;*************************************************************************

TABLE PROC 	
;copy string
	XOR SI,SI
COPY0:
	CMP TOBESOLVED[SI],'$'
	JE END0
	MOV AL,TOBESOLVED[SI]
	MOV MSG[SI],AL
	INC SI
	LOOP COPY0
END0:
	MOV MSG[SI],'$'
	;PRINTSTR MSG
  CALL displayEmpty    	 	
	
	RET
TABLE ENDP

;**************************************************************************
;	displayEmpty Procedure
;**************************************************************************
displayEmpty PROC
	MOV STR_L,0		;initialize string length
	MOV BL,'-'
	MOV AH,9
	LEA DX,CRLF
	INT 21H
;display dash
	XOR SI,SI		;resets index
BEGIN:
	CMP MSG[SI],'$'
	JE End_
	MOV TEMP[SI],BL
	INC STR_L
	INC SI
	JMP BEGIN
End_ :
	MOV TEMP[SI],'$'

	MOV AH,9
	LEA DX,TEMP
	INT 21H
	MOV AH,9
	LEA DX,CRLF
	INT 21H

 	RET

displayEmpty ENDP

;***************************************************************************
;	matchWord Procedure
;***************************************************************************
matchWord PROC
	MOV CREDIT,0		;initialize Credit
	MOV  correct,0		;initialize values of correct & incorrect
	MOV  incorrect,0
	MOV CX,7
INPUT:	;*********************** user input loop ***************************
	CMP CX,0
	JE  looses
	MOV DL,correct
	CMP DL,STR_L
	JE  wins
OTHER_INPUT:
	MOV AH,9	
	LEA DX,PROMPT3		;asks "What letter do you guess?"
	INT 21H
	MOV AH,1
	INT 21H
	MOV BL,AL		;save input to BL
	XOR SI,SI
CHECK_DUP:			;check if there is a duplicate entry
	CMP STACK_INPUT[SI],'$'
	JE  STORE_INPUT		
	CMP AL,STACK_INPUT[SI]
	JE  DUPLICATE
	INC SI
	JMP CHECK_DUP
DUPLICATE:
	MOV AH,9
	LEA DX,PROMPT7
	INT 21H
	JMP OTHER_INPUT	
STORE_INPUT:
	MOV STACK_INPUT[SI],BL
	INC SI
	MOV STACK_INPUT[SI],'$'

	MOV AH,9
	LEA DX,PROMPT8
	INT 21H	
	MOV AH,9
	LEA DX,STACK_INPUT
	INT 21H	

	MOV AH,9
	LEA DX,PROMPT4
	INT 21H			;Comment the user's guessing 
	XOR SI,SI		;resets index
COMPARE:;*********************** compares an char input to a word ***********
	CMP MSG[SI],'$'
	JE GETINPUT
	CMP BL,MSG[SI]		;input matches any letter of the word?
	JE GAIN_CORRECT
	INC SI
	JMP COMPARE
wins:
jmp WINCASE
looses:
jmp LOOSE
	

GAIN_CORRECT:
	MOV TEMP[SI],BL
	INC SI
	INC correct
	INC CREDIT
	JMP COMPARE
GETINPUT:
	MOV AH,9
	LEA DX,TEMP
	INT 21H
	CMP CREDIT,0
	JG  GAIN_SCORE
	DEC CX
	INC incorrect
GAIN_SCORE:
	CALL DISPLAY
	XOR SI,SI		;resets index
	MOV CREDIT,0
	JMP INPUT
WINCASE:
	MOV incorrect,8
	CALL DISPLAY
	MOV AH,9
	LEA DX,PROMPT5
	INT 21H
	JMP RESULT
LOOSE:
	MOV AH,9
	LEA DX,PROMPT6
	INT 21H	
RESULT:
	RET			;return to main

matchWord ENDP

;*************************************************************************
;	Display (bitmap) procedure
;*************************************************************************
DISPLAY PROC
;checking score value and display
        CMP incorrect,0
        JE DISP0

        CMP incorrect,1
        JE DISP1

        CMP incorrect,2
        JE DISP2

        CMP incorrect,3
        JE DISP3

        CMP incorrect,4
        JE DISP4

        CMP incorrect,5
        JE DISP5

        CMP incorrect,6
        JE DISP6

        CMP incorrect,7
        JE DISP7

        CMP incorrect,8
        JE DISP8

        ret

;display message0
DISP0:
        LEA DX,FIG0
        MOV AH,9
        INT 21h
        RET

DISP1:
;display message1
        LEA DX,FIG1
        MOV AH,9
        INT 21h
        RET

DISP2:
;display message2
        LEA DX,FIG2
        MOV AH,9
        INT 21h
        RET

DISP3:
;display message3
        LEA DX,FIG3
        MOV AH,9
        INT 21h
        RET

DISP4:
;display message4
        LEA DX,FIG4
        MOV AH,9
        INT 21h
        RET

DISP5:
;display message5
        LEA DX,FIG5
        MOV AH,9
        INT 21h
        RET

DISP6:
;display message6
        LEA DX,FIG6
        MOV AH,9
        INT 21h
        RET

DISP7:
;display message7
        LEA DX,FIG7
        MOV AH,9
        INT 21h
        RET

DISP8:
;display message8
        LEA DX,FIG8
        MOV AH,9
        INT 21h
        RET

DISPLAY ENDP

END MAIN
