//
//  WordTagSectionView.h
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextView, SearchView;

@interface WordTagSectionView : UIView
{
    UITableView *tagTable;
    CGPoint truePosition;
    SearchView *aView;
    TextView *tagInput;
}
- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIViewController*)parentView Layout:(int)layout;
- (id)initSearchWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout;

@end
