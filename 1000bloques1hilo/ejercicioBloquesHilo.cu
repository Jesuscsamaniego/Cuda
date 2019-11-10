#include <stdio.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#define N 1000	//NUMERO MAXIMO DE BLOQUES
#define T 1		//NUMERO MAXIMO DE HILOS POR BLOQUE
#define V 1000	//TAMAÑO DE LOS VECTORES

__global__ void vecAdd(int *a, int *b, int *c);

int main() {
	int a[V], b[V], c[V];
	int *dev_a, *dev_b, *dev_c;

	for (int i = 0; i<V; i++) {
		a[i] = i;
		b[i] = i; 
	}
	
	cudaMalloc((void**)&dev_a, V * sizeof(int));
	cudaMalloc((void**)&dev_b, V * sizeof(int));
	cudaMalloc((void**)&dev_c, V * sizeof(int));
	
	cudaMemcpy(dev_a, a, V * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, b, V * sizeof(int), cudaMemcpyHostToDevice);
	
	dim3 bDim(N,1);
	dim3 bGrid(T,1);
	
	vecAdd << < N , T >> >(dev_a, dev_b, dev_c);
	cudaMemcpy(c, dev_c, V * sizeof(int), cudaMemcpyDeviceToHost);
	
	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);
	
	printf("El resultado de las operaciones :\n");
	for (int i = 0; i<V; i++)
	{
		printf("%d + %d = %d\n", a[i], b[i], c[i]);
	}
	return 0;
}
__global__ void vecAdd(int *a, int *b, int *c) {
	int tid = threadIdx.x + blockIdx.x * blockDim.x;
	while(tid < N)
	{
		c[tid] = a[tid] + b[tid];
		tid += blockDim.x * gridDim.x;
	}
}