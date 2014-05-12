//
//  WordList.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "WordList.h"
#import "WordListCell.h"

#import "Utilities.h"
#import "Database.h"

#import "Word.h"

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
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)CreateGUI
{
    layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setMinimumInteritemSpacing:2.0f];
    [layout setMinimumLineSpacing:2.0f];
    [self SetCellWidth];
    

    UICollectionView *newView = [[UICollectionView alloc]initWithFrame:CGRectMake(2, 2, contentWidth - 4, contentHeight - 4) collectionViewLayout:layout];
    [newView setDelegate:self];
    [newView setDataSource:self];
    [newView setBackgroundColor:[UIColor whiteColor]];
    [newView registerClass:[WordListCell class] forCellWithReuseIdentifier:@"WordListCell"];
    [content addSubview:newView];
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
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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

@end
