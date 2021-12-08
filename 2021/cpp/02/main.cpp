#include <iostream>
#include <fstream>
#include <vector>

std::vector<int> readData();
std::vector<int> slice(const std::vector<int>& arr, int index, int amount);

int main() {
    std::vector<int> input = readData();
    int counter = 0;

    for(int i = 0; i < input.size() - 1; i++) {
        std::vector<int> lowerWindow = slice(input, i, 3);
        std::vector<int> upperWindow = slice(input, i + 1, 3);
        int lowerSum = 0;
        int upperSum = 0;

        for(int j = 0; j < lowerWindow.size(); j++) {
            lowerSum += lowerWindow[j];
            upperSum += upperWindow[j];
        }

        if (upperSum > lowerSum) {
            counter++;
        }
    }

    std::cout << "Answer: " << counter << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}

std::vector<int> readData() {
    std::vector<int> data;
    std::ifstream file("input.txt");
    if (file.is_open()) {
        std::string line;
        while(std::getline(file, line)) {
            data.push_back(std::stoi(line));
        }
    }
    return data;
}

std::vector<int> slice(const std::vector<int>& arr, int index, int amount) {
    auto start = arr.begin() + index;
    auto end = arr.begin() + index + amount;
    return std::vector<int>(start, end);
}