assume cs:abc
abc segment


   mov ax,2
   add ax,ax
   add ax,ax

   mov ax,4C00H
   int 21H

abc ends
end
