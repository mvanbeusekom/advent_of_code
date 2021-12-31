#include <string>
#include <vector>
#include "../shared/utils.h"

class DumboOctopus {
private:
    int m_TimesFlashed, m_EnergyLevel, m_X, m_Y, m_Step;
    bool m_HasFlashed;
    std::vector<DumboOctopus *> m_Neighbours;

public:
    DumboOctopus(int energyLevel, int x, int y) {
        m_EnergyLevel = energyLevel;
        m_X = x;
        m_Y = y;

        m_Step = 0;
    }
    DumboOctopus() = delete;

    std::vector<DumboOctopus *> getNeighbours(std::vector<std::vector<DumboOctopus>>& octopuses) {
        if (!m_Neighbours.empty()) {
            return m_Neighbours;
        }

        if (m_X > 0) {
            if (m_Y > 0) {
                m_Neighbours.push_back(&(octopuses[m_Y-1][m_X-1]));
            }
            m_Neighbours.push_back(&(octopuses[m_Y][m_X-1]));
            if (m_Y < octopuses.size() - 1) {
                m_Neighbours.push_back(&(octopuses[m_Y+1][m_X-1]));
            }
        }

        if (m_Y > 0) {
            m_Neighbours.push_back(&(octopuses[m_Y-1][m_X]));
        }
        if (m_Y < octopuses.size() - 1) {
            m_Neighbours.push_back(&(octopuses[m_Y+1][m_X]));
        }

        if (m_X < octopuses[m_Y].size() - 1) {
            if (m_Y > 0) {
                m_Neighbours.push_back(&(octopuses[m_Y-1][m_X+1]));
            }
            m_Neighbours.push_back(&(octopuses[m_Y][m_X+1]));
            if (m_Y < octopuses.size() - 1) {
                m_Neighbours.push_back(&(octopuses[m_Y+1][m_X+1]));
            }
        }

        return m_Neighbours;
    }
    const int getEnergyLevel() const { return m_EnergyLevel; }
    const int getX() const { return m_X; }
    const int getY() const { return m_Y; }
    const bool isFullyCharged() const { return m_EnergyLevel > 9; }

    void charge(const int& step) {
        if (step == m_Step && m_EnergyLevel == 0) {
            return;
        }

        m_Step = step;
        ++m_EnergyLevel;
    }

    void flash() {
        m_EnergyLevel = 0;
    }

    std::string to_string() {
        return "DumboOctopus(m_EnergyLevel: " + std::to_string(m_EnergyLevel) + ", m_X: " + std::to_string(m_X) + ", m_Y: " + std::to_string(m_Y) + ", m_Step: " + std::to_string(m_Step) + ")";
    }
};

void print(const std::vector<std::vector<DumboOctopus>>& octopuses) {
    for (int j = 0; j < octopuses.size(); ++j) {
        for (int i = 0; i < octopuses[j].size(); ++i) {
            std::cout << octopuses[j][i].getEnergyLevel();
        }
        std::cout << std::endl;
    }
}

void runStep(std::vector<std::vector<DumboOctopus>>& octopuses, const int& step) {
    for (std::vector<DumboOctopus>& row: octopuses) {
        for (DumboOctopus& octopus: row) {
            octopus.charge(step);
        }
    }

    bool oneOrMoreFlashed;
    while(true) {
        oneOrMoreFlashed = false;

        for (int j = 0; j < octopuses.size(); ++j) {
            for (int i = 0; i < octopuses[j].size(); ++i) {
                if (octopuses[j][i].isFullyCharged()) {
                    oneOrMoreFlashed = true;
                    octopuses[j][i].flash();
                    for (auto* neighbour: octopuses[j][i].getNeighbours(octopuses)) {
                        neighbour->charge(step);
                    }
                }
            }
        }

        if (!oneOrMoreFlashed) {
            break;
        }
    }
}

bool allFlashed(const std::vector<std::vector<DumboOctopus>>& octopuses) {
    for (int j = 0; j < octopuses.size(); ++j) {
        for (int i = 0; i < octopuses[j].size(); ++i) {
            if (octopuses[j][i].getEnergyLevel() != 0) {
                return false;
            }
        }
    }

    return true;
}

void walk(std::vector<std::vector<DumboOctopus>>& octopuses) {
    int step = 0;
    while(true) {

        std::cout << "STEP " << step << ":" << std::endl;
        print(octopuses);
        std::cout << std::endl;

        if (allFlashed(octopuses)) {
            std::cout << "Answer: " << step << std::endl;
            return;
        }

        runStep(octopuses, step);
        ++step;
    }
}

std::vector<std::vector<DumboOctopus>> parseData(const std::vector<std::string>& data) {
    std::vector<std::vector<DumboOctopus>> parsedData;
    for (std::string::size_type j = 0; j < data.size(); ++j) {
        std::vector<DumboOctopus> row;
        for (std::string::size_type i = 0; i < data[j].length(); ++i) {
            row.push_back(DumboOctopus((int)data[j][i] - 48, i, j));
        }
        parsedData.push_back(row);
    }

    return parsedData;
}

int main() {
    std::vector<std::string> data = readData();
    std::vector<std::vector<DumboOctopus>> octopuses = parseData(data);

    walk(octopuses);

    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}