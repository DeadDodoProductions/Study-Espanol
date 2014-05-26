//
//  Switch.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  Overrides UISwitch in order to provide one common place for assigning themes, and other fucntionality all Switches need.

#import "Switch.h"
#import "SwitchController.h"

#import "Database.h"


@implementation Switch
@synthesize group, value, screenLoc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[[SwitchController GetInstance] switches] addObject:self];
        [self addTarget:[SwitchController GetInstance] action:@selector(SwitchWasPressed:) forControlEvents:UIControlEventAllTouchEvents];
    }
    return self;
}

@end
