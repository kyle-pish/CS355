/*
Kyle Pish
CS355
Assignment 1 p3.cpp
*/

#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

int main() {

  //create an empty string vector and prompt user for input
  std::vector <std::string> alphabetical;
  std::string inputString = "";
  std::cout << "Enter a string (Type nothing and hit enter to end input): " << std::endl;
  
  //store the input in inputString variable
  std::getline (std::cin, inputString);

  //while loop to add input to vector until user enters ""
  while (inputString != "") {
    alphabetical.push_back(inputString);
    std::cout << "Enter a string (Type nothing and hit enter to end input): " << std::endl;
    std::getline (std::cin, inputString);
  }

  //sort vector alphabetically
  std::sort( alphabetical.begin(), alphabetical.end() );

  //calculations and output statements to display correct values
  int size = alphabetical.size();
  std::cout << alphabetical[0] + " ";
  std::cout << alphabetical[size / 2] + " ";
  std::cout << alphabetical[size - 1];
  
  
}