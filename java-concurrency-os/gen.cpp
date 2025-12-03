// Written Fall 2022 by Prof. Raymond Klefstad to generate test inputs for UCI ICS 141 Homework assignment 8 & 9

#include <iostream>
#include <fstream>
#include <sstream>

using namespace std;

const int NUM_COPIES_PER_FILE = 2;
const int NUM_USERS = 26;
const int NUM_FILES_PER_USER = 10;
const int LINES_PER_FILE = 5;
string user_names[] = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};


void gen_save(ofstream &out, string user_name, int user_number, int file_number)
{
    out << ".save " << user_name << file_number << endl;
    for (int i=0; i<LINES_PER_FILE; ++i)
    {
        out << user_name << file_number << " ";
        out << i << i << i << i << i << endl;
    }
    out << ".end" << endl;
}


void gen_print(ofstream &out, string user_name, int user_number, int file_number)
{
    out << ".print " << user_name << file_number << endl;
}


void gen_user_file(string user_name, int user_number)
{
    ostringstream ss;
    ss << "USER" << user_number;
    ofstream out(ss.str().c_str());
    for (int file_number=0; file_number<NUM_FILES_PER_USER; ++file_number)
    {
        gen_save(out, user_name, user_number, file_number);
        for (int i=0; i<NUM_COPIES_PER_FILE; ++i)
            gen_print(out, user_name, user_number, file_number);
    }
    out.close();
}


void gen_user_files(int N)
{
    for (int i=0; i<N; ++i)
        gen_user_file(user_names[i], i);
}


int main()
{
    gen_user_files(NUM_USERS);
    return 0;
}
