;msort.asm
data segment
     nums1 db 100,34,78,9,160,200,90,65
     nums2 db 212,152,8,49,83,35,79,51
     buffer db 8 dup(?)               ; 用于两个有序数列进行合并的缓冲区
     bufptr dw 0                      ; buffer中已合并数据的个数
data ends

code segment
      assume cs:code
      
start:     
     mov ax,data
     mov ds,ax
     mov es,ax

     ;对nums1中的数据排序并显示
     mov bx,offset nums1
     mov cx,8
     call mergesort
     call showdecs
     
     ;显示换行和回车
     mov dl,0ah
     mov ah, 02h
     int 21h
     mov dl,0dh
     mov ah, 02h
     int 21h
     
     ;对nums2中的数据排序并显示
     mov bx,offset nums2
     mov cx,8
     call mergesort
     call showdecs

     mov ah,4ch              ; 功能：返回DOS系统
     int 21h                 ;       DOS功能调用

; 对一组数据进行归并排序（采用递归方法实现）
; bx--基地址 addr cx--数据个数
mergesort proc near	
	push bx
	push cx
	
	cmp cx,1
	jz merge
		
	divide:;cx>1,数据个数减半，递归分
	
	mov ax,cx
	mov cl,2
    div cl
	mov cl,al
	mov ch,0	;cx/=2
	
    call mergesort
	add bx,cx
	call mergesort
	 
	;治
	merge:
	pop cx
	pop bx
	call mergepart
	ret
mergesort endp


; 对两组已分别排序的数据进行合并和排序，两组数据的个数相同
;    中间结果可以存放到buffer中，最后结果要放到原区域
; 参数：bx--基地址（两部分连续存放）,cx--总数据的个数
mergepart proc near
	cmp cx,1
	jz jumpover
	
	push cx
	mov ax,cx
	mov cl,2
    div cl
	mov cl,al
	mov ch,0	;cx/=2
	
	mov bp,bx
	add bp,cx
	
	mov si,0
	mov di,0	
	
	compare:
	mov al,ds:[bp+di]
	cmp [bx+si],al
	inc di
	ja save
	
	mov al,[bx+si]
	dec di
	inc si
	
	save: 
	call saveToBuffer
	
	cmp di,cx
	je copysi
	cmp si,cx
	je copydi
	
	jmp compare
	
	copydi:
	mov al,ds:[bp+di]
	call saveToBuffer
	inc di
	cmp di,cx
	jne copydi
	jmp ending
	copysi:
	mov al,[bx+si]
	call saveToBuffer
	inc si
	cmp si,cx
	jne copysi
	ending:
	pop cx
	call copyFromBufferToNums
	jumpover:
    ret
mergepart endp

; 把buffer中的数据拷贝到bx开始的存储区中
; 参数：bx--基地址,cx--数据个数
copyFromBufferToNums proc
	push cx
	push bx
	lea bp,buffer
	
	btobx:
	mov al,ds:[bp]
	mov [bx],al
	inc bx
	inc bp
	loop btobx
	
	lea si,bufptr
	mov WORD PTR[si],0
	pop bx
	pop cx
    ret
copyFromBufferToNums endp

; 把al的数据保存到buffer中
saveToBuffer proc
	push bx
	push si
	lea bx,buffer
	lea si,bufptr
	add bx,[si]
	mov [bx],al
	inc WORD PTR[si]
	pop si
	pop bx
    ret
saveToBuffer endp

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