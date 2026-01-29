#include <iostream>
#include <chrono>

long long powerFast(long long a, int b) {
    long long result = 1;
    long long base = a;
    int exp = b;
    while (exp > 0) {
        if (exp & 1)
            result *= base;
        base *= base;
        exp >>= 1;
    }
    return result;
}

int main() {
    const int iterations = 1000000000;
    long long a = 3;
    int b = 13;
    volatile long long dummy = 0;

    auto start = std::chrono::high_resolution_clock::now();

    for (int i = 0; i < iterations; ++i) {
        dummy ^= powerFast(a, b);
    }

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

    std::cout << "Czas optymalnego potegowania: " << duration.count() << " ms\n";

    if (dummy == 0) std::cout << "";

    return 0;
}
