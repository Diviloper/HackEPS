#include <iostream>
#include <vector>
#include <chrono>
#include <ctime>
#include <fstream>
#include <omp.h>
using namespace std;

void llegir_vectors(int size, vector<int> &a, vector<int> &b)
{
    ifstream file;
    file.open("input.txt");
    for (int i = 0; i < size; ++i)
    {
        file >> a[i];
    }
    for (int i = 0; i < size; ++i)
    {
        file >> b[i];
    }
    file.close();
}

inline int closest(int target, int p1, int p2)
{
    return abs(p1 - target) <= abs(p2 - target) ? p1 : p2;
}

vector<int> busca_mes_propers_multithreaded(int size, vector<int> &a, vector<int> &b, int c)
{
    vector<vector<int>> closests(omp_get_max_threads(), vector<int>(2));
#pragma omp parallel
    {
        int num_threads = omp_get_num_threads();
        int thread = omp_get_thread_num();
        closests[thread][0] = a[thread];
        closests[thread][1] = b[thread];
        for (int i = thread; i < size; i += num_threads)
        {
            closests[thread][0] = closest(c, closests[thread][0], a[i]);
            closests[thread][1] = closest(c, closests[thread][1], b[i]);
        }
    }
    vector<int> result = closests[0];
    for (int i = 1; i < closests.size(); ++i)
    {
        result[0] = closest(c, result[0], closests[i][0]);
        result[1] = closest(c, result[1], closests[i][1]);
    }
    return result;
}

vector<int> busca_mes_propers(int size, vector<int> &a, vector<int> &b, int c)
{
    vector<int> closests(2);
    closests[0] = a[0];
    closests[1] = b[0];
    for (int i = 1; i < size; ++i){
        closests[0] = closest(c, closests[0], a[i]);
        closests[1] = closest(c, closests[1], b[i]);
    }
    return closests;
}

int main()
{
    int size;
    cin >> size;
    vector<int> a(size), b(size);
    llegir_vectors(size, a, b);
    int c;
    cin >> c;
    

    auto start = chrono::system_clock::now();
    vector<int> lineal = busca_mes_propers(size, a, b, c);
    auto end = chrono::system_clock::now();
    chrono::duration<double> elapsed_seconds_lineal = end - start;

    start = chrono::system_clock::now();
    vector<int> multiThreaded = busca_mes_propers_multithreaded(size, a, b, c);
     end = chrono::system_clock::now();
    chrono::duration<double> elapsed_seconds_multithreaded = end - start;

    cout << "Resultat Lineal (1 thread): " << lineal[0] << " " << lineal[1] << endl;
    cout << "Temps Lineal (1 thread): " << elapsed_seconds_lineal.count() << endl;
    cout << "Resultat MultiThread (" << omp_get_max_threads() << " thread): " << multiThreaded[0] << " " << multiThreaded[1] << endl;
    cout << "Temps MultiThread (" << omp_get_max_threads() << " thread): " << elapsed_seconds_multithreaded.count() << endl;
}