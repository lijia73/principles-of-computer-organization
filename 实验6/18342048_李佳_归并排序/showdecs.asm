;showdecs.asm
data segment
     nums1 db 100,34,78,9,160,200,90,65
data ends

code segment
      assume cs:code
      
start:     
     mov ax,data
     mov ds,ax
     mov es,ax

     mov bx,offset nums1
     mov cx,8
     call showdecs

     mov ah,4ch              ; 功能：返回DOS系统
     int 21h                 ;       DOS功能调用

; 把一组十六进制数据转换为十进制数并显示出来
; 参数：ds:bx --基地址 cx -- 数据个数
showdecs proc near
	
  trans:mov bp,cx
		mov ah,0
		mov al,[bx]
		
		mov cl,100
		div cl
		add al,30H
		mov dl,al
		mov dh,ah
		mov ah,02h              ; 功能：显示输出
		int 21h
		
		mov ah,0
		mov al,dh
		mov cl,10
		div cl
		add al,30H
		mov dl,al
		mov dh,ah
		mov ah,02h              ; 功能：显示输出
		int 21h
		
		
		add dh,30H
		mov dl,dh
		mov al,ah
		mov ah,02h              ; 功能：显示输出
		int 21h
		
		
		mov cx,bp
		inc bx
		; 输出换行	
		mov dl,0ah
		mov ah,02h              ; 功能：显示输出
		int 21h	
	
	loop trans
	
      ret
showdecs endp

code  ends
      end start