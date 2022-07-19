#pragma once

#include "example_export.h"
#include <string>

namespace example {

class EXAMPLE_EXPORT Foo {
public:
    static std::string hello_world();
    static void print_hello_world();
};

}