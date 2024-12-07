#include <iostream>
#include <fstream>
#include <utility>
#include <vector>
#include <algorithm>
#include <unordered_map>
using namespace std;

class SOLUTION {
    vector<int> l;
    vector<int> r;

public:
    SOLUTION (vector<int> l, vector<int> r) {
        this->l = move(l);
        this->r = move(r);
    }

    int getMin() {
        int result = 0;
        for (int i = 0; i < l.size(); ++i) {
            result += abs(l[i] - r[i]);
        }
        return result;
    }

    int calc2() {
        unordered_map<int, int> counter;
        // get frequency of r list
        for (int e : r) {
            counter[e]++;
        }

        // find elements in l and sum
        int result = 0;
        for (int e : l) {
            result += e * counter[e];
        }

        return result;
    }
};

class FILE_PROCESS {
    // left and right list
    vector<int> l;
    vector<int> r;

public:
    void process_file(const string &file_path) {
        ifstream file_stream (file_path);

        // check if opening file worked
        if (!file_stream.is_open()) {
            std::cerr << "Error: Could not open file " << file_path << std::endl;
            return;
        }


        // get lines
        string line;
        while (std::getline(file_stream, line)) {
            size_t space_pos = line.find(' ');
            if (space_pos != std::string::npos) {
                // get left and right string from the space
                int left = std::stoi(line.substr(0, space_pos));
                int right = std::stoi(line.substr(space_pos + 1));
                // push onto vectors
                l.push_back(left);
                r.push_back(right);
            } else {
                std::cerr << "Error: Malformed line: " << line << std::endl;
            }
        }

        file_stream.close();
    }

    // getter
    vector<int> getL() {
        return l;
    }

    vector<int> getR() {
        return r;
    }


};



int main() {
    FILE_PROCESS testfp;
    testfp.process_file("/Users/yannick/Documents/TUM/Orga/kram/c_leet/aoc/day1/input.txt");

    // Get and sort both lists
    vector<int> l_list = testfp.getL();
    ranges::sort(l_list);

    vector<int> r_list = testfp.getR();
    ranges::sort(r_list);

    SOLUTION testsol(l_list, r_list);
    int res = testsol.calc2();

    std::cout << to_string(res) << std::endl;

    return 0;
}
