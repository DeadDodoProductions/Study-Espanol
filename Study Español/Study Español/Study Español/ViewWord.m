//
//  ViewWord.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This subview displays the Active Word's information within the view that creates it

#import "ViewWord.h"
#import "TextView.h"
#import "ConjugationWordViewCell.h"

#import "Word.h"
#import "Conjugation.h"
#import "Tag.h"

#import "Button.h"

#import "Database.h"

@implementation ViewWord
@synthesize startFrame;
///Initalization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor grayColor]];
        // Initialization code
        conjugationTable = [[UITableView alloc]init];
    }
    return self;
}
-(void)SetDelegate:(id)delegate
{
    theDelegate = delegate;
}


///User Interface
-(void)CreateWordView:(Word*)word
{
    NSLog(@"Adding Word to Word View");
    [self setHidden:false];
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
    int y = 5;
    Button *closeButton = [[Button alloc]initWithFrame:CGRectMake(self.frame.size.width - 25, y, 20, 20)];
    [closeButton setTitle:@"^" forState:UIControlStateNormal];
    [closeButton setBackgroundColor:[UIColor darkGrayColor]];
    [closeButton addTarget:self action:@selector(ButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (word.pronunciation.length > 0)
    {
        UILabel *proLable = [[UILabel alloc]initWithFrame:CGRectMake(5, y, 100, 25)];
        [proLable setText:@"Pronunciation: "];
        [proLable setFont:[UIFont systemFontOfSize:14]];
        [proLable setBackgroundColor:[UIColor grayColor]];
        [self addSubview:proLable];
        UILabel *pronunciation = [[UILabel alloc]initWithFrame:CGRectMake(105, y, self.frame.size.width - 110, 25)];
        [pronunciation setText:[NSString stringWithFormat:@"%@", word.pronunciation]];
        [pronunciation setBackgroundColor:[UIColor grayColor]];
        [self addSubview:pronunciation];
        y = y + 25;
    }
    
    if (word.definition.length > 0)
    {
        UILabel *defLable = [[UILabel alloc]initWithFrame:CGRectMake(5, y, 100, 25)];
        [defLable setText:@"Definition: "];
        [defLable setFont:[UIFont systemFontOfSize:14]];
        [defLable setBackgroundColor:[UIColor grayColor]];
        [self addSubview:defLable];
        TextView *definition = [[TextView alloc]initWithFrame:CGRectMake(105, y, self.frame.size.width - 110, 50)];
        [definition setText:[NSString stringWithFormat:@"%@", word.definition]];
        [definition setBackgroundColor:[UIColor grayColor]];
        [self addSubview:definition];
        y = y + 50;
    }
    
    UILabel *worLable = [[UILabel alloc]initWithFrame:CGRectMake(5, y, 80, 25)];
    [worLable setText:@"Word Type: "];
    [worLable setFont:[UIFont systemFontOfSize:14]];
    [worLable setBackgroundColor:[UIColor grayColor]];
    [self addSubview:worLable];
    UILabel *wordType = [[UILabel alloc]initWithFrame:CGRectMake(80, y, self.frame.size.width - 90, 25)];
    NSArray *wordTypes = [[NSArray alloc]initWithObjects:@"Noun", @"Verb", @"Adjective", @"Adverb", @"Pronoun", @"Conjunction", @"Preposition", @"Number", nil];
    int index = [[word wordType] intValue];
    NSLog(@"%d", index);
    NSLog(@"%@", word.wordType);
    [wordType setText:[NSString stringWithFormat:@"%@", wordTypes[index]]];
    [wordType setBackgroundColor:[UIColor grayColor]];
    [self addSubview:wordType];
    y = y + 25;
    
    UILabel *infoLable = [[UILabel alloc]initWithFrame:CGRectMake(5, y, 80, 25)];
    [infoLable setFont:[UIFont systemFontOfSize:14]];
    [infoLable setBackgroundColor:[UIColor grayColor]];
    [self addSubview:infoLable];
    UILabel *wordInfo = [[UILabel alloc]initWithFrame:CGRectMake(80, y, self.frame.size.width - 90, 25)];
    [wordInfo setBackgroundColor:[UIColor grayColor]];
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
        [infoLable setText:@"Verb Type: "];
        [wordInfo setText:[NSString stringWithFormat:@"%@, %@", verbEnding[a], verbReg[b]]];
        [self addSubview:wordInfo];
        y = y + 25;
    }
    //changed to else if in order to avoid creating it for a number
    else if (![[word wordType] isEqualToNumber:[NSNumber numberWithInt:7]])
    {
        NSString *genderString = [[NSString alloc]init];
        if ([[word gender] isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            genderString = @"Masculine";
            [wordInfo setText:[NSString stringWithFormat:@"%@", genderString]];
        }
        else if ([[word gender] isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            genderString = @"Feminine";
            [wordInfo setText:[NSString stringWithFormat:@"%@", genderString]];
        }
        [infoLable setText:@"Gender: "];
        [self addSubview:wordInfo];
        y = y + 25;
    }
    
    UILabel *tagLable = [[UILabel alloc]initWithFrame:CGRectMake(5, y, 50, 25)];
    [tagLable setText:@"Tags: "];
    [tagLable setFont:[UIFont systemFontOfSize:14]];
    [tagLable setBackgroundColor:[UIColor grayColor]];
    [self addSubview:tagLable];
    UILabel *tagsLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, y, self.frame.size.width - 60, 50)];
    NSMutableString *aString = [NSMutableString stringWithFormat:@""];
    for (Tag *a in [[[Database GetInstance] activeWord] tags])
    {
        [aString appendString:[NSString stringWithFormat:@"%@, ", a.tag]];
    }
    if (aString.length > 0)
    {
        [aString replaceCharactersInRange:NSMakeRange(aString.length - 2, 2) withString:@""];
    }
    [tagsLabel setText:aString];
    [tagsLabel setBackgroundColor:[UIColor grayColor]];
    [self addSubview:tagsLabel];
    y = y + 50;
    
    [conjugationTable setHidden:true];
    if ([[word wordType] isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        [conjugationTable setHidden:false];
        [conjugationTable setFrame:CGRectMake(5, y, self.frame.size.width - 10, 120)];
        [conjugationTable setTag:1];
        [conjugationTable setRowHeight:107];
        [conjugationTable setDelegate:self];
        [conjugationTable setDataSource:self];
        [self addSubview:conjugationTable];
        y = y + 117;
    }
    [self addSubview:closeButton];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, y + 5)];
}


///User Interaction
-(void)ButtonWasPressed:(Button*)button
{
    [self setHidden:true];
    [theDelegate ViewWordDissmiss:self];
}


///UITableView Delagates
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
