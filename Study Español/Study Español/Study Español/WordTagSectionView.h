//
//  WordTagSectionView.h
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextView, SearchView, Button;

@protocol WordTagSectionDelagate<NSObject>
-(void)AddTag:(NSString*)tag;
-(void)RemoveTag;
@end

@interface WordTagSectionView : UIView <UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSArray *tagsArray;
    NSMutableArray *tagOptions;
    UITableView *tagTable;
    UITableView *tagSearchTable;
    id<UITableViewDelegate, UITableViewDataSource> tableViewDelegate;
    SearchView *aView;
    TextView *tagInput;
    Button *removeButton;
    Button *addButton;
}
@property (readwrite, nonatomic) CGPoint truePosition;
@property (readwrite, nonatomic) id<WordTagSectionDelagate> delegate;
- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIViewController*)parentView Layout:(int)layout;
- (id)initSearchWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout;
-(void)ClearTag;

@end
