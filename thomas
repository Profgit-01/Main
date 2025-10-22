#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    int n;
    cout << "Enter the order of tridiagonal matrix: ";
    cin >> n;

    double a[20], b[20], c[20], d[20];  // Sub, main, super diagonals and RHS
    double alpha[20], beta[20], x[20];

    cout << "Enter sub-diagonal elements (a):\n";
    for (int i = 1; i < n; i++) cin >> a[i];
    a[0] = 0; // no element below the first row

    cout << "Enter main diagonal elements (b):\n";
    for (int i = 0; i < n; i++) cin >> b[i];

    cout << "Enter super-diagonal elements (c):\n";
    for (int i = 0; i < n - 1; i++) cin >> c[i];
    c[n - 1] = 0; // no element above the last row

    cout << "Enter RHS elements (d):\n";
    for (int i = 0; i < n; i++) cin >> d[i];

    // ---------------- Step 1 & 2: Forward Elimination ----------------
    alpha[0] = b[0];
    beta[0] = d[0] / alpha[0];

    for (int i = 1; i < n; i++) {
        alpha[i] = b[i] - (a[i] * c[i - 1]) / alpha[i - 1];
        beta[i] = (d[i] - a[i] * beta[i - 1]) / alpha[i];
    }

    // ---------------- Step 3: Back Substitution ----------------
    x[n - 1] = beta[n - 1];
    for (int i = n - 2; i >= 0; i--) {
        x[i] = beta[i] - (c[i] * x[i + 1]) / alpha[i];
    }

    // ---------------- Step 4: Display Solution ----------------
    cout << "\nSolution (x):\n";
    for (int i = 0; i < n; i++)
        cout << "x[" << i << "] = " << fixed << setprecision(6) << x[i] << endl;

    return 0;
}
