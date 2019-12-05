#include "genericMemory.hpp"
#include "math/math.hpp"
#include <cstdlib>
#include <stdio.h>

void* GenericMemory::malloc(uintptr amt, uint32 alignment)
{
	alignment = Math::max(amt >= 16 ? 16u : 8u, alignment);
	void* ptr = ::malloc(amt + alignment + sizeof(void*) + sizeof(uintptr));
	void* result = align((uint8*)ptr + sizeof(void*) + sizeof(uintptr), (uintptr)alignment);
	*((void**)((uint8*)result - sizeof(void*))) = ptr;
	*((uintptr*)((uint8*)result - sizeof(void*) - sizeof(uintptr))) = amt;
	return result;
}

void* GenericMemory::realloc(void* ptr, uintptr amt, uint32 alignment)
{
	alignment = Math::max(amt >= 16 ? 16u : 8u, alignment);
	if(ptr == nullptr) {
		return GenericMemory::malloc(amt, alignment);
	}

	if(amt == 0) {
		GenericMemory::free(ptr);
		return nullptr;
	}

	void* result = malloc(amt, alignment);
	uintptr size = GenericMemory::getAllocSize(ptr);
	GenericMemory::memcpy(result, ptr, Math::min(size, amt));
	free(ptr);

	return result;
}

void* GenericMemory::free(void* ptr)
{
	if(ptr) {
		::free(*((void**)((uint8*)ptr - sizeof(void*))));
	}
	return nullptr;
}

uintptr GenericMemory::getAllocSize(void* ptr)
{
	return *((uintptr*)((uint8*)ptr - sizeof(void*) - sizeof(uintptr)));
}

void GenericMemory::bigmemswap(void* a, void* b, uintptr size)
{
	uint64* ptr1 = (uint64*)a;
	uint64* ptr2 = (uint64*)b;
	while(size > GENERIC_MEMORY_SMALL_MEMSWAP_MAX) {
		uint64 tmp = *ptr1;
		*ptr1 = *ptr2;
		*ptr2 = tmp;
		size -= 8;
		ptr1++;
		ptr2++;
	}
	smallmemswap(ptr1, ptr2, size);
}
