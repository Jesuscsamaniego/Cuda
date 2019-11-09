CC = g++
INC=-I/usr/local/cuda/include -I/usr/local/cuda-9.1/samples/common/inc -L/usr/local/cuda/lib64
NVCC=/usr/local/cuda/bin/nvcc
NVCC_OPT=-std=c++11
all:
	$(NVCC) $(NVCC_OPT) $(INC) 1Bloque1000Hilos.cu -o 1bx1000

clean:
	-rm -f 1bx1000
