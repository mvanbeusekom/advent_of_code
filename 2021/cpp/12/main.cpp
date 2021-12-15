#include <iostream>
#include <vector>
#include <map>
#include "../shared/utils.h"

std::map<int, unsigned long long> createInitialGen(std::vector<int>& data) {
    std::map<int, unsigned long long> initialGen {
            {0, 0},
            {1, 0},
            {2, 0},
            {3, 0},
            {4, 0},
            {5, 0},
            {6, 0},
            {7, 0},
            {8, 0},
    };

    for (std::vector<int>::iterator it = data.begin(); it != data.end(); ++it) {
        initialGen[*it]++;
    }

    return initialGen;
}

int main () {
    std::vector<std::string> data = readData();
    std::vector<int> input = split<int>(
            data[0],
            ",",
            [](std::string str) { return std::stoi(str); });

    std::map<int, unsigned long long> lanternfish = createInitialGen(input);
    unsigned long long newFish = 0;

    for (int i = 0; i < 256; ++i) {
        for (auto pair: lanternfish) {
            if (pair.first == 0) {
                newFish = pair.second;
            } else {
                lanternfish[pair.first - 1] = pair.second;
            }

            lanternfish[pair.first] = 0;
        }

        lanternfish[6] = lanternfish[6] + newFish;
        lanternfish[8] = newFish;
        newFish = 0;

        std::cout << "Day " << i << ":" << std::endl;
        for (auto& pair: lanternfish) {
            std::cout << "[" << pair.first << "]: " << pair.second << std::endl;
        }
    }

    unsigned long long answer = 0;
    std::cout << "Final: " << std::endl;
    for (auto& pair: lanternfish) {
        std::cout << "[" << pair.first << "]: " << pair.second << std::endl;
        answer = answer + pair.second;
    }

    std::cout << "Answer: " << answer << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}