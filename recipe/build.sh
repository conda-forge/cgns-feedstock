#! /usr/bin/env bash

_build_shared=ON
if [[ `uname -s` == 'Darwin' ]]; then
    _build_shared=OFF
fi

mkdir _build && cd _build
cmake \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCGNS_BUILD_SHARED=$_build_shared \
    -DCGNS_USE_SHARED=ON \
    -DCGNS_ENABLE_FORTRAN=OFF \
    -DFORTRAN_NAMING="LOWERCASE_" \
    -DCGNS_ENABLE_TESTS=ON \
    -DCGNS_ENABLE_LFS=OFF \
    -DZZZCMAKE_C_FLAGS:STRING=-D_LARGEFILE64_SOURCE \
    -DCGNS_ENABLE_HDF5=ON \
    -DHDF5_NEED_SZIP=OFF \
    -DHDF5_NEED_ZLIB=ON \
    ..

make install -j$CPU_COUNT
if [[ `uname -s` == 'Linux' ]]; then
    ctest
fi
