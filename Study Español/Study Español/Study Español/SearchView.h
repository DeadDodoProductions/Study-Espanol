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
    int layout;
    NSMutableArray *tags;
    UIScrollView *scrollView;
    CGRect startRect;
    Home *superHome;
}
-(id)initWithFrame:(CGRect)frame Home:(Home*)home;
-(void)NewTag:(NSString*)tag TagTable:(UITableView*)tagTable;

@end
