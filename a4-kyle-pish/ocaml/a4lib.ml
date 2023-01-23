(* A version of days_in_month using pattern matching.
 * Args:
 *   int: a month, 1 through 12.
 * Returns:
 *   int: number of days in the given month.
 * Fails (crashes) with an error if an invalid month is given.
 *)
let days_in_month = function
    | 1 | 3 | 5 | 7 | 8 | 10 | 12 -> 31
    | 4 | 6 | 9 | 11 -> 30
    | 2 -> 28
    | _ -> failwith "Invalid month"  (* crash with this error if we get here *)

(* Print a date tuple using the Printf module and a format string.
 * Args:
 *   (int, int, int): a tuple of three integers in order (year, month, day)
 * Returns:
 *   (): unit - nothing.
 *)
let print_date (year, month, day) =
    Printf.printf "%d-%d-%d" year month day

(* Print a list of dates as (year, month, day) tuples.
 * Args:
 *   (int, int, int) list: a list of year,month,day int tuples.
 * Returns:
 *   (): unit - nothing.
 *)
let rec print_date_list_ex = function
    | [] -> print_newline ()   (* end the line at the end of the list *)
    | hd :: tl ->
        print_date hd ;        (* use print_date to print one value *)
        print_string " " ;     (* a space *)
        print_date_list_ex tl  (* recursively print the rest *)

(* Add a number of days to a given (year, month, day) int tuple.
 * Assumes leap years don't exist (i.e., Feb always has 28 days).
 * Args:
 *   (int, int, int): a tuple of three integers in order (year, month, day)
 *   int: the number of days to move forward
 * Returns:
 *   (int, int, int): the resulting date as a (year, month, day) tuple
 *)
let rec date_add (year, month, day) days =
    let newday = day + days in
    let monthlen = days_in_month month in
    if newday <= monthlen then
        (year, month, newday)
    else
        let newday = newday - monthlen in
        if month = 12 then
            date_add (year + 1, 1, newday) 0
        else
            date_add (year, month + 1, newday) 0
