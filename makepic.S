.global _start

.data
message:
        .ascii  "P3 512 512 255\n"
newl:
        .ascii "\n"
zero:
        .ascii "0 "
one:
        .ascii "255 "
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
        mov     $4, %rdx
        mov     $one, %rsi
        mov     %r12, %r14
        and     $15, %r14
        jz      after1
        mov     $zero, %rsi
        mov     $2, %rdx
        after1:
        mov     $1, %rax
        syscall

        mov     $4, %rdx
        mov     $one, %rsi
        mov     %r12, %r14
        and     $15, %r14
        jz      after2
        mov     $zero, %rsi
        mov     $2, %rdx
        after2:
        mov     $1, %rdx
        mov     $1, %rax
        syscall
        
        mov     $4, %rdx
        mov     $one, %rsi
        mov     %r12, %r14
        and     %r13, %r14
        and     $15, %r14
        jz      after3
        mov     $zero, %rsi
        mov     $2, %rdx
        after3:
        mov     $1, %rdx
        mov     $1, %rax
        syscall
#handle loop stuff
        mov     $512, %rsi
        
        inc     %r12
        cmp     %r12, %rsi
        jg      imgx

        mov     $newl, %rsi
        mov     $1, %rdx
        mov     $1, %rax
        syscall

        inc     %r13
        mov     $1536, %rsi
        cmp     %r13, %rsi
        jg      imgy



#close file
        mov     $3, %rax
        syscall

        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall                      

