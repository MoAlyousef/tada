# Tada

A simple FLTK GUI todo app written in x86-64 assembly (GAS, Intel syntax).  
Targets the System V AMD64 ABI (SysV calling convention).

## Building
```bash
cmake -Bbin -DCMAKE_BUILD_TYPE=MinSizeRel && cmake --build bin --parallel
./bin/tada
```
