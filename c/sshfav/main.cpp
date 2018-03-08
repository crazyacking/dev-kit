#include <iostream>
#include <fstream>
#include <regex>
#include "json.hpp"

#define HOSTS_DIR "/Users/shanbiao.jsb/code/bash-style/c/sshfav/sshfav.txt"

using namespace std;
using json = nlohmann::json;


class record {
    string num;
    string user;
    string host;
    string desc;
public:
    record(string num, string user, string host, string desc) {
        this->num = num;
        this->user = user;
        this->host = host;
        this->desc = desc;
    }
};

vector<string> pass_host(string opt) {
    vector<string> ret;

    opt.insert(0, "(");
    opt.append(")");

    const int LINE_LENGTH = 100;
    char str[LINE_LENGTH];

    ifstream fin(HOSTS_DIR);
    while (fin.getline(str, LINE_LENGTH)) {
        string s = string(str);

        if (s.find(opt) != string::npos) {
            regex e("\\s+");
            regex_token_iterator<string::iterator> i(s.begin(), s.end(), e, -1);
            regex_token_iterator<string::iterator> end;
            while (i != end) {
                ret.push_back(*i++);
            }
            break;
        }
    }
    return ret;
}

int main() {
    string opt;
    cin >> opt;
    vector<string> arrays = pass_host(opt);

    for (auto &&item : arrays) {
        item.erase(remove(item.begin(), item.end(), '('), item.end());
        item.erase(remove(item.begin(), item.end(), ')'), item.end());
        cout << item << endl;
    }
    return 0;
}

