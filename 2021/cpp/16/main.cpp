#include <iostream>
#include <map>
#include <vector>
#include "../shared/utils.h"

int matchingSegments(
        const std::string& source,
        const std::string& pattern) {
    int count = 0;

    for (char const& c: pattern) {
        if (source.find(c) != std::string::npos) {
            count++;
        }
    }

    return count;
}

int main() {
    std::vector<std::string> data = readData();
    int answer = 0;

    for (std::vector<std::string>::iterator it = data.begin(); it != data.end(); ++it) {
        auto transform = [](std::string str) { return str; };
        std::vector<std::string> input = split<std::string>(*it, " | ", transform);
        std::vector<std::string> signalValues = split<std::string>(input[0], " ", transform);
        std::vector<std::string> outputValues = split<std::string>(input[1], " ", transform);

        std::sort(signalValues.begin(), signalValues.end(), []
                (const std::string& first, const std::string& second){
            return first.size() < second.size();
        });

        std::map<int, std::string> digitMap {
                { 1, signalValues[0] },
                { 2, "" },
                { 3, "" },
                { 4, signalValues[2] },
                { 5, "" },
                { 6, "" },
                { 7, signalValues[1] },
                { 8, signalValues[9] },
                { 9, "" },
                { 0, "" }
        };

        for (std::vector<std::string>::iterator itValue = signalValues.begin(); itValue != signalValues.end(); ++itValue) {
            if (itValue->size() == 5) {
                if (matchingSegments(*itValue, digitMap[1]) == digitMap[1].size()) {
                    digitMap[3] = *itValue;
                    continue;
                } else if (matchingSegments(*itValue, digitMap[4]) == 2) {
                    digitMap[2] = *itValue;
                    continue;
                } else if (matchingSegments(*itValue, digitMap[4]) == 3) {
                    digitMap[5] = *itValue;
                    continue;
                }
            }

            if (itValue->size() == 6) {
                if (matchingSegments(*itValue, digitMap[4]) == digitMap[4].size()) {
                    digitMap[9] = *itValue;
                    continue;
                } else if (matchingSegments(*itValue, digitMap[1]) == 1) {
                    digitMap[6] = *itValue;
                    continue;
                } else {
                    digitMap[0] = *itValue;
                    continue;
                }
            }
        }

        std::string digit = "";
        for (std::vector<std::string>::iterator itValue = outputValues.begin(); itValue != outputValues.end(); ++itValue) {
            for (const auto& kvp: digitMap) {
                if (kvp.second.size() == itValue->size() && matchingSegments(*itValue, kvp.second) == kvp.second.size()) {
                    digit += std::to_string(kvp.first);
                }
            }
        }
        
        answer += std::stoi(digit);
    }

    std::cout << "Answer: " << answer << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}