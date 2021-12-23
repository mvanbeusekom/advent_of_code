#include <stack>
#include <string>
#include "../shared/utils.h"

const std::string open = "([{<";
const std::string close = ")]}>";
const int points[] = { 3, 57, 1197, 25137 };

int main() {
    std::vector<std::string> data = readData();
    int answer = 0;

    for (std::string& line: data) {
        std::stack<char> chunkStack;
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
                    std::cout << "Expected '" << (chunkStack.top()) << "' but found '" << *it << std::endl;
                    answer += points[closeIndex];
                    break;
                } else {
                    chunkStack.pop();
                }
            }
        }
    }

    std::cout << "Answer: " << answer << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}