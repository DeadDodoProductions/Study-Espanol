//
//  SwitchController.m
//  Study Español
//
//  Created by Evan Combs on 5/18/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This will hold a master list of all Switches currently active and on screen
//  The methods will control which the switches
//  Each switch will have a single listener that calls back to this class
//  It will need to be a singleton

#import "SwitchController.h"
#import "Switch.h"

#import "Database.h"

@implementation SwitchController
@synthesize switches, wtSwitches, veSwitches, vrSwitches, ctSwitches, qSwitches, tSwitches, gSwitches;
static SwitchController *instance = nil;
///Initilization
+(SwitchController*)GetInstance
{
    if (instance == nil)
    {
        [[self alloc] init];
    }
    return instance;
}
+(id)alloc
{
    instance = [super alloc];
    return instance;
}
-(id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}


//Determines which switches need to be on and off
-(void)SwitchWasPressed:(Switch*)aSwitch
{
    NSLog(@"Switch Controller");
    NSLog(@"Group: %d", aSwitch.group);
    NSLog(@"Value: %@", aSwitch.value);
    NSLog(@"On: %d", aSwitch.on);
    switch(aSwitch.group)
    {
        case 0:
            NSLog(@"Section: WordType");
            if ([aSwitch isOn])
            {
                [[Database GetInstance] setWordType:aSwitch.value];
            }
            else
            {
                [[Database GetInstance] setWordType:[NSNumber numberWithInt:-1]];
            }
            NSLog(@"Set Value: %@", [[Database GetInstance] wordType]);
            for (Switch *a in wtSwitches)
            {
                NSLog(@"Switch: %@", a.value);
                NSLog(@"On: %d", a.on);
                if (a.on == true && a.value != aSwitch.value)
                {
                    [a setOn:false animated:true];
                }
            }
            if ([[[Database GetInstance] quizType] isEqualToNumber:[NSNumber numberWithInt:1]])
            {
                [[Database GetInstance] setQuizType:[NSNumber numberWithInt:0]];
                [qSwitches[0] setOn:true animated:true];
                [qSwitches[1] setOn:false animated:true];
            }
            break;
            
        case 1:
            NSLog(@"Section: VerbEnding");
            if ([aSwitch isOn])
            {
                [[Database GetInstance] setVerbEnding:aSwitch.value];
            }
            else
            {
                [[Database GetInstance] setVerbEnding:[NSNumber numberWithInt:-1]];
            }
            NSLog(@"Set Value: %@", [[Database GetInstance] verbEnding]);
            for (Switch *a in veSwitches)
            {
                NSLog(@"Switch: %@", a.value);
                NSLog(@"On: %d", a.on);
                if (a.on == true && a.value != aSwitch.value)
                {
                    [a setOn:false animated:true];
                }
            }
            break;
            
        case 2:
            NSLog(@"Section: VerbRegular");
            if ([aSwitch isOn])
            {
                [[Database GetInstance] setVerbRegular:aSwitch.value];
            }
            else
            {
                [[Database GetInstance] setVerbRegular:[NSNumber numberWithInt:-1]];
            }
            NSLog(@"Set Value: %@", [[Database GetInstance] verbRegular]);
            for (Switch *a in vrSwitches)
            {
                NSLog(@"Switch: %@", a.value);
                NSLog(@"On: %d", a.on);
                if (a.on == true && a.value != aSwitch.value)
                {
                    [a setOn:false animated:true];
                }
            }
            break;
            
        case 3:
            NSLog(@"Section: Gender");
            if ([aSwitch isOn])
            {
                if ([aSwitch.value isEqualToNumber:[NSNumber numberWithInt:0]])
                {
                    [[Database GetInstance] setGender:aSwitch.value];
                    [gSwitches[1] setOn:false animated:true];
                }
                else
                {
                    [[Database GetInstance] setGender:aSwitch.value];
                    [gSwitches[0] setOn:false animated:true];
                }
            }
            NSLog(@"Set Value: %@", [[Database GetInstance] gender]);
            break;
            
        case 4:
            NSLog(@"Section: ConjugationType");
            if ([[Database GetInstance] conjugationType] == nil)
            {
                NSLog(@"Nil");
                [Database GetInstance].conjugationType = [[NSMutableArray alloc]init];
            }
            if ([aSwitch isOn])
            {
                [[[Database GetInstance] conjugationType] addObject:aSwitch.value];
            }
            else
            {
                for (int i = 0; i < [[Database GetInstance] conjugationType].count; i++)
                {
                    if ([[Database GetInstance] conjugationType][i] == aSwitch.value)
                    {
                        [[[Database GetInstance] conjugationType] removeObjectAtIndex:i];
                    }
                }
            }
            NSLog(@"Size: %lu", (unsigned long)[[[Database GetInstance]conjugationType] count]);
            break;
            
        case 5:
            NSLog(@"Section: QuizType");
            if ([aSwitch isOn])
            {
                if ([aSwitch.value isEqualToNumber:[NSNumber numberWithInt:0]])
                {
                    [[Database GetInstance] setQuizType:aSwitch.value];
                    [qSwitches[1] setOn:false animated:true];
                }
                else
                {
                    [[Database GetInstance] setQuizType:aSwitch.value];
                    [qSwitches[0] setOn:false animated:true];
                    
                    for (Switch *a in wtSwitches)
                    {
                        [a setOn:false animated:true];
                    }
                    [[Database GetInstance] setWordType:[NSNumber numberWithInt:1]];
                    [wtSwitches[1] setOn:true animated:true];
                }
            }
            else
            {
                if ([aSwitch.value isEqualToNumber:[NSNumber numberWithInt:0]])
                {
                    [[Database GetInstance] setQuizType:[NSNumber numberWithInt:1]];
                    [qSwitches[1] setOn:true animated:true];
                    
                    for (Switch *a in wtSwitches)
                    {
                        [a setOn:false animated:true];
                    }
                    [[Database GetInstance] setWordType:[NSNumber numberWithInt:1]];
                    [wtSwitches[1] setOn:true animated:true];
                }
                else
                {
                    [[Database GetInstance] setQuizType:[NSNumber numberWithInt:0]];
                    [qSwitches[0] setOn:true animated:true];
                }
            }
            NSLog(@"Set Value: %@", [[Database GetInstance] quizType]);
            break;
            
        case 6:
            NSLog(@"Section: Translation");
            if ([aSwitch isOn])
            {
                if ([aSwitch.value isEqualToNumber:[NSNumber numberWithInt:0]])
                {
                    [[Database GetInstance] setTranslate:aSwitch.value];
                    [tSwitches[1] setOn:false animated:true];
                }
                else
                {
                    [[Database GetInstance] setTranslate:aSwitch.value];
                    [tSwitches[0] setOn:false animated:true];
                }
            }
            else
            {
                if ([aSwitch.value isEqualToNumber:[NSNumber numberWithInt:0]])
                {
                    [[Database GetInstance] setTranslate:[NSNumber numberWithInt:1]];
                    [tSwitches[1] setOn:true animated:true];
                }
                else
                {
                    [[Database GetInstance] setTranslate:[NSNumber numberWithInt:0]];
                    [tSwitches[0] setOn:true animated:true];
                }
            }
            NSLog(@"Set Value: %@", [[Database GetInstance] translate]);
            break;
    }
}

@end
