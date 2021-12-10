#include <fstream>
#include <iostream>
#include <vector>
#include "../shared/utils.h"

int main() {
    std::vector<std::string> instructions = readData();

    int aim = 0;
    int horizontal = 0;
    int depth = 0;

    for(std::string instruction: instructions) {
        std::vector<std::string> splitInstruction = split<std::string>(
                instruction,
                ' ',
                [](std::string str) { return str; });

        if (splitInstruction[0] == "forward") {
            int x = std::stoi(splitInstruction[1]);
            horizontal += x;
            depth += aim * x;
        } else if (splitInstruction[0] == "up") {
            aim -= std::stoi(splitInstruction[1]);
        } else if (splitInstruction[0] == "down") {
            aim += std::stoi(splitInstruction[1]);
        }
    }
        
    log("Answer: " + std::to_string(horizontal * depth));
    log("Press enter to exit the application.");
    std::cin.get();
}
