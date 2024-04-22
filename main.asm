; https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html
; https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention?view=msvc-170

global main
extern GetStdHandle, WriteConsoleA, ExitProcess

section .text

STD_OUTPUT_HANDLE: EQU -11

main:
    sub rsp, 40+8    ; Allocate space for parameters and align stack

    mov rcx, STD_OUTPUT_HANDLE
    call GetStdHandle

    push 0           ; lpReserved
    lea r9, [rsp+16] ; lpNumberOfCharsWritten
    mov r8, len      ; nNumberOfCharsToWrite
    mov rdx, msg     ; *lpBuffer
    mov rcx, rax     ; hConsoleOutput
    call WriteConsoleA

    mov rcx, len     ; Check all chars were written correctly
    sub rcx, [rsp+16]; Exit code should be 0

    add rsp, 40+8    ; Clean up stack
    call ExitProcess

msg:
    db "Hello World!", 0x0A
    len equ $-msg