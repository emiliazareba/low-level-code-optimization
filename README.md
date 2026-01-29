# Low-Level Code Optimization (ASM vs C++)

Repozytorium zawiera projekt poświęcony **analizie i optymalizacji algorytmów
niskopoziomowych** zaimplementowanych w **asemblerze (NASM)** oraz w **języku C++**.

Celem projektu jest porównanie:
- wydajności obu języków,
- wpływu ręcznych optymalizacji,
- różnic pomiędzy kodem niskopoziomowym i wysokopoziomowym.


## Cel projektu

Projekt miał na celu:
- implementację wybranych algorytmów w NASM i C++,
- optymalizację kodu pod kątem wydajności,
- wykonanie pomiarów czasu działania,
- analizę wyników i porównanie efektywności rozwiązań.


## Analizowane algorytmy

W projekcie zaimplementowano trzy algorytmy:

- **Bubble Sort (sortowanie bąbelkowe)**  
- **Mnożenie macierzy**  
- **Szybkie potęgowanie (Exponentiation by Squaring)**  

Każdy algorytm został:
- zaimplementowany w asemblerze (NASM),
- zaimplementowany w C++ w wersji bazowej,
- zoptymalizowany w C++.


## Środowisko testowe

- System operacyjny: Linux (środowiska online)
- Asembler: **NASM 32-bit**
- Kompilator C++: **GCC**
- Pomiar czasu:
  - NASM: `gettimeofday` (syscall)
  - C++: `std::chrono`
- Narzędzia:
  - OneCompiler (NASM)
  - OnlineGDB (C++)


## Zakres prac

### 1. Implementacje w NASM
- ręczne zarządzanie rejestrami,
- brak użycia bibliotek zewnętrznych,
- bezpośrednie wywołania systemowe,
- precyzyjny pomiar czasu wykonania algorytmów.

### 2. Implementacje w C++
- wersje bazowe algorytmów,
- wersje zoptymalizowane:
  - wcześniejsze zakończenie pętli (bubble sort),
  - poprawa lokalności pamięci (mnożenie macierzy),
  - redukcja złożoności obliczeniowej (szybkie potęgowanie).

### 3. Pomiar wydajności
- pomiar czasu wykonania każdej wersji algorytmu,
- porównanie wyników NASM vs C++,
- analiza wpływu optymalizacji na czas działania.


## Wyniki i obserwacje

- Asembler zapewnia najwyższą wydajność dzięki pełnej kontroli nad sprzętem.
- Odpowiednio zoptymalizowany kod C++ może osiągać wyniki zbliżone do NASM.
- Proste optymalizacje (zmiana kolejności pętli, redukcja złożoności) mają istotny wpływ na wydajność.
- Wysoka wydajność asemblera wiąże się z większą złożonością kodu i trudniejszym utrzymaniem.


## Wnioski

- Asembler jest najlepszym wyborem w krytycznych fragmentach kodu wymagających maksymalnej wydajności.
- C++ oferuje lepszą czytelność i szybszy proces tworzenia oprogramowania.
- Optymalizowany C++ stanowi dobry kompromis pomiędzy wydajnością a wygodą implementacji.
- Najlepszym podejściem jest łączenie obu technologii w jednym projekcie.


## Autorzy

- Emilia Zaręba  
- Katarzyna Zieleniewska

---

## ⚠️ Informacja

Projekt ma charakter **edukacyjny** i służy analizie wydajności oraz technik optymalizacji
algorytmów niskopoziomowych.
