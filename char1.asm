.model small

.data
    x db "Hello WORLD",'$'

.code
    main proc far
        .startup
        mov dl, 11011111b
        mov cx, 11
        lea si, x
        
        a:
        and [si], dl
        inc si
        loop a
        
        lea dx, x
        mov ah, 09h
        int 21h
        .exit
    main endp
    
end main