//
//  WordTagSection.m
//  Study Español
//
//  Created by Evan on 4/20/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This view is used by the AddEditView and SearchView classes.
//  It creates an interface for adding and deleting tags from words and searches

#import "WordTagSection.h"
#import "SearchView.h"
#import "TextView.h"
#import "Switch.h"
#import "Button.h"


@implementation WordTagSection
-(void)CreateSearchSection:(UIView*)view SuperView:(UIView*)superView Layout:(int)layout
{
    NSLog(@"Creating Word and Tag Section");
    aView = view;
    UILabel *word = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, view.frame.size.width * .15, 30)];
    [word setText:@"Word"];
    [view addSubview:word];
    
    TextView *wordInput = [[TextView alloc]initWithFrame:CGRectMake(view.frame.size.width * .15 + 10, 5, view.frame.size.width * .85 - 15, 30)];
    [wordInput setDelegate:superView];
    [view addSubview:wordInput];
    
    
    UILabel *tag = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, view.frame.size.width * .15, 30)];
    [tag setText:@"Tag"];
    [view addSubview:tag];
    
    tagInput = [[TextView alloc]initWithFrame:CGRectMake(view.frame.size.width * .15 + 10, 40, view.frame.size.width * .85 - 15, 30)];
    [view addSubview:tagInput];
    
    Button *removeButton = [[Button alloc]initWithFrame:CGRectMake(5, tag.frame.origin.y + 5 + tag.frame.size.height, view.frame.size.width * .5 - 10, 30)];
    [removeButton setTitle:@"Remove" forState:UIControlStateNormal];
    [removeButton addTarget:superView action:@selector(RemoveTag) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:removeButton];
    
    Button *addButton = [[Button alloc]initWithFrame:CGRectMake(removeButton.frame.size.width + 10, removeButton.frame.origin.y, view.frame.size.width * .5 - 10, 30)];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [addButton addTarget:superView action:@selector(NewTag) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addButton];
    
    if (layout == 2)
    {
        tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, view.frame.size.width - 10, 250)];
    }
    else if (layout == 0)
    {
        tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, view.frame.size.width - 10, 349)];
    }
    else
    {
        tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, view.frame.size.width - 10, 439)];
    }
    [tagTable setDelegate:superView];
    [tagTable setDataSource:superView];
    [view addSubview:tagTable];
}

-(void)NewTag:(Button*)button
{
    [aView NewTag:tagInput.text TagTable:tagTable];
}

-(void)CreateAddEditSection:(UIView*)view SuperView:(UIViewController*)superView Layout:(int)layout
{
    NSLog(@"Creating Tag Section");
    //[self CreateSearchSection:view SuperView:superView Layout:layout];
    NSLog(@"Creating Word and Tag Section");
    UILabel *tag = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, view.frame.size.width * .15, 30)];
    [tag setText:@"Tag"];
    [view addSubview:tag];
    tagInput = [[TextView alloc]initWithFrame:CGRectMake(view.frame.size.width * .15 + 10, 5, view.frame.size.width * .85 - 15, 30)];
    [view addSubview:tagInput];
    
    Button *removeButton = [[Button alloc]initWithFrame:CGRectMake(5, tag.frame.origin.y + 5 + tag.frame.size.height, view.frame.size.width * .5 - 10, 30)];
    [removeButton setTitle:@"Remove" forState:UIControlStateNormal];
    [removeButton addTarget:superView action:@selector(RemoveTag) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:removeButton];
    
    Button *addButton = [[Button alloc]initWithFrame:CGRectMake(removeButton.frame.size.width + 10, removeButton.frame.origin.y, view.frame.size.width * .5 - 10, 30)];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [addButton addTarget:superView action:@selector(NewTag) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addButton];
    
    if (layout == 2)
    {
        tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, view.frame.size.width - 10, 250)];
    }
    else
    {
        tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, view.frame.size.width - 10, 321)];
    }
    [tagTable setDelegate:superView];
    [tagTable setDataSource:superView];
    [view addSubview:tagTable];
}

@end
