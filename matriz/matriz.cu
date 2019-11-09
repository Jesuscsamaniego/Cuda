#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <stdlib.h>     /* malloc, free, rand */

#define D 256

float entrada[D], salida[D];
__global__ void transponer(float* entrada, float* salida, int ANCHO){
	int tx = blockIdx.x*blockDim.x + threadIdx.x;
	int ty = blockIdx.y*blockDim.y + threadIdx.y;
	salida[tx*ANCHO + ty] = entrada[ty*ANCHO + tx];
}
int main(int args, char* argv[]){

	for (int i = 0; i<D; i++) 
	{
		entrada[i] = i;	
	}
	const int ALTO = 16;
	const int ANCHO = 16;
	const int TAM = ALTO*ANCHO*sizeof(float);

	float* M = (float*)malloc(TAM);
	float* Md = NULL;
	float* ld = NULL;
	cudaMalloc((void**)&Md, TAM);
	cudaMalloc((void**)&ld, TAM);

	cudaMemcpy(Md, entrada, D * sizeof(float), cudaMemcpyHostToDevice);
	
	dim3 bDim(16, 16);
	dim3 gDim(ALTO / bDim.x, ALTO / bDim.y);
	transponer << < gDim, bDim >> > (Md, ld, ANCHO);
	cudaMemcpy(salida, ld, D * sizeof(float), cudaMemcpyDeviceToHost);
	
	cudaFree(Md);
	cudaFree(ld);

	printf("El resultado de las operaciones :\n");
	for (int i = 0; i<D; i++)
	{
		printf(" entrada = %f | salida = %f \n",entrada[i],salida[i]);
	}

	
	
	free(M);
	return 0;
}