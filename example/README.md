# Example

## Quick Start (without Docker)

### Install [vcpkg](https://vcpkg.io/en/index.html):

- Windows: 

		git clone https://github.com/Microsoft/vcpkg.git
		.\vcpkg\bootstrap-vcpkg.bat

- Linux/MacOS: 

		$ git clone https://github.com/Microsoft/vcpkg.git
		$ ./vcpkg/bootstrap-vcpkg.sh

### Configure:

    $ cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=./vcpkg/scripts/buildsystems/vcpkg.cmake

### Build:

	$ cmake --build build


## Links

### CMake and Project Structure

 - [C++ Weekly - Ep 208 - The Ultimate CMake / C++ Quick Start](https://www.youtube.com/watch?v=YbgH7yat-Jo)
 - https://github.com/lefticus/cpp_starter_project
 - https://github.com/bsamseth/cpp-project
 - [Oh No! More Modern CMake - Deniz Bahadir - Meeting C++ 2019](https://www.youtube.com/watch?v=y9kSr5enrSk)
 - [More Modern CMake - Deniz Bahadir - Meeting C++ 2018](https://www.youtube.com/watch?v=y7ndUhdQuU8)
 - [C++Now 2017: Daniel Pfeifer “Effective CMake"](https://www.youtube.com/watch?v=bsXLMQ6WgIk)