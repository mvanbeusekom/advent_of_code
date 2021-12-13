#include <fstream>
#include <iostream>
#include <vector>
#include "../shared/utils.h"

int main() {
    std::vector<std::string> instructions = readData();

    int horizontal = 0;
    int depth = 0;

    for(std::string instruction: instructions) {
        std::vector<std::string> splitInstruction = split<std::string>(
                instruction,
                " ",
                [](std::string str) { return str; });

        if (splitInstruction[0] == "forward") {
            horizontal += std::stoi(splitInstruction[1]);
        } else if (splitInstruction[0] == "up") {
            depth -= std::stoi(splitInstruction[1]);
        } else if (splitInstruction[0] == "down") {
            depth += std::stoi(splitInstruction[1]);
        }
    }

    std::cout << "Answer: " << horizontal * depth << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}
