//
//  QuizVocabCell.h
//  Study Español
//
//  Created by Evan on 4/29/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextView;

@interface QuizVocabCell : UICollectionViewCell
{
    
}
@property (nonatomic, readwrite) UILabel *wordLabel;
@property (nonatomic, readwrite) TextView *wordField;

@end
