#include <cuda.h>
#include <cuda_runtime.h>
#include <stdio.h>
#include <sys/time.h>
__global__ void vecMultiply(int *arr, int size){
    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    if(tid<size){
        for(int i = 0;i<100000;i++){
            *(arr + tid) += 10;
        }
    }
}

int main(int argc, char *argv[]){
    // Initialize
        int elementSize = 64;
    int threadsPerBlock = 32;
    int blockSize = (elementSize+threadsPerBlock-1)/threadsPerBlock;
    int *host_input_arr;
    cudaMallocManaged((void**)&host_input_arr, sizeof(int) * elementSize);
    for(int i = 0;i<elementSize;i++){
        host_input_arr[i] = i;
    }

    
    vecMultiply<<<blockSize, threadsPerBlock>>>(host_input_arr, elementSize);
    cudaDeviceSynchronize();

    for(int i = 0;i<elementSize;i++){
        printf("%d ", host_input_arr[i]);
    }
    printf("\n");
    
    cudaFree(host_input_arr);
    
    
    return 0;
}