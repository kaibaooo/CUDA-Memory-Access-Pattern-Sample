all:
	nvcc Pinned.cu -o Pinned.out
	nvcc Pageable.cu -o Pageable.out
	nvcc UnifiedMemoryAccess.cu -o UnifiedMemoryAccess.out
	nvcc ZeroCopy.cu -o ZeroCopy.out



clean:
	rm *.out