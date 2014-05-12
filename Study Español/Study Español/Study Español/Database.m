//
//  Database.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "Database.h"
#import "Word.h"
#import "AppDelegate.h"
#import "Conjugation.h"
#import "Tag.h"

@implementation Database
@synthesize wordType, wordString, wordMax, words, conjugationType, activeWord, tags, gender, verbRegular, verbEnding, quizType, translate, conjugations, english, spanish, pronunciation, definition;
static Database *instance = nil;

//Initialization
+(Database*)GetInstance
{
    if (instance == nil)
    {
        [[self alloc] init];
    }
    return instance;
}
+(id)alloc
{
    instance = [super alloc];
    return instance;
}
-(id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}


//saves a new word to the database
-(void)Save
{
    NSLog(@"Saving Word");
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    //creates object
    Word *word = [NSEntityDescription insertNewObjectForEntityForName:@"Word" inManagedObjectContext:context];
    word.english = english;
    NSLog(@"English: %@", english);
    word.spanish = spanish;
    NSLog(@"Spanish: %@", spanish);
    word.pronunciation = pronunciation;
    NSLog(@"Pronunciation: %@", pronunciation);
    word.definition = definition;
    NSLog(@"Definition: %@", definition);
    word.wordType = wordType;
    NSLog(@"WordType: %@", wordType);
    for (int i = 0; i < tags.count; i++)
    {
        Tag *newTag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:context];
        newTag.tag = tags[i];
        [word addTagsObject:newTag];
        NSLog(@"Tag: %@", tags[i]);
    }
    word.verbEnding = verbEnding;
    NSLog(@"VerbEnding: %@", verbEnding);
    word.verbType = verbRegular;
    NSLog(@"VerbType: %@", verbRegular);
    word.gender = gender;
    NSLog(@"Gender: %@", gender);
    for (int i = 0; i < 8; i++)
    {
        Conjugation *newConjugation = [NSEntityDescription insertNewObjectForEntityForName:@"Conjugation" inManagedObjectContext:context];
        newConjugation.tense = conjugations[0 + (i * 7)];
        newConjugation.yo = conjugations[1 + (i * 7)];
        newConjugation.tu = conjugations[2 + (i * 7)];
        newConjugation.el = conjugations[3 + (i * 7)];
        newConjugation.nosotros = conjugations[4 + (i * 7)];
        newConjugation.vosotros = conjugations[5 + (i * 7)];
        newConjugation.ellos = conjugations[6 + (i * 7)];
        NSLog(@"Conjugation: %@, %@, %@, %@, %@, %@, %@", conjugations[0 + (i * 7)], conjugations[1 + (i * 7)], conjugations[2 + (i * 7)], conjugations[3 + (i * 7)], conjugations[4 + (i * 7)], conjugations[5 + (i * 7)], conjugations[6 + (i * 7)]);
        [word addConjugationsObject:newConjugation];
    }
    NSError *error = nil;
    
    //save word
    if (![context save:&error])
    {
        NSLog(@"Problem Saving: %@, %@, %@", error, [error localizedDescription], error.userInfo);
    }
    else
    {
        NSLog(@"Saved");
    }
}

//Edits the Database (hopefully)
-(void)Edit
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    [appDelegate.managedObjectContext mergeChangesFromContextDidSaveNotification:nil];
}

//Deletes an item from the database
-(void)Delete
{
    NSLog(@"Trying to Delete");
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    [appDelegate.managedObjectContext deleteObject:activeWord];
    NSError *error;
    if (![appDelegate.managedObjectContext save:&error])
    {
        NSLog(@"Did Not Delete");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error Deleting" message:@"Unable to Delete Word" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSLog(@"Deleted");
    }
}

//retrieves words from the database based on criteria
-(void)Search
{
    NSLog(@"Starting Search");
    NSPredicate *predicate = [self CreateSearchPredicate];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    NSLog(@"Creating Request");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:[appDelegate managedObjectContext]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *fetchedWords = [[appDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    NSLog(@"Returning Fetched Words");
    
    words = [self RandomizeArray:[NSArray arrayWithArray:fetchedWords]];
    NSLog(@"Finished Search");
    NSLog(@"Found %lu Words for Search Criteria", (unsigned long)words.count);
    if (words.count <= 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"0 Words Found" message:@"Unable to find any words matching search criteria." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//randmoizes the order of an array
-(NSArray*)RandomizeArray:(NSArray*)array
{
    NSLog(@"Randomizing Array");
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:array];
    
    for (int i = (int)[array count]; i > 1; i--)
    {
        int j = arc4random_uniform(i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    return [NSArray arrayWithArray:temp];
}

//Creates a predicate for the Search Criteria
-(NSPredicate*)CreateSearchPredicate
{
    NSLog(@"Creating Search Predicate");
    NSMutableArray *predicateArray = [[NSMutableArray alloc]init];
    //creates predicates to define search criteria
    if (![wordString length] == 0)
    {
        NSLog(@"(english = %@ || spanish = %@)", wordString, wordString);
        NSPredicate *englishPredicate = [NSPredicate predicateWithFormat:@"(english = %@ || spanish = %@)", wordString, wordString];
        [predicateArray addObject:englishPredicate];
    }
    if (wordType != nil)
    {
        NSLog(@"(wordType = %@)", wordType);
        NSPredicate *wordTypePredicate = [NSPredicate predicateWithFormat:@"(wordType = %@)", wordType];
        [predicateArray addObject:wordTypePredicate];
        if ([wordType isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            if (verbEnding != nil)
            {
                NSLog(@"(verbEnding = %@)", verbEnding);
                NSPredicate *verbEndingPredicate = [NSPredicate predicateWithFormat:@"(verbEnding = %@)", verbEnding];
                [predicateArray addObject:verbEndingPredicate];
            }
            if (verbRegular != nil)
            {
                NSLog(@"(verbType = %@)", verbRegular);
                NSPredicate *verbRegularPredicate = [NSPredicate predicateWithFormat:@"(verbType = %@)", verbRegular];
                [predicateArray addObject:verbRegularPredicate];
            }
        }
    }
    if (tags.count != 0)
    {
        for (int i = 0; i < [tags count]; i++)
        {
            NSString *search = tags[i];
            NSLog(@"(ANY tags.tag MATCHES[c] %@)", search);
            NSPredicate *tagPredicate = [NSPredicate predicateWithFormat:@"(ANY tags.tag MATCHES[c] %@)", search];
            [predicateArray addObject:tagPredicate];
        }
    }
    
    //resets values of static fields
    for (int i = 0; i < 7; i++)
    {
        [self SetValue:nil Group:i Remove:true];
    }
    
    return [NSCompoundPredicate andPredicateWithSubpredicates:predicateArray];
}

//Sets the values when a switch is pressed
-(void)SetValue:(NSNumber*)value Group:(int)group Remove:(bool)remove
{
    NSLog(@"Setting Group: %d Value: %@", group, value);
    if (conjugationType == nil)
    {
        conjugationType = [[NSMutableArray alloc]init];
    }
    if (group == 4)
    {
        NSLog(@"Set Conjugation Tpye");
        if (remove == true)
        {
            for (int i = (int)conjugationType.count - 1; i >= 0; i--)
            {
                if (conjugationType[i] == value)
                {
                    [conjugationType removeObjectAtIndex:i];
                }
            }
        }
        else
        {
            [conjugationType addObject:value];
        }
    }
    if (remove == true)
    {
        value = nil;
    }
    switch (group)
    {
        case 0:
            wordType = value;
            NSLog(@"Set Word Type");
            break;
            
        case 1:
            verbEnding = value;
            NSLog(@"Set Verb Ending");
            break;
            
        case 2:
            verbRegular = value;
            NSLog(@"Set Verb Regular");
            break;
            
        case 3:
            gender = value;
            NSLog(@"Set Gender");
            break;
            
        case 5:
            quizType = value;
            NSLog(@"Set Quiz Type");
            break;
            
        case 6:
            translate = value;
            NSLog(@"Set Translate");
            break;
    }
}

@end
