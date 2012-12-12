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

;���ƣ�divdw

;���ܣ����в����������ĳ������㣬������Ϊdword�ͣ�����Ϊword�ͣ����Ϊdword�͡�

;������(ax)=dword�����ݵĵ�16λ��

;      (dx)=dword�����ݵĸ�16λ��

;      (cx)=������

;���أ�(dx)=����ĸ�16λ��

;      (ax)=����ĵ�16λ��

;      (cx)=������
divdw:  push si
		push bx
		
		push ax
		mov ax,dx
		mov dx,0
		div cx		;��������λ/cx������ax,������dx
		mov si,ax 
		pop ax
		div cx		;����������λ��+��λ)/cx,����ax,������dx
		mov cx,dx 
		mov dx,si
		
		pop bx
		pop si
		ret
		
show_str:   push ax
			push si
			push di
			push es
			;�����ƫ��λ�ƴ洢��di
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