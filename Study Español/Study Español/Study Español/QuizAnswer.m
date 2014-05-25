//
//  QuizAnswer.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "QuizAnswer.h"
#import "QuizAnswerCell.h"
#import "Utilities.h"

@interface QuizAnswer ()

@end

@implementation QuizAnswer

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
    flow = [[UICollectionViewFlowLayout alloc]init];
    [flow setMinimumInteritemSpacing:2.0f];
    [flow setMinimumLineSpacing:2.0f];
    [self SetCellWidth];
    
    
    UICollectionView *newView = [[UICollectionView alloc]initWithFrame:CGRectMake(2, 2, contentWidth - 4, contentHeight - 4) collectionViewLayout:flow];
    [newView setDelegate:self];
    [newView setDataSource:self];
    [newView setBackgroundColor:[UIColor whiteColor]];
    [newView registerClass:[QuizAnswerCell class] forCellWithReuseIdentifier:@"QuizAnswerCell"];
    [content addSubview:newView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 40;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QuizAnswerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuizAnswerCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor grayColor]];
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

@end
