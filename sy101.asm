assume cs:code
data segment
	db 'Welcome to masm!',0
data ends

code segment
start:  mov dh,8	;行号（0～24）
		mov dl,3	;列号（0～79）
		mov cl,2	;颜色
		mov ax,data
		mov ds,ax	;ds:si指向字符串的首地址
		mov si,0
		call show_str
		
		mov ax,4c00H
		int 21H
show_str:   push ax
			push si
			push di
			push es
			;先求出偏移位移存储在di
			mov ax,0B800H
			mov es,ax
			mov ax,160
			mul dh
			mov di,ax
			mov ax,2
			mul dl
			add di,ax
			mov al,cl
			mov ch,0
show0:		
			mov cl,[si]
			jcxz show1
				
			mov es:[di],cl
			mov es:[di].1,al
			inc si
			add di,2
			jmp short show0
show1:	
			pop es
			pop di
			pop si
			pop ax
			ret
code ends
end start