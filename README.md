# assembly_ngram_algorithm

In this project me and my friends write an assembly code about n-gram algorithms. Firstly C file works and read from input-tab.txt. After that assembly file works. 
Our homework pdf file has been added in this repo if you want to look in more detail.

## If you want to run the code you have follow these commands:


``` 
nasm -f elf32 assembly.asm -o assembly.o
gcc -c last_main_asm.c -o last_main_asm.o
gcc assembly.o last_main_asm.o -o ngram
./ngram
```
