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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Hello World");
    Word *word = [Database GetInstance].words[indexPath.row];
    [[Database GetInstance] setActiveWord:word];
    int x = [[collectionView subviews][indexPath.row] frame].origin.x;
    int y = [[collectionView subviews][indexPath.row] frame].origin.y;
    int h = [[collectionView subviews][indexPath.row] frame].size.height;
    ViewWord *viewWord = [[ViewWord alloc]initWithFrame:CGRectMake(x + 2, y + h, layout.itemSize.width, 300)];
    [viewWord CreateWordView:word];
    [content addSubview:viewWord];
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
    [layout setItemSize:CGSizeMake(width, 40)];
    NSLog(@"Cell Width: %f", [layout itemSize].width);
}
@end
