#include <iostream>
#include <vector>
#include <cmath>
#include "../shared/utils.h"


int main () {
    std::vector<std::string> data = readData();
    std::vector<int> input = split<int>(
            data[0],
            ",",
            [](std::string str) { return std::stoi(str); });
    std::sort(input.begin(), input.end());
    int lowestConsumption = -1;

    for (int i = input[0]; i <= input[input.size() - 1]; ++i) {
        int consumption = 0;
        for (std::vector<int>::iterator it = input.begin(); it != input.end(); ++it) {
            consumption += std::abs((*it) - i);
        }

        if (lowestConsumption == -1 || consumption < lowestConsumption) {
            lowestConsumption = consumption;
        }
    }

    std::cout << "Answer: " << lowestConsumption << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}