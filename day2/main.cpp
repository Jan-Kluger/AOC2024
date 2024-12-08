#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
using namespace std;

class file_Process {
public:
    vector<vector<int>> parse_file(const string &file_path) {
        ifstream file_stream(file_path);
        vector<vector<int>> result;

        if (!file_stream.is_open()) {
            cerr << "Error: Could not open file " << file_path << endl;
            return result;
        }

        string line;
        while (getline(file_stream, line)) {
            vector<int> numbers;
            stringstream ss(line);
            int num;

            // Read integers from the line
            while (ss >> num) {
                numbers.push_back(num);
            }

            result.push_back(numbers);
        }

        file_stream.close();
        return result;
    }
};

class Solution {
public:
    int countSafeReports(const vector<vector<int>>& reports) {
        int safeCount = 0;
        for (const auto& rep : reports) {
            if (rep.size() < 2) {
                // Not enough data to determine if safe
                continue;
            }

            int firstDiff = rep[1] - rep[0];
            if (firstDiff == 0 || std::abs(firstDiff) > 3) {
                // Fails the monotonic and difference criteria right away
                continue;
            }

            bool increasing = (firstDiff > 0);
            bool decreasing = (firstDiff < 0);
            bool safe = true;

            for (size_t i = 2; i < rep.size(); ++i) {
                int diff = rep[i] - rep[i - 1];
                if (diff == 0 || std::abs(diff) > 3) {
                    safe = false;
                    break;
                }

                if (diff > 0) decreasing = false;
                if (diff < 0) increasing = false;

                if (!increasing && !decreasing) {
                    safe = false;
                    break;
                }
            }

            if (safe) safeCount++;
        }
        return safeCount;
    }
};

int main() {
    string file_path = "/Users/yannick/Documents/TUM/Orga/kram/c_leet/AOC2024/day2/input.txt";
    file_Process testProc;
    Solution testSol;
    const vector<vector<int>> vecs = testProc.parse_file(file_path);
    int res = testSol.countSafeReports(vecs);
    cout << to_string(res) << endl;
}
