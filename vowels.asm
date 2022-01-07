.model small
.data
    vowels db "aeiou"
    string db "helloawoiud"
    
.code

    main proc far
        .startup
            
            mov si, offset string
            
            mov cx, 11
            mov dl, 0
            a:
                mov bx, 5
                mov di, offset vowels
                
                jmp again
                
                again:
                    mov al, [di]
                    cmp al, [si]
                    je b
                    jne c
                    
                    b:
                        inc dl
                        jmp stop
                    c:
                        inc di
                        dec bx
                        cmp bx, 0
                        je stop
                        jne again
                stop:
                    inc si
            loop a
            
            add dl, 30h
            mov ah, 02h
            int 21h
        
        .exit
    main endp
    
end main