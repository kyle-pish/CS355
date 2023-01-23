/*
Kyle Pish
CS355
Assignment 1 p4_lib.h
*/

#ifndef P4_LIB_H_
#define P4_LIB_H_
#include <iostream>
#include <vector>
#include <utility>

bool date_is_before (std::pair<int, int> date1, std::pair<int, int> date2);

int days_in_month (int month);

std::pair <int, int> date_plus(std::pair<int, int> date, int days_forward);

std::pair<int, int> latest_date(std::vector<std::pair<int, int>> list_of_dates);

#endif