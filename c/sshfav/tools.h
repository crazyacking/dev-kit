//
// Created by shanbiao.jsb on 2018/1/18.
//

#ifndef SSHFAV_TOOLS_H
#define SSHFAV_TOOLS_H


#include <cstdio>
#include <cstdlib>
#include <unistd.h>
#include <cstdlib>
#include <sstream>
#include <iostream>
#include <cstring>
#include <string>
#include <cmath>
#include <fstream>
#include <vector>
#include <ctime>

namespace tools {

    bool is_number(const std::string &s) {
        std::string::const_iterator it = s.begin();
        while (it != s.end() && std::isdigit(*it)) ++it;
        return !s.empty() && it == s.end();
    }

};


#endif //SSHFAV_TOOLS_H
