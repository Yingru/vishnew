cmake_minimum_required(VERSION 2.6)
project(vishnew Fortran)

# default build type: Release
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
endif()

# default install prefix: ~/.local
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "$ENV{HOME}/.local"
      CACHE PATH "Install path prefix, prepended onto install directories."
      FORCE)
  set(CMAKE_INSTALL_PREFIX_ALT "/usr/lib64"
      CACHE PATH "Install another path prefix"
      FORCE)
endif()

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "Install prefix: ${CMAKE_INSTALL_PREFIX} ${CMAKE_INSTALL_PREFIC_ALT}")


find_package(HDF5 COMPONENTS Fortran)
if(HDF5_FOUND)
  message(STATUS "HDF5 found, using pakage")
  message(STATUS ${HDF5_INCLUDE_DIRS})
  message(STATUS ${HDF5_Fortran_LIBRARIES})
  message(STATUS ${HDF5_LIBRARIES})
  include_directories(${HDF5_INCLUDE_DIRS})
else()
  message(STATUS "hdf5 not found, using package")
endif()


# Set default architecture flags to optimize for the current system,
# but don't override user settings.
if(NOT CMAKE_Fortran_FLAGS MATCHES "-march|-mtune")
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -march=native")
endif()

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -cpp -fno-align-commons")

install(FILES ${PROJECT_NAME}.conf DESTINATION bin)

add_subdirectory(eos)
add_subdirectory(src)
