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
    int *host_output_arr;
    int *device_arr;
    cudaMallocHost((void**)&host_input_arr, sizeof(int) * elementSize, cudaHostAllocDefault);
    cudaMallocHost((void**)&host_output_arr, sizeof(int) * elementSize, cudaHostAllocDefault);
    for(int i = 0;i<elementSize;i++){
        host_input_arr[i] = i;
    }

    
    cudaMalloc((void**)&device_arr, sizeof(int) * elementSize);
    cudaMemcpy(device_arr, host_input_arr, sizeof(int) * elementSize, cudaMemcpyHostToDevice);
    vecMultiply<<<blockSize, threadsPerBlock>>>(device_arr, elementSize);
    cudaMemcpy(host_output_arr, device_arr, sizeof(int) * elementSize, cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();

    for(int i = 0;i<elementSize;i++){
        printf("%d ", host_output_arr[i]);
    }
    printf("\n");
    
    cudaFree(device_arr);
    cudaFreeHost(host_input_arr);
    cudaFreeHost(host_output_arr);
    
    
    return 0;
}