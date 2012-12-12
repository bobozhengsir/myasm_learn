assume cs:codesg,ds:datasg,ss:stacksg

datasg segment

	db '1. file         '
	db '2. edit         '
	db '3. search       '
	db '4. view         '
	db '5. options      '
	db '6. help         '
	
datasg ends

stacksg segment
	dw 0,0,0,0,0,0
stacksg ends

codesg segment

start:
	mov ax,datasg
	mov ds,ax
	mov ax,stacksg
	mov ss,ax
	mov sp,16
	mov bx,0
	
	mov cx,6
 s0:
	push cx
	mov si,3
	mov cx,4
 s1:
	mov al,[bx+si]
	and al,11011111B
	mov [bx+si],al
	inc si
	loop s1
	
	add bx,16
	pop cx
	loop s0
	
	mov ax,4c00H
	int 21H

codesg ends
end start