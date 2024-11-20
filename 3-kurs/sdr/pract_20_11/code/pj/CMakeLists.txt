cmake_minimum_required(VERSION 3.16)
project(PlutoSDR CXX C)

option(INSTALL_DEPS "Установить зависимости" ON)

find_library(LIBIIO_LIBRARIES iio)
message(${LIBIIO_LIBRARIES})

set(MAIN_SOURCE_FILES
  src/main.cpp
)

add_executable(main ${MAIN_SOURCE_FILES})

target_link_libraries(main ${LIBIIO_LIBRARIES})