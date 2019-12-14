;num3.asm
;num2.asm
data segment
      num1 db 15 dup(0)
      num2 db 15 dup(0)
      sum  db 15 dup(0)
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
		
		push bx
		push di
		
				
		mov dx,0
	   
		mov cx,15
	   
		input1: mov bp,cx
				mov ah,01h              ; 功能：键盘输入
				int 21h 
				mov ah,0
				
				cmp al,0dh        
				je next1
				
				inc dl
				
				sub al,30h
				mov cl,04h
				shl al,cl
				mov cx,bp
				mov ds:[bp+si-1],al
				
				mov ah,01h              ; 功能：键盘输入
				int 21h	
				mov ah,0
				
				cmp al,0dh        
				je next
				
				inc dl
				
				sub al,30h
				add ds:[bp+si-1],al
				loop input1
		
		
		; 输出换行	
			mov dl,0ah
			mov ah,02h              ; 功能：显示输出
			int 21h
			jmp next1
			
		 next:mov cx,14
		formatnum3: mov dl,[si]
					cmp dl,0
					jne adjust1
					inc si
					loop formatnum3
			
			cmp cx,0
			je oneelement1
					
			adjust1:mov al,[si]
				   shr al,1
				   shr al,1
				   shr al,1
				   shr al,1
				   mov dl,[si+1]
				   shl dl,1
				   shl dl,1
				   shl dl,1
				   shl dl,1
				   add al,dl
				   mov [si],al
				   inc si
				   loop adjust1	   
				   
			oneelement1:	   
				   mov al,[si]
				   shr al,1
				   shr al,1
				   shr al,1
				   shr al,1
				   mov [si],al
				   sub si,14
						
		 next1:	mov cx,15
				mov dx,0
		   
		input2: mov bp,cx
				mov ah,01h              ; 功能：键盘输入
				int 21h 
				mov ah,0
				
				cmp al,0dh        
				je next2
				
				inc dl
				
				sub al,30h
				mov cl,04h
				shl al,cl
				mov cx,bp
				mov ds:[bp+di-1],al
				
				mov ah,01h              ; 功能：键盘输入
				int 21h 
				mov ah,0
				
				cmp al,0dh        
				je next0
				
				inc dl
				
				sub al,30h
				add ds:[bp+di-1],al
				
		loop input2
		
			; 输出换行	
		mov dl,0ah
		mov ah,02h              ; 功能：显示输出
		int 21h
		mov cx,15
		mov ax,0
		jmp calculate1
		
		next0:mov cx,14
		formatnum4: mov dl,[di]
					cmp dl,0
					jne adjust2
					inc di
					loop formatnum4  
					
			cmp cx,0
			je oneelement2
			adjust2:mov al,[di]
				   shr al,1
				   shr al,1
				   shr al,1
				   shr al,1
				   mov dl,[di+1]
				   shl dl,1
				   shl dl,1
				   shl dl,1
				   shl dl,1
				   add al,dl
				   mov [di],al
				   inc di
				   loop adjust2	
			oneelement2:	   
				   mov al,[di]
				   shr al,1
				   shr al,1
				   shr al,1
				   shr al,1
				   mov [di],al
				   sub di,14
		
    next2:mov cx,15
		  mov ax,0
		formatnum1: mov dl,[si]
					cmp dl,0
					jne next3
					inc si
					dec al
					loop formatnum1
				
	next3:mov cx,15
        formatnum2: mov dl,[di]
					cmp dl,0
					jne next4
					inc di
					dec ah
					loop formatnum2

	
	
	next4:clc
		  add al,15
          add ah,15		  
		  cmp al,ah
		  js calculate
		  	
	max: mov dl,al
		 mov al,ah
		 mov ah,dl   
    
	
	calculate:
		mov cl,al
		sub ah,al
		cmp cl,0
		jz copy	
    calculate1: mov al,[si]
			   adc al,[di]
			   daa
			   mov [bx],al
			   inc si
			   inc bx
			   inc di
			   loop calculate1 
			   
			   jnc copy
			   cmp ah,0
		       jne copy
	           mov dl,31h 
	           mov cl,ah
	           mov ah,02h      ; 功能：显示输出
			   int 21h 
			   mov dh,1
               mov ah,cl
	copy:	
		mov cl,ah
		pop bp
		cmp ah,0
		je thisoutput
		add bp,15
		cmp bp,di    
		je calculate3a
	    mov al,[si-1]
		adc al,[di-1] 
		daa
	calculate2: 
	            mov al,0
	            adc al,[di]
	            daa
				mov [bx],al
				inc di
				inc bx
				loop calculate2			
				jmp thisoutput
	
	calculate3a: mov al,[si-1]
		         adc al,[di-1] 
		         daa
	calculate3: mov al,0
	            adc al,[si] 
	            daa
				mov [bx],al
				inc si
				inc bx
				loop calculate3   	   	
		
	thisoutput:pop bp
	           clc
			   dec bx
			   mov dl,[bx]
			   mov cl,04h
			   shr dl,cl
			   
			   cmp dl,0
			   jz zero
	    	   add dl,30h
			   mov ah,02h              ; 功能：显示输出
			   int 21h			   ;       DOS功能调用
			   
			   zero:
			   cmp dh,1
			   je butc
			   
			   mov dl,[bx]
			   and dl,00001111B
			   add dl,30h
			   mov ah,02h              ; 功能：显示输出
			   int 21h   
			   
			   cmp bx,bp
			   je theend
			   jmp output 
			   
			   butc:  
			   add dl,30h
			   mov ah,02h              ; 功能：显示输出
			   int 21h
			   mov dl,[bx]
			   and dl,00001111B
			   add dl,30h
			   mov ah,02h              ; 功能：显示输出
			   int 21h   
			   
			   cmp bx,bp
			   je theend 
	   
	   output: clc
			   dec bx
			   mov dl,[bx]
			   mov cl,04h
			   shr dl,cl
			   add dl,30h
			   mov ah,02h              ; 功能：显示输出
			   int 21h			   ;       DOS功能调用
			   
			   mov dl,[bx]
			   and dl,00001111B
			   add dl,30h
			   mov ah,02h              ; 功能：显示输出
			   int 21h
			   
			   
			   cmp bx,bp
			   jne output 
			   
	    theend:
        mov ah,4ch              ; 功能：结束程序，返回DOS系统
        int 21h                 ; DOS功能调用
code  ends
      end start