assume cs:code,ds:data

data segment
	dd 100001
	dw 100
	dw 0
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov bx,0
	mov ax,[bx]
	mov dx,2[bx]
	div word ptr 4[bx]
	mov 6[bx],ax
	
	mov ax,4c00H
	int 21H
code ends
end start
	