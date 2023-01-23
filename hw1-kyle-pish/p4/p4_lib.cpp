/*
Kyle Pish
CS355
Assignment 1 p4_lib.cpp
*/

#include <iostream>
#include <vector>
#include <list>
#include <utility>
#include <unordered_map>
#include "p4_lib.h"

std::list<int> month = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
std::list<int> day = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31};

//function to return true or false depending on which date is first
bool date_is_before (std::pair<int, int> date1, std::pair<int, int> date2) {
    
    //check to make sure dates are valid
    if ((date1.first <= month.back() && date1.second <= day.back()) && (date1.first <= month.back() && date1.second <= day.back())){ 
       //if the month is the same it will check the day
       if (date1.first == date2.first) {
            if (date1.second < date2.second){
                return true;
            }
            else {
                return false;
            }
        }
        //if month is not the same then check which one is first
        else if (date1.first < date2.first){
            return true;
        }
        else {
            return false;
        }
        
        return false;
    }
    else {
        return false;
    }
}

//function to return how many days are in a given month
int days_in_month (int month){
    //create an unordered map(similar to dictionary in python)
    std::unordered_map <int, int> monthDict = {
        {1,31}, {2,28}, {3,31}, {4,30}, {5,31}, {6,30}, {7,31}, {8,31}, {9,30}, {10,31}, {11,30}, {12,31}
    };
    return monthDict[month];

}

//function to take a date, add x amount of days, and return new date
std::pair <int, int> date_plus(std::pair<int, int> date, int days_forward){
    
    //declaring all variables
    int newDay = date.second + days_forward;
    int newMonth = date.first;
    std::pair<int, int> newDate;
    newDate.first = newMonth;
    newDate.second = newDay;

    //checking if dates are valid
    if ((date.first <= month.back() && date.second <= day.back())){
        
        //check if the new amount of days is more than the max in the month
        if (newDay > days_in_month(newMonth)){
            //while the days exceed the limit loop will subtract amount of days and add 1 to the month
            while (newDay > days_in_month(newMonth)){
                newMonth = newMonth + 1;
                newDay = newDay - days_in_month(newMonth -1);
                //change the date to put through while loop again
                newDate.first = newMonth;
                newDate.second = newDay;
                //if month goes past max the restart at first month
                if (newMonth >= 12){
                    newMonth = 1;
                    //change the date to put through while loop again
                    newDate.first = newMonth;
                    newDate.second = newDay;
                }

            }

            return newDate;
        }
        //if new number of days does not exeed limit then return new date
        else {
            newDate.first = newMonth;
            newDate.second = newDay;
            
            return newDate;
        }
    }
    else {
        return date;
    }
}

//function to take a list of dates and return the latest one
std::pair<int, int> latest_date(std::vector<std::pair<int, int>> list_of_dates){
    
    std::pair dateLatest = list_of_dates.front();
    //Set variable to first date because at current moment that is latest date
    int length = list_of_dates.size();
    
    //looping over length of list
    for (int i = 1; i < length; i++) {
        //if dateLatest id the latest then change nothing
        if (date_is_before(dateLatest, list_of_dates[i]) == false){
            dateLatest = dateLatest;
        }
        //if dateLatest is not latest then change to new date
        else{
            dateLatest = list_of_dates[i];
        }
    }
    
    return (dateLatest);
}



