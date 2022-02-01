#! /usr/bin/env bash

mkdir _build && cd _build
cmake ${CMAKE_ARGS} \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCGNS_BUILD_SHARED=ON \
    -DCGNS_USE_SHARED=ON \
    -DCGNS_ENABLE_FORTRAN=ON \
    -DFORTRAN_NAMING="LOWERCASE_" \
    -DCGNS_ENABLE_TESTS=ON \
    -DCGNS_ENABLE_LFS=ON \
    -DZZZCMAKE_C_FLAGS:STRING=-D_LARGEFILE64_SOURCE \
    -DCGNS_ENABLE_HDF5=ON \
    -DHDF5_NEED_SZIP=OFF \
    -DHDF5_NEED_ZLIB=ON \
    ..

make install -j$CPU_COUNT
if [[ `uname -s` == 'Linux' ]]; then
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    ctest
fi
fi
