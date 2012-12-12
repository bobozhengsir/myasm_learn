assume cs:code
code segment
start:  mov ax,4240H
		mov dx,000FH
		mov cx,0AH
		call divdw
		
		mov ax,4c00H
		int 21H


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
code ends
end start