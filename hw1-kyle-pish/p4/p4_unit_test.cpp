// Header comment
// Test out the functions in p4_lib.py
// Using the Catch C++ unit testing framework: https://github.com/catchorg/Catch2/tree/v2.x

#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include "catch.hpp"

#include "p4_lib.h"


TEST_CASE( "Testing all p4_lib functions") {
    auto jan1 = std::make_pair(1, 1);
    auto jan2 = std::make_pair(1, 2);
    auto feb28 = std::make_pair(2, 28);
    auto dec1 = std::make_pair(12, 1);
    auto dec31 = std::make_pair(12, 31);

    SECTION( "date_is_before" ) {
        REQUIRE(date_is_before(jan1, jan2));
        REQUIRE(date_is_before(jan2, feb28));
        REQUIRE(date_is_before(jan2, dec1));
        REQUIRE(date_is_before(feb28, dec31));
    }

    SECTION( "days_in_month" ) {
        REQUIRE(days_in_month(1) == 31);
        REQUIRE(days_in_month(2) == 28);
        REQUIRE(days_in_month(12) == 31);
    }

    SECTION( "date_plus" ) {
        REQUIRE(date_plus(jan1, 1) == jan2);
        REQUIRE(date_plus(feb28, 1) == std::make_pair(3, 1));
        REQUIRE(date_plus(dec31, 2) == jan2);
    }

    SECTION( "latest_date" ) {
        REQUIRE(latest_date({jan1, jan2}) == jan2);
        REQUIRE(latest_date({feb28, jan1, jan2}) == feb28);
        REQUIRE(latest_date({jan1, feb28, dec31, jan2}) == dec31);
        REQUIRE(latest_date({jan1, feb28, dec1, jan2}) == dec1);
    }
}
