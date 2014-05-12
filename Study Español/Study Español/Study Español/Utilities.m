//
//  Utilities.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities
@synthesize curView, curWord;
static NSString *device;

+(NSString*)GetDevice
{
    NSLog(@"Getting Device");
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        NSLog(@"iPad");
        return @"iPad";
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            NSLog(@"iPhone568");
            return @"iPhone568";
        }
        else
        {
            NSLog(@"iPhone480");
            return @"iPhone480";
        }
    }
}

@end
