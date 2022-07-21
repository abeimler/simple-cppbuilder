#include <cstdlib>

#include "example.h"

int main([[maybe_unused]] int argc,[[maybe_unused]] char *argv[])
{
  example::Foo::print_hello_world();
  return EXIT_SUCCESS;
}