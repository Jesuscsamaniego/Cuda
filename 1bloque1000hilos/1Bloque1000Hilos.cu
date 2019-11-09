#include <stdio.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#define N 1 //BLOQUES
#define T 1000 //NUMERO MAXIMO DE HILOS POR BLOQUE

__global__ void vecAdd(int *a, int *b, int *c);

int main() {
	int a[T], b[T], c[T];
	int *dev_a, *dev_b, *dev_c;
	for (int i = 0; i<T; i++) {
		a[i] = i;
		b[i] = i*i; 
    }
    
	cudaMalloc((void**)&dev_a, T * sizeof(int));
	cudaMalloc((void**)&dev_b, T * sizeof(int));
    cudaMalloc((void**)&dev_c, T * sizeof(int));
    
	cudaMemcpy(dev_a, a, T * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, b, T * sizeof(int), cudaMemcpyHostToDevice);

	vecAdd << <N , T >> >(dev_a, dev_b, dev_c);
	cudaMemcpy(c, dev_c, T * sizeof(int), cudaMemcpyDeviceToHost);
	cudaFree(dev_a);
	cudaFree(dev_b);
    cudaFree(dev_c);
    
	printf("El resultado de las operaciones :\n");
	for (int i = 0; i<T; i++)
	{
		printf("%d + %d = %d\n", a[i], b[i], c[i]);
	}
	return 0;
}
__global__ void vecAdd(int *a, int *b, int *c) {
	int i = blockIdx.x;
	if (i < T) 
	{
		c[i] = a[i] + b[i];
	}
}