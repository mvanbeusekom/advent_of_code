#include <iostream>
#include <fstream>

int main() {
    int prev = 0;
    int curr = 0;
    int counter = 0;

    std::ifstream file("input.txt");
    if (file.is_open()) {
        std::string line;
        
        while(std::getline(file, line)) {
            if (prev == 0) {
                prev = std::stoi(line);
                continue;
            }
            curr = std::stoi(line);

            if (curr > prev) {
                counter++;
            }

            prev = curr;
        }

        std::cout << "Answer:" << counter << std::endl;
    } else {
        std::cout << "Unable to open file." << std::endl;
    }

    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}