#include <iostream>
#define CHECK_CUDA(cmd)                                                                                   \
  do {                                                                                                    \
    cudaError_t err = cmd;                                                                                \
    if (err != cudaSuccess) {                                                                             \
      fprintf(stderr, "CUDA error: %s, file %s, line %d\n", cudaGetErrorString(err), __FILE__, __LINE__); \
      exit(1);                                                                                            \
    }                                                                                                     \
  } while (0)

struct Pointer {
	void* ptr;
	Pointer () : ptr (nullptr) {}
	void alloc(int size) {
		if (ptr) cudaFree(ptr);
		CHECK_CUDA(cudaMalloc(&ptr, size));
	}
	virtual ~Pointer() {
		if (ptr != nullptr) {
			CHECK_CUDA(cudaFree(ptr));
		}
		printf("destructor\n");
	}
};

//Pointer *a;
Pointer a;  // when process end, destructor will report error CUDA error: driver shutting down
int main () {
	// Pointer p;
	// p.alloc(10000);
	a.alloc(10000);
	return 0;
}



