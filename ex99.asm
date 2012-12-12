assume cs:code,ds:data

data segment

	db '  Hello World!  '
	db 02H,14H,71H,0CAH

data ends

code segment

start:  mov ax,data
		mov ds,ax
		
		mov ax,0B800H
		mov es,ax
		
		mov di,0  
		mov bp,960
		mov cx,4
   s0:  mov dx,cx
		mov si,0
		mov bx,0
		mov cx,16
   s1:  mov al,[bx]         ;ascii
		mov ah,16[di]  ;rgb
		mov word ptr es:[bp].72[si],ax
		inc bx
		add si,2
		loop s1
		
		inc di
		add bp,160
		mov cx,dx
		loop s0
		
	mov ax,4c00H
	int 21H
	
code ends
end start