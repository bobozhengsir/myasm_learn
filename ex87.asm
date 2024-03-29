assume cs:codesg,ds:data,es:table

data segment

    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'

    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'

    db '1993','1994','1995'

    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514

    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226

    dw 11452,14430,15257,17800

data ends

table segment

    db 21 dup ('year summ ne ?? ')

table ends

codesg segment

start:
	mov ax,data
	mov ds,ax
	mov ax,table
	mov es,ax
	mov bx,0
	mov si,0
	mov di,0
	
	mov cx,21
 s0:
	mov ax,ds:[di]
	mov es:[bx],ax
	mov ax,ds:[di].2
	mov es:[bx].2,ax
	
	;mov al,20H
	;mov es:[bx].4,al
	;mov es:[bx].9,al
	;mov es:[bx].12,al
	;mov es:[bx].15,al
	
	mov ax,ds:[di].84
	mov es:[bx].5,ax
	
	mov dx,ds:[di].86
	mov es:[bx].7,dx
	
	div word ptr ds:[si].168
	mov es:[bx].13,ax
	
	mov ax,ds:[si].168
	mov es:[bx].10,ax
	
	add si,2
	add di,4
	add bx,16
	loop s0
	
	mov ax,4c00H
	int 21H
	
codesg ends
end start
