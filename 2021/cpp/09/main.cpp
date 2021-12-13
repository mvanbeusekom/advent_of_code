#include <iostream>
#include <cmath>
#include <vector>
#include "../shared/utils.h"

class Point {
public:
    int X, Y;

public:
    Point() = delete;
    Point(int x, int y)
        : X(x), Y(y) {
    }

    int compare(const Point& other) {
        if (X == other.X && Y == other.Y) {
            return 0;
        }

        if (X < other.X || Y < other.Y) {
            return -1;
        }

        return 1;
    }

    static Point parse(const std::string& value) {
        std::vector<int> coordinates = split<int>(value, ",", [](std::string v){
            return std::stoi(v);
        });

        return Point(coordinates[0], coordinates[1]);
    }
};

class Line {
private:
    Point m_StartPoint, m_EndPoint;

public:
    Line() = delete;
    Line(const Point& startPoint, const Point& endPoint)
        : m_StartPoint(startPoint), m_EndPoint(endPoint) {
    }

    bool isDiagonal() {
        return m_StartPoint.X != m_EndPoint.X && m_StartPoint.Y != m_EndPoint.Y;
    }

    std::vector<Point> getPoints() {
        Point difference = Point(m_StartPoint.X - m_EndPoint.X, m_StartPoint.Y - m_EndPoint.Y);

        std::vector<Point> points { m_StartPoint };
        int incrementX = difference.X != 0 ? difference.X / abs(difference.X) : 0;
        int incrementY = difference.Y != 0 ? difference.Y / abs(difference.Y) : 0;

        for (int i = 1; i < abs(difference.X); ++i) {
            points.push_back(Point(m_StartPoint.X + (incrementX * i) * -1, m_StartPoint.Y));
        }

        for (int i = 1; i < abs(difference.Y); ++i) {
            points.push_back(Point(m_StartPoint.X, m_StartPoint.Y + (incrementY * i) * -1));
        }

        points.push_back(m_EndPoint);

        return points;
    }

    static Line parse(const std::string& value) {
        std::vector<std::string> lineData = split<std::string>(value, " -> ", [](std::string s) { return s; } );

        Point startPoint = Point::parse(lineData[0]);
        Point endPoint = Point::parse(lineData[1]);
        return Line(startPoint, endPoint);
    }
};

int main() {
    const int matrix_size = 1000;
    int vents[matrix_size][matrix_size] {0};

    std::vector<std::string> data = readData();
    std::vector<Line> lines;

    for (std::vector<std::string>::iterator it = data.begin(); it != data.end(); ++it) {
        Line line = Line::parse(*it);

        if (!line.isDiagonal()) {
            lines.push_back(line);
        }
    }

    for (std::vector<Line>::iterator it = lines.begin(); it != lines.end(); ++it) {
        auto points = it->getPoints();
        for (std::vector<Point>::iterator pointIt = points.begin(); pointIt != points.end(); ++pointIt) {
            vents[pointIt->X][pointIt->Y]++;
        }
    }

    int answer = 0;
    for (int i = 0; i < matrix_size; ++i) {
        for (int j = 0; j < matrix_size; ++j) {
            if (vents[i][j] >= 2) {
                answer++;
            }
        }
    }

    std::cout << "Answer: " << answer << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}