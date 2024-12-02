#include <fstream>
#include <vector>
#include "../shared/utils.h"

typedef std::vector<int> row;
typedef std::vector<row> matrix;

matrix convertRawData(const std::vector<std::string>& data);

struct Card {
private:
    matrix m_Numbers;

public:
    Card(const matrix& numbers) {
        m_Numbers = numbers;
    }

    bool hasBingo(const row& numbers) {
        for(int i = 0; i < m_Numbers.size(); i++) {
            bool bingo = true;
            for(int j = 0; j < m_Numbers.size(); j++) {
                if(std::find(numbers.begin(), numbers.end(), m_Numbers[i][j]) != numbers.end()) {
                    continue;
                }

                bingo = false;
                break;
            }

            if (bingo) {
                return true;
            }
        }

        for(int i = 0; i < m_Numbers.size(); i++) {
            bool bingo = true;
            for(int j = 0; j < m_Numbers.size(); j++) {
                if(std::find(numbers.begin(), numbers.end(), m_Numbers[j][i]) != numbers.end()) {
                    continue;
                }

                bingo = false;
                break;
            }

            if (bingo) {
                return true;
            }
        }

        return false;
    }

    int getScore(const row& drawnNumbers) {
        int sumOfUnmarked = 0;
        for(int i = 0; i < m_Numbers.size(); i++) {
            for (int j = 0; j < m_Numbers.size(); j++) {
                if(std::find(drawnNumbers.begin(), drawnNumbers.end(), m_Numbers[i][j]) == drawnNumbers.end()) {
                    sumOfUnmarked += m_Numbers[i][j];
                }
            }
        }

        return sumOfUnmarked * drawnNumbers.back();
    }

    void toString() {
        for(int i = 0; i < m_Numbers.size(); ++i) {
            for (int j = 0; j < m_Numbers[i].size(); ++j) {
                std::cout << m_Numbers[i][j] << " ";
            }

            std::cout << std::endl;
        }
    }
};

int main() {
    std::vector<Card> cards;
    std::vector<std::string> data = readData();
    row numbersToDraw = split<int>(
            data[0],
            ",",
            [](std::string str) { return std::stoi(str); });

    matrix numbers = convertRawData(data);

    for(int i = 0; i < numbers.size(); i+= 5) {
        cards.push_back(Card(std::vector<std::vector<int>>(numbers.begin() + i, numbers.begin() + i + 5)));
    }

    for(Card card: cards) {
        card.toString();
        std::cout << std::endl;
    }

    int winningIndex = -1;
    row drawnNumbers;
    for (int i = 0; i < numbersToDraw.size(); i++) {
        drawnNumbers.push_back(numbersToDraw[i]);
        for(int j = 0; j < cards.size(); j++) {
            if (cards[j].hasBingo(drawnNumbers)) {
                winningIndex = j;
                break;
            }
        }

        if(winningIndex != -1) {
            break;
        }
    }

    Card winningCard = cards[winningIndex];
    std::cout << "Answer: " << winningCard.getScore(drawnNumbers) << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}

matrix convertRawData(const std::vector<std::string>& data) {
    matrix numericData;

    for(int i = 1; i < data.size(); i++) {
        row line = split<int>(
                data[i],
                " ",
                [](std::string str) {
                    return std::stoi(str);
                }
        );

        numericData.push_back(line);
    }

    return numericData;
}