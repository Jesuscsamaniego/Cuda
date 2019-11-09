#include "cuda_runtime.h"
#include <stdio.h>
__global__ void mikernel(void){
	printf("Llamada a kernel de gpu\n");
}
main(void){
	mikernel << <1, 1 >> >();
	cudaDeviceSynchronize();
	printf("Mensaje desde el cpu \n");
	return 0;
}
