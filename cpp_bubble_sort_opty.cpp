#include <iostream>
#include <vector>
#include <chrono>
#include <cstdlib>

void bubbleSortOptimized(std::vector<int>& arr) {
    int n = arr.size();
    bool swapped;
    do {
        swapped = false;
        for (int i = 1; i < n; ++i) {
            if (arr[i - 1] > arr[i]) {
                std::swap(arr[i - 1], arr[i]);
                swapped = true;
            }
        }
        --n; // ostatni element już na właściwym miejscu
    } while (swapped);
}

int main() {
    const int N = 1000;
    std::vector<int> data(N);

    // Wypełniamy tablicę w odwrotnej kolejności
    for (int i = 0; i < N; ++i)
        data[i] = N - i;

    auto start = std::chrono::high_resolution_clock::now();

    bubbleSortOptimized(data);

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);

    std::cout << "Czas (optymalny bubble sort): " << duration.count() << " mikrosekund\n";

    return 0;
}