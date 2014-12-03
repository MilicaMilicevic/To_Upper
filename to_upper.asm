;Reserve memory for n bytes. In that space storage ASCII array that starts on location ORIGINAL.
;After that,transform all small to capital letters, then move back content to location ORIGINAL.

;Rezervisati memorijski prostor od n bajtova pa u njega pohraniti sadrzaj niza ASCII karaktera koji
;pocinje na lokaciji ORIGINAL. Nakon toga pretvoriti sva mala slova u velika, pa vratiti sadrzaj nazad na lokaciju
;ORIGINAL


SECTION .data
original TIMES 5 db 'a' ;'a' just for an example!
size equ 5

SECTION .bss
copy resb size

SECTION .text
global _start
_start:

;move original to copy
CLD 	;set increment
MOV ESI,original
MOV EDI,copy
MOV CX,size
REP MOVSB 

;iterate through copy and check if element small or capital letter

MOV ESI,copy
MOV EDI,copy	;because of stosb 
MOV CX,size

iterate:
      LODSB 	;	move element to acumulator
      CMP AL,'a'	;check if small letter
      JB next
      CMP AL,'z'
      JA next
      SUB AL,32		;32 is difference between small and capital,modify 
next:
      STOSB 		;write it back
      LOOP iterate

;move back to original
MOV ESI,copy
MOV EDI,original
MOV CX,size
REP MOVSB ;repeat while Cx>0


MOV EAX,1
MOV EBX,0
INT 80h