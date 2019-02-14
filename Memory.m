//
//  Memory.m
//  Test
//
//  Created by YLCHUN on 2019/2/13.
//  Copyright © 2019年 YLCHUN. All rights reserved.
//

#import "Memory.h"
#import <mach/mach.h>

static const int k2_1024 = 1024.0 * 1024.0;

double getVailableMemory_MB(void) {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return -1;
    }
    return (vm_page_size * vmStats.free_count) / k2_1024;
}

double getUsedMemory_MB(void) {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return -1;
    }
    return (taskInfo.resident_size / k2_1024);
}

