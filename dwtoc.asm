assume cs:code

data segment 
	db 10 dup (0)
data ends

code segment
start:  mov ax,12666
		mov dx,1000H
		mov bx,data
		mov ds,bx
		mov si,0
		call dtoc
		
		mov dh,8
		mov dl,3
		mov cl,2
		call show_str
		
		mov ax,4c00H
		int 21H

dtoc:   push si
		push di
		push dx
		push cx
		push bx
		push ax
		mov di,0	
dtoc0:	mov cx,10
	    call divdw
		mov bl,cl
		mov bh,0
		add bl,30H
		push bx
		inc di
		mov cx,ax
		or cx,dx
		jcxz dtoc1
		jmp dtoc0
dtoc1:  mov cx,di		
dtoc2:  pop bx
		mov [si],bl
		inc si
		loop dtoc2
		mov byte ptr ds:[si],0
		pop ax
		pop bx
		pop cx
		pop dx
		pop di
		pop si
		ret

;名称：divdw

;功能：进行不会产生溢出的除法运算，被除数为dword型，除数为word型，结果为dword型。

;参数：(ax)=dword型数据的低16位；

;      (dx)=dword型数据的高16位；

;      (cx)=除数。

;返回：(dx)=结果的高16位；

;      (ax)=结果的低16位；

;      (cx)=余数。
divdw:  push si
		push bx
		
		push ax
		mov ax,dx
		mov dx,0
		div cx		;被除数高位/cx，商在ax,余数在dx
		mov si,ax 
		pop ax
		div cx		;（被除数高位商+低位)/cx,商在ax,余数在dx
		mov cx,dx 
		mov dx,si
		
		pop bx
		pop si
		ret
		
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