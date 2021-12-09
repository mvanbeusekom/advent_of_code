#include <fstream>
#include <iostream>
#include <vector>
#include "../shared/utils.h"

char findCommonBitAtIndex(const std::vector<std::string>& data, int index, bool mostCommon);
std::vector<std::string> filterData(const std::vector<std::string>& data, int filterPos, bool mostCommon);

int main() {
    std::string oxygen;
    std::string scrubber;

    std::string filePath;
    getInputFile(filePath);
    std::vector<std::string> data = readData(filePath);

    oxygen = filterData(data, 0, true)[0];
    scrubber = filterData(data, 0, false)[0];

    log("Answer: " + std::to_string(std::stoi(oxygen, 0, 2) * std::stoi(scrubber, 0, 2)));
    log("Press enter to exit the application.");
    std::cin.get();
}

char findCommonBitAtIndex(const std::vector<std::string>& data, int index, bool mostCommon) {
    std::string reading = data[index];
    int set = std::count(reading.begin(), reading.end(), '1');
    int unset = reading.length() - set;

    if (mostCommon) {
        return set >= unset ? '1' : '0';
    } else {
        return unset <= set ? '0' : '1';
    }
}

std::vector<std::string> filterData(const std::vector<std::string>& data, int filterPos, bool mostCommon) {
    std::vector<std::string> pivot = pivotData(data);
    char mostCommonBit = findCommonBitAtIndex(pivot, filterPos, mostCommon);
    std::vector<std::string> result;

    for(const std::string& reading: data) {
        if (reading[filterPos] == mostCommonBit) {
            result.push_back(reading);
        }
    }

    if (result.size() > 1) {
        return filterData(result, filterPos + 1, mostCommon);
    } else {
        return result;
    }

}