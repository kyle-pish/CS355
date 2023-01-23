// Thinger type definition.
// In Rust, a struct is like a class in C++.
// (And actually, it's like a struct in C++, too: struct and class are nearly the same thing in C++!)
#[derive(Clone)]
struct Thinger {
    name: String,
    num: i32,
}
// Defining a print_me method for Thinger.
impl Thinger {
    fn print_me(&self) {
        println!("{} {}", self.name, self.num);
    }
}
// Defining a destructor for Thinger that announces itself.
impl Drop for Thinger {
    fn drop(&mut self) {
        println!("Destroying {}", self.name);
    }
}

//Function to print Thinger and drop it
fn print_and_drop(thing: Thinger) {
    thing.print_me();
}

//Function to print thinger and maintain its value
fn print_and_retain(thing: &Thinger) {
    thing.print_me();
}

//Function to modify thinger and maintain its value
fn modify_and_retain(mut thing: Thinger) -> Thinger {
    thing.num = 456;
    thing
}

//
// Example code for creating a new Thinger object:
//   let example = Thinger {
//       name: String::from("Example"),
//       num: 42,
//   };
//
// Example code for printing a Thinger named example:
//   example.print_me()

fn main() {
    //creating Thinger objects to use in scenarios
    let first = Thinger {
        name: String::from("First"),
        num: 123,
    };
    let second = Thinger {
        name: String::from("Second"),
        num: 123,
    };
    let third = Thinger {
        name: String::from("Third"),
        num: 123,
    };
    let fourth = Thinger {
        name: String::from("Fourth"),
        num: 123,
    };

    //calling function on first Thinger
    println!("1) Before");
    print_and_drop(first);
    println!("1) After");

    //Calling object on second Thinger and check to make sure value was maintained
    println!("2) Before");
    print_and_retain(&second);
    second.print_me();
    println!("2) After");

    //Modify the Thinger and make sure it is accessable after function
    println!("3) Before");
    let third = modify_and_retain(third);
    third.print_me();
    println!("3) After");

    //Create a copy of the Thinger, modify it, then make sure the original was maintained
    println!("4) Before");
    let copy4 = fourth.clone();
    let modified_copy = modify_and_retain(copy4);
    fourth.print_me();
    modified_copy.print_me();
    println!("4) After");
}
