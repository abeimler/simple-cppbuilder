#include <iostream>
#include "example.h"

namespace example {

std::string hello_world() {
  return "Hello World!";
}

void print_hello_world() {
  std::cout << hello_world();
}

}