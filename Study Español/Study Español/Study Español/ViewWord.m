//
//  ViewWord.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This needs to be a singleton

#import "ViewWord.h"
#import "Word.h"
#import "Conjugation.h"
#import "Tag.h"
#import "TextView.h"
#import "ConjugationWordViewCell.h"
#import "Database.h"

@implementation ViewWord

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor grayColor]];
        // Initialization code
        tagArray = [[NSMutableArray alloc]initWithArray:[Database GetInstance].activeWord.tags.allObjects];
        conjugationArray = [[NSMutableArray alloc]initWithArray:[Database GetInstance].activeWord.conjugations.allObjects];
        for (Conjugation *a in [[[Database GetInstance] activeWord] conjugations])
        {
            NSLog(@"%@", a.tense);
            if ([[a.tense uppercaseString]  isEqual: @"PRESENT"])
            {
                [conjugationArray replaceObjectAtIndex:0 withObject:a];
            }
            else if ([[a.tense uppercaseString]  isEqual: @"PAST IMPERFECT"])
            {
                [conjugationArray replaceObjectAtIndex:1 withObject:a];
            }
            else if ([[a.tense uppercaseString]  isEqual: @"PAST PRETERITE"])
            {
                [conjugationArray replaceObjectAtIndex:2 withObject:a];
            }
            else if ([[a.tense uppercaseString]  isEqual: @"FUTURE"])
            {
                [conjugationArray replaceObjectAtIndex:3 withObject:a];
            }
            else if ([[a.tense uppercaseString]  isEqual: @"CONDITIONAL"])
            {
                [conjugationArray replaceObjectAtIndex:4 withObject:a];
            }
            else if ([[a.tense uppercaseString]  isEqual: @"IMPERATIVE"])
            {
                [conjugationArray replaceObjectAtIndex:5 withObject:a];
            }
            else if ([[a.tense uppercaseString]  isEqual: @"PRESENT SUBJUNCTIVE"])
            {
                [conjugationArray replaceObjectAtIndex:6 withObject:a];
            }
            else if ([[a.tense uppercaseString]  isEqual: @"IMPERFECT SUBJUNCTIVE"])
            {
                [conjugationArray replaceObjectAtIndex:7 withObject:a];
            }
        }
        NSLog(@"Array Count: %lu", (unsigned long)[conjugationArray count]);
    }
    return self;
}

-(void)CreateWordView:(Word*)word
{
    NSLog(@"Adding Word to Word View");
    UILabel *pronunciation = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, 150, 25)];
    [pronunciation setText:[NSString stringWithFormat:@"Pronunciation: %@", word.pronunciation]];
    [self addSubview:pronunciation];
    
    TextView *definition = [[TextView alloc]initWithFrame:CGRectMake(5, 35, self.frame.size.width - 10, 50)];
    [definition setText:[NSString stringWithFormat:@"Definition: %@", word.definition]];
    [self addSubview:definition];
    
    
    UILabel *wordType = [[UILabel alloc]initWithFrame:CGRectMake(5, 85, 150, 25)];
    NSArray *wordTypes = [[NSArray alloc]initWithObjects:@"Noun", @"Verb", @"Adjective", @"Adverb", @"Pronoun", @"Conjunction", @"Preposition", @"Number", nil];
    int index = [[word wordType] intValue];
    NSLog(@"%d", index);
    NSLog(@"%@", word.wordType);
    [wordType setText:[NSString stringWithFormat:@"Word Type: %@", wordTypes[index]]];
    [self addSubview:wordType];
    
    UILabel *wordInfo = [[UILabel alloc]initWithFrame:CGRectMake(155, 85, 150, 25)];
    if ([[word wordType] isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        NSArray *verbEnding = [[NSArray alloc]initWithObjects:@"AR", @"ER", @"IR", nil];
        NSArray *verbReg = [[NSArray alloc]initWithObjects:@"Regular", @"Irregular", nil];
        int a = [[word verbEnding] intValue];
        int b = [[word verbType] intValue];
        if (b >= 3)
        {
            b = b - 3;
        }
        NSLog(@"%d", a);
        NSLog(@"%d", b);
        [wordInfo setText:[NSString stringWithFormat:@"Verb Type: %@, %@", verbEnding[a], verbReg[b]]];
    }
    else
    {
        NSString *genderString = [[NSString alloc]init];
        if ([[word gender] isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            genderString = @"Masculine";
            [wordInfo setText:[NSString stringWithFormat:@"Gender: %@", genderString]];
        }
        else if ([[word gender] isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            genderString = @"Feminine";
            [wordInfo setText:[NSString stringWithFormat:@"Gender: %@", genderString]];
        }
    }
    [self addSubview:wordInfo];
    
    UILabel *tagsLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 125, self.frame.size.width - 10, 50)];
    NSString *aString = @"Tags: ";
    for (Tag *a in [[[Database GetInstance] activeWord] tags])
    {
        aString = [NSString stringWithFormat:@"%@ %@, ", aString, a.tag];
    }
    [tagsLabel setText:aString];
    [self addSubview:tagsLabel];
    
    if ([[word wordType] isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        conjugationTable = [[UITableView alloc]initWithFrame:CGRectMake(5, 180, self.frame.size.width - 10, 75)];
        [conjugationTable setTag:1];
        [conjugationTable setRowHeight:150];
        [conjugationTable setDelegate:self];
        [conjugationTable setDataSource:self];
        [self addSubview:conjugationTable];
    }
}

//Add Items to the Table View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[Database GetInstance] activeWord] conjugations] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ConjugationWordViewCell";
    ConjugationWordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[ConjugationWordViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.tense.text = [conjugationArray[indexPath.row] tense];
    cell.yo.text = [conjugationArray[indexPath.row] yo];
    cell.tu.text = [conjugationArray[indexPath.row] tu];
    cell.el.text = [conjugationArray[indexPath.row] el];
    cell.nos.text = [conjugationArray[indexPath.row] nosotros];
    cell.vos.text = [conjugationArray[indexPath.row] vosotros];
    cell.ellos.text = [conjugationArray[indexPath.row] ellos];
    return cell;
}
@end
