set(XRT_POSSIBLE_ROOT_DIRS
  "$ENV{XILINX_XRT}"
  "$ENV{SDKTARGETSYSROOT}"
)

MESSAGE(STATUS "XRT search path: ${XRT_POSSIBLE_ROOT_DIRS}")

set(XRT_INCDIR_SUFFIXES
  "usr/include/xrt"
  "include"
  "include/CL"
  "usr/include/xrt/CL"
)

set(XRT_LIBDIR_SUFFIXES
  "lib"
  "usr/lib"
)

find_path(XRT_INCDIR "xclbin.h" PATHS ${XRT_POSSIBLE_ROOT_DIRS} PATH_SUFFIXES ${XRT_INCDIR_SUFFIXES} NO_CMAKE_FIND_ROOT_PATH)
find_path(XRT_INCDIR_OCL "cl_ext_xilinx.h" PATHS ${XRT_POSSIBLE_ROOT_DIRS} PATH_SUFFIXES ${XRT_INCDIR_SUFFIXES} NO_CMAKE_FIND_ROOT_PATH)

find_library(LIBXRT_CORE_LIBRARY NAMES xrt_core PATHS ${XRT_POSSIBLE_ROOT_DIRS} PATH_SUFFIXES ${XRT_LIBDIR_SUFFIXES})
find_library(LIBXRT_XILOCL_LIBRARY NAMES xilinxopencl PATHS ${XRT_POSSIBLE_ROOT_DIRS} PATH_SUFFIXES ${XRT_LIBDIR_SUFFIXES})

set(XRT_INCLUDE_DIR ${XRT_INCDIR} ${XRT_INCDIR_OCL})

if(EXISTS ${XRT_INCDIR} AND EXISTS ${XRT_INCDIR_OCL})
  MESSAGE(STATUS "XRT and OpenCL extensions found")
  set(XRT_FOUND ON)
else(EXISTS ${XRT_INCDIR} AND EXISTS ${XRT_INCDIR_OCL})
  message(STATUS "XRT and OpenCL extensions not found")
  set(XRT_FOUND OFF)
endif(EXISTS ${XRT_INCDIR} AND EXISTS ${XRT_INCDIR_OCL})

set(XRT_INCLUDE_DIRS ${XRT_INCLUDE_DIR})
set(XRT_LIBS ${LIBXRT_XILOCL_LIBRARY})
message(STATUS "XRT_INCLUDE_DIRS = ${XRT_INCLUDE_DIRS}")
message(STATUS "XRT_LIBS         = ${XRT_LIBS}")