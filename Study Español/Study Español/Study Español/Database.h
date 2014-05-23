//
//  Database.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  Handles the interaction with the Database and Holds the data returned
//  Turn into singleton

#import <Foundation/Foundation.h>

@class Word;

@interface Database : NSObject
{
}
//words found in search
@property (nonatomic, readwrite) NSArray *words;
@property (nonatomic, readwrite) Word *activeWord;
//for search
@property (nonatomic, readwrite) int wordMax;
@property (nonatomic, readwrite) NSString *wordString;
@property (nonatomic, readwrite) NSMutableArray *conjugationType;
@property (nonatomic, readwrite) NSNumber *quizType;
@property (nonatomic, readwrite) NSNumber *translate;
//for new/edit word
@property (nonatomic, readwrite) NSArray *tags;
@property (nonatomic, readwrite) NSArray *conjugations;
@property (nonatomic, readwrite) NSNumber *wordType;
@property (nonatomic, readwrite) NSNumber *verbEnding;
@property (nonatomic, readwrite) NSNumber *verbRegular;
@property (nonatomic, readwrite) NSNumber *gender;
@property (nonatomic, readwrite) NSString *english;
@property (nonatomic, readwrite) NSString *spanish;
@property (nonatomic, readwrite) NSString *pronunciation;
@property (nonatomic, readwrite) NSString *definition;

+(Database*)GetInstance;
-(void)Save;
-(void)Delete;
-(void)Search;
-(void)Edit;
-(NSArray*)RandomizeArray:(NSArray*)array;
-(NSPredicate*)CreateSearchPredicate;
-(void)SetValue:(NSNumber*)value Group:(int)group Remove:(bool)remove;

@end
