//
//  QuizAnswer.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  Displays and controls the QuizAnswers view
//  This class allows the user to see how well they performed on the Vocab or Conjugation quiz they completed

#import "QuizAnswer.h"
#import "AddEditView.h"

#import "QuizAnswerCell.h"

#import "Word.h"
#import "Button.h"
#import "Database.h"

#import "Utilities.h"

@interface QuizAnswer ()

@end

@implementation QuizAnswer

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
-(void)SetArraysForVocab:(NSArray*)_words Answers:(NSArray*)_answers
{
    words = [[NSArray alloc]initWithArray:_words];
    answers = [[NSArray alloc]initWithArray:_answers];
    total = [[[Database GetInstance] words] count];
}
-(void)SetArraysForConjugation:(NSArray*)_words Tense:(NSArray*)_tense Correct:(NSArray*)_correct Answers:(NSArray*)_answers Total:(int)_total
{
    words = [[NSArray alloc]initWithArray:_words];
    answers = [[NSArray alloc]initWithArray:_answers];
    tenses = [[NSArray alloc]initWithArray:_tense];
    corrections = [[NSArray alloc]initWithArray:_correct];
    total = _total;
}
-(void)SetCellSize
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *string = [Utilities GetDevice];
    int height = 40;
    if (tenses != 0)
    {
        height = 60;
    }
    if ([string isEqualToString:@"iPad"])
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPad Portrait");
            [flow setItemSize:CGSizeMake((contentWidth - 4) * .498, height)];
        }
        else
        {
            NSLog(@"iPad Landscape");
            [flow setItemSize:CGSizeMake((contentWidth - 4) * .332, height)];
        }
    }
    else
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPhone Portrait");
            [flow setItemSize:CGSizeMake(contentWidth - 4, height)];
        }
        else
        {
            NSLog(@"iPhone Landscape");
            [flow setItemSize:CGSizeMake((contentWidth - 4) * .497, height)];
        }
    }
}


///User Interface
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self CreateGUI];
}
-(void)CreateGUI
{
    int correct = total - [answers count];
    int percentage = (int)(100 * (correct / total));
    int headerHeight = contentHeight * .05;
    
    UILabel *headerLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (contentWidth * .5) - 5, headerHeight)];
    [headerLabel1 setText:[NSString stringWithFormat:@"%d / %d", correct, total]];
    [headerLabel1 setTextAlignment:NSTextAlignmentRight];
    [content addSubview:headerLabel1];
    
    UILabel *headerLabel2 = [[UILabel alloc]initWithFrame:CGRectMake((contentWidth * .5) + 5, 0, contentWidth * .5, headerHeight)];
    [headerLabel2 setText:[NSString stringWithFormat:@"%d%%", percentage]];
    [headerLabel2 setTextAlignment:NSTextAlignmentLeft];
    [content addSubview:headerLabel2];
    
    flow = [[UICollectionViewFlowLayout alloc]init];
    [flow setMinimumInteritemSpacing:2.0f];
    [flow setMinimumLineSpacing:2.0f];
    [self SetCellSize];
    
    wordCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(2, headerHeight + 2, contentWidth - 4, contentHeight - (headerHeight + 4)) collectionViewLayout:flow];
    [wordCollectionView setDelegate:self];
    [wordCollectionView setDataSource:self];
    [wordCollectionView setBackgroundColor:[UIColor whiteColor]];
    [wordCollectionView registerClass:[QuizAnswerCell class] forCellWithReuseIdentifier:@"QuizAnswerCell"];
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
    return [answers count];
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QuizAnswerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuizAnswerCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor grayColor]];
    if ([tenses count] == 0)
    {
        if ([[[Database GetInstance] translate] isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            [cell CreateCell:[words[indexPath.row] spanish] Answer:answers[indexPath.row] Correction:[words[indexPath.row] english]];
        }
        else
        {
            [cell CreateCell:[words[indexPath.row] english] Answer:answers[indexPath.row] Correction:[words[indexPath.row] spanish]];
        }
    }
    else
    {
        [cell CreateCell:words[indexPath.row] Tense:tenses[indexPath.row] Answer:answers[indexPath.row] Correction:corrections[indexPath.row]];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did Select Cell");
    Word *word = words[indexPath.row];
    [[Database GetInstance] setActiveWord:word];
    int x = [[collectionView subviews][indexPath.row] frame].origin.x;
    int y = [[collectionView subviews][indexPath.row] frame].origin.y;
    int h = [[collectionView subviews][indexPath.row] frame].size.height;
    [viewWord setFrame:CGRectMake(x + 2, y + h + [collectionView frame].origin.y, flow.itemSize.width, 0)];
    [viewWord SetDelegate:self];
    [viewWord CreateWordView:word];
    
    [super SetActionButton:1 Title:@"Edit"];
    [super SetActionButton:2 Title:@"Delete"];
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [actionButton1 setHidden:true];
    [actionButton2 setHidden:true];
}


//ViewWord Delagates
-(void)ViewWordDissmiss:(ViewWord *)wordView
{
    [actionButton1 setHidden:true];
    [actionButton2 setHidden:true];
}
@end
