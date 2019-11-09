#include <stdio.h>
#include "cuda_runtime.h"
#include <stdio.h>

//#define N 65535 //Bloques
//#define T 128 //Hilos
//#define D N*T
#define D 8388480

int a[D], b[D], c[D];

__global__ void vecAdd(int *a, int *b, int *c);

int main() {
	int *dev_a, *dev_b, *dev_c;

	for (int i = 0; i<D; i++) {
		a[i] = i;
		b[i] = i; 

	}

	cudaMalloc((void**)&dev_a, D * sizeof(int));
	cudaMalloc((void**)&dev_b, D * sizeof(int));
	cudaMalloc((void**)&dev_c, D * sizeof(int));

	cudaMemcpy(dev_a, a, D * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, b, D * sizeof(int), cudaMemcpyHostToDevice);
	
	dim3 bDim(65535,1);
	dim3 bGrid(128,1);

	vecAdd << <bDim , bGrid >> >(dev_a, dev_b, dev_c);
	cudaMemcpy(c, dev_c, D * sizeof(int), cudaMemcpyDeviceToHost);
	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);

	printf("El resultado de las operaciones :\n");
	for (int i = 0; i<D; i++)
	{
		printf("%d + %d = %d\n", a[i], b[i], c[i]);
	}
	return 0;
}
__global__ void vecAdd(int *a, int *b, int *c) {
	int tid = threadIdx.x + blockIdx.x * blockDim.x;
	while(tid < D)
	{
		c[tid] = a[tid] + b[tid];
		tid += blockDim.x * gridDim.x;
	}

}
