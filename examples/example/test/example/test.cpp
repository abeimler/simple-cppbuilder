#include <catch2/catch_test_macros.hpp>
#include "example.h"

unsigned int Factorial( unsigned int number ) {
    return number <= 1 ? number : Factorial(number-1)*number;
}

TEST_CASE( "Factorials are computed", "[factorial]" ) {
    REQUIRE( Factorial(1) == 1 );
    REQUIRE( Factorial(2) == 2 );
    REQUIRE( Factorial(3) == 6 );
    REQUIRE( Factorial(10) == 3628800 );
}

TEST_CASE( "example", "[example]" ) {
    using namespace std::string_literals;
    REQUIRE( example::Foo::hello_world() == "Hello, World!\n"s );
}