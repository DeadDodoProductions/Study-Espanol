//
//  WordList.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "WordList.h"
#import "WordListCell.h"
#import "ViewWord.h"

#import "Utilities.h"
#import "Database.h"
#import "Button.h"

#import "Word.h"
#import "Conjugation.h"

#import "AddEditView.h"
#import "ConjugationWordViewCell.h"

@interface WordList ()

@end

@implementation WordList

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
    [content addSubview:wordCollectionView];
}

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
    NSLog(@"Hello World");
    Word *word = [Database GetInstance].words[indexPath.row];
    [[Database GetInstance] setActiveWord:word];
    int x = [[collectionView subviews][indexPath.row] frame].origin.x;
    int y = [[collectionView subviews][indexPath.row] frame].origin.y;
    int h = [[collectionView subviews][indexPath.row] frame].size.height;
    [viewWord setFrame:CGRectMake(x + 2, y + h, flow.itemSize.width, 0)];
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

-(void)ViewWordDissmiss:(ViewWord *)wordView
{
    [actionButton1 setHidden:true];
    [actionButton2 setHidden:true];
}
@end
