CC=g++
INC=-I/usr/local/cuda/include -L/usr/local/cuda/lib64
LIB64= -L/usr/local/cuda/lib64
NVCC=/usr/local/cuda/bin/nvcc
NVCC_OPT=-std=c++11
all:
	$(NVCC) $(NVCC_OPT) $(INC) holamundo.cu -o holamundo
clean:
	-rm -f holamundo


