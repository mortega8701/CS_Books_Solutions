#include <err.h>
#include <errno.h>
#include <semaphore.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <time.h>
#include <unistd.h>

#define MAX_MSG 40
#define PRODUCERS 8
#define CONSUMERS 8

typedef struct {
    int idx;
    char data[30];
} message_t;

sem_t used_slots_sem;
sem_t unused_slots_sem;
int tail = 0, head = 0;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

message_t buffer[MAX_MSG];

message_t createMsg(int index) {
    message_t generatedMsg;
    const char *words[] = {"apple", "banana", "cherry", "date", "elderberry"};
    int num_words = sizeof(words) / sizeof(words[0]);
    generatedMsg.idx = index;
    strcpy(generatedMsg.data, words[rand() % num_words]);
    return generatedMsg;
}

void printMsg(message_t msg, int index) {
    printf("Producer number %d says %s to consumer %d\n", msg.idx, msg.data, index);
}

void send(message_t msg) {
    sem_wait(&unused_slots_sem);
    pthread_mutex_lock(&lock);
    buffer[head] = msg;
    head = (head + 1) % MAX_MSG;
    pthread_mutex_unlock(&lock);
    sem_post(&used_slots_sem);
}

message_t receive(void) {
    sem_wait(&used_slots_sem);
    pthread_mutex_lock(&lock);
    message_t readMsg = buffer[tail];
    tail = (tail + 1) % MAX_MSG;
    pthread_mutex_unlock(&lock);
    sem_post(&unused_slots_sem);
    return readMsg;
}

void* producer(void* args) {
    int prodNum = *(int*)args;
    free(args);
    message_t msgCreated;
    for(int i=0; i<10; i++) {
        msgCreated = createMsg(prodNum);
        send(msgCreated);
    }
    pthread_exit(0);
}

void* consumer(void *args) {
    int consNum = *(int*)args;
    free(args);
    message_t msgConsumed;
    for(int i=0; i<10; i++) {
        msgConsumed = receive();
        printMsg(msgConsumed, consNum);
    }
    pthread_exit(0);
}

int main(int argc, char *argv[]) {
    if (sem_init(&used_slots_sem, 0, 0) == -1)
        err(errno, "Failed to initialize used slots semaphore");
    if (sem_init(&unused_slots_sem, 0, MAX_MSG) == -1)
        err(errno, "Failed to initialize unused slots semaphore");

    pthread_t producers[PRODUCERS];
    pthread_t consumers[CONSUMERS];

    srand(time(NULL));

    for(int i=0; i<PRODUCERS; i++) {
        int *prod_i = malloc(sizeof(int));
        *prod_i = i;
        if (pthread_create(&producers[i], NULL, &producer, prod_i) != 0)
            err(errno, "Failed creating producer thread");
    }

    for(int i=0; i<CONSUMERS; i++) {
        int *cons_i = malloc(sizeof(int));
        *cons_i = i;
        if (pthread_create(&consumers[i], NULL, &consumer, cons_i) != 0)
            err(errno, "Failed creating consumer thread");
    }
    
    for(int i=0; i<PRODUCERS; i++) {
        pthread_join(producers[i], NULL);
    }

    for(int i=0; i<CONSUMERS; i++) {
        pthread_join(consumers[i], NULL);
    }

    sem_destroy(&used_slots_sem);
    sem_destroy(&unused_slots_sem);
    return 0;
}
