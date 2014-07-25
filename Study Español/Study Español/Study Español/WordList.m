//
//  WordList.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  Displays and controls the WordList view.
//  The Word List allows the user to search for words and displays them in a list to be viewed all at once.
//  The user can then select a word to view the information that has been provided for the word, delete the word, or edit the word's information

#import "WordList.h"
#import "AddEditView.h"

#import "WordListCell.h"
#import "ConjugationWordViewCell.h"
#import "ViewWord.h"

#import "Word.h"
#import "Conjugation.h"

#import "Button.h"

#import "Utilities.h"
#import "Database.h"

@interface WordList ()

@end

@implementation WordList
///Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CreateGUI];
    viewWord = [[ViewWord alloc]init];
    [content addSubview:viewWord];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)SetCellWidth
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *string = [Utilities GetDevice];
    float width;
    if ([string isEqualToString:@"iPad"])
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPad Portrait");
            width = roundf((contentWidth - 4) * .498);
        }
        else
        {
            NSLog(@"iPad Landscape");
            width = roundf((contentWidth - 4) * .331);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPhone Portrait");
            width = roundf((contentWidth - 4));
        }
        else
        {
            NSLog(@"iPhone Landscape");
            width = roundf((contentWidth - 4) * .497);
        }
    }
    [flow setItemSize:CGSizeMake(width, 40)];
    NSLog(@"Cell Width: %f", [flow itemSize].width);
}


///User Interface
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self CreateGUI];
}
-(void)CreateGUI
{
    flow = [[UICollectionViewFlowLayout alloc]init];
    [flow setMinimumInteritemSpacing:2.0f];
    [flow setMinimumLineSpacing:2.0f];
    [self SetCellWidth];
    

    wordCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(2, 2, contentWidth - 4, contentHeight - 4) collectionViewLayout:flow];
    [wordCollectionView setDelegate:self];
    [wordCollectionView setDataSource:self];
    [wordCollectionView setBackgroundColor:[UIColor whiteColor]];
    [wordCollectionView registerClass:[WordListCell class] forCellWithReuseIdentifier:@"WordListCell"];
    [wordCollectionView setTag:1];
    [content addSubview:wordCollectionView];
}


///User Interactions
-(void)ActionButtonPressed:(Button*)button
{
    [viewWord setHidden:true];
    [actionButton1 setHidden:true];
    [actionButton2 setHidden:true];
    if (button.tag == 2)
    {
        NSLog(@"Edit(Action1) Button Pressed");
        AddEditView *addEditView = [self.storyboard instantiateViewControllerWithIdentifier:@"AddEditView"];
        [addEditView setEditingWord:true];
        [self presentViewController:addEditView animated:false completion:nil];
    }
    else
    {
        NSLog(@"Delete(Action2) Button Pressed");
        //This should delete the word from the database and the table datasource then refresh the table
        NSLog(@"Word Count Before Deletion: %lu", (unsigned long)[[[Database GetInstance] words] count]);
        for (Word *a in [[Database GetInstance] words])
        {
            if ([a isEqual:[Database GetInstance].activeWord])
            {
                NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[Database GetInstance].words];
                [array removeObject:a];
                [[Database GetInstance] setWords:array];
            }
        }
        [[Database GetInstance] Delete];
        NSLog(@"Word Count After Deletion: %lu", (unsigned long)[[[Database GetInstance] words] count]);
        [wordCollectionView reloadData];
    }
}


///UICollectionView Delagates
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[Database GetInstance] words] count];
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WordListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WordListCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor grayColor]];
    //English and Espanol will come from the List of Words located in a Singleton/Static class
    Word *aWord = [[Database GetInstance] words][indexPath.row];
    NSLog(@"%ld: %@ - %@", (long)indexPath.row, [aWord english], [aWord spanish]);
    [[cell cellLabel] setText:[NSString stringWithFormat:@"%@ -- %@", [aWord english], [aWord spanish]]];
    [[cell cellLabel] setTextAlignment:NSTextAlignmentCenter];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Word Selected: %ld", (long)indexPath.row);
    Word *word = [Database GetInstance].words[indexPath.row];
    [[Database GetInstance] setActiveWord:word];
    NSLog(@"Active Word: %@", [[[Database GetInstance] activeWord] english]);
    int index = indexPath.row;
    if (index >= 50)
    {
        int a = index / 50;
        index = index - (50 * a);
    }
    //use a math equation to determine if the word is in the first row, second row, or third row
    int x = [[collectionView subviews][index] frame].origin.x;
    int y = [[collectionView subviews][index] frame].origin.y;
    int h = [[collectionView subviews][index] frame].size.height;
    NSLog(@"ViewWord Frame: X: %d Y: %d", x, y);
    [viewWord setFrame:CGRectMake(x + 2, y + h  - collectionView.contentOffset.y, flow.itemSize.width, 0)];
    [viewWord setStartFrame:CGRectMake(x, y, viewWord.frame.size.width, viewWord.frame.size.height)];
    [viewWord SetDelegate:self];
    [viewWord CreateWordView:word];
    
    NSLog(@"%f", y + h - collectionView.contentOffset.y + viewWord.frame.size.height);
    NSLog(@"%f", collectionView.frame.size.height);
    if (y + h - collectionView.contentOffset.y + viewWord.frame.size.height >= collectionView.frame.size.height)
    {
        [collectionView setContentOffset:CGPointMake(0, ((y + h - collectionView.contentOffset.y + viewWord.frame.size.height) - collectionView.frame.size.height) + collectionView.contentOffset.y) animated:true];
    }
    
    [super SetActionButton:1 Title:@"Edit"];
    [super SetActionButton:2 Title:@"Delete"];
    NSLog(@"Word View Created");
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [actionButton1 setHidden:true];
    [actionButton2 setHidden:true];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1)
    {
        [viewWord setFrame:CGRectMake(viewWord.frame.origin.x, viewWord.startFrame.origin.y + 40 - wordCollectionView.contentOffset.y, viewWord.frame.size.width, viewWord.frame.size.height)];
    }
}


//ViewWord Delagates
-(void)ViewWordDissmiss:(ViewWord *)wordView
{
    [actionButton1 setHidden:true];
    [actionButton2 setHidden:true];
}
@end
