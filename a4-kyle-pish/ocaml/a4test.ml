open A4
open A4lib

(*create dates to be used as arguements*)
let jan1_2001 = (2001, 01, 01) 
let jan2_2002 = (2002, 01, 02) 
let feb28_2006 = (2006, 02, 28) 
let dec1_2004 = (2004, 12, 01) 
let dec31_2010 = (2010, 12, 31) 
let jun23_2022 = (2022, 06, 23)
let mar20_2023 = (2023, 03, 20)

(*set variables to function results to be passed into test cases*)
let results_before2022 = before2022 [jan1_2001; jan2_2002; jun23_2022; mar20_2023]
let results_notbefore2022 = notbefore2022 [jan1_2001; jan2_2002; jun23_2022; mar20_2023]
let results_add_x_years = add_x_years 10 mar20_2023
let results_add_1_year = add_1_year jun23_2022
let results_add_40_years = add_40_years dec1_2004
let results_weird_date_thing = weird_date_thing [jan1_2001; jan2_2002; jun23_2022; mar20_2023]
let results_final_day = final_day dec31_2010
let results_final_day2 = final_day jun23_2022
let results_no_month_ends = no_month_ends [jan1_2001; jan2_2002; dec31_2010; feb28_2006]

(*Test cases to check for correctness of functions*)
print_any_list print_date [jan1_2001; jan2_2002; feb28_2006; dec1_2004; dec31_2010]
print_string_list ["hello"; "bye"; ":)"]
print_int_list [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]
print_date_list [jan1_2001; jan2_2002; feb28_2006; dec1_2004; dec31_2010]
let _ = assert (results_before2022 = [(2001, 1, 1); (2002, 1, 2)])
let _ = assert (results_notbefore2022 = [(2022, 6, 23); (2023, 3, 20)])
let _ = assert (results_add_x_years = (2033, 3, 20))
let _ = assert (results_add_1_year = (2023, 6, 23))
let _ = assert (results_add_40_years = (2044, 12, 1))
let _ = assert (results_weird_date_thing = [[(2002, 1, 1); (2003, 1, 2)]; [(2062, 6, 23); (2063, 3, 20)]])
let _ = assert (results_final_day = true)
let _ = assert (results_final_day2 = false)
let _ = assert (results_no_month_ends = [(2001, 1, 1); (2002, 1, 2); (2011, 1, 1); (2006, 3, 1)])
