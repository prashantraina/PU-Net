#/bin/bash
CUDA_HOME=/opt/cuda
TF_CFLAGS=$(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))')
TF_LFLAGS=$(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))')

nvcc tf_nndistance_g.cu -c -o tf_nndistance_g.cu.o -std=c++11 $TF_CFLAGS -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC -O2

g++ tf_nndistance.cpp tf_nndistance_g.cu.o -o tf_nndistance_so.so -std=c++11 -shared -fPIC $TF_CFLAGS $TF_LFLAGS -lcudart -L $CUDA_HOME/lib64 -O2
