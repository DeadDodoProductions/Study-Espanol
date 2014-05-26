//
//  ViewWord.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  When a word is selected in WordList of QuizAnswers this view will popup showing the user all of the information about the selected word

#import <UIKit/UIKit.h>

@class Word;

@interface ViewWord : UIView <UITableViewDataSource, UITableViewDelegate>
{
    id theDelegate;
    NSMutableArray *conjugationArray;
    NSArray *tagArray;
    UITableView *tagsTable;
    UITableView *conjugationTable;
}
-(void)CreateWordView:(Word*)word;
-(void)SetDelegate:(id)delegate;

@end

@protocol ViewWordDelagate<NSObject>
@optional
-(void)ViewWordDissmiss:(ViewWord*)wordView;
@end
