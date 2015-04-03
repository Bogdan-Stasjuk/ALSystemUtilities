//
//  ALHardware.m
//  ALSystem
//
//  Created by Andrea Mario Lufino on 21/07/13.
//  Copyright (c) 2013 Andrea Mario Lufino. All rights reserved.
//

#import "ALHardware.h"
#include <sys/utsname.h>
#include <sys/types.h>
#include <sys/sysctl.h>

#define MIB_SIZE 2

@interface ALHardware ()

+ (NSDictionary *)infoForDevice;

@end

@implementation ALHardware

#pragma mark - Info for device

+ (NSDictionary *)infoForDevice {
    NSString *device = [ALHardware platformType];
    NSDictionary *info = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[device stringByReplacingOccurrencesOfString:@" " withString:@""] ofType:@"plist"]];
    return info;
}

#pragma mark - Methods

+ (NSString *)deviceModel {
    return [[UIDevice currentDevice] model];
}

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

+ (NSString *)systemName {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSInteger)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (NSInteger)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)brightness {
    return [[UIScreen mainScreen] brightness] * 100;
}

+ (NSString *)platformType {
  switch ([self platformTypeID]) {
    case ALPlatformTypeUndef:
      return nil;
    case ALPlatformTypeSimulator:
      return @"Simulator";
    case ALPlatformTypeiPodTouch3:
      return @"iPod Touch 3";
    case ALPlatformTypeiPodTouch4:
      return @"iPod Touch 4";
    case ALPlatformTypeiPodTouch5:
      return @"iPod Touch 5";
    case ALPlatformTypeiPhone3Gs:
      return @"iPhone 3Gs";
    case ALPlatformTypeiPhone4:
      return @"iPhone 4";
    case ALPlatformTypeiPhone4s:
      return @"iPhone 4s";
    case ALPlatformTypeiPhone5:
      return @"iPhone 5";
    case ALPlatformTypeiPad2:
      return @"iPad 2";
    case ALPlatformTypeiPad3:
      return @"iPad 3";
    case ALPlatformTypeiPad4:
      return @"iPad 4";
    case ALPlatformTypeiPadAir:
      return @"iPad Air";
    case ALPlatformTypeiPadAir2:
      return @"iPad Air 2";
    case ALPlatformTypeiPadMini:
      return @"iPad Mini";
    case ALPlatformTypeiPadMiniRetina:
      return @"iPad Mini Retina";
    case ALPlatformTypeiPhone5s:
      return @"iPhone 5s";
    case ALPlatformTypeiPhone5c:
      return @"iPhone 5c";
    case ALPlatformTypeiPhone6:
      return @"iPhone 6";
    case ALPlatformTypeiPhone6Plus:
      return @"iPhone 6 Plus";
  }
}

+ (ALPlatformType)platformTypeID {
  struct utsname systemInfo;
  uname(&systemInfo);
  NSString *hardwareType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
  if ([hardwareType isEqualToString:@"i386"]) {
    return ALPlatformTypeSimulator;
  }
  if ([hardwareType isEqualToString:@"iPod3,1"]) {
    return ALPlatformTypeiPodTouch3;
  }
  if ([hardwareType isEqualToString:@"iPod4,1"]) {
    return ALPlatformTypeiPodTouch4;
  }
  if ([hardwareType isEqualToString:@"iPod5,1"]) {
    return ALPlatformTypeiPodTouch5;
  }
  if ([hardwareType isEqualToString:@"iPhone2,1"]) {
    return ALPlatformTypeiPhone3Gs;
  }
  if ([hardwareType isEqualToString:@"iPhone3,1"]) {
    return ALPlatformTypeiPhone4;
  }
  if ([hardwareType isEqualToString:@"iPhone4,1"]) {
    return ALPlatformTypeiPhone4s;
  }
  if ([hardwareType isEqualToString:@"iPhone5,1"] ||
      [hardwareType isEqualToString:@"iPhone5,2"]) {
    return ALPlatformTypeiPhone5;
  }
  if ([hardwareType isEqualToString:@"iPad2,1"] ||
      [hardwareType isEqualToString:@"iPad2,2"] ||
      [hardwareType isEqualToString:@"iPad2,3"]) {
    return ALPlatformTypeiPad2;
  }
  if ([hardwareType isEqualToString:@"iPad3,1"] ||
      [hardwareType isEqualToString:@"iPad3,2"] ||
      [hardwareType isEqualToString:@"iPad3,3"]) {
    return ALPlatformTypeiPad3;
  }
  if ([hardwareType isEqualToString:@"iPad3,4"] ||
      [hardwareType isEqualToString:@"iPad3,5"] ||
      [hardwareType isEqualToString:@"iPad3,6"]) {
    return ALPlatformTypeiPad4;
  }
  if ([hardwareType isEqualToString:@"iPad4,1"] ||
      [hardwareType isEqualToString:@"iPad4,2"]) {
    return ALPlatformTypeiPadAir;
  }
  if ([hardwareType isEqualToString:@"iPad5,3"] ||
      [hardwareType isEqualToString:@"iPad5,4"]) {
    return ALPlatformTypeiPadAir2;
  }
  if ([hardwareType isEqualToString:@"iPad2,5"] ||
      [hardwareType isEqualToString:@"iPad2,6"] ||
      [hardwareType isEqualToString:@"iPad2,7"]) {
    return ALPlatformTypeiPadMini;
  }
  if ([hardwareType isEqualToString:@"iPad4,4"] ||
      [hardwareType isEqualToString:@"iPad4,5"]) {
    return ALPlatformTypeiPadMiniRetina;
  }
  if ([hardwareType isEqualToString:@"iPhone6,1"] ||
      [hardwareType isEqualToString:@"iPhone6,2"]) {
    return ALPlatformTypeiPhone5s;
  }
  if ([hardwareType isEqualToString:@"iPhone5,3"] ||
      [hardwareType isEqualToString:@"iPhone5,4"]) {
    return ALPlatformTypeiPhone5c;
  }
  if ([hardwareType isEqualToString:@"iPhone7,2"]) {
    return ALPlatformTypeiPhone6;
  }
  if ([hardwareType isEqualToString:@"iPhone7,1"]) {
    return ALPlatformTypeiPhone6Plus;
  }
  
  return ALPlatformTypeUndef;
}

+ (NSString *)bootTime {
    NSInteger ti = (NSInteger)[[NSProcessInfo processInfo] systemUptime];
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
}

+ (BOOL)proximitySensor {
    // Make a Bool for the proximity Sensor
    BOOL proximitySensor = NO;
    // Is the proximity sensor enabled?
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setProximityMonitoringEnabled:)]) {
        // Create a UIDevice variable
        UIDevice *device = [UIDevice currentDevice];
        // Turn the sensor on, if not already on, and see if it works
        if (device.proximityMonitoringEnabled != YES) {
            // Sensor is off
            // Turn it on
            [device setProximityMonitoringEnabled:YES];
            // See if it turned on
            if (device.proximityMonitoringEnabled == YES) {
                // It turned on!  Turn it off
                [device setProximityMonitoringEnabled:NO];
                // It works
                proximitySensor = YES;
            } else {
                // Didn't turn on, no good
                proximitySensor = NO;
            }
        } else {
            // Sensor is already on
            proximitySensor = YES;
        }
    }
    // Return on or off
    return proximitySensor;
}

+ (BOOL)multitaskingEnabled {
    // Is multitasking enabled?
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        // Create a bool
        BOOL multitaskingSupported = [UIDevice currentDevice].multitaskingSupported;
        // Return the value
        return multitaskingSupported;
    } else {
        // Doesn't respond to selector
        return NO;
    }
}

// 1.2

+ (NSString *)sim {
    return [[self infoForDevice] objectForKey:@"sim"];
}

+ (NSString *)dimensions {
    return [[self infoForDevice] objectForKey:@"dimensions"];
}

+ (NSString *)weight {
    return [[self infoForDevice] objectForKey:@"weight"];
}

+ (NSString *)displayType {
    return [[self infoForDevice] objectForKey:@"display-type"];
}

+ (NSString *)displayDensity {
    return [[self infoForDevice] objectForKey:@"display-density"];
}

+ (NSString *)WLAN {
    return [[self infoForDevice] objectForKey:@"WLAN"];
}

+ (NSString *)bluetooth {
    return [[self infoForDevice] objectForKey:@"bluetooth"];
}

+ (NSString *)cameraPrimary {
    return [[self infoForDevice] objectForKey:@"camera-primary"];
}

+ (NSString *)cameraSecondary {
    return [[self infoForDevice] objectForKey:@"camera-secondary"];
}

+ (NSString *)cpu {
    return [[self infoForDevice] objectForKey:@"cpu"];
}

+ (NSString *)gpu {
    return [[self infoForDevice] objectForKey:@"gpu"];
}

+ (BOOL)siri {
    if ([[[self infoForDevice] objectForKey:@"siri"] isEqualToString:@"Yes"])
        return YES;
    else
        return NO;
}

+ (BOOL)touchID {
    if ([[[self infoForDevice] objectForKey:@"touch-id"] isEqualToString:@"Yes"])
        return YES;
    else
        return NO;
}

@end
