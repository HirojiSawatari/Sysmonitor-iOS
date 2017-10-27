//
//  GetCPU.h
//  Sysmonitor
//
//  Created by 何韬 on 2017/10/27.
//  Copyright © 2017年 何韬. All rights reserved.
//

#ifndef GetCPU_h
#define GetCPU_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GetCPU : NSObject

+ (CGFloat)usedMemoryInMB;

+ (CGFloat)cpuUsage;

@end

#endif /* GetCPU_h */
