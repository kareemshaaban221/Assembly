.model small

.data
    s db "enter number:", 10, '$'
    num dw 1
    ten dw 10
    hundred db '100$'
.code
    main proc far
        .startup ; mov dx, $data
                 ; mov ds, dx
            call pro2
             
        .exit    ; mov ah, 4ch
                 ; int 21h
    main endp
    
    pro1 proc near
        lea dx, s
        call printstring
        
        mov ah, 01h
        int 21h
        
        mov dl, al
        
        mov ah, 01h
        int 21h
        
        mov dh, al
        
        call printchar
        mov dl, dh
        call printchar
        
        ret
    pro1 endp
    
    pro2 proc near
        mov cx, 1000 ; 99
        a:
            ;cmp num, 9
            ;jna normal
            ;ja multidigit
            ;normal:
            ;    mov dx, num
            ;    add dx, 30h
            ;    call printchar
            ;    
            ;    jmp re
            ;multidigit:
                mov dx, 0
                mov ax, num
                div ten
                
                mov bx, 1
                push dx
                cond:
                    cmp ax, 0
                    jne divide
                    je flow
                divide:
                    inc bx
                    mov dx, 0
                    div ten
                    push dx
                    jmp cond
                
                flow:
                cmp bx, 0
                jne print
                je re
                print:
                    pop dx
                    add dx, 30h
                    call printchar
                    dec bx
                    jmp flow
                
                ;mov bx, dx
                ;
                ;mov dx, ax
                ;add dx, 30h
                ;call printchar
                ;
                ;mov dx, bx
                ;add dx, 30h
                ;call printchar
                ;
                ;jmp re
            
            re:
                inc num
                mov dl, ' '
                call printchar
        loop a
        
        ;lea dx, hundred
        ;call printstring
        ret
    pro2 endp
    
    printchar proc near
        mov ah, 02h
        int 21h
        ret
    printchar endp
    
    printstring proc near
        mov ah, 09h
        int 21h
        ret
    printstring endp
end main