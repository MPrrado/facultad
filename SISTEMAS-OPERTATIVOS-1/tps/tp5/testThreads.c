#include<stdio.h>
#include<pthread.h>
#include<stdlib.h>
#include<sys/types.h>
#include<sys/syscall.h>
#include<unistd.h>

void *threadFunction(void *arg);

int main()
{
    int n=0, i= 0, retVal = 0;
    pthread_t *thread;
    printf("Ingrese el numero de hilos que quiere crear, debe ser un numero entre 1 y 100 \n");
    scanf("%d", &n);
    thread = (pthread_t *) malloc(n*sizeof(pthread_t));
    for(i; i<n; i++)
    {
        getchar();
        retVal = pthread_create(&thread[i], NULL, threadFunction, (void *)i);
        getchar();
        if(retVal != 0)
        {
            printf("pthread_create failed in %d_th pass\n", i);
            exit(EXIT_FAILURE);
        }
    }

    for (i = 0; i < n; i++)
    {
        retVal = pthread_join(thread[i], NULL);
        if(retVal != 0)
        {
            printf("pthread_join failed in %d_th pass\n",i);
            exit(EXIT_FAILURE);
        }        
    }
    
}

void * threadFunction(void * arg)
{
    int threadNum = (int) arg;
    pid_t tid = syscall(SYS_gettid);
    printf("soy el hilo no: %d con mi identificador: %d\n", threadNum, (int)tid);
}
