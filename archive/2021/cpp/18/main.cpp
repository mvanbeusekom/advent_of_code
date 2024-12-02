#include <iostream>
#include <vector>
#include "../shared/utils.h"

class Location {
private:
    int m_Value, m_X, m_Y;

public:
    Location(int value, int x, int  y)
      : m_Value(value), m_X(x), m_Y(y) {};
    Location() = delete;

    const int getX() { return m_X; }

    const int getY() { return m_Y; }

    const int getValue() { return m_Value; }
};

class Basin {
private:
    std::vector<Location> m_Locations;
public:
    void add(Location location) {
        m_Locations.push_back(location);
    }

    std::size_t count() const {
        return m_Locations.size();
    }

    bool find(int x, int y) {
        return std::find_if(
                m_Locations.begin(),
                m_Locations.end(),
                [&](Location location) {
                    return location.getX() == x && location.getY() == y;
                }) != m_Locations.end();
    }

    Location& operator[](int index) {
        return m_Locations[index];
    }
};

std::vector<std::vector<int>> parseData(const std::vector<std::string>& data) {
    std::vector<std::vector<int>> parsedData;
    for (auto const& line: data) {
        std::vector<int> numbers;
        for (const char& c: line) {
            numbers.push_back((int)c - 48);
        }
        parsedData.push_back(numbers);
    }

    return parsedData;
}

std::vector<std::vector<int>> matrix;
std::vector<Basin> basins;

void findLocation(int x, int y, Basin& basin) {
    if (matrix[y][x] == 9) {
        return;
    }

    if (basin.find(x, y) || std::find_if(
            basins.begin(),
            basins.end(),
            [&, x, y](Basin basin) { return basin.find(x, y); }) != basins.end()) {
        return;
    }

    basin.add(Location(matrix[y][x], x, y));

    if (x > 0) {
        findLocation(x - 1, y, basin);
    }

    if (x < matrix[y].size() - 1) {
        findLocation(x + 1, y, basin);
    }

    if (y > 0) {
        findLocation(x, y - 1, basin);
    }

    if (y < matrix.size() - 1) {
        findLocation(x, y + 1, basin);
    }
}

int main() {
    std::vector<std::string> data = readData();
    int answer = 0;
    matrix = parseData(data);

    for (std::size_t i = 0; i < matrix.size(); ++i) {
        for (std::size_t j = 0; j < matrix[i].size(); ++j) {
            Basin basin;
            findLocation(j, i, basin);

            if (basin.count() > 0) {
                basins.push_back(basin);
            }
        }
    }

    std::sort(basins.begin(), basins.end(), [](const Basin& first, const Basin& second) {
        return first.count() > second.count();
    });

    if (basins.size() < 3) {
        std::cout << "Didn't find three basins." << std::endl;
        return -1;
    }

    answer = basins[0].count() * basins[1].count() * basins[2].count();

    std::cout << "Answer: " << answer << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}