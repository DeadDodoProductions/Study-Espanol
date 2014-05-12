//
//  Button.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "Button.h"

@implementation Button
@synthesize screenLoc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1]];
    }
    return self;
}

//sets the button's theme to the down theme
-(void)ButtonStateDown
{
    
}

//sets the button's theme to the up theme
-(void)ButtonStateUp
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
