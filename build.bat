nasm -fwin64 main.asm
ld -LC:/Windows/System32 -lkernel32 -o main.exe main.obj