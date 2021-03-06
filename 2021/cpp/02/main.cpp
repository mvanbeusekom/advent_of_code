#include <iostream>
#include <fstream>
#include <vector>
#include "../shared/utils.h"

int main() {
    std::vector<std::string> input = readData();
    int counter = 0;

    for(int i = 0; i < input.size() - 1; i++) {
        std::vector<std::string> lowerWindow = slice(input, i, 3);
        std::vector<std::string> upperWindow = slice(input, i + 1, 3);
        int lowerSum = 0;
        int upperSum = 0;

        for(int j = 0; j < upperWindow.size(); j++) {
            if (upperWindow[j].length() > 0) {
                lowerSum += std::stoi(lowerWindow[j]);
                upperSum += std::stoi(upperWindow[j]);
            }
        }

        if (upperSum > lowerSum) {
            counter++;
        }
    }

    std::cout << "Answer: " << counter << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}



