//
//  Button.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Button : UIButton
{
    
}
@property (nonatomic, readwrite) CGPoint screenLoc;
-(void)ButtonStateDown;
-(void)ButtonStateUp;

@end
