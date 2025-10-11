# Main
#include <iostream>
#include <cmath>
using namespace std;

int main() {
    int n, i, j, k, maxIter;
    double tol;

    cout << "Enter number of variables (n): ";
    cin >> n;

    double a[10][11];   // Maximum size 10x11 (10 variables + constants)
    double x[10], oldX[10];

    cout << "\nEnter coefficients of each equation (including constant term):\n";
    for (i = 0; i < n; i++) {
        cout << "Equation " << i + 1 << ": ";
        for (j = 0; j <= n; j++)
            cin >> a[i][j];
    }

    // ----- Check Diagonal Dominance -----
    bool diagDom = true;
    for (i = 0; i < n; i++) {
        double sum = 0;
        for (j = 0; j < n; j++) {
            if (i != j)
                sum += fabs(a[i][j]);
        }
        if (fabs(a[i][i]) < sum)
            diagDom = false;
    }

    if (diagDom)
        cout << "\nMatrix is diagonally dominant.\n";
    else
        cout << "\nMatrix is NOT diagonally dominant. Trying to rearrange rows...\n";

    // ----- Try simple rearrangement -----
    if (!diagDom) {
        int used[10] = {0};
        double newA[10][11];
        bool possible = true;

        for (i = 0; i < n; i++) {
            int bestRow = -1;
            for (int r = 0; r < n; r++) {
                if (used[r]) continue;

                double sum = 0;
                for (int c = 0; c < n; c++)
                    if (c != i)
                        sum += fabs(a[r][c]);

                if (fabs(a[r][i]) >= sum) {
                    bestRow = r;
                    break;
                }
            }

            if (bestRow == -1) {
                possible = false;
                break;
            }

            for (int c = 0; c <= n; c++)
                newA[i][c] = a[bestRow][c];
            used[bestRow] = 1;
        }

        if (possible) {
            cout << "Successfully rearranged to make diagonally dominant.\n";
            for (i = 0; i < n; i++)
                for (j = 0; j <= n; j++)
                    a[i][j] = newA[i][j];
        } else {
            cout << "Could NOT make diagonally dominant. Results may not converge.\n";
        }
    }

    // ----- Get tolerance and max iterations -----
    cout << "\nEnter tolerance: ";
    cin >> tol;
    cout << "Enter maximum iterations: ";
    cin >> maxIter;

    // Initialize x = 0
    for (i = 0; i < n; i++)
        x[i] = 0;

    cout << "\n--- Gauss-Seidel Iterations ---\n";

    for (k = 1; k <= maxIter; k++) {
        for (i = 0; i < n; i++)
            oldX[i] = x[i];

        for (i = 0; i < n; i++) {
            double sum = a[i][n];
            for (j = 0; j < n; j++) {
                if (j != i)
                    sum -= a[i][j] * x[j];
            }
            x[i] = sum / a[i][i];
        }

        // Calculate total error
        double error = 0;
        for (i = 0; i < n; i++)
            error += fabs(x[i] - oldX[i]);

        cout << "Iteration " << k << ": ";
        for (i = 0; i < n; i++)
            cout << "x" << i + 1 << " = " << x[i] << "  ";
        cout << " | Error = " << error << endl;

        if (error < tol) {
            cout << "\nConverged after " << k << " iterations.\n";
            break;
        }
    }

    if (k > maxIter)
        cout << "\nDid not converge within given iterations.\n";

    cout << "\nFinal Approximations:\n";
    for (i = 0; i < n; i++)
        cout << "x" << i + 1 << " = " << x[i] << endl;

    return 0;
}
