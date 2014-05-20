//
//  SwitchController.h
//  Study Español
//
//  Created by Evan Combs on 5/18/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwitchController : NSObject
{
    
}
@property (nonatomic, readwrite) NSMutableArray *switches;
@property (nonatomic, readwrite) NSMutableArray *wtSwitches;
@property (nonatomic, readwrite) NSMutableArray *veSwitches;
@property (nonatomic, readwrite) NSMutableArray *vrSwitches;
@property (nonatomic, readwrite) NSMutableArray *ctSwitches;
@property (nonatomic, readwrite) NSMutableArray *qSwitches;
@property (nonatomic, readwrite) NSMutableArray *tSwitches;
@property (nonatomic, readwrite) NSMutableArray *gSwitches;
+(SwitchController*)GetInstance;

@end
