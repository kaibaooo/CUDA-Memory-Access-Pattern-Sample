#include <cuda.h>
#include <cuda_runtime.h>
#include <stdio.h>
#include <sys/time.h>
__global__ void vecMultiply(int *arr, int size){
    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    if(tid<size){
        *(arr + tid) += 10;
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
    int *host_input_arr;
    int *device_input_arr;
    cudaHostAlloc((void**)&host_input_arr, sizeof(int) * elementSize, cudaHostAllocMapped);
    for(int i = 0;i<elementSize;i++){
        host_input_arr[i] = i;
    }
    gettimeofday(&start, NULL);
    cudaHostGetDevicePointer((void **)&device_input_arr,  (void *) host_input_arr , 0);
    vecMultiply<<<blockSize, threadsPerBlock>>>(device_input_arr, elementSize);
    cudaDeviceSynchronize();

    // for(int i = 0;i<elementSize;i++){
    //     printf("%d ", device_input_arr[i]);
    // }
    // printf("\n");
    gettimeofday(&end, NULL);
    cudaFree(device_input_arr);
    
    diff = 1000000 * (end.tv_sec - start.tv_sec) + end.tv_usec - start.tv_usec;
    printf("Spend Time is %.2fms\n", diff / 1000.0);
    return 0;
}