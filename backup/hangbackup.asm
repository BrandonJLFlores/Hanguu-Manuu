TITLE HANGMAN (SIMPLFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 100H
;---------------------------------------------
.DATA
	TEMP DB 32 DUP('$') 
	HOWTO_FILE DB 'howto.txt', 00H
	GAMEOVER_FILE DB 'gameover.txt', 00H
  ERROR_STR DB "ERROR!$"
	HOWTO_STR DB 2001 DUP('$')
	GAMEOVER_STR DB 2001 DUP('$')

	MESSAGE  DB 0ah, 0dh,"       __  __    ___     _   __   ______   __  __   __  __        ._________", 0ah, 0dh    
					 DB "      / / / /   /   |   / | / /  / ____/  / / / /  / / / /       _|_        |", 0ah, 0dh
					 DB "     / /_/ /   / /| |  /  |/ /  / / __   / / / /  / / / /       /x x\       |", 0ah, 0dh
					 DB "    / __  /   / ___ | / /|  /  / /_/ /  / /_/ /  / /_/ /        \___/       |", 0ah, 0dh
					 DB "   /_/ /_/   /_/  |_|/_/ |_/   \____/   \____/   \____/          /|\        |", 0ah, 0dh
					 DB "                                                                / | \       |", 0ah, 0dh
					 DB "       __  ___    ___     _   __   __  __   __  __                -         |", 0ah, 0dh
					 DB "      /  |/  /   /   |   / | / /  / / / /  / / / /               / \        |", 0ah, 0dh
					 DB "     / /|_/ /   / /| |  /  |/ /  / / / /  / / / /               /   \       |", 0ah, 0dh
					 DB "    / /  / /   / ___ | / /|  /  / /_/ /  / /_/ /                            |", 0ah, 0dh
					 DB "   /_/  /_/   /_/  |_|/_/ |_/   \____/   \____/                       ______|___$", 0ah, 0dh
	
	FTXT DB "MAIN MENU$", 0ah, 0dh
  OPT1 DB " Normal Mode$", 0ah, 0dh
  OPT2 DB " Extreme Mode$", 0ah, 0dh
  OPT3 DB " How to Play$", 0ah, 0dh
  OPT4 DB " Exit$"
	
	PROMPT3 DB 0DH,0AH,'What letter do you guess?  ', '$'
	PROMPT4 DB 0DH,0AH,'The word is:',0DH,0AH, '$'
	PROMPT5 DB 0DH,0AH,'Congratulations! You won the round',0DH,0AH, '$'
	PROMPT6 DB 0DH,0AH,'Sorry you missed.',0DH,0AH, '$'
	PROMPT7 DB 0DH,0AH,'Sorry, duplicate entry.  Please try again.',0DH,0AH, '$'
	PROMPT8 DB 0DH,0AH,'List of chosen letter(s): ', '$'
	CURRENTHIGH DB 0DH,0AH,'Score to beat: ', '$'
	CURRENTSCORE DB 0DH,0AH,'Your score: ', '$'
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
	ERROR4_STR    DB 'Error writing in file.$'
  ERROR5_STR    DB 'Record not written properly.$'
	
	WORDS  DB 'words.txt', 00H
	HIGHSCORETXT  DB 'high.txt', 00H
	;HIGHSCORETXT2  DB 'high2.txt', 00H
  FILEHANDLE    DW ?

	STACK_INPUT		DB 32 DUP('$') 
	RECORD_STR    DB 2001 DUP('$')  ;length = original length of record + 1 (for $)
  TOBESOLVED    DB 32 DUP(' ')  ;length = original length of record + 1 (for $)
	HIGH_STR    DB 32 DUP('$')    ;
	;HIGH_STR  DW 10
  ;      DW 0
	;			DW 10 DUP(0)
	
	
	;TEMP DB ?,'$'
	;STACK_INPUT DB ?,'$'
	CREDIT    DB ?
	correct   DB ?
	incorrect DB ?
	STR_L	  DB ?
	;MSG  DB ?,'$'
	MSG DB 32 DUP('$') 
	RES  DW 100 DUP ('$')
	RES2  DB 10
        DB 0
				DB 10 DUP(0)
  multiplier db 0ah
	
	COUNT DW ?
	SCORE DW ?
	;SCORE DW 10
  ;      DW 0
	;			DW 10 DUP(0)
	HIGHSCORE DW 100 DUP ('$')
	MODE DB 1 ;-------NORMAL OR EXTREME MODE-------;
	LOSE DW ? ;--------IF DEDZ NA BA-----------;
	TEN DW ?
	TOT DW ? ;**********TOTAL HIGH***************;
	COUNTER DW ? ;**********TOTAL CURRENT***************;
	ARROW DB 175, '$'
  ARROW_ROW DB 16
  ARROW_COL DB 01EH 
  SPACE DB " $"
  FLAG DB 0 
	NEW_INPUT   DB    ?
	
	
	
  
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

;*************************************************************************
;  MACRO FOR CLEARING STRINGS
;*************************************************************************
RESETS MACRO STRING 	
	LOCAL WIPE
	LOCAL ENDRESET
	XOR  SI,SI
WIPE:
     CMP  STRING[SI], '$'
		 JE ENDRESET
     MOV  STRING[SI], '$'
		 INC  SI
		 JMP WIPE
     
		 ENDRESET:
ENDM

MAIN PROC FAR
  MOV AX, @data
  MOV DS, AX
	
	LEA DX,HOWTO_FILE
	CALL OPEN
	LEA DX,HOWTO_STR
	CALL READ
	CALL FILECLOSE
	
	LEA DX,GAMEOVER_FILE
	CALL OPEN
	LEA DX,GAMEOVER_STR
	CALL READ
	CALL FILECLOSE
	
	CALL DISPLAY_HOME_SCREEN
	CALL MAINGAME

EXIT:
  MOV AH, 4CH
  INT 21H
MAIN ENDP

MAINGAME PROC
	XOR BP,BP
	MOV SCORE,0
;*************************************************************************
;  FILE READING
;*************************************************************************
	LEA SI, RECORD_STR
	LEA DI, TOBESOLVED
	MOV BP,SI
	
	;-------READ FOR HIGHSCORE-------;
	;-------CONVERT TEXT TO HEX---------;
	LEA DX,HIGHSCORETXT
	CALL OPEN
	LEA DX, HIGH_STR
	CALL READ
	CALL STR2HEX	
	
	CALL FILECLOSE
	
	;-------READ FOR WORDS-------;
  LEA DX, WORDS
	CALL OPEN
  LEA DX, RECORD_STR    ;address of input area
	CALL READ
  
	CALL GETCOUNT ;gets file string length
	MOV CREDIT,0		;initialize Credit
	MOV  correct,0		;initialize values of correct & incorrect
	MOV  incorrect,0
	MOV CX,7
	MOV LOSE,0
	
;*************************************************************************
;  LOOP FOR ALL WORDS IN THE FILE
;*************************************************************************
	PLAY:
	CALL GETLINE ; gets 1 line form file
	
	CMP LOSE,1
	JE OVER
	CALL TABLE
	CALL matchWord
	
	CALL RESET
	LEA DI, TOBESOLVED
	
	CMP COUNT,0
	JNE PLAY
	
	CALL FILECLOSE
	JMP OVER
	
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
	
	JMP EXIT
	
RET
MAINGAME ENDP

OVER:
CALL _CLEAR_SCREEN
CALL DISPGAMEOVER
OVER2:
		MOV NEW_INPUT,0
		CALL GET_INPUT
		CMP NEW_INPUT,1CH
		JNE OVER2
		CALL DISPLAY_HOME_SCREEN

;*************************************************************************
;  FILECLOSE DISPLAY
;*************************************************************************

FILECLOSE PROC
	 MOV AH, 3EH           ;request close file
  MOV BX, FILEHANDLE    ;file handle
  INT 21H
	RET
FILECLOSE ENDP

;*************************************************************************
;  OPEN procedure
;*************************************************************************

OPEN PROC
	MOV AH, 3DH           
	MOV AL, 00            
	INT 21H
	JC DISPLAY_ERROR1
	MOV FILEHANDLE, AX
	RET

OPEN ENDP

;*************************************************************************
;  READ procedure
;*************************************************************************
READ PROC
	MOV AH, 3FH           
	MOV BX, FILEHANDLE    
	MOV CX, 2000             
	INT 21H
	JC DISPLAY_ERROR2
	CMP AX, 00            
	JE DISPLAY_ERROR3

	RET

READ ENDP

EXITP	PROC
	MOV AH, 4CH
  INT 21H
RET
EXITP ENDP

DISPOPT PROC
		
    ;set cursor
    MOV		DL, 01
    MOV		DH, 01
    CALL	_SET_CURSOR  
  
    PRINTSTR MESSAGE

;---------------------------------------------no. 1
    MOV DL, 01FH
    MOV DH, 16
    CALL _SET_CURSOR

    PRINTSTR OPT1
    
;---------------------------------------------no. 2    

    MOV DL, 01FH
    MOV DH, 17
    CALL _SET_CURSOR
		PRINTSTR OPT2
 
;---------------------------------------------no. 3    

    MOV DL, 01FH
    MOV DH, 18
    CALL _SET_CURSOR

    PRINTSTR OPT3

;---------------------------------------------no. 4

    MOV DL, 01FH
    MOV DH, 19
    CALL _SET_CURSOR
		PRINTSTR OPT4
;---------------------------------------------main menu functions

	 ARROW_POS:
    MOV DH, ARROW_ROW
    MOV DL, ARROW_COL
    PUSH DX
    CALL _SET_CURSOR2

    DISPLAY_ARROW:
    MOV AH, 09H
    LEA DX, ARROW
    INT 21H
    CALL _CURSOR_REMOVE
RET
DISPOPT ENDP

;*************************************************************************
;  MENU DISPLAY
;*************************************************************************
DISPLAY_HOME_SCREEN PROC

  MENUMAIN:
    CALL _CLEAR_SCREEN
		CALL DISPOPT
		
    CHOOSE:
    MOV FLAG, 0   
    MOV AH, 00H   
    INT 16H
    CMP AL, 0DH   
    JNE SKIP_TO_LEFT
    JMP CHOICE
    SKIP_TO_LEFT:
    CMP AH, 48H   
    JE  UP
    CMP AH, 50H 
    JE  DOWN

    JMP CHOOSE
		
		HOW_TO2:
		CALL GET_INPUT
		CMP NEW_INPUT,1CH
		JNE HOW_TO2
		JE MENUMAIN
		
    UP:
    CMP ARROW_ROW, 16   
    JNE  SET_DELETE_POS

    SET_TUMOY_UP:
    MOV FLAG, 1

    SET_DELETE_POS:
    MOV DH, ARROW_ROW
    MOV DL, ARROW_COL
    PUSH DX
    CALL _SET_CURSOR2

    DELETE_ARROW:
    MOV AH, 09H
    LEA DX, SPACE
    INT 21H
    CALL _CURSOR_REMOVE

    SET_ARROW_POS:
    CMP FLAG, 1
    JNE CONT
    ADD ARROW_ROW, 4
    CONT:
    SUB ARROW_ROW, 1
    MOV DH, ARROW_ROW
    MOV DL, ARROW_COL
    PUSH DX
    CALL _SET_CURSOR2

    DISPLAY_ARROW2:
    MOV AH, 09H
    LEA DX, ARROW
    INT 21H
    CALL _CURSOR_REMOVE
    JMP CHOOSE
		
		HOW_TO:
		CALL _CLEAR_SCREEN
		MOV NEW_INPUT,0
    CALL DISPHOWTO
		JMP HOW_TO2

    DOWN:
    CMP ARROW_ROW, 19 
    JNE SET_DELETE_POS2

    SET_TUMOY_DOWN:
    MOV FLAG, 1

    SET_DELETE_POS2:
    MOV DH, ARROW_ROW
    MOV DL, ARROW_COL
    PUSH DX
    CALL _SET_CURSOR2

    DELETE_ARROW2:
    MOV AH, 09H
    LEA DX, SPACE
    INT 21H
    CALL _CURSOR_REMOVE

    SET_ARROW_POS2:
    CMP FLAG, 1
    JNE CONT2
    SUB ARROW_ROW, 4
    CONT2:
    ADD ARROW_ROW, 1
    MOV DH, ARROW_ROW
    MOV DL, ARROW_COL
    PUSH DX
    CALL _SET_CURSOR2

    DISPLAY_ARROW3:
    MOV AH, 09H
    LEA DX, ARROW
    INT 21H
    CALL _CURSOR_REMOVE
    JMP CHOOSE
		
		CHOICE:   
    CMP ARROW_ROW, 16
    JE PLAY_GAME1
    CMP ARROW_ROW, 17
    JE PLAY_GAME2
    CMP ARROW_ROW, 18
    JE HOW_TO
    CMP ARROW_ROW, 19
    JE	TERMINATE
    JMP CHOOSE

    RET
DISPLAY_HOME_SCREEN ENDP



TERMINATE:
CALL EXITP

PLAY_GAME1:
MOV MODE,1
CALL _CLEAR_SCREEN
CALL MAINGAME
;JMP GAMEOVER

PLAY_GAME2:
MOV MODE,2
CALL _CLEAR_SCREEN
CALL MAINGAME
;JMP GAMEOVER

DISPHOWTO PROC
	PRINTSTR HOWTO_STR

		ENDDISP:
		RET
DISPHOWTO ENDP

DISPGAMEOVER PROC
	PRINTSTR GAMEOVER_STR
	MOV DH, 16
	MOV DL, 01BH
	PUSH DX
	CALL _SET_CURSOR2
	; CURRENT SCORE
	
	MOV AH, 09H
	LEA DX, HIGHSCORE 			;change to score
	INT 21H
	CALL _CURSOR_REMOVE
	
	MOV DH, 16	
	MOV DL, 03FH
	PUSH DX
	CALL _SET_CURSOR2

	MOV AH, 09H
	LEA DX, HIGH_STR 			;change to score
	INT 21H
	CALL _CURSOR_REMOVE
			;PRINTSTR HOWTO_STR
			;CALL GET_INPUT
			
		
		RET
DISPGAMEOVER ENDP

;-------------------------------------------


    _CLEAR_SCREEN PROC	NEAR
        MOV		AX, 0600H  ;fullscreen
        MOV		BH, 00FH   ;black bg white fg
        MOV 	CX, 0000H 
        MOV		DX, 184FH
        INT		10H
        RET
    _CLEAR_SCREEN ENDP
;-------------------------------------------
    _SET_CURSOR PROC	NEAR
        MOV		AH, 02H
        MOV		BH, 00
        INT		10H
        RET
    _SET_CURSOR ENDP
;-------------------------------------------

    _SET_CURSOR2 PROC NEAR
      POP BX
      POP DX
      PUSH BX
      MOV AH, 02H   
      MOV BH, 00    
      INT 10H

      RET
    _SET_CURSOR2 ENDP

;-------------------------------------------

    _CURSOR_REMOVE PROC NEAR
      MOV AH, 02H   
      MOV BH, 00    
      MOV DH, 25   
      MOV DL, 80 
      INT 10H

      RET
    _CURSOR_REMOVE ENDP

;-------------------------------------------

GET_INPUT PROC NEAR 
	  MOV   AH, 01H   ;check for input
      INT   16H

      JZ    BACKTOGAME
	  
      MOV   AH, 00H   
      INT   16H
	  
	  MOV NEW_INPUT, AH
	  
    RETURN:
       RET
	BACKTOGAME:
		RET
GET_INPUT  ENDP

;*************************************************************************
;  GETCOUNT procedure
;*************************************************************************	

GETCOUNT PROC
	MOV CX,AX			;SIZE OF STRING IS STORED IN AX WHEN USING 3FH
	MOV COUNT,CX
	RET
GETCOUNT ENDP

;*************************************************************************
;  GETLINE procedure
;*************************************************************************

GETLINE PROC
	MOV SI,BP			;RESTORES PREVIOUS POSITION OF SI FROM THE ENTIRE STRING FETCHED FROM THE FILE

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
	MOV AL,'$'
	MOV [DI],AX
	INC SI
	MOV BP,SI

	RET
GETLINE ENDP

;*************************************************************************
;  RESET procedure
;*************************************************************************

RESET PROC 	
		RESETS STACK_INPUT
		RESETS TEMP
		RESETS MSG
		 RET
RESET ENDP

;*************************************************************************
;  HEX TO DEC procedure
;*************************************************************************

HEX2DEC PROC 	
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	LEA SI,RES
	MOV CX,0
  MOV BX,10
   
LOOP1: MOV DX,0
       DIV BX
       ADD DL,30H
       PUSH DX
       INC CX
       CMP AX,9
       JG LOOP1
     
       ADD AL,30H
       MOV [SI],AL
     
LOOP2: POP AX
       INC SI
       MOV [SI],AL
       LOOP LOOP2
		
		INC SI
		MOV AL,'$'
		MOV [SI],AL
    
		POP SI
		POP DX
		POP CX
		POP BX
		POP AX
		RET
HEX2DEC ENDP

;*************************************************************************
;  STRING TO HEX procedure
;*************************************************************************

STR2HEX PROC 	
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	
	XOR SI,SI
	XOR AX,AX
	XOR BX,BX
	MOV TEN,10
	MOV TOT,0
	
	
	LOOP0:
	CMP HIGH_STR[SI],'$'
	JE END00
	
	MOV CX,TEN
	MOV AX, TOT
	MUL CX
	MOV TOT,AX
	
	XOR AX,AX
	
	MOV AL,HIGH_STR[SI]
	SUB AL,30H
	
	ADD TOT,AX

	INC SI
	JMP LOOP0
END00:
			
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	
	RET
STR2HEX ENDP

;*************************************************************************
;  TABLE procedure
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
	JMP COPY0
END0:
	MOV MSG[SI],'$'
  CALL displayEmpty    	 	
	
	RET
TABLE ENDP

;**************************************************************************
;	displayEmpty Procedure
;**************************************************************************
displayEmpty PROC
	MOV STR_L,0		;initialize string length
	MOV BL,'-'
	PRINTSTR CRLF
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

	PRINTSTR TEMP
	PRINTSTR CRLF

 	RET

displayEmpty ENDP


wins:
jmp WINCASE
looses:
jmp LOOSE
RESETINC:
MOV CREDIT,0		;initialize Credit
MOV  correct,0		;initialize values of correct & incorrect
MOV  incorrect,0
MOV CX,7
JMP CONTI
;RET
;***************************************************************************
;	matchWord Procedure
;***************************************************************************
matchWord PROC
	CMP MODE,2  ;**********comparison if extreme mode is selected or not**************;
	JNE RESETINC
	CONTI:

INPUT:	;*********************** user input loop ***************************
	CMP CX,0
	JE  looses
	MOV DL,correct
	CMP DL,STR_L
	JE  wins
OTHER_INPUT:
;***************PRINTING OF CURRENT AND HIGH SCORES***************;
	MOV AX, SCORE
	CALL HEX2DEC
	PRINTSTR CURRENTHIGH
	PRINTSTR HIGH_STR    ;---------HIGHSCORE----------;
	;PRINTSTR HIGHSCORE
	PRINTSTR CURRENTSCORE
	PRINTSTR RES  ;-----CONVERTED SCORE TO DEC----------;
	MOV AX,RES
	MOV HIGHSCORE,AX
	PRINTSTR CRLF
	PRINTSTR PROMPT3  ;--------USER INPUT PROMPT---------;
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
	PRINTSTR PROMPT7
	JMP OTHER_INPUT	
STORE_INPUT:
	MOV STACK_INPUT[SI],BL
	INC SI
	MOV STACK_INPUT[SI],'$'

	PRINTSTR PROMPT8
	PRINTSTR STACK_INPUT

	PRINTSTR PROMPT4  ;Comment the user's guessing 
	XOR SI,SI		;resets index
COMPARE:;*********************** compares an char input to a word ***********
	CMP MSG[SI],'$'
	JE GETINPUT
	CMP BL,MSG[SI]		;input matches any letter of the word?
	JE GAIN_CORRECT
	INC SI
	JMP COMPARE	

GAIN_CORRECT:
	MOV TEMP[SI],BL
	INC SI
	INC SCORE ;----player score-----;
	INC correct
	INC CREDIT
	JMP COMPARE
GETINPUT:
	PRINTSTR TEMP
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
	CMP MODE,2
	JNE NORESETINC
	;MOV incorrect,8
	JMP RESETINC2
	CONT0:
	CALL DISPLAY
	PRINTSTR PROMPT5
	JMP RESULT
LOOSE:
	MOV LOSE,1
	;PRINTSTR PROMPT6	
RESULT:
	;-------CHECK IF CURRENT SCORE GREATER THAN HISCORE--------------;
	CALL GETSIZE ;GETSIZE OF CURRENT HIGH SCORE (FILE WRITE PURPOSES)
	MOV AX,TOT
	CMP SCORE,AX
	JG WRITE
	CONTINUE:
	RET			;return to main

matchWord ENDP

NORESETINC:
MOV incorrect,8
JMP CONT0

RESETINC2:
MOV CREDIT,0		;initialize Credit
MOV  correct,0		;initialize values of correct & incorrect
JMP CONT0

;------------OVERWRITE HISCORE FILE IF GREATER-------------;

WRITE:
	MOV AH, 3CH           ;request create file
  MOV CX, 00            ;normal attribute
  LEA DX, HIGHSCORETXT  ;load path and file name
  INT 21H
  JC DISPLAY_ERROR6     ;if there's error in creating file, carry flag = 1, otherwise 0
  MOV FILEHANDLE, AX

  ;write file
  MOV AH, 40H           ;request write record
  MOV BX, FILEHANDLE    ;file handle
  MOV CX, COUNTER            ;record length
  LEA DX, RES    ;address of output area
  INT 21H
  JC DISPLAY_ERROR4     ;if carry flag = 1, there's error in writing (nothing is written)
  CMP AX, COUNTER            ;after writing, set AX to size of chars nga na write
  JNE DISPLAY_ERROR5  
  
  ;close file handle
  MOV AH, 3EH           ;request close file
  MOV BX, FILEHANDLE    ;file handle
  INT 21H
	JMP CONTINUE
	
	DISPLAY_ERROR4:
	LEA DX, ERROR4_STR
	MOV AH, 09
	INT 21H
	JMP EXIT1
	
	DISPLAY_ERROR5:
	LEA DX, ERROR5_STR
	MOV AH, 09
	INT 21H
	JMP EXIT1
	
	DISPLAY_ERROR6:
	LEA DX, ERROR1_STR
	MOV AH, 09
	INT 21H
	JMP EXIT1

	EXIT1:
 	MOV AX, 4C00H
	INT 21H	

;*************************************************************************
;	SIZE OF CURRENT SCORE procedure
;*************************************************************************	

GETSIZE PROC
	MOV COUNTER,0
	XOR SI,SI
COPY10:
	CMP RES[SI],'$'
	JE END10
	INC COUNTER
	INC SI
	JMP COPY10
END10:
	MOV MSG[SI],'$'
	
RET
GETSIZE ENDP

;RET
;*************************************************************************
;	Display Hangman procedure
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

		
RET

DISP0:
	PRINTSTR FIG0
	RET

DISP1:
	PRINTSTR FIG1
	RET

DISP2:
	PRINTSTR FIG2
	RET

DISP3:
	PRINTSTR FIG3
	RET

DISP4:
	PRINTSTR FIG4
	RET

DISP5:
	PRINTSTR FIG5
	RET

DISP6:
	PRINTSTR FIG6
	RET

DISP7:
  PRINTSTR FIG7
  RET

DISP8:
	PRINTSTR FIG8
	RET

DISPLAY ENDP

END MAIN
