.model small

.data
    newln db 0dh, 0ah, '$'
    arr db 10 dup(?)
    welcomeMsg db "========================= WELCOME ==========================$"
    readNumbersMsg db "ENTER TEN SINGLE-DIGIT NUMS OR CHARACTERS WITHOUT SPACES", 0dh, 0ah, "INPUT: $"
    readOpType db "ENTER OPERATION CODE", 0dh, 0ah, "'s' => SEARCHING, 'o' => SORTING,", 0dh, 0ah, "'p' => PRINTING, 'n' => NEW INPUT,", 0dh, 0ah, "'q' => EXIT", 0dh, 0ah, "OPCODE: $"
    readSearchTarget db "ENTER SEARCH TARGET OR ('q' => QUIT)", 0dh, 0ah, "TARGET: $"
    foundMsg db "FOUND AT INDEX $"
    notfoundMsg db "NOT FOUND$"
    exitMsg db "I HOPE YOU ENJOY USING THIS SIMPLE APP!", 0dh, 0ah, "THANKS ALOT :)$"
.code

    main proc far
        .startup
            
            call println
            lea dx, welcomeMsg ; Welcome MSG
            call printstrln
        
            call drivercode
        
        .exit
    main endp
    
    drivercode proc near
        input:
            call println
            call println
            lea dx, readNumbersMsg ; arr input msg
            call printstr
            
            call readTenNum ; read ten numbers or chars
        
        cond:
            call println
            lea dx, readOpType ; operation code input msg
            call printstr
            
            call readchar ; read operation type
            
            cmp al, 's'
            je srchquery
            jne els1 ; else
        
        els1: 
            cmp al, 'p'
            je printing
            jne els2
        
        els2:
            cmp al, 'o'
            je sorting
            jne els3
        
        els3:
            cmp al, 'n'
            je input
            jne els4
            
        els4:
            cmp al, 'q'
            je stop
            call println
            jne cond
        
        srchquery:
            call println
            call println
            lea dx, readSearchTarget
            call printstr
            
            call readchar
            cmp al, 'q'
            jne srch ; if char not equ \n or enter
            call println
            je cond
        srch: ; search
            call linearSearch
            call println
            jmp srchquery
            
        printing:
            call println
            call printTenNum
            call println
            jmp cond
            
        sorting:
            call println
            call insertionSort
            call println
            jmp cond
        
        stop:
            call println
            call println
            call println
            lea dx, exitMsg
            call printstrln
            ret
    drivercode endp
    
    ; ex: 2019836574
    insertionSort proc near
        mov cx, 9
        outer:
            lea si, arr ; hold first elem
            
            mov bx, 9 ; hold number of elements in arr
            sub bx, cx ; the index of the current loop 0-8 (n-1 = 10-1 = 9 loops)
            add si, bx ; get the current element index in insertion sort first pointer
            
            mov di, si ; for ex: 2    0    1 .... (arr)
            inc si     ;         di   si
            
            ;;;;;;;;;; testing ;;;;;;;;;;;
            ; note: di values not distinct because the array sorting work in place!
            ; uncomment this code and run for more visualization
            ;mov dl, [di] ; print di values
            ;add dl, '0'
            ;call printchar
            ;
            ;mov dl, [si] ; print si values
            ;add dl, '0'
            ;call printchar
            ;call println
            
            mov al, [si]
            innerloop:
                cmp al, [di]
                jb action
                jmp cont ; continue
            
            action:
                mov dl, [di]
                mov [si], dl
                dec di
                cmp di, offset arr
                jb cont
                dec si
                jmp innerloop
            
            cont:
                inc di
                mov [di], al
        loop outer
        
        call printTenNum
        ret
    insertionSort endp
    
    linearSearch proc near
        call setLoopParam ; set cx=10 and si=arr*
        sub al, '0'
        search:
            cmp al, [si]
            je found
            inc si
        loop search
        
        jmp notfound
        
        found:
            call println
            call println
            lea dx, foundMsg
            call printstr
            mov dl, 10
            sub dl, cl ; dl = index in decimal
            add dl, '0' ; turning digit into char
            call printchar
            jmp rt
        
        notfound:
            call println
            call println
            lea dx, notfoundMsg
            call printstr
        
        rt:
            ret
    linearSearch endp
    
    ; read ten characters & convert them into numbers
    ; then store them in array called arr
    readTenNum proc near
        call setLoopParam
        
        read:
            call readchar
            sub al, '0'
            mov [si], al
            inc si
        loop read
        
        call println
        ret
    readTenNum endp
    
    ; convert numbers of array (arr) into characters
    ; then print them in the screen
    printTenNum proc near
        call println
        call setLoopParam
        
        print:
            mov dl, [si]
            add dl, '0'
            call printchar
            mov dl, ' '
            call printchar
            inc si
        loop print
        
        call println
        ret
    printTenNum endp
    
    ; set loop to 10 times and
    ; source index to first element in array (arr)
    setLoopParam proc near
        mov cx, 10
        mov si, offset arr
        ret
    setLoopParam endp
    
    readchar proc near ; read char & store it in al
        mov ah, 01h
        int 21h
        ret
    readchar endp
    
    printchar proc near ; print char stored in dl
        mov ah, 02h
        int 21h
        ret
    printchar endp
    
    println proc near
        mov dx, offset newln
        call printstr
        ret
    println endp
    
    printstr proc near
        mov ah, 09h
        int 21h
        ret
    printstr endp
    
    printstrln proc near
        call printstr
        call println
        ret
    printstrln endp

end main