//
//  TextField.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  Overrides UITextView in order to be used as a central place to apply themes to the Textviews.

#import "TextView.h"
#import "BaseView.h"

@implementation TextView
@synthesize screenPosition;
///Initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[self layer] setBorderWidth:1.0f];
        [[self layer] setBorderColor:[[UIColor grayColor] CGColor]];
    }
    return self;
}
@end
