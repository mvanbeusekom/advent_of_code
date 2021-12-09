#include <fstream>
#include <iostream>
#include <vector>
#include "../shared/utils.h"

int main() {
    std::vector<std::string> instructions = readData();

    int horizontal = 0;
    int depth = 0;

    for(std::string instruction: instructions) {
        std::vector<std::string> splitInstruction = split(instruction, ' ');

        if (splitInstruction[0] == "forward") {
            horizontal += std::stoi(splitInstruction[1]);
        } else if (splitInstruction[0] == "up") {
            depth -= std::stoi(splitInstruction[1]);
        } else if (splitInstruction[0] == "down") {
            depth += std::stoi(splitInstruction[1]);
        }
    }

    log("Answer: " + std::to_string(horizontal * depth));
    log("Press enter to exit the application.");
    std::cin.get();
}
