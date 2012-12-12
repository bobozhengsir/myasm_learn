assume cs:codesg,ds:data,es:table

table segment

    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'

    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'

    db '1993','1994','1995'

    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514

    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226

    dw 11452,14430,15257,17800

table ends

data segment

    db 32 dup (0)

data ends


codesg segment

start:
	mov ax,data
	mov ds,ax
	mov ax,table
	mov es,ax
	mov bx,0
	mov si,0
	mov di,0
	mov dh,2   ;初始行号
	mov dl,30  ;初始列号
	mov cx,21	
 s0:push cx
	push dx
	mov ax,es:[di]
	mov [si],ax
	mov ax,es:[di].2
	mov [si].2,ax
	
	
	add si,6
	mov ax,es:[di].84
	mov dx,es:[di].86
	call dtoc
	
	div word ptr es:[bx].168
	push ax
	
	add si,10
	mov ax,es:[bx].168
	mov dx,0
	call dtoc
	
	add si,6
	pop ax
	call dtoc

	
	mov si,0
	mov cx,29
s1: push cx
	mov cl,[si]
	jcxz space
s2: inc si
	pop cx
	loop s1
	
	mov al,0
	mov [si],al
	mov si,0
	pop dx
	mov cl,2
	call show_str
	add di,4
	add bx,2
	add dh,1
	pop cx
	loop s0
	
	mov ax,4c00H
	int 21H
	
space:  mov al,20H
		mov [si],al
		jmp s2
	
	
	



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
codesg ends
end start
