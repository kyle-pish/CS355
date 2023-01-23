import functools

import a4lib   # now functions from a4lib can be used via dot notation:  a4lib.functionname()

#Define print_any_list to take a printing function and a list of matching values
#(i.e., the print function prints 'a and the list is a list of 'a as well)
#and print the list, separating each value from the next with a space character.
def print_any_list(print_func, lst):
    for val in lst:
        print_func(val)
        a4lib.print_no_newline(" ")
    print()

#print_string_list prints a list of strings.
#Use print_any_list and partial function application.
print_string_list = functools.partial(print_any_list, print)

#Print a list of dates using partial application
print_date_list = functools.partial (print_any_list, a4lib.print_date)

#filter out all dates that arent before 2022, 1, 1
before2022 = functools.partial (filter, (lambda x: (x < (2022, 1, 1))))

#filter out all dates that are before 2022, 1, 1
notbefore2022 = functools.partial (filter, (lambda x: (x > (2022, 1, 1))))

#take a given date and add a given amount of years
def add_x_years(years, date):
    year, month, day = date
    return (a4lib.date_add (date ,(years * 365)))

#add one year to a given date
add_1_year = functools.partial(add_x_years, 1)

#add 40 years to a given date
add_40_years = functools.partial(add_x_years, 40)

#take a list of dates and add 1 year to dates before 2022 and 40 years to dates after 2022
#return the dates that were originally before 2022 first 
def weird_date_thing(lst):
    before = list(map (add_1_year, before2022 (lst)))
    notbefore = list(map (add_40_years, notbefore2022 (lst)))
    return before + notbefore

#return true if date given is the last day in the month, false otherwise
def final_day(date):
    year, month, day = date
    return ((a4lib.days_in_month (month)) == day)

#take a list of dates and add 1 day to the dates that are on the last day of the month
def no_month_ends(dates):
    return list(map ((lambda x: a4lib.date_add (x, 1) if final_day (x) else a4lib.date_add (x, 0)), dates))




jan1_2001 = (2001, 1, 1) 
jan2_2002 = (2002, 1, 2) 
feb28_2006 = (2006, 2, 28) 
dec1_2004 = (2004, 12, 1) 
dec31_2010 = (2010, 12, 31) 
jun23_2022 = (2022, 6, 23)
mar20_2023 = (2023, 3, 20)
