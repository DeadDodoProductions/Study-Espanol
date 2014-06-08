//
//  WordSectionView.h
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordSectionView : UIView <UITextViewDelegate>
{
    
}
@property (readwrite, nonatomic) CGPoint truePosition;
- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout;

@end
