//
//  Conjugation.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;

@interface Conjugation : NSManagedObject

@property (nonatomic, retain) NSString * tense;
@property (nonatomic, retain) NSString * yo;
@property (nonatomic, retain) NSString * tu;
@property (nonatomic, retain) NSString * el;
@property (nonatomic, retain) NSString * nosotros;
@property (nonatomic, retain) NSString * vosotros;
@property (nonatomic, retain) NSString * ellos;
@property (nonatomic, retain) Word *word;

@end
