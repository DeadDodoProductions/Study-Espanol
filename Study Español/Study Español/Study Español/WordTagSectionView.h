//
//  WordTagSectionView.h
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextView, SearchView;

@interface WordTagSectionView : UIView <UITextFieldDelegate>
{
    UITableView *tagTable;
    SearchView *aView;
    TextView *tagInput;
}
@property (readwrite, nonatomic) CGPoint truePosition;
- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIViewController*)parentView Layout:(int)layout;
- (id)initSearchWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout;

@end
