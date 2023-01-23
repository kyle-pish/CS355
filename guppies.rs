// guppies
//
// Author: Kyle Pish (with code provided by Mark Liffiton)
// Date: December, 2022
//

use colored::*;
use rand::Rng; // for generating random numbers
use std::io; // for reading from stdin // for coloring printed output

/// Prints a given prompt and reads a line of input from stdin as a String.
///
/// # Arguments
///
/// * `prompt` - A string slice that holds the prompt to be printed.
///
fn read_input(prompt: &str) -> String {
    println!("{}", prompt.yellow());
    let mut line = String::new(); // buffer for reading input from the user
    io::stdin()
        .read_line(&mut line)
        .expect("Failed to read line");
    let trimmed = line.trim(); // drop whitespace
    return trimmed.to_string();
}

/// Prints a given prompt and reads an integer from stdin as an i32.
/// Prints an error and requests input again as long as the user enters something
/// other than an integer.
///
/// # Arguments
///
/// * `prompt` - A string slice that holds the prompt to be printed.
///
fn read_int_input(prompt: &str) -> i32 {
    loop {
        let line = read_input(prompt);
        let parsed = line.parse::<i32>();
        match parsed {
            Ok(i) => return i,
            Err(..) => println!("{}  Try again...", "That's not an integer.".red()),
        }
    }
}

/// creating the structs for each of the currency types
struct Dollar {
    amount: i32,
}

struct TurkishLira {
    amount: i32,
}

struct BottleCaps {
    amount: i32,
}

///trait for currency structs, to create the needed methods
///starting_amount sets the base starting amount
/// print_amount tells you how much you have
/// get_amount returns the amount you have
trait Currency {
    fn starting_amount(&mut self) -> i32;

    fn print_amount(&self, amount: i32);

    fn get_amount(&self) -> i32;
}

///implementing Currency trait for Dollar struct
impl Currency for Dollar {
    fn starting_amount(&mut self) -> i32 {
        self.amount = 100;
        return self.amount;
    }

    fn print_amount(&self, amount: i32) {
        println!("You have {} dollars.", amount);
    }

    fn get_amount(&self) -> i32 {
        return self.amount;
    }
}

///implementing Currency trait for TurkishLira struct
impl Currency for TurkishLira {
    fn starting_amount(&mut self) -> i32 {
        self.amount = 100000000;
        return self.amount;
    }

    fn print_amount(&self, amount: i32) {
        println!("You have {} Turkish Lira.", amount);
    }
    fn get_amount(&self) -> i32 {
        return self.amount;
    }
}

///implementing Currency trait for BottleCap struct
impl Currency for BottleCaps {
    fn starting_amount(&mut self) -> i32 {
        self.amount = 10;
        return self.amount;
    }

    fn print_amount(&self, amount: i32) {
        println!("You have {} BottleCaps.", amount);
    }
    fn get_amount(&self) -> i32 {
        return self.amount;
    }
}

///creating structs for the different game mode that can store the 2 random values and the users guess
struct PlainGuppies {
    num1: i32,
    num2: i32,
    user_guess: String,
}

struct RainbowGuppies {
    color1: i32,
    color2: i32,
    user_guess: String,
}

struct AlphabetGuppies {
    letter1: i32,
    letter2: i32,
    user_guess: String,
}

///trait for game mode structs to create the needed methods
/// generate_new_randoms will generate 2 random values (numbers, colors, or letter depending on which mode)
/// tell_randoms will tell user the first random value, then the second after they have guessed
/// get_guess will prompt the user and store their guess
/// check_guess will check to see if the users guess was correct
/// getter_guess is a getter to return the users guess (mainly for run_game function)
trait GuppiesVariant {
    fn generate_new_randoms(&mut self);
    fn tell_random(&self, option: RandomOption);
    fn get_guess(&mut self);
    fn check_guess(&self, guess: &str) -> bool;
    fn getter_guess(&self) -> String;
}

///enum that is used to determine which random value to show the user
enum RandomOption {
    First,
    Second,
}

///implementing GameVariant trait for PlainGuppies game mode
impl GuppiesVariant for PlainGuppies {
    fn generate_new_randoms(&mut self) {
        self.num1 = rand::thread_rng().gen_range(1..11);
        self.num2 = rand::thread_rng().gen_range(1..11);
    }

    fn tell_random(&self, option: RandomOption) {
        match option {
            RandomOption::First => println!("The first random value is {}", self.num1),
            RandomOption::Second => println!("The second random value is {}", self.num2),
        }
    }

    fn get_guess(&mut self) {
        self.user_guess =
            read_input("Is the second number (h)igher, (l)ower, or the (s)ame?   [Or (q)uit.]");
        while self.user_guess != "h"
            && self.user_guess != "l"
            && self.user_guess != "s"
            && self.user_guess != "q"
        {
            self.user_guess = read_input(
            "Invalid guess.  Is the second number (h)igher, (l)ower, or the (s)ame?   [Or (q)uit.]",
        );
        }
    }

    fn check_guess(&self, guess: &str) -> bool {
        match guess {
            "h" => self.num2 > self.num1,
            "l" => self.num2 < self.num1,
            "s" => self.num2 == self.num1,
            _ => panic!("Ooh, bad guess..."),
        }
    }

    fn getter_guess(&self) -> String {
        return self.user_guess.clone();
    }
}

///implementing GameVariant trait for RainbowGuppies game mode
impl GuppiesVariant for RainbowGuppies {
    fn generate_new_randoms(&mut self) {
        self.color1 = rand::thread_rng().gen_range(1..8);
        self.color2 = rand::thread_rng().gen_range(1..8);
    }

    fn tell_random(&self, option: RandomOption) {
        let rainbow_colors = [
            "red", "orange", "yellow", "green", "blue", "indigo", "violet",
        ];
        match option {
            RandomOption::First => {
                println!(
                    "The first random color is {}",
                    rainbow_colors[(self.color1 - 1) as usize]
                )
            }
            RandomOption::Second => println!(
                "The second random color is {}",
                rainbow_colors[(self.color2 - 1) as usize]
            ),
        }
    }

    fn get_guess(&mut self) {
        self.user_guess =
            read_input("Is the second color (c)loser or (f)urther from green, or are the two random colors the (s)ame distance from green?   [Or (q)uit.]");
        while self.user_guess != "c"
            && self.user_guess != "f"
            && self.user_guess != "s"
            && self.user_guess != "q"
        {
            self.user_guess = read_input(
          "Invalid guess. Is the second color (c)loser or (f)urther from green, or are the two random colors the (s)ame distance from green?   [Or (q)uit.] ",
      );
        }
    }

    fn check_guess(&self, guess: &str) -> bool {
        match guess {
            "c" => (4 - self.color2).abs() < (4 - self.color1).abs(),
            "f" => (4 - self.color2).abs() > (4 - self.color1).abs(),
            "s" => (4 - self.color2).abs() == (4 - self.color1).abs(),
            _ => panic!("Ooh, bad guess..."),
        }
    }

    fn getter_guess(&self) -> String {
        return self.user_guess.clone();
    }
}

///implementing GameVariant trait for AlphabetGuppies game mode
impl GuppiesVariant for AlphabetGuppies {
    fn generate_new_randoms(&mut self) {
        self.letter1 = rand::thread_rng().gen_range(1..27);
        self.letter2 = rand::thread_rng().gen_range(1..27);
    }

    fn tell_random(&self, option: RandomOption) {
        let alphabet_letters = [
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q",
            "r", "s", "t", "u", "v", "w", "x", "y", "z",
        ];
        match option {
            RandomOption::First => println!(
                "The first random letter is {}",
                alphabet_letters[(self.letter1 - 1) as usize]
            ),
            RandomOption::Second => println!(
                "The second random letter is {}",
                alphabet_letters[(self.letter2 - 1) as usize]
            ),
        }
    }

    fn get_guess(&mut self) {
        self.user_guess =
            read_input("Is the second letter (b)efore or (a)fter the first letter, or are they the (s)ame letter? [Or (q)uit.]");
        while self.user_guess != "b"
            && self.user_guess != "a"
            && self.user_guess != "s"
            && self.user_guess != "q"
        {
            self.user_guess = read_input(
          "Invalid guess. Is the second letter (b)efore or (a)fter the first letter, or are they the (s)ame letter? [Or (q)uit.] ",
      );
        }
    }

    fn check_guess(&self, guess: &str) -> bool {
        match guess {
            "b" => self.letter2 < self.letter1,
            "a" => self.letter2 > self.letter1,
            "s" => self.letter2 == self.letter1,
            _ => panic!("Ooh, bad guess..."),
        }
    }

    fn getter_guess(&self) -> String {
        return self.user_guess.clone();
    }
}

///run_game function is called from main using the user input
fn run_game(money: &dyn Currency, mode: &mut dyn GuppiesVariant) {
    let mut game_money = money.get_amount();
    //while the user still has money the game continues
    while game_money > 0 {
        money.print_amount(game_money);
        //getting a bet from the user
        let mut bet = read_int_input("What is your bet? (or enter 0 to quit)");
        if bet == 0 {
            break;
        }
        while bet < 0 || bet > game_money {
            println!("{}  Try again...", "Invalid bet.".red());
            bet = read_int_input("What is your bet?");
        }
        //the following creates new randoms, displlays the first, asks user for guess, then displays the second random
        mode.generate_new_randoms();
        mode.tell_random(RandomOption::First);
        mode.get_guess();
        let user_guess: String = mode.getter_guess();
        if user_guess == "q" {
            break;
        }
        mode.tell_random(RandomOption::Second);
        //checking to see if the user was right or wrong, then adding or subtracting money accordingly
        if mode.check_guess(&user_guess) {
            println!("You were right!");
            game_money += bet;
        } else {
            println!("You were incorrect.");
            game_money -= bet;
        }
    }
    //once user runs out of money or quits the game, display corresponding message
    if game_money == 0 {
        println!("{}", "You're broke. :-/".red());
    } else {
        println!("{}", "You made it out!".bright_green());
        money.print_amount(game_money);
    }
}

///main function prompts user to choose options for the game
fn main() {
    println!("{}", "Welcome to Guppies!".bright_purple());
    println!("{}", "-------------------".bright_purple());

    //ask user to choose the type of currency they want to play iwth
    let mut currency_choice = read_int_input(
        "What currency would you like to use? Dollars (1), Turkish Lira (2), or Bottle caps (3)",
    );
    while currency_choice != 1 && currency_choice != 2 && currency_choice != 3 {
        currency_choice = read_int_input(
          "What currency would you like to use? Dollars (1), Turkish Lira (2), or Bottle caps (3)",
        );
    }

    //ask user what game mode they want to play
    let mut game_choice = read_int_input(
        "What game varient would you like to play? Plain (1), Rainbow (2), or Alphabet (3)",
    );
    while game_choice != 1 && game_choice != 2 && game_choice != 3 {
        game_choice = read_int_input(
            "What game varient would you like to play? Plain (1), Rainbow (2), or Alphabet (3)",
        );
    }

    //create an object for the currency based off what the user chose
    let currency_obj: &dyn Currency = match currency_choice {
        1 => &Dollar { amount: 100 },
        2 => &TurkishLira { amount: 100000000 },
        3 => &BottleCaps { amount: 10 },
        _ => panic!(),
    };

    //create basic objects for each of the possible game modes the user could choose
    let mut plain_guppies_game: PlainGuppies = PlainGuppies {
        num1: 0,
        num2: 0,
        user_guess: String::from("none"),
    };
    let mut rainbow_guppies_game = RainbowGuppies {
        color1: 0,
        color2: 0,
        user_guess: String::from("none"),
    };

    let mut alphabet_guppies_game: AlphabetGuppies = AlphabetGuppies {
        letter1: 0,
        letter2: 0,
        user_guess: String::from("none"),
    };

    //depending on what game_mode the user chose, call the run_game function with the appropriate user input objects
    if game_choice == 1 {
        run_game(currency_obj, &mut plain_guppies_game)
    }
    if game_choice == 2 {
        run_game(currency_obj, &mut rainbow_guppies_game)
    }
    if game_choice == 3 {
        run_game(currency_obj, &mut alphabet_guppies_game)
    }
}
