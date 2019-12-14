;num1.asm
data segment
      num1 db 23H, 45H, 67H, 89H ;Integer 0x89674523
      num2 db 19H,0ABH,0CDH,0EFH ;Integer 0xEFCDAB19
      sum db 4 dup(?)
data ends

code segment
          assume cs:code, ds:data
start:
       mov ax,data
       mov ds, ax
       
	   lea si,num1
	   lea bx,num2
	   lea di,sum
	   clc
	   
	   mov cx,4
	   
 next: mov al,[si]
	   adc al,[bx]
	   daa
	   mov [di],al
	   inc si
	   inc bx
	   inc di
	   loop next
	   
       mov ah,4ch              ; 功能：结束程序，返回DOS系统
       int 21h                 ; DOS功能调用
code  ends
      end start