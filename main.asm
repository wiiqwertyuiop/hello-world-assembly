; https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html
; https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention?view=msvc-170

global _main
extern GetStdHandle, WriteConsoleA, ExitProcess

section .text

STD_OUTPUT_HANDLE: EQU -11

_main:

    ; Align the stack on a 16-byte boundary
    and     rsp, -16
    
    push    rbp
    mov     rbp, rsp

    mov rcx, STD_OUTPUT_HANDLE
    call GetStdHandle

    mov rcx, rax    ; hConsoleOutput
    mov rdx, msg    ; *lpBuffer
    mov r8, len     ; nNumberOfCharsToWrite
    mov r9, 0       ; lpNumberOfCharsWritten
    push 0          ; lpReserved
    call WriteConsoleA

    mov     rsp, rbp
    pop     rbp
    
    mov rcx, 0
    call ExitProcess

section .data

msg:
    db "Hello World!", 0x0A
    len equ $-msg