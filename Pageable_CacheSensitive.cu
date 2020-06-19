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
    struct timeval start;
    struct timeval end;
    unsigned long diff;
    
    int elementSize = 8192;
    int threadsPerBlock = 32;
    int blockSize = (elementSize+threadsPerBlock-1)/threadsPerBlock;
    int *host_input_arr = (int*)malloc(sizeof(int) * elementSize);
    int *host_output_arr = (int*)malloc(sizeof(int) * elementSize);
    int *device_arr;
    
    for(int i = 0;i<elementSize;i++){
        host_input_arr[i] = i;
    }

    gettimeofday(&start, NULL);
    cudaMalloc((void**)&device_arr, sizeof(int) * elementSize);
    cudaMemcpy(device_arr, host_input_arr, sizeof(int) * elementSize, cudaMemcpyHostToDevice);
    vecMultiply<<<blockSize, threadsPerBlock>>>(device_arr, elementSize);
    cudaMemcpy(host_output_arr, device_arr, sizeof(int) * elementSize, cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();


    // for(int i = 0;i<elementSize;i++){
    //     printf("%d ", host_output_arr[i]);
    // }
    // printf("\n");
    gettimeofday(&end, NULL);
    cudaFree(device_arr);
    free(host_input_arr);
    free(host_output_arr);
    
    diff = 1000000 * (end.tv_sec - start.tv_sec) + end.tv_usec - start.tv_usec;
    printf("Spend Time is %.2fms\n", diff / 1000.0);
    return 0;
}