.model small

.data

.code
    main proc far
        .startup
            mov cx, 26
            
            mov bl, 'A'
            a:
                mov dl, bl
                mov ah, 02h
                int 21h
                inc bl
                
                mov dl, ' '
                mov ah, 02h
                int 21h
            loop a
        .exit
    main endp
    
end main