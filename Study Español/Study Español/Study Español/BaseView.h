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
    UIScreen *screen;
    UIView *header;
    UIView *grid;
    UIScrollView *content;
    UIInterfaceOrientation orientation;
    CGSize screenSize;
    Button *homeButton;
    Button *actionButton1;
    Button *actionButton2;
    Button *helpButton;
    int contentWidth;
    int contentHeight;
    int layout;
    
    @public
    id superID;
}
-(void)HeaderButtonPressed:(Button*)button;
-(void)SetActionButton:(int)button Title:(NSString*)title;
-(void)AdjustContent;
+(void)SetTextViewPosition:(CGPoint)textviewPosition;

@end
