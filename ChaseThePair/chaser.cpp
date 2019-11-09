#include <iostream>
#include <vector>
#include <chrono>
#include <ctime>
#include <fstream>
#include <omp.h>
using namespace std;

void llegir_vectors(int size, vector<int>& a, vector<int>& b) {
    ifstream file;
    file.open("input.txt");
    for (int i=0; i<size; ++i) {
        file >> a[i];
    }
    for (int i=0; i<size; ++i) {
        file >> b[i];
    }
    file.close();
}

inline int closest(int target, int p1, int p2) {
    return abs(p1-target) <= abs(p2-target) ? p1 : p2;
}


vector<int> busca_mes_propers(int size, vector<int>& a, vector<int>& b, int c) {
    vector<vector<int>> closests(4, vector<int>(2));
    #pragma omp parallel
    {
        int num_threads = omp_get_num_threads();
        int thread = omp_get_thread_num();
        closests[thread][0] = a[thread];
        closests[thread][1] = b[thread];
        for(int i=thread; i<size; i += num_threads) {
            closests[thread][0] = closest(c, closests[thread][0], a[i]);
            closests[thread][1] = closest(c, closests[thread][1], b[i]);
        }
    }
    vector<int> result = closests[0];
    for (int i=1; i<closests.size(); ++i) {
        result[0] = closest(c, result[0], closests[i][0]);
        result[1] = closest(c, result[1], closests[i][1]);
    }
    return result;
}

int main() {
    int size;
    cout << "Introdueix la mida: ";
    cin >> size;
    vector<int> a(size), b(size);
    llegir_vectors(size, a, b);
    cout << "Introdueix el valor a buscar: ";
    int c;
    cin >> c;

    auto start = chrono::system_clock::now();
    vector<int> hey = busca_mes_propers(size, a, b, c);
    // Some computation here
    auto end = chrono::system_clock::now();

   chrono::duration<double> elapsed_seconds = end-start;
   time_t end_time =chrono::system_clock::to_time_t(end);

    cout << "Resultat: " << hey[0] << " " << hey[1] << endl;
    cout << "Temps: " << elapsed_seconds.count() << endl;

}