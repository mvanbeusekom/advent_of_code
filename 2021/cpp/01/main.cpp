#include <iostream>
#include <fstream>
#include <vector>
#include "../shared/utils.h"

int main() {
    int prev = 0;
    int curr;
    int counter = 0;
    std::vector<std::string> data = readData();

    for(const std::string& line: data) {
        if (prev == 0) {
            prev = std::stoi(line);
            continue;
        }

        curr = std::stoi(line);

        if (curr > prev) {
            counter++;
        }

        prev = curr;
    }

    log("Answer: " + std::to_string(counter));
    log("Press enter to exit the application.");
    std::cin.get();
}