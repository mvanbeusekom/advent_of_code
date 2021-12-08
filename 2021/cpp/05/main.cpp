#include <fstream>
#include <iostream>
#include <string>
#include <vector>

std::vector<std::string> readData();
std::vector<std::string> pivotData(const std::vector<std::string>& data);
int countUnsetBits(const std::string& bits);

int main() {
    std::string gamma;
    std::string epsilon;

    std::vector<std::string> data = readData();
    std::vector<std::string> pivot = pivotData(data);

    for(const std::string& reading: pivot) {      
        int set = std::count(reading.begin(), reading.end(), '1');
        int unset = reading.length() - set;

        gamma.append(1, set > unset ? '1' : '0');
        epsilon.append(1, set > unset ? '0' : '1');
    }

    std::cout << "Answer: " << std::stoi(gamma, 0, 2) * std::stoi(epsilon, 0, 2) << std::endl;
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
