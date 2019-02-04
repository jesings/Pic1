.global _start

.data
message:
        .ascii  "P3 512 512 255\n"
newl:
        .ascii "\n"
pathname:
        .asciz "./image.ppm"
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
        mov     %r12, %rax
        shr     $1, %rax
        call convert
        mov     $1, %rax
        mov     %rbx, %rdx
        syscall
        mov     %r13, %rax
        shr     $1, %rax
        call convert
        mov     $1, %rax
        mov     %rbx, %rdx
        syscall
        mov     %r12, %rax
        add     %r13, %rax
        shr     $2, %rax
        call convert
        mov     $1, %rax
        mov     %rbx, %rdx
        syscall

 
#handle loop stuff
        mov     $512, %r9
        
        inc     %r12
        cmp     %r12, %r9
        jg      imgx

        mov     $newl, %rsi
        mov     $1, %rdx
        mov     $1, %rax
        syscall

        inc     %r13
        cmp     $512, %r13
        jl      imgy



#close file
        mov     $3, %rax
        syscall

        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall                      

