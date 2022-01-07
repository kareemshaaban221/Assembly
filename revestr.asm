.model small
.data
    string db "hello"
    
.stack

.code
    main proc far
        .startup
        
            mov si, offset string
            mov cx, 5
            a:
                mov ax, [si]
                push ax
                inc si
            loop a
            
            mov cx, 5
            b:
                pop ax
                mov dl, al
                mov ah, 02h
                int 21h
            loop b
        
        .exit
    main endp
    
end main