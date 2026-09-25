#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* ptrMatrix;
    int rows;
    int cols;
} matrix_t;

typedef struct {
    int* ptrA;
    int* ptrIA;
    int* ptrJA;
    size_t sizeA;
    size_t sizeIA;
    size_t sizeJA;
} sparsematrix_t;

sparsematrix_t* getSparseMatrix(matrix_t* ptrMatrix);
matrix_t* classicMatrixMultiplication(matrix_t* matrixA, matrix_t* matrixB);
matrix_t* improvedMatrixMultiplication(sparsematrix_t* matrixA, matrix_t* matrixB);
matrix_t* createMatrix(int rows, int cols, const int* data);
void freeMatrix(matrix_t* matrix);
void freeSparseMatrix(sparsematrix_t* sparseMatrix);
void printMatrix(const matrix_t* matrix);
void printSparseMatrix(const sparsematrix_t* sparseMatrix);

int main(void){
    int initValA[6][6] = {
        {1, 2, 0, 0, 0, 0},
        {0, 0, 1, 1, 0, 0},
        {0, 0, 0, 0, 9, 0},
        {2, 0, 0, 0, 0, 2},
        {0, 0, 3, 3, 0, 7},
        {1, 3, 0, 0, 0, 1}
    };

    int initValB[6][1] = {
        {2}, 
        {4}, 
        {1}, 
        {99}, 
        {7},
        {2}
    };

    matrix_t* matrixA = createMatrix(6, 6, &initValA[0][0]);
    matrix_t* matrixB = createMatrix(6, 1, &initValB[0][0]);
    
    printMatrix(matrixA);
    printMatrix(matrixB);
    matrix_t* matrixC = classicMatrixMultiplication(matrixA, matrixB);
    printMatrix(matrixC);

    sparsematrix_t* sparseMatrixA = getSparseMatrix(matrixA);
    printSparseMatrix(sparseMatrixA); 
    
    //sparsematrix_t sparsematrixC = improvedMatrixMultiplication(&sparseMatrixA, &MatrixB);
    //printSparseMatrix(&sparseMatrixC);

    freeMatrix(matrixA);
    freeMatrix(matrixB);
    freeMatrix(matrixC);
    freeSparseMatrix(sparseMatrixA);
    return 0;
}

sparsematrix_t* getSparseMatrix(matrix_t* ptrMatrix) {
    int i, j, R=0;
    for(i=0; i<ptrMatrix->rows; i++) {
        for(j=0; j<ptrMatrix->cols; j++) {
            if (*(ptrMatrix->ptrMatrix+ptrMatrix->cols*i+j) != 0) {
                R++;
            }
        }
    }

    sparsematrix_t* sparseMatrix = malloc(sizeof(sparsematrix_t));
    if(!sparseMatrix) {
        printf("Failed to allocate sparceMatrix structure\n");
        exit(1);
    }
    sparseMatrix->sizeA = R;
    sparseMatrix->sizeIA = ptrMatrix->rows+1;
    sparseMatrix->sizeJA = R;
    sparseMatrix->ptrA = malloc(sizeof(int)*sparseMatrix->sizeA);
    sparseMatrix->ptrIA = malloc(sizeof(int)*sparseMatrix->sizeIA);
    sparseMatrix->ptrJA = malloc(sizeof(int)*sparseMatrix->sizeJA);
    if (!sparseMatrix->ptrA || !sparseMatrix->ptrIA || !sparseMatrix->ptrJA) {
        printf("Failed to allocate sparceMatrix data\n");
        exit(1);
    }
    R = 0; 
    for(i=0; i<ptrMatrix->rows; i++) {
        *(sparseMatrix->ptrIA+i) = R;
        for(j=0; j<ptrMatrix->cols; j++) {
            if(*(ptrMatrix->ptrMatrix+ptrMatrix->cols*i+j) != 0) {
                *(sparseMatrix->ptrA+R) = *(ptrMatrix->ptrMatrix+ptrMatrix->cols*i+j);
                *(sparseMatrix->ptrJA+R) = j;
                R++;
            }
        }
    }

    *(sparseMatrix->ptrIA+sparseMatrix->sizeIA-1) = R;
    
    return sparseMatrix;
}

matrix_t* classicMatrixMultiplication(matrix_t* matrixA, matrix_t* matrixB) {
    matrix_t* matrixC = createMatrix(matrixA->rows, matrixB->cols, NULL);

    int i, j, k;
    for (i=0; i<matrixC->rows; i++) {
        for (j=0; j<matrixC->cols; j++) {
            for (k=0; k<matrixA->rows; k++) {
                *(matrixC->ptrMatrix+matrixC->cols*i+j) += (*(matrixA->ptrMatrix+matrixA->cols*i+k)) * (*(matrixB->ptrMatrix+matrixB->cols*k+j));
            }
        }
    }
    return matrixC;
}

matrix_t* improvedMatrixMultiplication(sparsematrix_t* matrixA, matrix_t* matrixB) {
    matrix_t* matrixC = malloc(sizeof(matrix_t));

    return matrixC;
}

matrix_t* createMatrix(int rows, int cols, const int* data) {
    matrix_t* matrix = malloc(sizeof(matrix_t));
    if (!matrix) return NULL;
    matrix->rows = rows;
    matrix->cols = cols;
    matrix->ptrMatrix = malloc(matrix->rows * matrix->cols * sizeof(int));
    if (!matrix->ptrMatrix) {
        free(matrix);
        return NULL;
    }

    if(data) {
        memcpy(matrix->ptrMatrix, data, matrix->rows * matrix->cols * sizeof(int));
    } else {
        memset(matrix->ptrMatrix, 0, matrix->rows * matrix->cols * sizeof(int));
    }

    return matrix;
}

void freeMatrix(matrix_t* matrix) {
    if (matrix) {
        free(matrix->ptrMatrix);
        free(matrix);
    }
}

void freeSparseMatrix(sparsematrix_t* sparseMatrix) {
    if (sparseMatrix) {
        free(sparseMatrix->ptrA);
        free(sparseMatrix->ptrIA);
        free(sparseMatrix->ptrJA);
        free(sparseMatrix);
    }
}

void printMatrix(const matrix_t* matrix) {
    int i,j;
    printf("[\n");
    for (i=0; i<matrix->rows; i++) {
        printf("\t[");
        for (j=0; j<matrix->cols; j++) {
            printf("%d, ", *(matrix->ptrMatrix+matrix->cols*i+j));
        }
        printf("]\n");
    }
    printf("]\n");
}

void printSparseMatrix(const sparsematrix_t* sparseMatrix) {
    int i;
    printf("A\t[");
    for (int i=0; i<sparseMatrix->sizeA; i++) {
        printf("%d, ", *(sparseMatrix->ptrA+i));
    }
    printf("]\n");

    printf("IA\t[");
    for (int i=0; i<sparseMatrix->sizeIA; i++) {
        printf("%d, ", *(sparseMatrix->ptrIA+i));
    }
    printf("]\n");

    printf("JA\t[");
    for (int i=0; i<sparseMatrix->sizeJA; i++) {
        printf("%d, ", *(sparseMatrix->ptrJA+i));
    }
    printf("]\n");
}
