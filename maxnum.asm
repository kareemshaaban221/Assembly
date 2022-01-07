.model small

.data
    arr db 1, 8, 5, 5, 6
.code

    main proc far
        .startup
        
        mov cx, 4
        lea si, arr
        
        mov al, [si]
        inc si
        mov bl, al
        a:
            mov al, [si]
            inc si
            cmp al, bl
            ja b
            jna c
            b:
                mov bl, al
            c:
        loop a
        
        mov dl, bl
        add dl, 30h
        mov ah, 02h
        int 21h
        
        .exit
    main endp
    
end main