//
//  Tag.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSSet *word;
@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addWordObject:(Word *)value;
- (void)removeWordObject:(Word *)value;
- (void)addWord:(NSSet *)values;
- (void)removeWord:(NSSet *)values;

@end
