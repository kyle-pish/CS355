import a4
import a4lib

#create dates to be used as arguments
jan1_2001 = (2001, 1, 1) 
jan2_2002 = (2002, 1, 2) 
feb28_2006 = (2006, 2, 28) 
dec1_2004 = (2004, 12, 1) 
dec31_2010 = (2010, 12, 31) 
jun23_2022 = (2022, 6, 23)
mar20_2023 = (2023, 3, 20)

#use variables to store results to be passed into test cases
results_before2022 = (list(a4.before2022 ([jan1_2001, jan2_2002, jun23_2022, mar20_2023])))
results_notbefore2022 = (list(a4.notbefore2022 ([jan1_2001, jan2_2002, jun23_2022, mar20_2023])))
results_add_x_years = (a4.add_x_years (10, mar20_2023))
results_add_1_year = list(a4.add_1_year (jun23_2022))
results_add_40_years = list(a4.add_40_years (dec1_2004))
results_weird_date_thing = (a4.weird_date_thing ([jan1_2001, jan2_2002, jun23_2022, mar20_2023]))
results_final_day = (a4.final_day (dec31_2010))
results_final_day2 = (a4.final_day (jun23_2022))
results_no_month_ends = (a4.no_month_ends ([jan1_2001, jan2_2002, dec31_2010, feb28_2006]))

#test cases to check for correctness of functions
a4.print_any_list (a4lib.print_date, [jan1_2001, jan2_2002, feb28_2006, dec1_2004, dec31_2010]) 
a4.print_string_list (["hello", "bye", ":)"])
a4.print_date_list ([jan1_2001, jan2_2002, feb28_2006, dec1_2004, dec31_2010])
assert results_before2022 == [(2001, 1, 1), (2002, 1, 2)], "Failed"
assert results_notbefore2022 == [(2022, 6, 23), (2023, 3, 20)], "Failed"
assert results_add_x_years == (2033, 3, 20), "Failed"
assert results_add_1_year == [2023, 6, 23], "Failed"
assert results_add_40_years == [2044, 12, 1], "Failed"
assert results_weird_date_thing == [(2002, 1, 1), (2003, 1, 2), (2062, 6, 23), (2063, 3, 20)], "Failed"
assert results_final_day == True, "Failed"
assert results_final_day2 == False, "Failed"
assert results_no_month_ends == [(2001, 1, 1), (2002, 1, 2), (2011, 1, 1), (2006, 3, 1)], "Failed"