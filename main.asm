; https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html
; https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention?view=msvc-170

global main
extern GetStdHandle, WriteConsoleA, ExitProcess

section .text

STD_OUTPUT_HANDLE: EQU -11

main:
    and rsp, -16    ; Align the stack on a 16-byte boundary
    sub rsp, 40     ; Allocate space for parameters

    mov rcx, STD_OUTPUT_HANDLE
    call GetStdHandle

    push 0          ; lpReserved
    mov r9, 0       ; lpNumberOfCharsWritten
    mov r8, len     ; nNumberOfCharsToWrite
    mov rdx, msg    ; *lpBuffer
    mov rcx, rax    ; hConsoleOutput
    call WriteConsoleA

    add rsp, 40     ; Clean up stack
    mov rcx, 0
    call ExitProcess

msg:
    db "Hello World!", 0x0A
    len equ $-msg