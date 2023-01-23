'''
Kyle Pish
CS355
Assignment 1 p4_lib.py
'''


monthTuple = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dayTuple = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31);

#Function to return true of false depending on which date is first
def date_is_before(date1, date2):
     #make sure dates are valid
    if date1[0] in monthTuple and date2[0] in monthTuple and date1[1] in dayTuple and date2[1] in dayTuple:
        if date1[1] == date2[1]:
            return ("The dates are the same");
        #if month is the same then check the days
        elif date1[0] == date2[0]:
            if date1[1] < date2[1]:
                return True;
            else:
                return False;
        #if month different then check which is first
        elif date1[0] < date2[0]:
            return True;
        else:
            return False;

#function to return how many days are in a given month
def days_in_month(month):
    #create a dictionary to store the months with the corresponding amount of days
    monthDict = {1:31, 2:28, 3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31}
    return (monthDict[month])

#function to take a date, add x amount of days, and return new date
def date_plus(date, days_forward):
    #check that dates are valid
    if date[0] in monthTuple and date[1] in dayTuple:
        newDay = date[1] + days_forward;
        newMonth = date[0]
        newDate = (newMonth, newDay);
        #check if amount of days is more than max
        if newDay > days_in_month(newMonth):
            #while amount of days exceeds limit, subtract amount of days in month and add 1 to month
            while newDay > days_in_month(newMonth):
                newMonth = newMonth + 1
                newDay = newDay - days_in_month(newMonth - 1)
                newDate = (newMonth, newDay)
                #if month exceeds limit then reset to first month
                if newMonth >= 12:
                    newMonth = 1;
                    newDate = (newMonth, newDay)

            return (newDate);
        #if days do not exceed max then return new date
        else:
            newDate = (newMonth, newDay)
            return (newDate);
    else:
        return False;

#function to take a list of dates and return the latest one
def latest_date(list_of_dates):

    #Set variable to first date because at current moment that is latest date
    latestDate = list_of_dates[0];
    i = 1;

    #While loop for the length of the list
    while i < len(list_of_dates):
        #If the latestDate variable is the latest, then the variable will remain the same
        if not date_is_before(latestDate, list_of_dates[i]):
            i +=1;
        #If latestDate variable is not the latest then list_of_dates[i] will become new latestDate
        else:
            latestDate = list_of_dates[i]
            i += 1;
        #Increase interator
            
    return (latestDate);


