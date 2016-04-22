#include<linux/linkage.h>
#include<linux/kernel.h>
#include<linux/syscalls.h>
#include<linux/time.h>

SYSCALL_DEFINE1(greedy, struct rinfo *, myarg) {
	//give a struct array of 19500 elements in the argument
	//not sure if this is correct
	
	copy_to_user(myarg, sched_data, sizeof(struct rinfo)*19500);
	printk(KERN_ALERT "\nNo of Requests=%ld",lab11_requests);
	return 1;
}
