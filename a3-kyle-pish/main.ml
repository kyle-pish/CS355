(*
Kyle Pish
9/27/2022
CS355
Assignment 3   
*)


(*Function to print "Hello, World!"*)
let howdy () = print_endline "Hello, World!" 


(*Function to calculate price of a canteloupe giving its diamter in inches and its price*)
let canteloupe diameter price = (price /. ((4. /. 3.) *. Float.pi *. ((diameter /. 2.) ** 3.))) 


(*Function to tell you which date comes first out of 2 given dates*)
let date_is_before date1 date2 =
  (*Check for valid date*)
  if fst date1 <= 12 && fst date2 <= 12 && snd date1 <= 31 && snd date2 <= 31 then
    (*if the months are equal than check the date*)
    if fst date1 == fst date2 then
      if snd date1 < snd date2 then
        true
      else
        false
    else
      (*Check which date is first*)
      if fst date1 < fst date2 then
        true
      else
        false 
    else
      false


(*Functions tells you how many dyas are in a given month*)
let days_in_month month = 
  let days = List.nth [31; 28; 31; 30; 31; 30; 31; 31; 30; 31; 30; 31] (month - 1) in
  days 


(*Function to take a certain date and add a given amount of days to make a new date*)
let rec date_plus date days_forward = 
  
  (*Check if month is over 12, if it is then sart back at the start of the year*)
  if fst date > 12 then
    let new_date = (fst date - 12), snd date in
    date_plus new_date 0
  else
    (*adding the days_forward to the current days and checking if its valid*)
      (* if not valid than add 1 to your month and subtract the amount of days of that month from the days forward*)
    if (snd date) + days_forward > days_in_month (fst date) then
      let new_month = fst date + 1 in
      let day = snd date + days_forward in 
      let new_day = day - days_in_month (fst date) in
      let new_date = (new_month, new_day) in
      (*put the new date back through the function*)
      date_plus new_date 0
    else
      (*If month and day are valid then creat the new date and output*)
      let day = snd date + days_forward in 
      let new_date = (fst date, day) in
      new_date


(*Function to help the latest_date function*)
let rec latest_date_helper list_of_dates latest = 
  (*If list is not empty then...*)
  if list_of_dates <> [] then
    (*Check to see which date is first from the first and second in the list*)
    if date_is_before latest (List.hd list_of_dates) then
      (*if second is latest then change latest value and call function with new args*)
      let latest = (List.hd list_of_dates) in
      latest_date_helper (List.tl list_of_dates) latest
    else
      (*If current latest is still latest then just call function again*)
      latest_date_helper (List.tl list_of_dates) latest
  else
    (*if list is empty, return latest date*)
    latest


(*Function takes a list of dates and uses the latest_date_helper function to find the latest date*)
let latest_date list_of_dates = 
  let latest = List.hd list_of_dates in
  latest_date_helper list_of_dates latest

  
(*Creating some example dates to be used in assert functions*)
let jan1 = (1,1)
let jan2 = (1,2)
let feb28 = (2,28)
let dec1 = (12,1)
let dec31 = (12,31)

(*Generating results to run through assert functions*)
let results_canteloupe = canteloupe 10. 100.
let results_date_is_before = date_is_before jan1 jan2
let results_date_is_before2 = date_is_before dec1 jan2
let results_days_in_month = days_in_month 2
let results_date_plus = date_plus jan2 100
let results_latest_date = latest_date [jan1; dec1; feb28; dec31; jan2]

(*Assert functions to check if all functions working correctly*)
let _ = assert ((results_canteloupe -. 0.19098593171027442) = 0.00000)
let _ = assert (results_date_is_before = true)
let _ = assert (results_date_is_before2 = false)
let _ = assert (results_days_in_month = 28)
let _ = assert (results_date_plus = (4,12))
let _ = assert (results_latest_date = (12, 31))
