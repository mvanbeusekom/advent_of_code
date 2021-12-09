#include <fstream>
#include <iostream>
#include <vector>
#include "../shared/utils.h"

int main() {
    std::string gamma;
    std::string epsilon;

    std::string filePath;
    getInputFile(filePath);
    std::vector<std::string> data = readData(filePath);
    std::vector<std::string> pivot = pivotData(data);

    for(const std::string& reading: pivot) {      
        int set = std::count(reading.begin(), reading.end(), '1');
        int unset = reading.length() - set;

        gamma.append(1, set > unset ? '1' : '0');
        epsilon.append(1, set > unset ? '0' : '1');
    }

    log("Answer: " + std::to_string(std::stoi(gamma, 0, 2) * std::stoi(epsilon, 0, 2)));
    log("Press enter to exit the application.");
    std::cin.get();
}
