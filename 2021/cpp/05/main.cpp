#include <fstream>
#include <iostream>
#include <vector>
#include "../shared/utils.h"

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

    std::cout << "Answer: " << std::stoi(gamma,0 , 2) * std::stoi(epsilon, 0, 2) << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}
