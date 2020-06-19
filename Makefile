all:
	nvcc Pinned_nonCacheSensitive.cu -o Pinned_nonCacheSensitive.out
	nvcc Pageable_nonCacheSensitive.cu -o Pageable_nonCacheSensitive.out
	nvcc UnifiedMemoryAccess_nonCacheSensitive.cu -o UnifiedMemoryAccess_nonCacheSensitive.out
	nvcc ZeroCopy_nonCacheSensitive.cu -o ZeroCopy_nonCacheSensitive.out
	nvcc Pinned_CacheSensitive.cu -o Pinned_CacheSensitive.out
	nvcc Pageable_CacheSensitive.cu -o Pageable_CacheSensitive.out
	nvcc UnifiedMemoryAccess_CacheSensitive.cu -o UnifiedMemoryAccess_CacheSensitive.out
	nvcc ZeroCopy_CacheSensitive.cu -o ZeroCopy_CacheSensitive.out
nonCacheSensitive:
	nvcc Pinned_nonCacheSensitive.cu -o Pinned_nonCacheSensitive.out
	nvcc Pageable_nonCacheSensitive.cu -o Pageable_nonCacheSensitive.out
	nvcc UnifiedMemoryAccess_nonCacheSensitive.cu -o UnifiedMemoryAccess_nonCacheSensitive.out
	nvcc ZeroCopy_nonCacheSensitive.cu -o ZeroCopy_nonCacheSensitive.out
CacheSensitive:
	nvcc Pinned_CacheSensitive.cu -o Pinned_CacheSensitive.out
	nvcc Pageable_CacheSensitive.cu -o Pageable_CacheSensitive.out
	nvcc UnifiedMemoryAccess_CacheSensitive.cu -o UnifiedMemoryAccess_CacheSensitive.out
	nvcc ZeroCopy_CacheSensitive.cu -o ZeroCopy_CacheSensitive.out

clean:
	rm *.out