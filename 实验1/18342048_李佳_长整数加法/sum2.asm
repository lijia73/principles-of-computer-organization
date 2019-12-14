;num2.asm
data segment
      num1 db 4 dup(?)
      num2 db 4 dup(?)
      sum  db 4 dup(?)
data ends

code segment
          assume cs:code, ds:data
start:
        mov ax,data
        mov ds, ax
       
	    lea si,num1
	    lea di,num2
	    lea bx,sum
	    clc
	   
		mov cx,4
	   
		input1: mov bp,cx
				mov ah,01h              ; 功能：键盘输入
				int 21h 
				mov ah,0
				sub al,30h
				mov cl,04h
				shl al,cl
				mov cx,bp
				mov ds:[bp+si-1],al
				
				mov ah,01h              ; 功能：键盘输入
				int 21h
				mov ah,0
				sub al,30h
				add ds:[bp+si-1],al
				
		loop input1
		
		; 输出换行	
		mov dl,0ah
		mov ah,02h              ; 功能：显示输出
		int 21h	
		
		mov cx,4
	   
		input2: mov bp,cx
				mov ah,01h              ; 功能：键盘输入
				int 21h 
				mov ah,0
				sub al,30h
				mov cl,04h
				shl al,cl
				mov cx,bp
				mov ds:[bp+di-1],al
				
				mov ah,01h              ; 功能：键盘输入
				int 21h 
				mov ah,0
				sub al,30h
				add ds:[bp+di-1],al
				
		loop input2

		mov cx,4
			   
		 next: mov al,[si]
			   adc al,[di]
			   daa
			   mov [bx],al
			   inc si
			   inc bx
			   inc di
			   loop next			
	   
	   
	   	; 输出换行	
		mov dl,0ah
		mov ah,02h              ; 功能：显示输出
		int 21h	
		
	    mov cx,4
			   
	   output: dec bx
		       mov bp,cx
			   mov dl,[bx]
			   mov cl,04h
			   shr dl,cl
			   mov cx,bp
			   add dl,30h
			   mov ah,02h              ; 功能：显示输出
			   int 21h			   ;       DOS功能调用
			   
			   mov dl,[bx]
			   and dl,00001111B
			   add dl,30h
			   mov ah,02h              ; 功能：显示输出
			   int 21h
			   loop output
	   
        mov ah,4ch              ; 功能：结束程序，返回DOS系统
        int 21h                 ; DOS功能调用
code  ends
      end start