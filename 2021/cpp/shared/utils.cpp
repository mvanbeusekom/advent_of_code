#include <fstream>
#include <iostream>
#include <vector>

void log(const std::string& message) {
    std::cout << message << std::endl;
}

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

std::vector<std::string> readData(const std::string& filePath) {
    std::vector<std::string> data;
    std::ifstream file(filePath);
    if (file.is_open()) {
        std::string line;
        while (std::getline(file, line)) {
            if (line.length() > 0) {
                data.push_back(line);
            }
        }
    }
    return data;
}

std::vector<std::string> slice(const std::vector<std::string>& arr, int index, int amount) {
    auto start = arr.begin() + index;
    auto end = arr.begin() + index + amount;
    return std::vector<std::string>(start, end);
}

std::vector<std::string> split(std::string str, char delimiter) {
    std::vector<std::string> splittedString;
    int pos = 0;

    while ((pos = str.find(delimiter, 0)) != std::string::npos) {
        std::string token = str.substr(0, pos);
        if (token.length() > 0) {
            splittedString.push_back(token);
        }
        str.erase(0, pos + 1);
    }

    if (str.length() > 0) {
        splittedString.push_back(str);
    }

    return splittedString;
}