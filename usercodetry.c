#include <stdio.h>

#include <unistd.h>
struct rinfo {
	pid_t pid,pid2;
	unsigned long time_of_arrival;
	unsigned long time_of_start;
	unsigned long time_of_end;
};
void main(void)
{
	FILE *fp;
	int i;
	unsigned int mean_service_t = 0,a,b;
	unsigned int mean_responce_t = 0;
	struct rinfo cur_info[19600];
	syscall(328,cur_info);

	printf("\n");
	fp=fopen("OS_data.dat","wb");
	fwrite(cur_info,sizeof(struct rinfo),19500,fp);
	for(i = 0 ; i < 19500; i++)
	{
		a =(int)( cur_info[i].time_of_end - cur_info[i].time_of_start);
		b =(int)( cur_info[i].time_of_end - cur_info[i].time_of_arrival);
		if (a<0 || b<0)
		printf("\nNo.%d %d %d",i,a,b);
		mean_service_t +=a;
		mean_responce_t += b;
//	printf("current pid = %d \n",cur_info[i].pid);
	}
	mean_service_t /= 19500;
	mean_responce_t /=19500;
	printf("\n500th: %ld %ld %ld diff %ld pid=%d ",cur_info[500].time_of_start , cur_info[500].time_of_arrival, cur_info[500].time_of_end ,cur_info[500].time_of_end - cur_info[500].time_of_arrival,cur_info[500].pid);
	printf(" \nmean service t = %d \n mean responce t = %d\n",mean_service_t,mean_responce_t);
}
