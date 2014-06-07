//
//  TextField.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextView : UITextView <UITextFieldDelegate>
{
}
@property (nonatomic, readwrite) CGPoint screenPosition;
-(void)SettingPosition;

@end