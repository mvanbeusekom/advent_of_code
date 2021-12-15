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

private:
    int calculateSlope() {
        return (m_EndPoint.Y - m_StartPoint.Y) / (m_EndPoint.X - m_StartPoint.X);
    }

    int calculateIntercept(const int& slope) {
        return (m_StartPoint.Y - (slope * m_StartPoint.X));
    }

    int calculateY(const int& x, const int& slope, const int& intercept) {
        return x * slope + intercept;
    }

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

        if (incrementX != 0) {
            int slope = calculateSlope();
            int intercept = calculateIntercept(slope);

            for (int i = 1; i < abs(difference.X); ++i) {
                int x = m_StartPoint.X + (incrementX * i) * -1;
                int y = calculateY(x, slope, intercept);
                points.push_back(Point(x, y));
            }
        } else {
            for (int i = 1; i < abs(difference.Y); ++i) {
                points.push_back(Point(m_StartPoint.X, m_StartPoint.Y + (incrementY * i) * -1));
            }
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
        lines.push_back(Line::parse(*it));
    }

    for (std::vector<Line>::iterator it = lines.begin(); it != lines.end(); ++it) {
        auto points = it->getPoints();
        for (std::vector<Point>::iterator pointIt = points.begin(); pointIt != points.end(); ++pointIt) {
            //std::cout << pointIt->X << "," << pointIt->Y << std::endl;
            vents[pointIt->X][pointIt->Y]++;
        }
    }

    int answer = 0;
    for (int i = 0; i < matrix_size; ++i) {
        for (int j = 0; j < matrix_size; ++j) {
            //std::cout << ((vents[j][i] != 0) ? std::to_string(vents[j][i]) : ".");
            if (vents[j][i] >= 2) {
                answer++;
            }
        }
        //std::cout << std::endl;
    }

    std::cout << "Answer: " << answer << std::endl;
    std::cout << "Press enter to exit the application." << std::endl;
    std::cin.get();
}