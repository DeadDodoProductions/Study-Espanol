//
//  Word.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Conjugation, Tag;

@interface Word : NSManagedObject

@property (nonatomic, retain) NSString * english;
@property (nonatomic, retain) NSString * spanish;
@property (nonatomic, retain) NSString * pronunciation;
@property (nonatomic, retain) NSString * definition;
@property (nonatomic, retain) NSNumber * wordType;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * verbEnding;
@property (nonatomic, retain) NSNumber * verbType;
@property (nonatomic, retain) NSNumber * learned;
@property (nonatomic, retain) NSNumber * answered;
@property (nonatomic, retain) NSNumber * correct;
@property (nonatomic, retain) NSSet *conjugations;
@property (nonatomic, retain) NSSet *tags;
@end

@interface Word (CoreDataGeneratedAccessors)

- (void)addConjugationsObject:(Conjugation *)value;
- (void)removeConjugationsObject:(Conjugation *)value;
- (void)addConjugations:(NSSet *)values;
- (void)removeConjugations:(NSSet *)values;

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
