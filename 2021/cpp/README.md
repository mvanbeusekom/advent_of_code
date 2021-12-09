# Instructions

This folder contains my attempt of solving the 2021 edition of the [Advent of Code](https://adventofcode.com/2021) in 
C++. This solution is written using macOS, [Visual Studio Code](https://code.visualstudio.com) and 
[clang++](https://clang.llvm.org/). However the code should work with any C++ compiler.

Each puzzle is located in its own numbered folder (e.g. the first exercise is located in folder `01`, the next in folder
`02`, etc...). Each folder contains a file `main.cpp` which is the entry point of the application.

## Compile

To compile the application run the following command from the folder containing the `main.cpp` file (replace 
`<puzzle_number>` with the number of the puzzle to compile, e.g. `01`):

```shell
# Compile the exercise.
clang++ -std=c++17 <puzzle_number>/*.cpp shared/*.cpp -o <puzzle_number>
```

## Execute

To execute the application simply run the `./<puzzle_number>` command in a terminal (the command needs to match the 
value of the `-o` flag used when compiling the application). For example, when the first puzzle is compiled using the 
`-o 01` flag, the application can be run with the following command:  

```shell
# Run the first application.
./01
```

> NOTE: most applications will ask for a path to the input file. When this is the case you can find the input file in
> the root folder next to the source code of the puzzle. For example the input file of the first puzzle can be found at
> `01/input.txt`. The requested input path should either be a relative path from the location the application is run or 
> an absolute path.
