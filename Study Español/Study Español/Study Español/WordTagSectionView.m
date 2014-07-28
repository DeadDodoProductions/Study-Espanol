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
@synthesize truePosition, delegate;

- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIViewController<UITableViewDelegate, UITableViewDataSource>*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
    {
        tableViewDelegate = parentView;
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
        
        removeButton = [[Button alloc]initWithFrame:CGRectMake(5, tag.frame.origin.y + 5 + tag.frame.size.height, self.frame.size.width * .5 - 10, 30)];
        [removeButton setTitle:@"Remove" forState:UIControlStateNormal];
        [removeButton addTarget:self action:@selector(RemoveTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:removeButton];
        
        addButton = [[Button alloc]initWithFrame:CGRectMake(removeButton.frame.size.width + 10, removeButton.frame.origin.y, self.frame.size.width * .5 - 10, 30)];
        [addButton setTitle:@"Add" forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(AddTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        
        if (layout == iPhone)
        {
            tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, self.frame.size.width - 10, 250)];
        }
        else
        {
            tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, self.frame.size.width - 10, 321)];
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
        tableViewDelegate = parentView;
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
        
        Button *clearButton = [[Button alloc]initWithFrame:CGRectMake(tagInput.frame.size.width + tagInput.frame.origin.x + 3, 40, 25, 30)];
        [clearButton setTitle:@"X" forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(ClearTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearButton];
        
        removeButton = [[Button alloc]initWithFrame:CGRectMake(5, tag.frame.origin.y + 5 + tag.frame.size.height, self.frame.size.width * .5 - 10, 30)];
        [removeButton setTitle:@"Remove" forState:UIControlStateNormal];
        [removeButton addTarget:self action:@selector(RemoveTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:removeButton];
        
        addButton = [[Button alloc]initWithFrame:CGRectMake(removeButton.frame.size.width + 10, removeButton.frame.origin.y, self.frame.size.width * .5 - 10, 30)];
        [addButton setTitle:@"Add" forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(AddTag) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        
        if (layout == iPhone)
        {
            tagTable = [[UITableView alloc]initWithFrame:CGRectMake(5, addButton.frame.origin.y + addButton.frame.size.height + 5, self.frame.size.width - 10, 250)];
        }
        else if (layout == iPadPortrait)
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
    NSLog(@"WordTagSectionView: TextViewDidBeginEditing");
    [BaseView SetTextViewPosition:CGPointMake(truePosition.x + textView.frame.origin.x, truePosition.y + textView.frame.origin.y + textView.frame.size.height + 10)];
    
    if([textView tag] == 1)
    {
        if (tagSearchTable == nil)
        {
            [self CreateTagHintList:textView];
        }
        [removeButton addTarget:self action:@selector(HideTableView) forControlEvents:UIControlEventTouchUpInside];
        [addButton addTarget:self action:@selector(HideTableView) forControlEvents:UIControlEventTouchUpInside];
        if ([tagSearchTable isHidden])
        {
            [self ChangeLayoutPositions:30];
        }
        [tagSearchTable setHidden:false];
        
        tagsArray = [[Database GetInstance] SearchForTags];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"WordTagSectionView: TextViewDidChange");
    if([textView tag] == 1)
    {
        if ([tagSearchTable isHidden] || tagSearchTable == nil)
        {
            [self CreateTagHintList:textView];
        }
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
        [tagSearchTable setFrame:CGRectMake(textView.frame.origin.x + 1, textView.frame.origin.y + textView.frame.size.height, textView.frame.size.width - 2, 30)];
        [tagSearchTable reloadData];
    }
}

-(bool)CompareStrings:(NSString*)stringA StringB:(NSString*)stringB
{
    NSLog(@"WordTagSectionView: CompareStrings");
    NSRange range = [stringB rangeOfString:stringA options:NSCaseInsensitiveSearch];
    if (range.length != 0)
    {
        return true;
    }
    return false;
}

-(void)ClearTag
{
    NSLog(@"WordTagSectionView: ClearTag");
    [self HideTableView];
    [tagInput setText:@""];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"WordTagSectionView: TableView NumberOfRowsInSection");
    return [tagOptions count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"WordTagSectionView: TableView CellForRowAtIndexPath");
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI * 0.5);
    UILabel *label = [[UILabel alloc]init];
    [label setTransform:rotate];
    [label setFrame:CGRectMake(0, 0, 30, [tableView rowHeight])];
    [label setText:[NSString stringWithFormat:@"%@", tagOptions[indexPath.row]]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Arial" size:12]];
    [label setBackgroundColor:[UIColor whiteColor]];
    [cell addSubview:label];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"WordTagSectionView: TableView DidSelectRowAtIndexPath");
    NSLog(@"Cell Pressed %ul", indexPath.row);
    NSLog(@"%@", tagOptions);
    //got an error at this point, wasn't able to duplicate!
    [tagInput setText:tagOptions[indexPath.row]];
    [self AddTag];
    [self HideTableView];
}

-(void)HideTableView
{
    NSLog(@"WordTagSectionView: HideTableView");
    if (![tagSearchTable isHidden])
    {
        [tagOptions removeAllObjects];
        [tagSearchTable setHidden:true];
        [self ChangeLayoutPositions:-30];
    }
}

-(void)ChangeLayoutPositions:(int)a
{
    NSLog(@"WordTagSectionView: ChangeLayoutPositions");
    [removeButton setFrame:CGRectMake(removeButton.frame.origin.x, removeButton.frame.origin.y + a, removeButton.frame.size.width, removeButton.frame.size.height)];
    [addButton setFrame:CGRectMake(addButton.frame.origin.x, addButton.frame.origin.y + a, addButton.frame.size.width, addButton.frame.size.height)];
    [tagTable setFrame:CGRectMake(tagTable.frame.origin.x, tagTable.frame.origin.y + a, tagTable.frame.size.width, tagTable.frame.size.height - a)];
}

-(void)AddTag
{
    [delegate AddTag:[tagInput text]];
    [tagInput setText:@""];
}
-(void)RemoveTag
{
    [delegate RemoveTag];
}

-(void)CreateTagHintList:(UITextView*)textView
{
    //turn this into a horizontal table
    tagSearchTable = [[UITableView alloc]init];
    CGAffineTransform rotateTable = CGAffineTransformMakeRotation(-M_PI_2);
    tagSearchTable.transform = rotateTable;
    [tagSearchTable setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, 0)];
    [tagSearchTable setRowHeight:textView.frame.size.width * 0.3334];
    [tagSearchTable setTag:1];
    [tagSearchTable setDelegate:self];
    [tagSearchTable setDataSource:self];
    [self addSubview:tagSearchTable];
    [self ChangeLayoutPositions:30];
}
@end
