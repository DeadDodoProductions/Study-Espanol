//
//  Switch.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  group holds the integer associated with related switches
//  value holds the integer representing the value the switch represents

#import <UIKit/UIKit.h>

@interface Switch : UISwitch
{

}
@property (nonatomic, readwrite) int group;
@property (nonatomic, readwrite) NSNumber *value;
@property (nonatomic, readwrite) CGPoint screenLoc;
-(void)SwitchWasPressed;

@end
