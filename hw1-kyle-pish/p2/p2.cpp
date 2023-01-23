/*
Kyle Pish
CS355
Assignment 1 p2.cpp
*/

#include <iostream>
#include <math.h>
#include <iomanip>
int main() {

    //variable declarations
    double diameter;
    double price;
    double cubicInches;
    double pricePerCubicInch;
    double radius;
    
   
    //promt user input
    std::cout << "Enter the diameter of the canteloupe in inches: " << std::endl;
    std::cin >> diameter;

    std::cout << "Enter the price of the canteloupe in dollars: " << std::endl;
    std::cin >> price;

    //calculations
    radius = diameter / 2;
    cubicInches = (4 * M_PI * pow(radius, 3))/3;
    pricePerCubicInch = price / cubicInches;

    //print the final varlue rounded to 2 decimal places
    std::cout << std::setprecision(2) << pricePerCubicInch << std::endl;
    



}