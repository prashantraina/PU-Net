#!/usr/bin/env bash
CUDA_HOME=/opt/cuda
TF_CFLAGS=$(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))')
TF_LFLAGS=$(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))')

nvcc tf_sampling_g.cu -c -o tf_sampling_g.cu.o -std=c++11 $TF_CFLAGS -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC -O2

g++ tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -std=c++11 -shared -fPIC \
$TF_CFLAGS -I $CUDA_HOME/include $TF_LFLAGS -lcudart -L $CUDA_HOME/lib64 -O2 
