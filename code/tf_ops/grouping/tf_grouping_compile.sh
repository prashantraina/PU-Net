#!/usr/bin/env bash
CUDA_HOME=/opt/cuda
TF_CFLAGS=$(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))')
TF_LFLAGS=$(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))')

nvcc tf_grouping_g.cu -c -o tf_grouping_g.cu.o -std=c++11 $TF_CFLAGS -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC -O2

g++ tf_grouping.cpp tf_grouping_g.cu.o -o tf_grouping_so.so -std=c++11 -shared -fPIC -lcudart -I $CUDA_HOME/include -L $CUDA_HOME/lib64  $TF_CFLAGS $TF_LFLAGS -O2
