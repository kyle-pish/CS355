open A4lib

(* Define print_any_list to take a printing function and a list of matching values
 * (i.e., the print function prints 'a and the list is a list of 'a as well)
 * and print the list, separating each value from the next with a space character.
 * See the print_date_list_ex example function in a4lib.ml for a model.
 *)
let rec print_any_list print_func lst = 
    match lst with 
    | [] -> print_newline() 
    | hd :: tl ->
        print_func hd;
        print_string " ";
        print_any_list print_func tl;
        


(* print_string_list prints a list of strings.
 * Use print_any_list and partial function application.
 *)
let print_string_list =
    print_any_list print_string

(* print_string_list prints a list of ints.
 * Use print_any_list and partial function application.
 *)
let print_int_list =
    print_any_list print_int

(* print_string_list prints a list of dates.
 * Use print_any_list and partial function application.
 * You may use the print_date function in a4lib.ml.
 *)
let print_date_list =
    print_any_list print_date

(* Define a function that will filter a list of dates,
 * returning a list of only those dates that are before Jan 1, 2022.
 * Note that our date tuples can be correctly compared using basic <, >, etc.
 * operators.
 * Note that this is a regular variable binding.  What function can be partially
 * applied to evaluate to a function that does what we want here?
 * Use that function and an anonymous function.
 *)
let before2022 =
    (List.filter (fun x -> x < (2022, 1, 1) ))
     
    

(* Same as before2022, but this one is the opposite!
 * So it should return just those dates that are on or after Jan 1, 2022.
 *)
let notbefore2022 =
    (List.filter (fun x -> x > (2022, 1, 1) ))

(* add_x_years takes a number of years and a date and returns the date produced
 * by adding that many years to the given date.  Use date_add from a4lib.
 *)
let add_x_years years date =
    match date with
    |year, month, day -> date_add date (years * 365)

(* add_1_year adds a single year to a given date.
 * This is just a variable assignment... partial function application!
 *)
let add_1_year =
    add_x_years 1

(* add_40_years adds 40 years to a given date.
 *)
let add_40_years =
    add_x_years 40

(* Now we get to use some of those functions above...
 * weird_date_thing takes a list of dates and returns
 * a list of those dates with:
 *   1) all dates before 2022 increased by 1 year
 *   2) all dates not before 2022 increased by 40 years
 *   3) all dates originally before 2022 included in the
 *      result list *before* all dates that were originally
 *      not before 2022.
 * Weird, right?
 * Example (with dates just written in text as examples, not valid syntax):
 *   in:  [2022-01-01, 2000-04-01, 2029-12-31, 1999-12-31]
 *   out: [2001-04-01, 2000-12-31, 2062-01-01, 2069-12-31]
 *
 * Use List.map, List.filter, and the functions you've defined already.
 * Do not use any if expressions.
 * This can reasonably be just three lines long.
 *)
let weird_date_thing lst =
    [List.map add_1_year (before2022 lst) ] @ [List.map add_40_years (notbefore2022 lst)]




(* final_day checks if the given date is the last day in its month.
 * Returns a bool.
 * Example: 2022-01-30 -> false   2022-01-31 -> true
 * Do not use any if expressions.
 *)
let final_day date =
    match date with
    |y, m, d -> (days_in_month m) = d

    

(* no_month_ends takes a list of dates and adds one day to any dates that are
 * the last day of their month, leaving other dates unchanged.
 * Use List.map and an anonymous function.
 *)
let no_month_ends dates =
    List.map (fun x -> if final_day x then date_add x 1 else date_add x 0) dates



let jan1_2001 = (2001, 01, 01) 
let jan2_2002 = (2002, 01, 02) 
let feb28_2006 = (2006, 02, 28) 
let dec1_2004 = (2004, 12, 01) 
let dec31_2010 = (2010, 12, 31) 
let jun23_2022 = (2022, 06, 23)
let mar20_2023 = (2023, 03, 20)
