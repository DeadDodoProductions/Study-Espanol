//
//  Utilities.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This is for the misc. methods and variables the program needs

#import "Utilities.h"
#import "Database.h"
#import "Tag.h"
#import "Word.h"
#import "AppDelegate.h"

@implementation Utilities
@synthesize curView, curWord;
static NSString *device;

+(NSString*)GetDevice
{
    NSLog(@"Getting Device");
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        NSLog(@"iPad");
        return @"iPad";
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            NSLog(@"iPhone568");
            return @"iPhone568";
        }
        else
        {
            NSLog(@"iPhone480");
            return @"iPhone480";
        }
    }
}

+(void)DeleteUnusedTags
{
    NSArray *tags = [[Database GetInstance] SearchForTags];
    for (int i = tags.count - 1; i >= 0; i--)
    {
        Tag *tag = tags[i];
        if (tag.word.count <= 0)
        {
            NSLog(@"Deleting Tags");
            AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
            
            [appDelegate.managedObjectContext deleteObject:tag];
            NSError *error;
            if (![appDelegate.managedObjectContext save:&error])
            {
                NSLog(@"Did Not Delete Tags");
            }
            else
            {
                NSLog(@"Deleted Unused Tags");
            }

        }
    }
}

//randmoizes the order of an array
+(NSArray*)RandomizeArray:(NSArray*)array
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

+(NSArray*)SortAlphabetically:(NSArray*)array Sort:(NSString*)sortBy Order:(BOOL)ascending
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortBy ascending:ascending];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    return [array sortedArrayUsingDescriptors:sortDescriptors];
}

+(NSString*)AdjustWordForGender:(Word*)word
{
    if ([[word wordType] isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        if ([[word gender] isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            return [NSString stringWithFormat:@"La %@", [word spanish]];
        }
        else if ([[word gender] isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            return [NSString stringWithFormat:@"El %@", [word spanish]];
        }
        else
        {
            return [NSString stringWithFormat:@"%@", [word spanish]];
        }
    }
    return [NSString stringWithFormat:@"%@", [word spanish]];
}

@end
