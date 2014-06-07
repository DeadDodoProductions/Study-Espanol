//
//  VerbTypeSectionView.h
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerbTypeSectionView : UIView
{
    int titleSpace2;
    int switchSpace;
    int titleSpace;
}
- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout;
- (id)initSearchWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout;
@end
