#include <mach/host_info.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    struct host_basic_info host;
    struct vm_statistics vm_info;
    mach_msg_type_number_t count;
    kern_return_t kr;
    vm_size_t pagesize;

    count = HOST_BASIC_INFO_COUNT;
    kr = host_info(mach_host_self(), HOST_BASIC_INFO, (host_info_t)&host, &count);

    count = HOST_VM_INFO_COUNT;
    kr = host_statistics(mach_host_self(),HOST_VM_INFO,(host_info_t)&vm_info,&count);

    kr = host_page_size(mach_host_self(),&pagesize);

    if(kr == KERN_SUCCESS)
        printf("%2f\n",(((double)(vm_info.wire_count + vm_info.active_count)*pagesize)/host.memory_size)*100);
    return 0;
}

