#include <fstream>
#include <iostream>
#include <string>
#include <vector>

void getInputFile(std::string& filePath);
std::vector<std::string> pivotData(const std::vector<std::string>& data);
std::vector<std::string> readData();
std::vector<std::string> slice(const std::vector<std::string>& arr, int index, int amount);

template<typename T>
std::vector<T> split(std::string str, std::string delimiter, T (* transform)(std::string)) {
    std::vector<T> splittedString;
    int pos = 0;

    while ((pos = str.find(delimiter, 0)) != std::string::npos) {
        std::string token = str.substr(0, pos);
        if (token.length() > 0) {
            splittedString.push_back(transform(token));
        }
        str.erase(0, pos + delimiter.length());
    }

    if (str.length() > 0) {
        splittedString.push_back(transform(str));
    }

    return splittedString;
}