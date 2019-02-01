.global _start
.extern dprintf

.data
message:
        .ascii  "P3 512 512 255\n"
format:
        .ascii "%d "
newl:
        .ascii "\n"
pathname:
        .ascii "./image.ppm"
.text
_start:

        pushq   %rbp                     
        movq    %rsp, %rbp

#open file
        mov     $2, %rax
        mov     $pathname, %rdi
        mov     $65, %rsi                # open for writing and CREAT flag
        mov     $0777, %rdx
        syscall
        mov     %rax, %rdi

#write initial string to file (header) 
        mov     $1, %rax
        mov     $message, %rsi          # address of string to output
        mov     $15, %rdx               # number of bytes
        syscall

#do gradient
        mov     $0, %r13
imgy:
        mov     $0, %r12
imgx:
#write each color
        push %rdi
        push $format
        mov %r13, %r14
        and $255, %r14
        push %r14
        call dprintf
        pop %rax
        pop %rax
        pop %rax
        
        push %rdi
        push $format
        mov %r12, %r14
        and $255, %r14
        push %r14
        call dprintf
        pop %rax
        pop %rax
        pop %rax

        push %rdi
        push $format
        push $0
        call dprintf
        pop %rax
        pop %rax
        pop %rax

#handle loop stuff
        mov     $512, %rsi
        
        inc     %r12
        cmp     %r12, %rsi
        jg      imgx

        push %rdi
        push $newl
        call dprintf
        pop %rax
        pop %rax

        inc     %r13
        cmp     %r13, %rsi
        jg      imgy



#close file
        mov     $3, %rax
        syscall

        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall                      

