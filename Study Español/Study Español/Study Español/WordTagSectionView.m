//
//  WordTagSectionView.m
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "WordTagSectionView.h"
#import "TextView.h"
#import "Button.h"
#import "BaseView.h"
#import "Database.h"
#import "Tag.h"

@implementation WordTagSectionView
@synthesize truePosition;

- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIViewController<UITableViewDelegate, UITableViewDataSource>*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"Creating Tag Section");
        truePosition = CGPointMake(parentView.view.frame.origin.x + self.frame.origin.x, parentView.view.frame.origin.y + self.frame.origin.y);
        NSLog(@"Creating Word and Tag Section");
        UILabel *tag = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width * .15, 30)];
        [tag setText:@"Tag"];
        [self addSubview:tag];
        
        tagInput = [[TextView alloc]initWithFrame:CGRectMake(self.frame.size.width * .15 + 10, 5, self.frame.size.width * .85 - 40, 30)];
        [tagInput setTag:1];
        [tagInput setDelegate:self];
        [self addSubview:tagInput];
        
        Button *clearButton = [[Button alloc]initWithFrame:CGRectMake(tagInput.frame.size.width + tagInput.frame.origin.x + 5, 5, 25, 30)];
        [clearButton setTitle:@"X" forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(ClearTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearButton];
        
        Button *removeButton = [[Button alloc]initWithFrame:CGRectMake(5, tag.frame.origin.y + 5 + tag.frame.size.height, self.frame.size.width * .5 - 10, 30)];
        [removeButton setTitle:@"Remove" forState:UIControlStateNormal];
        [removeButton addTarget:parentView action:@selector(RemoveTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:removeButton];
        
        Button *addButton = [[Button alloc]initWithFrame:CGRectMake(removeButton.frame.size.width + 10, removeButton.frame.origin.y, self.frame.size.width * .5 - 10, 30)];
        [addButton setTitle:@"Add" forState:UIControlStateNormal];
        [addButton addTarget:parentView action:@selector(NewTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        
        if (layout == 2)
        {
            tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, self.frame.size.width - 10, 250)];
        }
        else
        {
            tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, self.frame.size.width - 10, 318)];
        }
        [tagTable setDelegate:parentView];
        [tagTable setDataSource:parentView];
        [self addSubview:tagTable];
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, tagTable.frame.origin.y + tagTable.frame.size.height + 5)];
    }
    return self;
}

- (id)initSearchWithFrame:(CGRect)frame ParentView:(UIView<UITableViewDelegate, UITableViewDataSource>*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"Creating Word and Tag Section");
        truePosition = CGPointMake(parentView.frame.origin.x + self.frame.origin.x, parentView.frame.origin.y + self.frame.origin.y);
        UILabel *word = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width * .15, 30)];
        [word setText:@"Word"];
        [self addSubview:word];
        
        TextView *wordInput = [[TextView alloc]initWithFrame:CGRectMake(self.frame.size.width * .15 + 10, 5, self.frame.size.width * .85 - 15, 30)];
        [wordInput setDelegate:self];
        [self addSubview:wordInput];
        
        
        UILabel *tag = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, self.frame.size.width * .15, 30)];
        [tag setText:@"Tag"];
        [self addSubview:tag];
        
        tagInput = [[TextView alloc]initWithFrame:CGRectMake(self.frame.size.width * .15 + 10, 40, self.frame.size.width * .85 - 40, 30)];
        [tagInput setTag:1];
        [tagInput setDelegate:self];
        [self addSubview:tagInput];
        
        Button *clearButton = [[Button alloc]initWithFrame:CGRectMake(tagInput.frame.size.width + tagInput.frame.origin.x + 5, 40, 25, 30)];
        [clearButton setTitle:@"X" forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(ClearTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearButton];
        
        Button *removeButton = [[Button alloc]initWithFrame:CGRectMake(5, tag.frame.origin.y + 5 + tag.frame.size.height, self.frame.size.width * .5 - 10, 30)];
        [removeButton setTitle:@"Remove" forState:UIControlStateNormal];
        [removeButton addTarget:parentView action:@selector(RemoveTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:removeButton];
        
        Button *addButton = [[Button alloc]initWithFrame:CGRectMake(removeButton.frame.size.width + 10, removeButton.frame.origin.y, self.frame.size.width * .5 - 10, 30)];
        [addButton setTitle:@"Add" forState:UIControlStateNormal];
        [addButton addTarget:parentView action:@selector(NewTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        
        if (layout == 2)
        {
            tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, self.frame.size.width - 10, 250)];
        }
        else if (layout == 0)
        {
            tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, self.frame.size.width - 10, 349)];
        }
        else
        {
            tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, self.frame.size.width - 10, 439)];
        }
        [tagTable setDelegate:parentView];
        [tagTable setDataSource:parentView];
        [self addSubview:tagTable];
    }
    return self;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [BaseView SetTextViewPosition:CGPointMake(truePosition.x + textView.frame.origin.x, truePosition.y + textView.frame.origin.y + textView.frame.size.height + 10)];
    
    if([textView tag] == 1)
    {
        if (tagSearchTable == nil)
        {
            tagSearchTable = [[UITableView alloc]init];
            [tagSearchTable setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, 0)];
            [tagSearchTable setDelegate:self];
            [tagSearchTable setDataSource:self];
            [self addSubview:tagSearchTable];
        }
        [tagSearchTable setHidden:false];
        
        tagsArray = [[Database GetInstance] SearchForTags];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    if([textView tag] == 1)
    {
        NSString* text = [textView text];
        tagOptions = [[NSMutableArray alloc]init];
        for (int i = 0; i < tagsArray.count; i++)
        {
            Tag *tag = tagsArray[i];
            NSString* name = [tag tag];
            if ([self CompareStrings:text StringB:name] || text.length == 0)
            {
                [tagOptions addObject:name];
            }
        }
        
        int height = tagOptions.count;
        if (height > 3)
        {
            height = 3;
        }
        [tagSearchTable setFrame:CGRectMake(textView.frame.origin.x + 1, textView.frame.origin.y, textView.frame.size.width - 2, -44 * height)];
        [tagSearchTable reloadData];
        int size = tagOptions.count - 1;
        if (size >= 0)
        {
            [tagSearchTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:size inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:false];
        }
    }
}

-(bool)CompareStrings:(NSString*)stringA StringB:(NSString*)stringB
{
    NSRange range = [stringB rangeOfString:stringA options:NSCaseInsensitiveSearch];
    if (range.length != 0)
    {
        NSLog(@"%lu, %lu", (unsigned long)range.location, (unsigned long)range.length);
        return true;
    }
    return false;
}

-(void)ClearTag
{
    [tagOptions removeAllObjects];
    [tagSearchTable setHidden:true];
    [tagInput setText:@""];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //returns the amount of objects to be in the table
    return [tagOptions count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    //int a = tagOptions.count - indexPath.row - 1;
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@", tagOptions[indexPath.row]]];
    return cell;
}
@end
