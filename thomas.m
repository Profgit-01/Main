#include <iostream>
using namespace std;

int main() {
    int n;
    cout << "Enter number of equations (n): ";
    cin >> n;

    double a[20], b[20], c[20], d[20], c_star[20], d_star[20], x[20];

    cout << "\nEnter coefficients of lower diagonal (a):\n";
    for (int i = 0; i < n; i++) {
        cout << "a[" << i << "] = ";
        cin >> a[i];
    }

    cout << "\nEnter coefficients of main diagonal (b):\n";
    for (int i = 0; i < n; i++) {
        cout << "b[" << i << "] = ";
        cin >> b[i];
    }

    cout << "\nEnter coefficients of upper diagonal (c):\n";
    for (int i = 0; i < n; i++) {
        cout << "c[" << i << "] = ";
        cin >> c[i];
    }

    cout << "\nEnter right-hand side values (d):\n";
    for (int i = 0; i < n; i++) {
        cout << "d[" << i << "] = ";
        cin >> d[i];
    }

    // ---------- Forward Elimination ----------
    c_star[0] = c[0] / b[0];
    d_star[0] = d[0] / b[0];

    for (int i = 1; i < n; i++) {
        double m = b[i] - a[i] * c_star[i - 1];
        c_star[i] = (i == n - 1) ? 0 : c[i] / m;
        d_star[i] = (d[i] - a[i] * d_star[i - 1]) / m;
    }

    // ---------- Back Substitution ----------
    x[n - 1] = d_star[n - 1];
    for (int i = n - 2; i >= 0; i--) {
        x[i] = d_star[i] - c_star[i] * x[i + 1];
    }

    cout << "\nSolution of the system:\n";
    for (int i = 0; i < n; i++) {
        cout << "x[" << i << "] = " << x[i] << endl;
    }

    return 0;
}
