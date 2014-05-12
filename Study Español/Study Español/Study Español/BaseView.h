//
//  BaseView.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Button, Switch, ViewWord, ConjugationView, TextView, Word, Conjugation, Tag, ViewWord;

@interface BaseView : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate>
{
    @protected
    UIView *header;
    UIScrollView *content;
    UIView *grid;
    UIScreen *screen;
    UIInterfaceOrientation orientation;
    CGSize screenSize;
    Button *homeButton;
    Button *actionButton1;
    Button *actionButton2;
    Button *helpButton;
    int contentWidth;
    int contentHeight;
}
-(void)HeaderButtonPressed:(Button*)button;
-(void)SetActionButton:(int)button Title:(NSString*)title;

@end
