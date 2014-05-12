//
//  Switch.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "Switch.h"
#import "Database.h"

@implementation Switch
@synthesize group, value, screenLoc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addTarget:self action:@selector(SwitchWasPressed:) forControlEvents:UIControlEventAllEvents];
    }
    return self;
}

//is called when a switch is pressed
-(void)SwitchWasPressed:(Switch*)aSwitch
{
    NSLog(@"Value: %@ Group: %d", value, group);
    if ([aSwitch isOn])
    {
        [[Database GetInstance] SetValue:value Group:group Remove:false];
    }
    else
    {
        [[Database GetInstance] SetValue:value Group:group Remove:true];
    }
    //determines if it was a press or a slide
    //calls [DeselectSwitches(group, value)] from SwitchController.m if press
}

-(void)TurnOff:(Switch*)aSwitch
{
    [self setOn:false animated:true];
}

@end
