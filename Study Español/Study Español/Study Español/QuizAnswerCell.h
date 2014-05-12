//
//  QuizAnswerCell.h
//  Study Español
//
//  Created by Evan on 4/29/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizAnswerCell : UICollectionViewCell
{
    
}
@property (nonatomic, readwrite) UILabel *wordTitle;
@property (nonatomic, readwrite) UILabel *answerTitle;
@property (nonatomic, readwrite) UILabel *correctionTitle;
@property (nonatomic, readwrite) UILabel *word;
@property (nonatomic, readwrite) UILabel *answer;
@property (nonatomic, readwrite) UILabel *correction;

@end
