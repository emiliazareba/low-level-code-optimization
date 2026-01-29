#include <iostream>
#include <vector>
#include <chrono>

void matrixMultiplyOptimized(const std::vector<std::vector<int>>& A,
                             const std::vector<std::vector<int>>& B,
                             std::vector<std::vector<int>>& C) {
    int N = A.size();
    for (int i = 0; i < N; ++i)
        for (int k = 0; k < N; ++k) {
            int a = A[i][k];
            for (int j = 0; j < N; ++j)
                C[i][j] += a * B[k][j];
        }
}

int main() {
    const int N = 1000;
    std::vector<std::vector<int>> A(N, std::vector<int>(N, 1));
    std::vector<std::vector<int>> B(N, std::vector<int>(N, 2));
    std::vector<std::vector<int>> C(N, std::vector<int>(N, 0));

    auto start = std::chrono::high_resolution_clock::now();

    matrixMultiplyOptimized(A, B, C);

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

    std::cout << "Czas (optymalne mnozenie): " << duration.count() << " ms\n";

    return 0;
}
