.model small

.data
.code
    main proc far
        .startup
        
            mov al, 3
            mov ah, 2
            add ah, al
            
            mov bl, ah
            
            mov ax, 10
            div bl
            
            mov dl, al
            add dl, 30h
            mov ah, 02h
            int 21h
        
        .exit
    main endp
    
end main