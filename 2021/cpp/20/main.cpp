#include <stack>
#include <string>
#include <vector>
#include "../shared/utils.h"

const std::string open = "([{<";
const std::string close = ")]}>";
const int points[] = { 1, 2, 3, 4 };

int main() {
    std::vector<std::string> data = readData();
    std::vector<long> pointsPerLine;

    for (std::string& line: data) {
        std::stack<char> chunkStack;
        bool skipLine = false;
        for (std::string::iterator it = line.begin(); it != line.end(); ++it) {
            if (open.find(*it) != std::string::npos) {
                chunkStack.push(*it);
            } else {
                auto closeIndex = close.find(*it);
                if (closeIndex == std::string::npos) {
                    std::cout << "Expected closing character but found '" << *it << "' instead." << std::endl;
                    return -1;
                }

                if (open.find(chunkStack.top()) != closeIndex) {
                    std::cout << "SKIPPING LINE (expected '" << (chunkStack.top()) << "' but found '" << *it << ")" << std::endl;
                    skipLine = true;
                    break;
                } else {
                    chunkStack.pop();
                }
            }
        }

        if (skipLine || chunkStack.size() <= 0) {
            continue;
        }

        long score = 0;
        do {
            int openIndex = open.find(chunkStack.top());
            score = score * 5 + (openIndex + 1);
            chunkStack.pop();
        } while (chunkStack.size() > 0);
        pointsPerLine.push_back(score);
        std::cout << std::endl;
    }

    std::sort(pointsPerLine.begin(), pointsPerLine.end(), [&](long first, long second) { return first < second; });
    std::cout << "Answer: " << pointsPerLine[pointsPerLine.size() / 2] << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}