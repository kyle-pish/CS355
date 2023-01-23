#include <iostream>

// Thinger type definition.
class Thinger
{
public: // bad design to make everything public, but this is just for practicing other concepts.
    std::string name;
    int num;

    // Concise definition of a simple constructor.
    Thinger(std::string i_name, int i_num) : name(i_name), num(i_num) {}

    // Defining a destructor that announces itself.
    ~Thinger()
    {
        std::cout << "Destroying " << this->name << std::endl;
    }

    // A print_me method to print the object's values.
    void print_me()
    {
        std::cout << this->name << " " << this->num << std::endl;
    }
};
//
// No example code for creating a Thinger object on the heap the "old" way.
// You have studied and practiced that a lot previously.
//

// Function to print Thinger and drop it
void print_and_drop(Thinger *thing)
{
    thing->print_me();
    thing->~Thinger();
}

// Function to print thinger and maintain its value
void print_and_retain(Thinger *thing)
{
    thing->print_me();
}

// Function to modify thinger and maintain its value
auto modify_and_retain(Thinger *thing)
{
    thing->num = 456;
    return thing;
}

int main()
{
    // Creating thinger objects
    Thinger *first = new Thinger("First", 123);
    Thinger *second = new Thinger("Second", 123);
    Thinger *third = new Thinger("Third", 123);
    Thinger *fourth = new Thinger("Fourth", 123);

    // calling function on first Thinger
    std::cout << "1) Before" << std::endl;
    print_and_drop(first);
    std::cout << "1) After" << std::endl;

    // Calling object on second Thinger and check to make sure value was maintained
    std::cout << "2) Before" << std::endl;
    print_and_retain(second);
    second->print_me();
    std::cout << "2) After" << std::endl;

    // Modify the Thinger and make sure it is accessable after function
    std::cout << "3) Before" << std::endl;
    third = modify_and_retain(third);
    third->print_me();
    std::cout << "3) After" << std::endl;

    // Create a copy of the Thinger, modify it, then make sure the original was maintained
    std::cout << "4) Before" << std::endl;
    auto copy4 = *fourth;
    fourth->print_me();
    modify_and_retain(&copy4)->print_me();
    std::cout << "4) After" << std::endl;

    // Manually deallocate all objects
    second->~Thinger();
    third->~Thinger();
    fourth->~Thinger();
}
