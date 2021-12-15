#include <iostream>
#include <vector>
#include "../shared/utils.h"

int main () {
    std::vector<std::string> data = readData();
    std::vector<int> input = split<int>(
            data[0],
            ",",
            [](std::string str) { return std::stoi(str); });

    for (int i = 0; i < 80; ++i) {
        std::vector<int> intermediate;
        for (std::vector<int>::iterator it = input.begin(); it != input.end(); ++it) {
            if (*it == 0) {
                intermediate.push_back(8);
                *it = 6;
            } else {
                (*it)--;
            }
        }

        input.insert(input.end(), intermediate.begin(), intermediate.end());
    }

    std::cout << "Answer: " << input.size() << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}