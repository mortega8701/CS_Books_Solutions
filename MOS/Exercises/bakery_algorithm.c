#include <pthread.h>
#include <err.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <limits.h>
#include <stdbool.h>

#define NUMBER_OF_THREADS 8

volatile int entering[NUMBER_OF_THREADS];
volatile int number[NUMBER_OF_THREADS];
int shared_counter=0;

int max(volatile int* array, int size) {
    int result = *(array);
    for(int i=0; i<size; i++) {
        if(result<*(array+i)){
            result = *(array+i);
        }
    }
    return result;
}

void lock(int i) {
    entering[i] = true;
    number[i] = 1 + max(&number[0], sizeof(number)/sizeof(int));
    entering[i] = false;
    for (int j = 0; j < NUMBER_OF_THREADS; j++) {
        while (entering[j]);
        while (number[j] != 0 && 
              (number[j] < number[i] || (number[j] == number[i] && j < i)));
    }
}

void unlock(int i) {
    number[i] = 0;
}

void *bakery(void *ptr_tid)
{
    int tid = *(int*)ptr_tid;
    free(ptr_tid);
    while(true) {
        lock(tid);
        if (shared_counter >= INT_MAX-1) {
            unlock(tid);
            break;
        }
        shared_counter++;
        printf("Hey, Critical section of thread %d here!, Counter is at %d\n", tid, shared_counter);
        unlock(tid);
    }
    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];

    for(int i=0; i<NUMBER_OF_THREADS; i++)
    {
        int *ptr_i = malloc(sizeof(int));
        *ptr_i = i;
        printf("Main here. Creating thread %d\n", i);
        if (pthread_create(&threads[i], NULL, &bakery, ptr_i) != 0)
            err(errno, "Failed creating thread");
    }
    for(int i=0; i<NUMBER_OF_THREADS; i++)
    {
        pthread_join(threads[i], NULL);
    }
    exit(0);
}
