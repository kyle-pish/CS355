import functools

# Use partial function application to make a print function
# that doesn't print a newline by binding its end argument
# to an empty string.
print_no_newline = functools.partial(print, end='')


# A print function specifically for our date tuples.
def print_date(date):
    print_no_newline(f"{date[0]}-{date[1]}-{date[2]}")


# Print a list of dates using our print_date function.
def print_date_list_ex(lst):
    # It's more "Pythonic" (idiomatic for Python) to use a loop here
    # rather than recursion.
    for val in lst:
        print_date(val)
        print_no_newline(" ")
    print()  # print a newline at the end


# Takes a month integer, returns the number of days in that month.
def days_in_month(month):
    lengths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    return lengths[month-1]


# Takes a date and a number of days, returns that date moved forward
# the given number of days.
def date_add(date, days):
    year, month, day = date
    newday = day + days
    monthlen = days_in_month(month)
    while newday > monthlen:
        newday -= monthlen
        month += 1
        if month > 12:
            year += 1
            month = 1
        monthlen = days_in_month(month)
    return (year, month, newday)
