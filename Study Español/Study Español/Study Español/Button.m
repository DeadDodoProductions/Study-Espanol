//
//  Button.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  Overrides UIButton in order to provide one common place for assigning themes.

#import "Button.h"

@implementation Button
@synthesize screenLoc;
///Initilization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1]];
    }
    return self;
}


///Theme Methods
//sets the button's theme to the down theme
-(void)ButtonStateDown
{
    
}
//sets the button's theme to the up theme
-(void)ButtonStateUp
{
    
}
@end
