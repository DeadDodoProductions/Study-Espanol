//
//  QuizVocab.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "QuizVocab.h"
#import "QuizVocabCell.h"
#import "Utilities.h"
#import "Database.h"
#import "Word.h"
#import "QuizAnswer.h"

@interface QuizVocab ()

@end

@implementation QuizVocab

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
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)CreateGUI
{
    NSLog(@"Creating Vocab Quiz");
    [self SetActionButton:1 Title:@"Done"];
    
    layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setMinimumInteritemSpacing:2.0f];
    [layout setMinimumLineSpacing:2.0f];
    [self SetCellWidth];
    
    
    UICollectionView *newView = [[UICollectionView alloc]initWithFrame:CGRectMake(2, 2, contentWidth - 4, contentHeight - 4) collectionViewLayout:layout];
    [newView setDelegate:self];
    [newView setDataSource:self];
    [newView setBackgroundColor:[UIColor whiteColor]];
    [newView registerClass:[QuizVocabCell class] forCellWithReuseIdentifier:@"QuizVocabCell"];
    [content addSubview:newView];
}

-(void)CompareAnswers
{
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[Database GetInstance] words] count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QuizVocabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuizVocabCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor grayColor]];
    Word *aWord = [[Database GetInstance] words][indexPath.row];
    int a = (int)[[Database GetInstance] translate];
    if (a == 0)
    {
        [[cell wordLabel] setText:[aWord spanish]];
    }
    else
    {
        [[cell wordLabel] setText:[aWord english]];
    }
    return cell;
}

-(void)SetCellWidth
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *string = [Utilities GetDevice];
    if ([string isEqualToString:@"iPad"])
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPad Portrait");
            [layout setItemSize:CGSizeMake((contentWidth - 4) * .498, 40)];
        }
        else
        {
            NSLog(@"iPad Landscape");
            [layout setItemSize:CGSizeMake((contentWidth - 4) * .332, 40)];
        }
    }
    else
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPhone Portrait");
            [layout setItemSize:CGSizeMake(contentWidth - 4, 40)];
        }
        else
        {
            NSLog(@"iPhone Landscape");
            [layout setItemSize:CGSizeMake((contentWidth - 4) * .497, 40)];
        }
    }
}

-(void)ActionButtonPressed:(Button*)button
{
    QuizAnswer *quizAnswer;
    quizAnswer = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizAnswer"];
    [self presentViewController:quizAnswer animated:false completion:nil];
}

@end
