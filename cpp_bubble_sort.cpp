#include <iostream>
#include <vector>
#include <chrono>
#include <cstdlib>

void bubbleSortNaive(std::vector<int>& arr) {
    int n = arr.size();
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n - 1; ++j) {
            if (arr[j] > arr[j + 1])
                std::swap(arr[j], arr[j + 1]);
        }
    }
}

int main() {
    const int N = 1000;
    std::vector<int> data(N);

    // Wypełniamy tablicę w odwrotnej kolejności (najgorszy przypadek)
    for (int i = 0; i < N; ++i)
        data[i] = N - i;

    auto start = std::chrono::high_resolution_clock::now();

    bubbleSortNaive(data);

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);

    std::cout << "Czas (nieoptymalny bubble sort): " << duration.count() << " mikrosekund\n";

    return 0;
}