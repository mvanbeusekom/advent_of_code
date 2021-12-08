#include <fstream>
#include <iostream>
#include <string>
#include <vector>

std::vector<std::string> readData();
std::vector<std::string> pivotData(const std::vector<std::string>& data);
char findCommonBitAtIndex(const std::vector<std::string>& data, int index, bool mostCommon);
std::vector<std::string> filterData(const std::vector<std::string>& data, int filterPos, bool mostCommon);

int main() {
    std::string oxygen;
    std::string scrubber;

    std::vector<std::string> data = readData();

    oxygen = filterData(data, 0, true)[0];
    scrubber = filterData(data, 0, false)[0];

    std::cout << "Answer: " << std::stoi(oxygen, 0, 2) * std::stoi(scrubber, 0, 2) << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}

std::vector<std::string> readData() {
    std::vector<std::string> data;
    std::ifstream file("input.txt");
    if (file.is_open()) {
        std::string line;
        while(std::getline(file, line)) {
            data.push_back(line);
        }
    }
    return data;
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