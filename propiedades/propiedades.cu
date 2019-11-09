#include <stdio.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

int main(void) 
{
	cudaDeviceProp  prop;
	int count;
	cudaGetDeviceCount(&count);
	
	for (int i = 0; i< count; i++) {
		cudaGetDeviceProperties(&prop, i);
		printf("   --- Informacion general de los dispositivos %d ---\n", i);
		printf("Nombre:  %s\n", prop.name);
		printf("Capacidad de computo:  %d.%d\n", prop.major, prop.minor);
		printf("Velocidad del Reloj:  %d mhz\n", prop.clockRate);
		
		printf("Sobre posicion de copia del dispositivo:  ");
		if (prop.deviceOverlap){
			printf("Habilidada\n");
			printf("Ejecucion simultanea de cudaMemcpy() y un kernel\n");
		}
		else
		{
			printf("Deshabilitada\n");
		}
		
		printf("Limite de tiempo de ejecucion del kernel :  ");
		if (prop.kernelExecTimeoutEnabled){
			printf("Habilitada\n");
		}
		else{
			printf("Deshabilidad\n");
		}

		printf("Soporte de kernels concurrentes :  ");
		if (prop.concurrentKernels){
			printf("Habilitada\n");
		}
		else{
			printf("Deshabilidad\n");
		}

		printf("Memoria con codigo de correccion de errores :  ");
		if (prop.ECCEnabled){
			printf("Habilitada\n");
		}
		else{
			printf("Deshabilidad\n");
		}
		
		printf("   --- Informacion de memoria del dispositivo %d ---\n", i);
		printf("Memoria global total:  %ld bytes\n", prop.totalGlobalMem);
		printf("Memoria total para constantes:  %ld\n", prop.totalConstMem);
		printf("Pico max en copias de memoria (bytes):  %ld\n", prop.memPitch);
		printf("Alineamiento de texturas:  %ld\n", prop.textureAlignment);
		printf("   --- Informacion secundaria del dispositivo %d ---\n", i);
		printf("Conteo de multiprocesadores en el GPU:  %d\n",
			prop.multiProcessorCount);
		printf("Memoria compartida por multiprocesadores:  %ld\n", prop.sharedMemPerBlock);
		printf("Registros por  mp:  %d\n", prop.regsPerBlock);
		printf("hilos por grupo:  %d\n", prop.warpSize);
		printf("Cantidad maxima de hilos por bloque:  %d\n",
			prop.maxThreadsPerBlock);
		printf("Dimensiones maximas del hilo:  (%d, %d, %d)\n",
			prop.maxThreadsDim[0], prop.maxThreadsDim[1],
			prop.maxThreadsDim[2]);
		printf("Tamanio maximo de los GRIDS:  (%d, %d, %d)\n",
			prop.maxGridSize[0], prop.maxGridSize[1],
			prop.maxGridSize[2]);
		printf("\n");
	}
	
}