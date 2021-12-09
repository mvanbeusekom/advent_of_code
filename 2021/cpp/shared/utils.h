#include <string>
#include <vector>

void log(const std::string& message);
void getInputFile(std::string& filePath);
std::vector<std::string> pivotData(const std::vector<std::string>& data);
std::vector<std::string> readData();
std::vector<std::string> readData(bool excludeEmptyLines);
std::vector<std::string> slice(const std::vector<std::string>& arr, int index, int amount);
std::vector<std::string> split(std::string str, char delimiter);