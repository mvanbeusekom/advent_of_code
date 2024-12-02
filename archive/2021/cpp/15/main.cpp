#include <iostream>
#include <vector>
#include "../shared/utils.h"

int main() {
    std::vector<std::string> data = readData();
    int answer = 0;

    for (std::vector<std::string>::iterator it = data.begin(); it != data.end(); ++it) {
        auto transform = [](std::string str) { return str; };
        std::vector<std::string> input = split<std::string>(*it, " | ", transform);
        std::vector<std::string> outputValues = split<std::string>(input[1], " ", transform);

        for (std::vector<std::string>::iterator itValue = outputValues.begin(); itValue != outputValues.end(); ++itValue) {
            int size = (*itValue).size();
            if (size == 2 || size == 3 || size == 4 || size == 7) {
                answer++;
            }
        }

        std::cout << std::endl;
    }

    std::cout << "Answer: " << answer << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}