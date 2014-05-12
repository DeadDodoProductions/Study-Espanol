//
//  SearchView.h
//  Study Español
//
//  Created by Evan on 4/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Home;

@interface SearchView : UIView <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
{
    int rows;
    int columns;
    NSMutableArray *tags;
    UIScrollView *scrollView;
    CGRect startRect;
    int layout;
    Home *superHome;
}
-(void)NewTag:(NSString*)tag TagTable:(UITableView*)tagTable;
- (id)initWithFrame:(CGRect)frame Home:(Home*)home;

@end
