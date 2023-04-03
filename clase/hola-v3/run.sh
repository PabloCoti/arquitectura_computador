echo "COMPILANDO .ASM"
nasm -f elf hola-v3.asm
echo "CREANDO OBJETO"
ld -m elf_i386 hola-v3.o -o hola-v3
echo "EJECUTANDO"
./hola-v3