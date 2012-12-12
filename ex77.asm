assume cs:codesg,ds:datasg

datasg segment

	db '1. file         '
	db '2. edit         '
	db '3. search       '
	db '4. view         '
	db '5. options      '
	db '6. help         '
	
datasg ends

codesg segment

start:
	mov ax,datasg
	mov ds,ax
	mov bx,0
	
	mov cx,6
 s0:
	mov dx,cx
	mov si,3
	mov cx,0DH
 s1:
	mov al,[bx+si]
	and al,11011111B
	mov [bx+si],al
	inc si
	loop s1
	
	add bx,16
	mov cx,dx
	loop s0
	
	mov ax,4c00H
	int 21H

codesg ends
end start