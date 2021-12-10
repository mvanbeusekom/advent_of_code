#include <fstream>
#include <iostream>
#include <vector>
#include "utils.h"

void getInputFile(std::string& filePath) {
    std::cout << "Specify the path to the input file: ";
    std::getline(std::cin, filePath);
}

std::vector<std::string> pivotData(const std::vector<std::string>& data) {
    std::vector<std::string> pivot;

    int bitCount = data[0].length();

    for(int i = 0; i < bitCount; i++) {
        std::string p;
        for(const std::string& reading: data) {
            p.append(1, reading[i]);
        }

        pivot.push_back(p);
    }

    return pivot;
}

std::vector<std::string> readData() {
    std::string filePath;
    getInputFile(filePath);

    std::vector<std::string> data;
    std::ifstream file(filePath);
    if (file.is_open()) {
        std::string line;
        while (std::getline(file, line)) {
            if (line.empty()) {
                continue;
            }
            data.push_back(line);
        }
    }
    return data;
}

std::vector<std::string> slice(const std::vector<std::string>& arr, int index, int amount) {
    auto start = arr.begin() + index;
    auto end = arr.begin() + index + amount;
    return std::vector<std::string>(start, end);
}