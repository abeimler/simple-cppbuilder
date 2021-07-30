#include <emscripten/bind.h>

using namespace emscripten;

int myadd(int a, int b) {
    return a+b;
}

EMSCRIPTEN_BINDINGS(my_module) {
    function("asurionadd", &myadd);
}