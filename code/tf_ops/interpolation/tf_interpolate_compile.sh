#!/usr/bin/env bash
CUDA_HOME=/opt/cuda
TF_CFLAGS=$(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))')
TF_LFLAGS=$(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))')

g++ tf_interpolate.cpp -o tf_interpolate_so.so -std=c++11  -shared -fPIC \
$TF_CFLAGS $TF_LFLAGS -lcudart -L $CUDA_HOME/lib64 -O2
