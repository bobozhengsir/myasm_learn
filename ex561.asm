assume cs:code

a segment
	dw 1,2,3,4,5,6,7,8
a ends

b segment
	dw 0,0,0,0,0,0,0,0
b ends

code segment

start:
	mov ax,a
	mov ss,ax
	mov sp,0
	
	mov ax,b
	mov ds,ax
	mov bx,0fH
	
	mov cx,8
  s:pop [bx]
	sub bx,2
	loop s
	
	mov ax,4c00H
	int 21H

code ends

end start