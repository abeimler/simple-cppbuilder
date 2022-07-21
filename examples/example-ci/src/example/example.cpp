#include <fmt/core.h>
#include "example.h"

namespace example {

std::string Foo::hello_world() {
  return "Hello, World!\n";
}

void Foo::print_hello_world() {
  fmt::print("{:s}", hello_world());
}

}