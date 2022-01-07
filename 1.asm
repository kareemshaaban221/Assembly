datas segment
    X db "hello, world!", '$'
datas ends

codes segment
    main proc far
        assume cs:codes, ds:datas
        mov ax, datas
        mov ds, ax
    
        mov dx, offset X
        mov ah, 09H
        int 21H
        
        mov ah, 4cH
        int 21H
    main endp
codes ends

end main