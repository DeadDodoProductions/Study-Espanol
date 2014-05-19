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
    NSLog(@"Value: %@ Group: %d QuizType: %@", value, group, [[Database GetInstance] quizType]);
    if (group == 0 && [[[Database GetInstance] quizType] isEqualToNumber:[NSNumber numberWithInt:1]] && ![value isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        [self TurnOff:aSwitch];
        [[Database GetInstance] SetValue:value Group:group Remove:true];
    }
    else
    {
        if ([aSwitch isOn])
        {
            [[Database GetInstance] SetValue:value Group:group Remove:false];
        }
        else
        {
            [[Database GetInstance] SetValue:value Group:group Remove:true];
        }
    }
    //determines if it was a press or a slide
    //calls [DeselectSwitches(group, value)] from SwitchController.m if press
}

-(void)TurnOff:(Switch*)aSwitch
{
    //toggles the switch on and off
    if (group == 0 || group == 4 || group == 1)
    {
        [self setOn:false animated:true];
    }
    else
    {
        [self setOn:!aSwitch.on animated:true];
    }
}

@end
