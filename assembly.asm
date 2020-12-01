;Mehmet Enver Akkoç
;150160528
;Nurettin Kağan Çocalak
;150160529
;Ahmet Serkan Göktaş
;150160122

segment .data
sizeOne	DD 0
sizeTwo	DD 0
strOne	DD 0
strTwo	DD 0
n	DD 0
firstInnerCounter	DD 0			; used in 
firstOuterCounter	DD 0
secondOuterCounter	DD 0


segment .text
global n_gram

n_gram:
	push 	ebp			    		; saving ebp
	mov 	ebp,esp			    	;

	mov 	ebx,[ebp+8]		    	; mov all inputs(str1,size1,str2,size2,n) to according assembly variables
	mov 	[strOne],ebx			; 
	mov 	ebx,[ebp+12]
	mov 	[sizeOne],ebx
	mov 	ebx,[ebp+16]
	mov 	[strTwo],ebx
	mov 	ebx,[ebp+20]
	mov 	[sizeTwo],ebx
	mov 	ebx,[ebp+24]
	mov 	[n],ebx

	xor 	eax,eax
	xor 	edi,edi
	xor 	esi,esi
	xor 	ecx,ecx			
	;clear registers for seting 0 on output array elements

	mov  	[firstOuterCounter], eax    	
	mov  	[secondOuterCounter], eax
	mov  	[firstInnerCounter], eax
	;clear counters for new ngram operation


main:	
	xor ebx, ebx
	add ebx, [secondOuterCounter]
	add ebx, [firstInnerCounter]
    cmp ebx, [sizeTwo]				; if we finished traversing n-gram set of strTwo
    je 	nextOuter					; then, we start checking equality for another element of n-gram set of strOne
    add ebx, [strTwo]				; addr of the current char of current element of set of strTwo
    mov al, [ebx]					; the char is stored in al
    xor ebx, ebx					; resetting ebx
	add ebx, [firstOuterCounter]	
    add ebx, [firstInnerCounter]
    cmp ebx, [sizeOne]				; if we finished traversing n-gram set of strOne
    je 	exit						; then it means that we checked all of the combination of elements
    add ebx, [strOne]				; addr of the current char of current element of set of strOne
	mov cl, [ebx]					; the char is stored in al
    cmp cl, al					 
	jne	nextInner                   ; if any member of the n-sized subset is not equal between strings, then go to next set on second string
    
   	mov ebx, [firstInnerCounter]	; we chould check the other char
	add ebx, 1						;
	mov	[firstInnerCounter], ebx	
	cmp ebx, [n]					; if we check all the chars of the current elements
    je  match						; then these elements are equal
	jmp	main						; if not, continue loop

match:  
	add edi, 1						; increment num of intersects

nextInner:	 
	xor eax, eax
	mov [firstInnerCounter], eax	; set first inner counter to 0
    mov ebx, [firstOuterCounter]    ; if it's not the first time, then don't add subset again
    cmp ebx, 0
    jne subsetAlreadyAdded			; we already counted the size of the n-gram set of strTwo
    add esi, 1 						; if we didn't, increase the esi
		    						; in the end esi will equal

subsetAlreadyAdded:    
	mov ebx, [secondOuterCounter]	
	add ebx, 1						; start checking next element of n-gram set of strTwo
	mov	[secondOuterCounter], ebx
	add ebx, [n]			
	cmp ebx, [sizeTwo]				; if we reached at the end of strTwo
	jg nextOuter					; then start checking for next element of n-gram set of strOne
    jmp main						; else continue main loop

nextOuter:    
	xor eax, eax
	mov [secondOuterCounter], eax	; set second outer counter to 0
    add esi, 1                     	; add each subset of first string to sum
    mov ebx, [firstOuterCounter]	; 
	add ebx, 1				
	mov	[firstOuterCounter], ebx 	; start checking for next element in n-gram set of strOne
	add ebx, [n]			
	cmp ebx, [sizeOne]				; if we reached at the end of strOne
    jg exit							; then it means that we checked all of the combination of elements
    jmp main						; else continue main loop
    
exit:	
	mov eax, edi					; moving # of intersect into eax
    mov ebx, 100					; multiplying by 100 for percentage
    mul ebx							; result = (intersect * 100) is in eax
    mov ebx, eax					; ebx = (intersect * 100)
    sub esi, edi					; esi equals size of the union
    mov eax, ebx					; eax = (intersect * 100)
    div esi							; eax =  (intersect * 100) / (size of union)
	pop ebp							; restoring ebp
	ret								; returning eax