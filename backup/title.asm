TITLE TITLE_SCREEN (SIMPLIFIED .EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 100H
;---------------------------------------------
.DATA  
  HOWTO_FILE DB 'howto.txt', 00H
  ERROR_STR DB "ERROR!$"
  FILE_HANDLE DW ?
  HOWTO_STR DB 2001 DUP('$')
  
  MESSAGE  DB 0ah, 0dh,"       __  __    ___     _   __   ______   __  __   __  __        ._________", 0ah, 0dh    
  MESSAGE2 DB "      / / / /   /   |   / | / /  / ____/  / / / /  / / / /       _|_        |", 0ah, 0dh
  MESSAGE3 DB "     / /_/ /   / /| |  /  |/ /  / / __   / / / /  / / / /       /x x\       |", 0ah, 0dh
  MESSAGE4 DB "    / __  /   / ___ | / /|  /  / /_/ /  / /_/ /  / /_/ /        \___/       |", 0ah, 0dh
  MESSAGE5 DB "   /_/ /_/   /_/  |_|/_/ |_/   \____/   \____/   \____/          /|\        |", 0ah, 0dh
  MESSAGE6 DB "                                                                / | \       |", 0ah, 0dh
  MESSAGE7 DB "       __  ___    ___     _   __   __  __   __  __                -         |", 0ah, 0dh
  MESSAGE8 DB "      /  |/  /   /   |   / | / /  / / / /  / / / /               / \        |", 0ah, 0dh
  MESSAGE9 DB "     / /|_/ /   / /| |  /  |/ /  / / / /  / / / /               /   \       |", 0ah, 0dh
  MESSAGEX DB "    / /  / /   / ___ | / /|  /  / /_/ /  / /_/ /                            |", 0ah, 0dh
  MESSAGX1 DB "   /_/  /_/   /_/  |_|/_/ |_/   \____/   \____/                       ______|___$", 0ah, 0dh

  FTXT DB "MAIN MENU$", 0ah, 0dh
  OPT1 DB " Normal Mode$", 0ah, 0dh
  OPT2 DB " Extreme Mode$", 0ah, 0dh
  OPT3 DB " How to Play$", 0ah, 0dh
  OPT4 DB " Exit$"

  ARROW DB 175, '$'
  ARROW_ROW DB 16
  ARROW_COL DB 01EH 
  SPACE DB " $"
  FLAG DB 0     
  
;---------------------------------------------
.CODE
START:
    ;SET DS to correct value
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX,HOWTO_FILE
    CALL OPEN_FILE
    LEA DX,HOWTO_STR
    CALL READ_FILE
    
    DISPLAY_HOME_SCREEN PROC
  
    CALL _CLEAR_SCREEN
  
    ;set cursor
    MOV   DL, 01
    MOV   DH, 01
    CALL  _SET_CURSOR  
  
    LEA DX, MESSAGE
    CALL _DISPLAY_STR

;---------------------------------------------no. 1
    MOV DL, 01FH
    MOV DH, 16
    CALL _SET_CURSOR

    LEA DX, OPT1
    CALL _DISPLAY_STR
;---------------------------------------------no. 2    

    MOV DL, 01FH
    MOV DH, 17
    CALL _SET_CURSOR

    LEA DX, OPT2
    CALL _DISPLAY_STR
;---------------------------------------------no. 3    

    MOV DL, 01FH
    MOV DH, 18
    CALL _SET_CURSOR

    LEA DX, OPT3
    CALL _DISPLAY_STR
;---------------------------------------------no. 4

    MOV DL, 01FH
    MOV DH, 19
    CALL _SET_CURSOR

    LEA DX, OPT4
    CALL _DISPLAY_STR
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
    ;JE PLAY_GAME
    CMP ARROW_ROW, 17
    ;JE PLAY_GAME
    CMP ARROW_ROW, 18
    JE HOW_TO
    CMP ARROW_ROW, 19
    JE EXIT
    JMP CHOOSE

    HOW_TO:
    MOV DH, 01
    MOV DL, 01
    CALL _SET_CURSOR
    CALL DISPHOWTO    

    RET
    DISPLAY_HOME_SCREEN ENDP

 ;-------------------------------------------   

    EXIT:
    ;return/exit
    MOV AH, 4CH
    INT 21H

;-------------------------------------------

    DISPHOWTO PROC
    MOV DH, 00
    MOV DL, 00
    CALL  _SET_CURSOR  

    CALL _CLEAR_SCREEN
    LEA DX, HOWTO_STR
    MOV AH,9
    INT 21H

    MOV AH,10
    INT 21H
    RET
    DISPHOWTO ENDP

    OPEN_FILE PROC NEAR
      MOV AH, 3DH           
      MOV AL, 00            
      INT 21H
      JC DISPLAY_ERROR
      MOV FILE_HANDLE, AX
      RET

    DISPLAY_ERROR:
      LEA DX, ERROR_STR
      MOV AH, 09
      INT 21H

    EXIT2:
        MOV AX, 4C00H
        INT 21H 
    OPEN_FILE ENDP

;-------------------------------------------
READ_FILE PROC NEAR
  MOV AH, 3FH           
  MOV BX, FILE_HANDLE    
  MOV CX, 2000             
  INT 21H
  JC DISPLAY_ERROR2
  CMP AX, 00            
  JE DISPLAY_ERROR2

CLOSE_FILE:
  MOV AH, 3EH           
  MOV BX, FILE_HANDLE    
  INT 21H
  RET

DISPLAY_ERROR2:
  LEA DX, ERROR_STR
  MOV AH, 09
  INT 21H

EXIT3:
    MOV AX, 4C00H
    INT 21H 
READ_FILE ENDP
;-------------------------------------------


    _CLEAR_SCREEN PROC  NEAR
        MOV   AX, 0600H  ;fullscreen
        MOV   BH, 00FH   ;black bg white fg
        MOV   CX, 0000H 
        MOV   DX, 184FH
        INT   10H
        RET
    _CLEAR_SCREEN ENDP
;-------------------------------------------
    _SET_CURSOR PROC  NEAR
        MOV   AH, 02H
        MOV   BH, 00
        INT   10H
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

    _DISPLAY_STR PROC  NEAR
        MOV AH, 09H
        INT 21H
        RET
    _DISPLAY_STR ENDP

;-------------------------------------------    

END START
