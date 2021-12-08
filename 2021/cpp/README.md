# Instructions

This folder contains my attempt of solving the 2021 edition of the [Advent of Code](https://adventofcode.com/2021) in C++. This solution is written using macOS, [Visual Studio Code](https://code.visualstudio.com) and [clang++](https://clang.llvm.org/). However the code should work with any C++ compiler.

Each puzzle is located into its own numbered folder (e.g. the first exercise is located in folder `01`, the next in folder `02`, etc...). Each folder contains a file `main.cpp` which is the entry point of the application.

## Compile

To compile the application run the following command from the folder containing the `main.cpp` file:

```shell
# Change into puzzle you want to compile.
cd 01
# Compile the exercise.
clang++ -std=c++17 -g main.cpp -o main
```

## Execute

To execute the application run the following command from the folder containing the `main.cpp` file:

```shell
# Change into puzzle you want to compile.
cd 01
# Run the exercise.
./main
```