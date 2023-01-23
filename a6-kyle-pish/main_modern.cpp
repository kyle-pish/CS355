#include <iostream>
#include <memory>

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
// Example code for creating a new unique pointer to a Thinger object:
//   auto example{ std::make_unique<Thinger>("Example", 42) };
//

// print_and_drop passes in by value
void print_and_drop(std::unique_ptr<Thinger> thing)
{
    thing->print_me();
}

// print_and_retain passes in by reference
void print_and_retain(std::unique_ptr<Thinger> &thing)
{
    thing->print_me();
}

// modify and retain
auto modify_and_retain(auto thing)
{
    thing->num = 456;
    return thing;
}

int main()
{
    // Creating unique_ptrs for scenarios
    auto first{std::make_unique<Thinger>("First", 123)};
    auto second{std::make_unique<Thinger>("Second", 123)};
    auto third{std::make_unique<Thinger>("Third", 123)};
    auto fourth{std::make_unique<Thinger>("Fourth", 123)};

    // Scenario for print_and_drop
    std::cout << "1) Before" << std::endl;
    print_and_drop(std::move(first));
    std::cout << "1) After" << std::endl;

    // Calling object on second Thinger and check to make sure value was maintained
    std::cout << "2) Before" << std::endl;
    print_and_retain(second);
    print_and_retain(second);
    std::cout << "2) After" << std::endl;

    // Modify the Thinger and make sure it is accessable after function
    std::cout << "3) Before" << std::endl;
    third = modify_and_retain(std::move(third));
    third->print_me();
    std::cout << "3) After" << std::endl;

    // Create a copy of the Thinger, modify it, then make sure the original was maintained
    std::cout << "4) Before" << std::endl;
    auto fourth_copy{std::make_unique<Thinger>(*fourth)};
    auto modified_copy = modify_and_retain(std::move(fourth_copy));
    fourth->print_me();
    modified_copy->print_me();
    std::cout << "4) After" << std::endl;
}
