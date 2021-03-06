#------------------------------------------------------------------------------
# CMake helper for libdevcore, libdevcrypto and libp2p modules.
#
# This module defines
#     Dev_XXX_LIBRARIES, the libraries needed to use ethereum.
#     Dev_INCLUDE_DIRS
#
# The documentation for cpp-ethereum is hosted at http://cpp-ethereum.org
#
# ------------------------------------------------------------------------------
include(ExternalProject)
include(GNUInstallDirs)


ExternalProject_Add(group_sig_lib
    PREFIX ${CMAKE_SOURCE_DIR}/deps
    DOWNLOAD_NAME group_sig_lib.tgz
    DOWNLOAD_NO_PROGRESS 1
    URL https://media.githubusercontent.com/media/FISCO-BCOS/LargeFiles/master/libs/group_sig_lib.tgz
    URL_HASH SHA256=99d82282730654c587d142c772ca6bf79db9efb7f6709909874c7a3d9de4df1e
    BUILD_IN_SOURCE 1
    LOG_CONFIGURE 1
    INSTALL_COMMAND ""
)

ExternalProject_Get_Property(group_sig_lib SOURCE_DIR)
set(GROUP_SIG_INCLUDE_DIRS ${SOURCE_DIR})
set(GROUP_SIG_LIB_DIRS ${SOURCE_DIR})
unset(BUILD_DIR)
set(GROUP_SIG_LIB_SUFFIX .a)

find_package(PBC REQUIRED)

add_library(group_sig_devcore STATIC IMPORTED)
set_property(TARGET group_sig_devcore PROPERTY IMPORTED_LOCATION ${GROUP_SIG_LIB_DIRS}/devcore/libgroup_sig_devcore${GROUP_SIG_LIB_SUFFIX})
add_dependencies(group_sig_devcore group_sig_lib)

add_library(group_sig STATIC IMPORTED)
set_property(TARGET group_sig PROPERTY IMPORTED_LOCATION ${GROUP_SIG_LIB_DIRS}/algorithm/libgroup_sig${GROUP_SIG_LIB_SUFFIX})
add_dependencies(group_sig group_sig_lib)
