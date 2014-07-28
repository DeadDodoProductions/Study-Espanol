//
//  SearchView.h
//  Study Español
//
//  Created by Evan on 4/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Home, WordTagSectionView;

@interface SearchView : UIScrollView <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    int rows;
    int columns;
    int layout;
    NSMutableArray *tags;
    NSArray *allTags;
    //UIScrollView *scrollView;
    CGRect startRect;
    CGPoint truePosition;
    Home *superHome;
    WordTagSectionView *wordTagSectionView;
}
- (id)initWithFrame:(CGRect)frame Home:(Home *)home;
-(void)NewTag:(NSString*)tag TagTable:(UITableView*)tagTable;
-(void)NewTag;

@end
