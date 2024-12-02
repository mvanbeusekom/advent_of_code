#include <iostream>
#include <vector>
#include "../shared/utils.h"

std::vector<std::vector<int>> parseData(const std::vector<std::string>& data) {
    std::vector<std::vector<int>> parsedData;
    for (auto const& line: data) {
        std::vector<int> numbers;
        for (const char& c: line) {
            numbers.push_back((int)c - 48);
        }
        parsedData.push_back(numbers);
    }

    return parsedData;
}

int main() {
    std::vector<std::string> data = readData();
    int answer = 0;
    auto matrix = parseData(data);

    for (std::size_t i = 0; i < matrix.size(); ++i) {
        for (std::size_t j = 0; j < matrix[i].size(); ++j) {
            std::vector<int> adjacentNumbers;
            int number = matrix[i][j];
            if (i > 0) {
                adjacentNumbers.push_back(matrix[i - 1][j]);
            }
            if (i < matrix.size() - 1) {
                adjacentNumbers.push_back(matrix[i + 1][j]);
            }
            if (j > 0) {
                adjacentNumbers.push_back(matrix[i][j - 1]);
            }
            if (j < matrix[i].size() - 1) {
                adjacentNumbers.push_back(matrix[i][j + 1]);
            }

            std::sort(adjacentNumbers.begin(), adjacentNumbers.end(), [](const int& first, const int& second) {
                return first < second;
            });

            if (number < adjacentNumbers[0]) {
                answer += number + 1;
            }
        }
    }

    std::cout << "Answer: " << answer << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}