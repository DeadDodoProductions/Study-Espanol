//
//  Utilities.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Word;

@interface Utilities : NSObject
{
}
@property (nonatomic, readwrite) NSString *curView;
@property (nonatomic, readwrite) Word *curWord;
+(void)KeyboardInView;
+(void)KeyboardOffView;
+(NSString*)GetDevice;

@end
