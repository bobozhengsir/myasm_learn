assume cs:code
code segment
start:  mov ax,4240H
		mov dx,000FH
		mov cx,0AH
		call divdw
		
		mov ax,4c00H
		int 21H


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
code ends
end start