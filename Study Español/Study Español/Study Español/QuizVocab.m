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
#import "TextView.h"

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
    textFields = [[NSMutableArray alloc]init];
    for (int i = 0; i < [[[Database GetInstance] words] count]; i++)
    {
        [textFields addObject:@""];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



///Creates the User Interface
-(void)CreateGUI
{
    NSLog(@"Creating Vocab Quiz");
    [self SetActionButton:1 Title:@"Done"];
    
    flow = [[UICollectionViewFlowLayout alloc]init];
    [flow setMinimumInteritemSpacing:2.0f];
    [flow setMinimumLineSpacing:2.0f];
    [self SetCellWidth];
    
    
    UICollectionView *newView = [[UICollectionView alloc]initWithFrame:CGRectMake(2, 2, contentWidth - 4, contentHeight - 4) collectionViewLayout:flow];
    [newView setDelegate:self];
    [newView setDataSource:self];
    [newView setBackgroundColor:[UIColor whiteColor]];
    [newView registerClass:[QuizVocabCell class] forCellWithReuseIdentifier:@"QuizVocabCell"];
    [content addSubview:newView];
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
            [flow setItemSize:CGSizeMake((contentWidth - 4) * .498, 40)];
        }
        else
        {
            NSLog(@"iPad Landscape");
            [flow setItemSize:CGSizeMake((contentWidth - 4) * .332, 40)];
        }
    }
    else
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPhone Portrait");
            [flow setItemSize:CGSizeMake(contentWidth - 4, 40)];
        }
        else
        {
            NSLog(@"iPhone Landscape");
            [flow setItemSize:CGSizeMake((contentWidth - 4) * .497, 40)];
        }
    }
}



///User Interaction
//compares the answers placing the wrong answers in arrays to be sent to QuizAnswers
-(void)ActionButtonPressed:(Button*)button
{
    NSMutableArray *words = [[NSMutableArray alloc]init];
    NSMutableArray *answers = [[NSMutableArray alloc]init];
    for (int i = 0; i < [[[Database GetInstance] words] count]; i++)
    {
        Word *word = [[Database GetInstance] words][i];
        NSLog(@"%@ -- %@ -- %@", [word english], [word spanish], textFields[i]);
        if (![[[word english] uppercaseString] isEqualToString:[textFields[i] uppercaseString]] && ![[[word spanish] uppercaseString] isEqualToString:[textFields[i] uppercaseString]])
        {
            [words addObject:word];
            [answers addObject:textFields[i]];
        }
    }
    QuizAnswer *quizAnswer;
    quizAnswer = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizAnswer"];
    [quizAnswer SetArrays:words Answers:answers];
    [self presentViewController:quizAnswer animated:false completion:nil];
}



///Delagate Functions
///UITableView Methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[Database GetInstance] words] count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QuizVocabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuizVocabCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor grayColor]];
    Word *aWord = [[Database GetInstance] words][indexPath.row];
    if ([[[Database GetInstance] translate] isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        [[cell wordLabel] setText:[aWord spanish]];
    }
    else
    {
        [[cell wordLabel] setText:[aWord english]];
    }
    [[cell wordField] setText:textFields[indexPath.row]];
    [[cell wordField] setTag:indexPath.row];
    [cell setTheDelagate:self];
    return cell;
}
///TextField Method
-(void)OnFinishAnsweringWord:(UITextField*)textField
{
    NSLog(@"Tag: %ld", (long)textField.tag);
    NSLog(@"Text: %@", textField.text);
    textFields[textField.tag] = textField.text;
    NSLog(@"TextFields: %@", textFields[textField.tag]);
}
@end
