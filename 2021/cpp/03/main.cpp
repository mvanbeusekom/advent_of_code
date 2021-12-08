#include <fstream>
#include <iostream>
#include <string>
#include <vector>

std::vector<std::string> readData();
std::vector<std::string> split(const std::string& instruction);

int main() {
    std::vector<std::string> instructions = readData();
    int horizontal = 0;
    int vertical = 0;

    for(std::string instruction: instructions) {
        std::vector<std::string> splitInstruction = split(instruction);

        if (splitInstruction[0] == "forward") {
            horizontal += std::stoi(splitInstruction[1]);
        } else if (splitInstruction[0] == "up") {
            vertical -= std::stoi(splitInstruction[1]);
        } else if (splitInstruction[0] == "down") {
            vertical += std::stoi(splitInstruction[1]);
        }
    }
        
    std::cout << "Answer: " << horizontal * vertical << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}

std::vector<std::string> readData() {
    std::vector<std::string> data;
    std::ifstream file("input.txt");
    if (file.is_open()) {
        std::string line;
        while(std::getline(file, line)) {
            data.push_back(line);
        }
    }
    return data;
}

// Dirty split without error handling
std::vector<std::string> split(const std::string& instruction) {
    std::vector<std::string> result;
    int pos = instruction.find(' ', 0);
    
    result.push_back(instruction.substr(0, pos));
    result.push_back(instruction.substr(pos + 1, instruction.length()));

    return result;
}
