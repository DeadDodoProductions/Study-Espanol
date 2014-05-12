//
//  VerbTypeSection.h
//  Study Español
//
//  Created by Evan on 4/20/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerbTypeSection : NSObject
{
    int titleSpace2;
    int switchSpace;
    int titleSpace;
}
-(void)CreateSearchSection:(UIView*)view SuperView:(UIView*)superView Layout:(int)layout;
-(void)CreateAddEditSection:(UIView*)view SuperView:(UIViewController*)superView Layout:(int)layout;

@end
