.model small

.data
    x db 25
    e db "even", '$'
    o db 'odd' , '$'
.code
    main proc far
        .startup
        
        ;mov al, 50
        ;div x
        
        ;mov ah, x
        and x, 1b
        cmp x, 0
        je printeven
        jne printodd
        
        printeven:
        lea dx, e
        mov ah, 09h
        int 21h
        
        printodd:
        lea dx, o
        mov ah, 09h
        int 21h
        
        .exit
    main endp

end main