//
//  Switch.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "Switch.h"
#import "Database.h"
#import "SwitchController.h"

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
